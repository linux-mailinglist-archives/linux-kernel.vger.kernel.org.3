Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A65A54AFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355478AbiFNLz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiFNLzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:55:52 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B6E3A72D;
        Tue, 14 Jun 2022 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1655207751; x=1686743751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UsQMaWZhEeYxx17NEwy4Z621E5SNxXPJnlF5jUIH3sE=;
  b=Nu5rw4Ui/wB8aeoYgiX6NmlvNUkKiF1byyINoS8+jo0fFJR6zb1gvEv8
   NzDjwvhLYFViBS4tbPnIwSWq8cjSMOGnUNMirkwmOEIi15bwsFTq84vtu
   E9ftG90rqpir0hJ6QQ7KhiFFk8VzseoludPFOhk7eFfVkbpQLWFrTOppu
   jPHt9G9VeeLbY3b7JJWRN0lco1sNGWOuxuosR56OTA3GqWPtOpmglHg/j
   b8u4htkHId3LN4WsXlIogw3Kk32ft5JecAX+x2iSyjTfOIv+/blgkACxk
   8zsXBqnW0bF8Y6DDd46uEvd5n7F0SJXRB98iXn1vxudXDPIfAbir0ok5n
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="59439464"
X-IronPort-AV: E=Sophos;i="5.91,300,1647270000"; 
   d="scan'208";a="59439464"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 20:55:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is+f70jey0NK5Rm/Qmq7sM6vQaGWWFJuziX+AcsGs8mMcIKjBNKTwCMTY6UvZf+dzrg+AguNHLN2KfYAEBrnIlxaR8UfQMtkh80DbwdafBOLVH9PCY/++QlxvhJwj1vMU91IGSY69abqycbJIq+PX9VmaA3veNTmIi1br4NBQFEx9HCGS6Dkb0Rc6OIVHOVMOwamZorkdgpZJxFeOh/eDWP4ywuecM2EN79c5VlZ+cN235hu3dC45eExNSf7wXHBwZLsLVDpNxfEJ1w+/uLaLYVOutMZM4Ve+clvhLnt4U6wfP3lCr79XbtLdLfImTzNZzvtAJYGEbDrL1PqVYrZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWkRUzHCfO1YWcuZ8izmHdoC7bTIQqUY1hWoCGnV/v4=;
 b=fzKYj7TmjE5kKluDiXysKGl+9Ww+kTkDvqOE8NZovWXP+gJdSTk69/tc0EgYWV/ttN7YbtFw88QpopWV3LNmaOE160tPORgCQtjROeVicXg4kVcfFNklpFAyB1U5cn9R1Q+w9B/gClZaCsk6Y/o6u899qCHJ2sclXciKn2rxJqETa8Ypm1KSoXPO8tsuFnYxCF1XEGA9a8921JLgWKCXlIdReb1VFFz8FKZvHC0Gyu8bEYhjcdT7nDCHkcxxJClHpuQSEkgfZ/zVC++a+pGBG86xoaA8j7eOX+GgTHpIswuAuq4dwgl9fGYOkHyr69usvZ4xQdDM83NLrY5R2mbmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWkRUzHCfO1YWcuZ8izmHdoC7bTIQqUY1hWoCGnV/v4=;
 b=kXGYpY6kwQfeHs9+Q/Kz/7i7qx+JOhpvqqSTsyRJnHDlNl06CyAUTNdo1IlWi/dcFATdJ9UJjD7S9kw8STK7m03iQEA9OYMY5WAFaXXN4NLb1akPmt1XOn601/aUTh1dIwNE3utdOrRz9O3XB/NJchLgyo82LOsZ1QEFIw9Cy/w=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYAPR01MB4767.jpnprd01.prod.outlook.com (2603:1096:404:12b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 11:55:39 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::3151:373d:fb9d:afd1]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::3151:373d:fb9d:afd1%7]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 11:55:39 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
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
Thread-Index: AQHYemckLVPNFhFQbU+IAdEo3cwBO61IoUEAgAYyEhA=
Date:   Tue, 14 Jun 2022 11:55:39 +0000
Message-ID: <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com>
In-Reply-To: <YqNCDrqcp9t8HlUJ@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9YzI2ZjBlMmMtODEzMC00MGM1LWExZDItODlm?=
 =?iso-2022-jp?B?MWJiM2ViYWI3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjItMDYtMTRUMTE6NDQ6MTJaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0682a3db-2ba6-4c77-6110-08da4dfccce3
x-ms-traffictypediagnostic: TYAPR01MB4767:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4767B134F1D9024D823D3A3380AA9@TYAPR01MB4767.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 04msqKUdgv2o/XcI/95vRA+PoTQV4eNZyOUfUrgoMJbgS9LfPmIEmqBSbfzvhd7d+wVLOsdkCQ4vhBUoBjHOy5wZ4cD2oIghou7/kWWBXbVqws28oSf1tqBP+hbID9mSXw0P314cMey0NGe/MIijGLwKHu1iluTS8U7JkeBzJ86A5IKkocNb7DOhob8ko4NBT/9lmzy/H2MphbyTevYVBbOu77b0pBAN5mfCnkB4PXVQDzs7OY20vjxgBP0LhBAII1XDBRLDw8XKgYhrL+XcLbd8zgOQfdy+pe0rGebRqO6lQ9ZyT/LXKFtEdGrg1uu69VCOnlwLvMbHlDnSg63gspPzRDTV9LYDyJF/UHLalYwJML16aWtGGMOg/0+o/iZukz9DJDW5WPPhUYLw4FqCcRP7gRGa4tUTZqriC0B4d1IMSx3HtlT4/7f352ORY+suYWmEQ4vKHYD3edNjpZ5YRT8wBWtlMZJt7RkL0Zd0Lfaahe2ptcYkDMKu6IwSeMOLES78qI4Bw3pUACY9cejPY1a34tV/PpeMnfHp8Ar46JH63HCph9hCldkxZKl1Mrhjfo2X+kHC26mRLnCfYvJmhVou9JYiBMpP0rxVS271kdzQuXuKfzYveGu7bYCTwM01J2VRE8B/aiOZMaTIxEjT3NTFUTXD+eDbWp+q7I3hQguha1ol0tCI4j5ZJtbS7xNaEiF7aak2mvxdO52e7ZyuDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(316002)(82960400001)(122000001)(38070700005)(83380400001)(7696005)(33656002)(26005)(54906003)(6506007)(86362001)(52536014)(508600001)(6916009)(9686003)(85182001)(71200400001)(66556008)(66476007)(66446008)(8676002)(4326008)(66946007)(64756008)(38100700002)(76116006)(55016003)(8936002)(186003)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eWhLanZ6UzNrdUtPS1dVU3pJakozUGp0ZTZ0MHpUMndnMTJiekxTRE5s?=
 =?iso-2022-jp?B?YWJ0Mk5aQjYvQ0JoSWZ2bWpnbUtkUGVsT1F2cmNNL2NlZElWb3hRK1ps?=
 =?iso-2022-jp?B?SW9qc3ZId2xmQTdHVFNFd0ZKejlNZUdHV2FpVzN1QjE2NVZnRnFCOEtW?=
 =?iso-2022-jp?B?QnlTNXBkV0J0cXdTYTJ4SjViL242dmNEZ2ZJRGRSSFRxanVpTzZFU2tC?=
 =?iso-2022-jp?B?ckZWb0NneG5HaUpDUkFMUVJYUHloVjRVd010TU9wanhXWE1vbnlTQjdH?=
 =?iso-2022-jp?B?MUp6N2dxQmNTRzZ1YjJDajJ2bklhRUNwU25weHdPNmY2TC95bi9zWlkz?=
 =?iso-2022-jp?B?a2pqb0tUUHdkNVpLclFGYk5yM0hJSXQwT1hPZnlRMThMN1lPR2dScllR?=
 =?iso-2022-jp?B?aS9sYnFhdk94L0NVNTFlNUtlaFRhTmZERUpCSUVTNDRzTkR6MGxHdE1N?=
 =?iso-2022-jp?B?L2tsY0tXMDVucTNwZTdaTEwwb2RlNWFDTkdiR3BTZzdzejlpbDVuZjBJ?=
 =?iso-2022-jp?B?aXpEQ0w5UFNJb2tCS2xvL1h6b1YyRFlpL0UwM3dXdjhwSnF1NnYyclJP?=
 =?iso-2022-jp?B?YTNZRUUyMGN6WHNuN3VqdUZkMUhobmo2TjZGUmdPT2w0cHBOZDFUWW9V?=
 =?iso-2022-jp?B?cGtYOFJiZlNDc21PeU9CbzJYaVdWRHd0SndWMUZBKzFnN3ExK1Z6RGVR?=
 =?iso-2022-jp?B?UlBwUXlHZVBoMElVYmhPMWpQZzVvRmFFWFBLSS9QaWZqbW5tRHN2c05x?=
 =?iso-2022-jp?B?OVpVd2I4L04vbzdFLzh3VDVQeVlxMTlIU0pSYXMxRUkyd2hIU2djNEJ4?=
 =?iso-2022-jp?B?R3Q1NWpyM0YvUFluRlhseFI1b2Y2NDhjajNpVGNCVXJ0alcrZkNBSnly?=
 =?iso-2022-jp?B?SDYwTnc4NTVHbm15elhQWXFQZllKVlMvODdhSlB3UGFZd3BKYXRISFVs?=
 =?iso-2022-jp?B?ZjRRYUsvYXJCTkEyVlIyTDZiMDkxVk1IRlFpM1EvZE1pcjV0RkdDejhR?=
 =?iso-2022-jp?B?K2NaZUVxbGZLaDBRQWpFanNpTjRVRmphdDQ0OTV2OFkvU3NNRVRmMGZs?=
 =?iso-2022-jp?B?aXNML283RWdCbDU5SWpaQVpMWTJZdG1ncFhsdXA1WjdNQmFMd0ZhL2s5?=
 =?iso-2022-jp?B?UXVxclAyWms2QUYwajJEQTluTVpZeFp6SGIyME5QOUlVY1Q4MU5ybEdy?=
 =?iso-2022-jp?B?MCt1TmhVWEM5dC9aRTlNUFZlZzBxOTVEcFNlZTYrbUo0c3FXcE9ES0Ur?=
 =?iso-2022-jp?B?NkNoamVxWDNEU3pXd09ZRElmVTlnMm85L0VOSldhQlY0RjRlQi9EbzRW?=
 =?iso-2022-jp?B?Z2wrYmoyOUVzazN6ZngwaVBuK1VlZ25aR09UNkdvbEYxSnl3Wlp0YlJD?=
 =?iso-2022-jp?B?M0pOb1gweCs3YzNSSDNpeTdVajlGMkpmcno4ckJibEdHOVo5MFoySG9F?=
 =?iso-2022-jp?B?T05GUENFU0RIQVlYTGhJR05pemJJSlBhV2RVR0I3Yk4zL1JtTEVyck91?=
 =?iso-2022-jp?B?QVEyR0MrU1FkRHBYaUg2K1A1cERldDJjeEJlRFdRaFEzeWxTZXFUbllj?=
 =?iso-2022-jp?B?d0JRYmxmZE1kalQxazV0ZXBpd2hxT3ZpYnlsL2xRck93OXFMVWJzL2Rm?=
 =?iso-2022-jp?B?QjF6WjZKM2luTDdab2F2NHhzdWYzWU9lQmJWS2pjck9NVnhxUlN0Y2U4?=
 =?iso-2022-jp?B?a20zRHZ0UUdYeDdRQzlxdlU1U2FUT1BBenZuRFM4MVdoS20yT3Y5SU1L?=
 =?iso-2022-jp?B?eGVHa08vcmV3TDhRcjhPNGtLL093MkFVeVZaYTh0bHZsbnptSXBvRmJl?=
 =?iso-2022-jp?B?YldlWXAxall4ZWl1eHVoZmNOY0l4cjR2YXlWb241NFhadXpPdnFjOWpT?=
 =?iso-2022-jp?B?QjFHamYwRXB1UEJ0ODdibGYyaStaRGVyWWd1RVJ3UEx6YUg5ZERPcUxt?=
 =?iso-2022-jp?B?dlFjanVacUE0eTlwcmRrOW1VcFpTSGNDMGVrNGQrMkJNOHFpNnNlQXFB?=
 =?iso-2022-jp?B?anlSTXBOSnhIKytvbkpGdW1NS0NrYURjN1IzODZqdEk2ZUYxd0lrTEJR?=
 =?iso-2022-jp?B?Wm5RTllIK2xtajhCMFFIRjJlSmZuNTFaajRmTXRYTzBSWlBhYnJaaXZr?=
 =?iso-2022-jp?B?TWphbGJ1TXVtWjdMaWFBU1pnbXZDRjQwMUVrUlpwVXZnUmUvcGkrNGdY?=
 =?iso-2022-jp?B?UGpFZkkybFdDdm5keVpjQm1JYUtyOElabFQ0UkNHMzZyNUs0cElKaVlK?=
 =?iso-2022-jp?B?Wjg5aFpzZnI3aURTcWZ0bFphaUttaWxFN0tMSXdDK01iWmUrcytiWFFC?=
 =?iso-2022-jp?B?bFE1NWZramZiaUhEaEhNSCtPVTI2Y2hsN2VLUGNkNUw2R3BaTGFxaVFB?=
 =?iso-2022-jp?B?S0t1MVNlSVJuUUJvTndaTGlJK2gza2MwdlF2UlE4ZU9iYkF0TmZ6dFU4?=
 =?iso-2022-jp?B?cUdZSHRNVVhsTXVZZ1pPc293YTJIdFlTeXA5K2t2alBhNTllVHRQYlBn?=
 =?iso-2022-jp?B?Y3p5RmF4VWN4RTFrL2x5eEhLMmRPeHZwVVRlS3VPV0VPU3hmbnp2YzNS?=
 =?iso-2022-jp?B?YTlhRktabz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0682a3db-2ba6-4c77-6110-08da4dfccce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 11:55:39.0741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/99KZnX6t+CyzIu7sXMi3fOxkmimNFgDqLhh1iOvJhfF8v8KppUQapqALYZemoVE/7JTzYrJTmdXMbOhLrnVNm92XpkXH4MWqz5shRNJ30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4767
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comment.

> Why does userspace want to even do this?

This is because the optimal settings may differ from application to
application.

Examples of performance improvements for applications with simple
memory access characteristics are described in [merit] section.
However, some applications have complex characteristics, so it is
difficult to predict if an application will improve without actually
trying it out.

This is not necessary for all applications. However, I want to provide
as a minimal interface that can be used by those who want to improve
their application even a little.

> How will they do this?

I assume to be used to tune a specific core and execute an application
on that core. The execution example is as follows.

1) The user tunes the parameters of a specific core before executing
   the program.

```
# echo 1024 > /sys/devices/system/cpu/cpu12/cache/index0/prefetch_control/s=
tream_detect_prefetcher_dist
# echo 1024 > /sys/devices/system/cpu/cpu12/cache/index2/prefetch_control/s=
tream_detect_prefetcher_dist
# echo 1024 > /sys/devices/system/cpu/cpu13/cache/index0/prefetch_control/s=
tream_detect_prefetcher_dist
# echo 1024 > /sys/devices/system/cpu/cpu13/cache/index2/prefetch_control/s=
tream_detect_prefetcher_dist
```

2) Execute the program bound to the target core.

```
# taskset -c 12-13 a.out
```

If the interface is exposed, the user can develop a library to execute
1) and 2) operation instead.

> What programs will do this?

It is assumed to be used by programs that execute many continuous
memory access. It may be useful for other applications, but I can't
explain them in detail right away.

> And why isn't just automatic and why does this hardware require manual
> intervention to work properly?

It is difficult for the hardware to determine the optimal parameters
in advance. Therefore, I think that the register is provided to change
the behavior of the hardware.
