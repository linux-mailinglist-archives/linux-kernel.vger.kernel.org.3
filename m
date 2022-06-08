Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2716C5427C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbiFHHOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354503AbiFHGTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:19:38 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7F830541;
        Tue,  7 Jun 2022 23:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1654668732; x=1686204732;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5VYIEsm8feSd1BvMHGQLOW9BHVE5rJbLu6iGLQWSESk=;
  b=KP4UUhDPcGZsNOlpnT4ARUu0mmKzRfcNDesgG/uMMOntrC0m3bTBU1B6
   RGU++3mUVPknD3tEDQPF6GfukWWBSgA20XJ00OuLU9EOPA+k66/zvsx76
   dv3u5XU06ZppFfLv46V33XMr3NpwykjW4KGghTGsWHomn/1Z3J2Pn1bww
   ah6quHkRlBnsXjJiu1CSf+KzvJgkWv21Xe+2UINmq7VkDUypMDP0WK2IT
   yleCdhLJIksL1D7zrnWSpUoHJoj5pcB4G27z3X3G34cnKBj6jvDTnpZdm
   ucZDpPgehFAXxZ/PQyHNJK62ZC48jY+lQScJ8QRcHXKIlJcfJCRSkWo/Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="58943441"
X-IronPort-AV: E=Sophos;i="5.91,285,1647270000"; 
   d="scan'208";a="58943441"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 15:12:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMNW9ikwu6LWwRr6mafoc0dmcfPt7dNfvJp/6vhXKCMH9anI2zylszEcav1UCfybBQHEfHtJeRBlNwgXDSG8KxwFwCNKMYQhDafOM1De0trbYQw4g+DXfF0RgCtWtTiWVvwOZKMIko+WIW1abp9MpWQzEbx7swnf05VEtY1GkPtfHT3Yie3WAmsBEKWSmN9NB9pjDeqYkNVkSnMVSIQYJ0wXlWAMt+I7T+mbS+E6tgl4kcj7t8SDgP6XHwD6xNu1r6b9osQARjRohPMAz+LiRViDkbTlmkTTp7k9Ltd5y9Ejk1vRrKMi9fn1W38nyH+xmtE45+XUaBpmGZWd0sCj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VYIEsm8feSd1BvMHGQLOW9BHVE5rJbLu6iGLQWSESk=;
 b=gf9OUoTA7LHUAHzo5WSrLxwDXoSfDVsDlP/80FVTfvmqj92ai8m87+s6nz2OAamMpsZ3w38qbo9xolyQnesOcKIiFtPBE7jMUWt1EfRutDXe/+5JuEzFPkpQq2eyRpAbgD+0N1e0LW3RDOEuhlpHN5e3eElcKlVwXttv6gckqCAwSkpJ8g7LPlUUSQDVS/lkzRWylnX8Zzp3rmCjOWX5mVzz4UF6IMJ24EKPXPvAvJVWVUcZSQcqBae8fFxNDg/p2ammOC/mWL1rlZ3seGA4Nz+rwmQhMfMS7JULIuEY01RRA2RFd6dW+uYYMlR3cwpS5bfe1BrEvFqpeOvvdVt2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VYIEsm8feSd1BvMHGQLOW9BHVE5rJbLu6iGLQWSESk=;
 b=phWi5SaTKcg1a5pJ54HV8Mr4b6x8uFur8pHtkzkyQ8F0PFzd3zU6Ssh5E30JoGgelpnEY8cUxJcN6n62VmIVOXPHVfAUXHfXdJfXPFMkbTeEpk4/KgparaDKs9UzIe8Qfc2g2K/udMqPP4Z7L4SR5Nnr79bx9rkbOmMBlQrZE8Q=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYWPR01MB9407.jpnprd01.prod.outlook.com (2603:1096:400:1a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 06:11:58 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8%7]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 06:11:58 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Randy Dunlap' <rdunlap@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Subject: RE: [PATCH v5 5/6] x86: Add Kconfig/Makefile to build hardware
 prefetch control driver
Thread-Topic: [PATCH v5 5/6] x86: Add Kconfig/Makefile to build hardware
 prefetch control driver
Thread-Index: AQHYemcz5MgOlHNqREW2vDJ6FRqGWq1EBFEAgADxQMA=
Date:   Wed, 8 Jun 2022 06:11:58 +0000
Message-ID: <OSBPR01MB203790CB7D9A00CDEC3F9C1680A49@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <20220607120530.2447112-6-tarumizu.kohei@fujitsu.com>
 <96f4cf1f-bd1e-ae5b-172b-fea572a32500@infradead.org>
In-Reply-To: <96f4cf1f-bd1e-ae5b-172b-fea572a32500@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NDM5Mjc2NzctMGI1OS00ZDM0LTgyMGYtNTlmYTU1ZDhi?=
 =?utf-8?B?Yjc1O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wNi0wOFQwNTowNDowOVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 749aa8df-6a3b-42a1-02fa-08da4915cbc5
x-ms-traffictypediagnostic: TYWPR01MB9407:EE_
x-microsoft-antispam-prvs: <TYWPR01MB940769D91722BECBBC43CC6680A49@TYWPR01MB9407.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRFnWCZfCc2KHtC4X67l4Oo4vLZyD+IADyOSDmMvVlkvGoGQD6HpTK8UFyZrVn89U03FY2lm5b58QmaDAjaMIkMk3eqUAlgMxu+XyiXPnp9aDaVUacWIYd3fhGOAKgBizyHyeOpFEyL2t7/sP6YUPpgRB4RBIDnF36xm0aada7dW6mSEo3mobGwh5RvhsBE57Czzf78P1nSlLStDdAeFZBqlq9zXY7zNTEGrxLjSoh4s6a9rYLlF9urxVdaL/3YT0K1VWnsUZjPgc9Ami36vPzHG0azFvgnCoW1F+z3JVOTUklGjGXjhGTPmNxfVBaYE6JGfzZ31SIr6GjjySgWMh0AFmMMpDQ3R6OUOeL/cOR7+BWkdCWOsK466zV8O32XKYRqhF7pyujEKCotoB/6s1dPryN/TwwDQ5S7M3SeK/4HnBrevprmuqZH9pDNlzOMs5Lr0gTEqSqwZTIRmjOwYG9hBbAncJPMq5wDQTtfvVejQqtnmnSye0HG1ma6Vqg2uqhoHv1C1F8EW0jCiOH3ifmyJ68Aa5H9kMiiLu1pzi1nRSdTZxCPwFTzheksln6u+pocZJu6Bsb7clZLHIOPJ9lPOFRcxmDLuSNICR/yBOUiw5XqaCT7aHtnk+lDH+J2naeGZeVHhBlSp1THN6Oz8hkeXybHo8xq18foSGHoGS7V1Z7lWyBqs0Fs5XtPZxGvzOag33fB0kiCssJYUhM5yRQZ9yHx6O/cRFMjgdXZ6gD4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66946007)(66556008)(5660300002)(2906002)(55016003)(71200400001)(9686003)(558084003)(26005)(38070700005)(316002)(186003)(6506007)(7696005)(33656002)(76116006)(38100700002)(66476007)(66446008)(8676002)(64756008)(82960400001)(508600001)(110136005)(85182001)(52536014)(122000001)(921005)(86362001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkpROFpPam9JZjM3ZFBLSFVOVW5qQ3lFNDNabk5Bb1ZGNEV2SnhIL2F4UFhK?=
 =?utf-8?B?RUFGNnhGUU1hY3hnSUtKbklWbUFNYnZZRHk5U1UrMkkrVHJVTVFoUVlpWDhR?=
 =?utf-8?B?WUFoMEw3cTFKK3REbE5wSW5uRmExWWhNVXJzb3RUeWxSMEoydmlub0RYMVNY?=
 =?utf-8?B?MDFYdTAvMU1FbDl0bXdNM1ZkTXNaNFd5WjAvOWl5L3FMZ24zZ2pQNFp6WHp1?=
 =?utf-8?B?QjVBZUhMN3I0TldtWTVBd0dFRHhvZ3pWSnQrZnQwNjVmVkJ1TFhoejluTlA2?=
 =?utf-8?B?STZxR1FhNUtyYlh5dWdqbXljbDExVCs1Z2JvZlJvaWtmTnhOMVNHcXNJK1pQ?=
 =?utf-8?B?bkI0N1ZjcDJxR1dRcmJXMTJGN09yMGMyRTVMQm1CTXJjR1RqbWZBK2hESlI4?=
 =?utf-8?B?cUlJanN3eWkvc0NiTEp4bTFXK2dFTXRXVUFXYXI0dyt3R3dZK29Jb0xsRFV1?=
 =?utf-8?B?S0orQ2cxd2pJZU53Q2xWVktvTWJHQnFHRnJ5Vy9qNXZBS0RhUnBjR09YUE45?=
 =?utf-8?B?MDNMaU5ZN3NPSjRoekpsRHNWa1pPOTUrbzlVQTZ6cUs3QVZxVXB2M2xjMTly?=
 =?utf-8?B?d1VMM3FXWVFxRytZWm9FbmdSQkRMbUtQS0dJSktzMnFJTmlpMDRKendaRU1o?=
 =?utf-8?B?a2RYTndxeTY2cEdySmd4WHRIVTNHWFVJcEhkcWU3dzhSY3hrREJMclpETDFP?=
 =?utf-8?B?dm1RK0JDRDBQZzJCMzdaaFBNVEVZRlRqMFhOZUcwYlV0NXovaWF5N1ZpcCsz?=
 =?utf-8?B?cVhjSzVRbkxtVjVtYU95QjdPazR0Q3BzcDJQanpTdzNIcmxZb3VXbWtRU01y?=
 =?utf-8?B?U1ByazNOdGFwT2pHNTBxQlZlS1RvblFwbnlvdk1UbXJEOFptWUMrelM1RGVH?=
 =?utf-8?B?aENhYjJva1RLeG9NVlBCMTE3V3V0Szk5UGh2Zk9jQVpMKzlNcXBHU09UQmFZ?=
 =?utf-8?B?dkcxelZqbEdNOE5KUzB5enFKQVE1aFY3Y3NnVmdObkZnd2N2eklYMHZRRHdu?=
 =?utf-8?B?RFhFYm9WU1NSaW5COHNxTzhLR1Vyc0VaY3FVZGlJbG1Vc1V1YWFxTHdxSUtL?=
 =?utf-8?B?S1JiRGc5MDJtK2dxYllHeUdEUFlsalFBVXpqTENQQXNGQjVPV3AraWxLU3hx?=
 =?utf-8?B?ZVZnbkprYVh1MU5aQUVEVGoydjVMbGlHTGg0WHFWd2hFOXZNQnJnSUhCbG1w?=
 =?utf-8?B?SVZhYnFYZy8rc1JuZkxrTmtqL2ptV2RsL2ZjeHhDS1B4TENlNTU5ZFZZdkFk?=
 =?utf-8?B?WXQwa0ZKaE1lN051d2xrMkM1RUFDdlc3MzF1ODRkZmZ6aUdKdVhFK3k5Q2s3?=
 =?utf-8?B?NHVYb1FaMGFmcG9DaGM5UWRmSzdGdkp2WmJQVmlyOEFHNElhdVFvdE9OYjVS?=
 =?utf-8?B?L3hQSHVkVUlQNlRXMFpDSnM5bEpobHR4Zmc5am93K0R1VzE4VjRGNC9GWGlj?=
 =?utf-8?B?a2c0NVNIN2NPd05oTEpJeUdSc2g5Tmpvby9sYlFGYXFZKzBPaUEwRTRpTUti?=
 =?utf-8?B?dk4wbThPYkRWbFovTGEyVlA2ZCs5TDVsRWZ0bDJseDJRR0dPekZVdXRFakg2?=
 =?utf-8?B?MWRyZitBbitBSWdFWU5YZytwYWpJWmlYZ1pTU1Z3SjExL1U4ZmMwb0xoVjZ3?=
 =?utf-8?B?Y2hDN29sNmxkS0hzdVhIMy9HZC9wcGFTeVh5anNrMzF3dFU4V2k5Y0lUNGdu?=
 =?utf-8?B?VnFjam9GeDJ1ZWxxRTlzL1NaRDZjL1BGQXlFZ3dIK2VwMnBNbHdkVWlZeHIr?=
 =?utf-8?B?SmNsa0ZaVEZhSndPNzN6QVptZDdnZjFuaVV2QVpPQkpXU2w1a0c3Rjd3RUli?=
 =?utf-8?B?aitCbFVyUkNyMjd2TjRuVlpiSXZzY2Z2ZmwyMDJRajZKRUZ6cXk0Q0Y1T2Ro?=
 =?utf-8?B?VGJsUk5NcEpmblJuY2dJR3ZFbjJkSG85QlhFK3hsSGo5SDFYeDNTK1ViaXRP?=
 =?utf-8?B?SkZ0Y0I3eFdRdHhHMjhoWjBnTkhSOWR5YTR1QzJqUlhnVHVCb3lLOXl3VG93?=
 =?utf-8?B?dEo2Rm9mS3R4Q0lveWZyZlgxeUh5ZmxwcGVna2IvT2VFTG9RaHdFWUpibHVW?=
 =?utf-8?B?d2t3TDVLdEthSjBjakFKTkN1VkpHQ3FwTlEyUWtpNjlpTkRPbzQ3YXNCUHNZ?=
 =?utf-8?B?dm9RSzN2LzNmWWVPNFh0THVwaU5qdzM2RDJocmJhQk1meENmU0orV2U0U1dq?=
 =?utf-8?B?eW1abXZ1b0dBUmNib1lnMWkvREN0NGRsN3dCUUxCUlI5TStrMFJ2VkZKM2VS?=
 =?utf-8?B?Wi92YjlNbk9rYmhreHkxTXMvYzFFUHFGUmdNYXM1RFNSS21qVkhROThCYXNO?=
 =?utf-8?B?L3hrR0IrckhNbkJiM1BYaExIVXo5TitwY01Qbzhwc2FQVGJyU213U1pTSSt5?=
 =?utf-8?Q?yuYBuKu327L4tnHc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749aa8df-6a3b-42a1-02fa-08da4915cbc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 06:11:58.8017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBaV++iHJXkjnhKU2906b388qVb+FwUnCfXWW+jvDi/qBIj/u8W9rRZu1HSo4AAAEqcL8AC1KOtWimSlzyrogqOfGoUZZ6/24R8yNwV/BwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9407
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsJICB3aGljaCBjYW4gY29udHJvbCB0aGUgaGFyZHdhcmUgcHJlZmVjaCBiZWhhdmlvci4g
SWYgdGhlIHByb2Nlc3Nvcg0KPiANCj4gCSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHByZWZldGNoDQo+IA0KDQpJJ2xsIGZpeCBpdCwgdGhhbmsgeW91Lg0K
