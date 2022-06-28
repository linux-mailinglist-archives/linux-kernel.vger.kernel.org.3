Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0439955E796
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347085AbiF1N5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346938AbiF1N4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:56:31 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 06:56:26 PDT
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9683633369;
        Tue, 28 Jun 2022 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656424587; x=1687960587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R0UwYYjk9yrf7raSF4daL0guFNoPOqkFTnyKIVaAwXU=;
  b=hinwsv+B7XkP7A/QtGERkWFsmulJLcj2sxHrrqn6CoJc+cXYnbToc6LQ
   V6jgAzbmrC1SbDRJ8iYd3q7JOxsPSWw/1tY6v9sY4331U4mhjwpEK8kRO
   V2A9SDTFEvmaxhJF4Do8L3XH5Pl5qYAbup8Imx4Bhe485N7WyGhyU+2K4
   Rv+Uv/SPuTjk2azlgBxR6VBlz14ri7EDq8P1xsnGcOEPtm3ujyf3F6JR+
   YWhcFiAKntcrJ0nruco13KnJUkw89ROQWnvt5eS+I1HFNag1YXxJrRL5W
   5wuI/88hs0tMGhFA2J09zxToG+M1JbdS15CgJRmrYQHhm76g0Nyf3nzX4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="58887602"
X-IronPort-AV: E=Sophos;i="5.92,227,1650898800"; 
   d="scan'208";a="58887602"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 22:55:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq8v+kRXDwKy+pv6JYD2nQux8OW1/cRmno7/mwA2WXtnqyLGLBDTvIzqgtxKA7O1R+mmfoRHh0vJE1K3XrkZUeS4oJi2BuwV7ZDNOwfBJTF0eOd+NrQ6xb0fJM0+J47kK34bojlxYoejDu+/K3hCUEpIKW0HVegcXnfn31bGXBXySHz5SWH5cBx18xVbdwESMmFtvXEaArRtOeCHNW9Pg0+m6BiKFAmrc403PX2OtxumY4dIb3MgDhGJuD3OAQ8zD9aGtuE5kfzXvcvSkaCN6IQ3RPbaPvtC4qwrdA6gQ0fEl19KRDVNgxIyiCZhEUrlcXWHMVNJOSXoUS9qmkacVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0UwYYjk9yrf7raSF4daL0guFNoPOqkFTnyKIVaAwXU=;
 b=FrRIz3k7Wsl/WH9xCwUyivCyO/fEH+R317joCHOMXl8fwwmrnQX8muxUWNqYHgsfgbIS8FSyfwsVrv3vn8I4/Ewe8LoFzAjfPjqLWOP+eD8EG9MVvoc8+X4iUKt7r0SYu2byeDqqJRJEODfjEj1lq2w3/Vp6rHpAlv+IC0JBiN8EDOIopfT3OxfQJaREfabesCigRjzBF8c/sIq6QHWtFAVlx/q/9Ms20/8XubjTHqopkw1dHEMYdyigurp5FuSv7gRp3ekbh20tiZ/WGqaTx6OqIhNUvt5yWC3HfNRvGbClWFWCjxiaXzomeL44C61A1dYcmwKjfL1bcS2WN9s04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0UwYYjk9yrf7raSF4daL0guFNoPOqkFTnyKIVaAwXU=;
 b=iJ7HSm9830CppK1fgpy0/vdJfUdCCPsdQPpyoE5jpxzqtqBDoUhNOXGkeReJZa95ntqmy1j4kMPTwOBIl2LSkX4xxGCREDT52UEK4LMduEKKG/N6Lhxbr/lSV9IVR7jQrwHnvc8mN0jhTIyyXelLTqUHM1sd1MsXVjZV/J6DvBU=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYYPR01MB6912.jpnprd01.prod.outlook.com (2603:1096:400:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 13:55:11 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::3151:373d:fb9d:afd1]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::3151:373d:fb9d:afd1%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 13:55:11 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Linus Walleij' <linus.walleij@linaro.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and
 x86
Thread-Topic: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX
 and x86
Thread-Index: AQHYemckLVPNFhFQbU+IAdEo3cwBO61IoUEAgAYyEhCAAA4dgIAEfPmggA+/dICAAdapAA==
Date:   Tue, 28 Jun 2022 13:55:11 +0000
Message-ID: <OSBPR01MB203739DD69FB8C50990C356A80B89@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com>
 <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YqiAY689pOJbHKUd@kroah.com>
 <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
 <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com>
In-Reply-To: <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NzBjY2M1ODgtNDljNi00ZGUxLWJhMmQtMDIyYzBmYmZl?=
 =?utf-8?B?OWYzO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wNi0yOFQxMzo0MDo0NFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e58fd8a-a191-4ab6-96fc-08da590dd1d9
x-ms-traffictypediagnostic: TYYPR01MB6912:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebRo8NRFauwYEQxuZN6pix7YRznHNbI42VfifCdr2pdYeGvqXSrDMKrIrkaTwpL4tWijkuD81ILvUJhrSg9Az422Q1Ct42wBe/4Klr1ckpUJ/OnzwGuMyrtH7sks5C5RP0dt1WrkH5QTsGUzqGLHOJe35V5pqEO3jWBUTKr3HCo9ZV74y+8nW/6Q5ZspaubCoYeKH04j11YidtP2/PbPBKTx3saiHlswXbESrKiT84OzHd+1X9+EoT74zCLpy6vLMmjTaLES6CxxXDnxd2iIBkYL6kPqngjfoO9r0M2Mhr/i7CSyjEFJ01Nbk7ZqtcVRUdj1JF4zYaavgUGdvAKk1N+MqbDc1mEs7flKsb/5cK9GLNenGCcQqRIO1ibPMIjbvkV84H5SBc+MXt90PXd4RGQJQ1VAEoHIHxMICxVramfxFRhYQVVd932b8fykS+JnBC3ciYQ7V5cwKjL8tzlp9Yrf6QeoiXqd2NxkMuV+8hvaPlzKMCyHDpYPm7Tj4Nyz3C8fM57zbqXfd2VLZoLi96qnycYa+ZxaXTqrm9z+QVCHNS7v+N+DVpkjuuNK7DrxETALG3LQjYjG3XqHGxb6qFxqL41hgxsdpMcekYH34e8cZYB+DNP3vTqJiDmQGpGrIGVZz7lbBvwMJ3UrLAe8ffqTudCoJ7iTfoLzAO6FBUJBbqFvn+hr/YgsfUoj9eG5pqw4nvZQw8XCedaoTi56lfJ2kQuhRU3a1q8R9B2bXWmElBPzkC04zxjfLbyetyfNA1VQJjq2xkVIn5PDmt4D+Eyx/AS1S2yBmwitKasRLrQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(71200400001)(478600001)(55016003)(26005)(4326008)(8676002)(41300700001)(33656002)(9686003)(86362001)(85182001)(2906002)(316002)(83380400001)(82960400001)(122000001)(52536014)(186003)(38100700002)(54906003)(7696005)(64756008)(6506007)(38070700005)(5660300002)(6916009)(8936002)(7416002)(66476007)(66446008)(76116006)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2RxeDVFMlNENUlEcE01OWNnNGh6UVVqN3FRS0lSc3UxY3RFSnBzdHd3bU5w?=
 =?utf-8?B?d2lRNlVwOU0yVlZKeGVIUDlYQi9WZTFUeHdoRkxFQlM0SGVMdGsrWDVpaDhR?=
 =?utf-8?B?YmErVnJWMFRHMUUwWDRRSUZ4QXdqbkg3K1QwVy9IMUc4U0VpZ0NEUnoxei9H?=
 =?utf-8?B?dkdRZklQYjFiOUlIOHFwL0p1VkZ0cTZPaDlIRjRxd0cxcDRCdXVmSjhDeHdz?=
 =?utf-8?B?WTNHNTYrTWU1LzJBbDdmVENzdU56eFpLaDlkN2I2NTI0ZkRPL0ZXaFpwN0g4?=
 =?utf-8?B?YnN2SmxlZjcxd1p4K1M3R0tKQ2RIQjltNDI3WTlVSkF6VXN1a2EyT2M0YnhK?=
 =?utf-8?B?WXliYzRxZ1NqY1d4Ylc2aFhPOVorTmR2ZXRuNEF0Zjhsd04vR004ZmNGdlVI?=
 =?utf-8?B?Q2p3bS9MSHRjelQ2ZUFTRDJPOG93MTQreVZTbjZDTE5oQjE0Z094cWlVRHI1?=
 =?utf-8?B?UlRER0Q5NEh0czRwM0Fvc0VpSnZOL1JTYnRrQnY0NjVOU2g2aDdVeHA1cHRn?=
 =?utf-8?B?S1hHcXRxblVSNHh3aHJkeTI5RC9qa2RhWE5yMVR2Tzg3Zy85cGo5a1h1T3Nl?=
 =?utf-8?B?b3hkZ0pyUmszUTlGbXBQbE8rSVJEVVhkS3JGa0NtVkpUc1czUnNjcEZOd3hH?=
 =?utf-8?B?SXlkTkJxT3VaOXJrQkdqN0N1ZFljMzQya1hUNDg1SENwQmRWQ251VnVvRUlB?=
 =?utf-8?B?MXNHRVNkbmQzVnFjMkprTHA1d1FLelY1ZStLc2FRY1Z4dlhFQi9qUyswdzFY?=
 =?utf-8?B?SEkzZnY1OHNPMFlsNFZEYnd1aVVPd3ZmYXgrV0FYZUM4SFZYS09KYzVBNDQ2?=
 =?utf-8?B?NFA0QXhLRVZKTjc0MUMyak5wdGcvVkIzZHI2TzlDRVdKWGxVR0FKM0o4TURV?=
 =?utf-8?B?dURZTDU3cFhSa3ZlWTJUYlN6OWJycHdCaHYvcTJncGk1OUhLTGY4bGVNTXdY?=
 =?utf-8?B?c1ViaVBXZzBEeUcycjgrRXBnRHBTQmFpbTB0TkxYR3lqTk8yc05rWUg1Rmt0?=
 =?utf-8?B?U0RsRzNpVm5BaTJRSHhNdzJkUFhIRFU2VVNMUjdRNnhsSGwzTnNyaWlaSThE?=
 =?utf-8?B?SEVQeTNocUpSb281cFdMdmpKcXU2ckZZd2V1K1pJWHBKSUEvS1QxUUJ6bXdZ?=
 =?utf-8?B?REFXTitYdG9xN09FMVZCVDhkT1RWWHg0cW81endKOGtORW1ZV1J6OVU0dVEz?=
 =?utf-8?B?U3BHdUJ6S284UVEvMlN6azdKSnpxSWNRMURVaUdMS05La1dFeld5eWc5YmRD?=
 =?utf-8?B?ZmtvaWx0cFVNc1l3TTVzQytDTjNhSVc2Z0sxMkVXSG9WRWtxeDc1RUNJWHRx?=
 =?utf-8?B?UHovWnZabStQZXZ5d0szSCttWExwUWQvTUhQMndTMmRWMzVOajJCaFk4bXdR?=
 =?utf-8?B?aTFsYlNEeDBWTW9uRXZ3cXc2TlhTS0Z6c0grNXpxN1BVODZwTnhDbExMY3Vh?=
 =?utf-8?B?bXhEZmdYdkRGZFMzWFc5dWJ3eEw5WGRoVi92M21KT0tvSkp6U2RPS3hkYmIz?=
 =?utf-8?B?Qm9CbGlHejhpbjc4eGpyVHR0WDIwQ1BwL1ppa1QyRGNxME5TaHBsNGZVbW5U?=
 =?utf-8?B?UnU2NW14MnJ6WVRVdUtOaTBnSk53WmZkMEJhbkg2SWFxL290S1I5Q1pXU2Zs?=
 =?utf-8?B?LzZlYWtnSFY4RkVVOGgyUG1ZWUdSUFcrdGpWMnZ1UEpwbWhPWEU5ZjdwakN0?=
 =?utf-8?B?SlcxTXl3bWFjODhHRVMxaUpDV3k2c254Y2EyMXhJNzVVQjVIdzdtTjgzZi9Y?=
 =?utf-8?B?T0xjOFJLYWFZVmdMaDdHT1B6KzNETnJaNjhqN2F3eGg0ZE9Wc3pzUElhRmQ0?=
 =?utf-8?B?c0laQVdJUVdodlpUSzJZUHRuT1dOWmJXb2JmcThGS3ljT2JUcVE2T1N6MitR?=
 =?utf-8?B?RkpwQXBRT1dFZzMyMmpPbXVYVlhiVHJhbWt4WXpLMGNmNTdNNXpabjJnRk9R?=
 =?utf-8?B?bkNvUUc0MEdIWUhIajdlOVk2b1R5bllnOFRBS2lXNlV5ZmdmaGxSYUNRWjNF?=
 =?utf-8?B?NGNLTHFVMnltbUQwOEUwUU42MzkxVE1xQjdCaW4wT0JNMlN1dk55bWVWaktk?=
 =?utf-8?B?TlBnMlNKNlBBNTc1ZFhZUHpta3BkMjJzUUlPaFVrcFdSOXNvNDhrT2ZZV0hC?=
 =?utf-8?B?MllQM1l2VWZ2TWE3SmJ1V096dUdGd0laVjQwQUIvU29SWkRLbjFHaXNFdGYw?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e58fd8a-a191-4ab6-96fc-08da590dd1d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 13:55:11.6179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1ZnDXavaVF/jqibqCejrqUuJvdmsHYbH9wfh6a1lBk2UEwFwZIpJnMVBkXg1E1VXIuAVkXHrk0h/fEnRYOF35HOEkosoLecrd3t1TPZr9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6912
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCj4gVGhlIHJpZ2h0IHdheSB0byBzb2x2ZSB0aGlzIGlzIHRvIG1ha2UgdGhl
IExpbnV4IGtlcm5lbCBjb250YWluIHRoZSBuZWNlc3NhcnkNCj4gaGV1cmlzdGljcyB0byBpZGVu
dGlmeSB3aGljaCB0YXNrcyBhbmQgdGh1cyBjb3JlcyBuZWVkIHRoaXMgdG8gaW1wcm92ZSBlZmZp
Y2llbmN5DQo+IGFuZCB0aGVuIGFwcGx5IGl0IGF1dG9tYXRpY2FsbHkuDQo+IA0KPiBQdXR0aW5n
IGl0IGluIHVzZXJzcGFjZSBpcyBtYWtpbmcgYSBodW1hbiBkbyBhIG1hY2hpbmVzIGpvYiB3aGlj
aCBpc24ndA0KPiBzdXN0YWluYWJsZS4NCj4gDQo+IEJ5IHB1dHRpbmcgdGhlIGhldXJpc3RpY3Mg
aW4ga2VybmVsc3BhY2UgTGludXggd2lsbCBpbXByb3ZlIHBlcmZvcm1hbmNlIGFsc28gb24NCj4g
d29ya2xvYWRzIHRoZSBodW1hbiBvcGVyYXRvciBkaWRuJ3QgdGhpbmsgb2YgYXMgdGhlIG1hY2hp
bmUgd2lsbCBkZXRlY3QgdGhlbSBmcm9tDQo+IHN0YXRpY3RpY2FsIG9yIG90aGVyIGJlaGF2aW91
ciBwYXR0ZXJucy4NCg0KSW4gb3JkZXIgdG8gcHV0IHRoZSBoZXVyaXN0aWNzIGludG8ga2VybmVs
c3BhY2UgTGludXgsIEkgdGhpbmsgaXQNCm5lY2Vzc2FyeSB0byBjb25zaWRlciB0aGUgZm9sbG93
aW5nIHR3byBwb2ludHMuDQoNCjEpIFdoaWNoIGNvcmVzIGFyZSB0aWVkIHdpdGggdGhlIHByb2Nl
c3M/DQpUaGlzIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBjb3JlIG9uIHdoaWNoIHRoZSBwcm9jZXNz
IGNhbiBydW4uIEl0DQpwcm9iYWJseSBuZWVkIHRvIGNvbWJpbmUgc29tZSBDUFUgcmVzb3VyY2Ug
bGltaXQgdG8gYXZvaWQgYWZmZWN0aW5nDQpub24tdGFyZ2V0IHByb2Nlc3Nlcy4NCg0KMikgSG93
IHRvIGRlcml2ZSB0aGUgdmFsdWUgdG8gc2V0IGluIHRoZSByZWdpc3Rlcj8NCkl0IGlzIG5lY2Vz
c2FyeSB0byB2ZXJpZnkgd2hldGhlciBhbiBhcHByb3ByaWF0ZSBzZXQgdmFsdWUgY2FuIGJlDQpk
ZXJpdmVkIHVzaW5nIHN0YXRpc3RpY2FsIGluZm9ybWF0aW9uLCBldGMuIEluIGFkZGl0aW9uLCB0
byBwcmV2ZW50DQp0aGUgY29zdCBvZiBhdXRvbWF0aWMgZGVyaXZhdGlvbiBmcm9tIGV4Y2VlZGlu
ZyB0aGUgdmFsdWUgdGhhdCB3b3VsZA0KYmUgaW1wcm92ZWQgYnkgaXQuDQoNCkkgZG9uJ3QgaGF2
ZSBhIHByb3NwZWN0IGZvciByZXNvbHZpbmcgdGhlc2UgaXNzdWVzIHlldC4gSSB3aWxsDQpjb250
aW51ZSB0aGVzZSBjb25zaWRlcmF0aW9ucy4NCg==
