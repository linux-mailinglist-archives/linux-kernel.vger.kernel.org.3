Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CB856B730
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiGHKWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiGHKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:22:31 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Jul 2022 03:22:30 PDT
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4EF17A81
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657275751; x=1688811751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jWu16ReoKWjOxCmt0OmCuy1hkLMjHf9TpoNcEXEV5fs=;
  b=zng3StsHLmH2SBG+K9Mj/FQS1Boge3gyfSRQD+GAQydTyK9jPAP+8jam
   j1aVR9cq0aBNxnJ8zMLFkc++USrq+33fV4At6Oxv9F6x6lmJMnPIgEmKv
   klCuFm5azjGDMA1mR2SIhES0OE7GvyY2FharB8qqkYBNgm0FWWdevUyVw
   Kx6T4rIZaZbBj9TZJUjZ6KPVeiz1v9oTk1r2KVGelBGTJHXwKrbHJyTRK
   iaElw7MRNntOLoD3Z8Cfh7+TGqX8gz+vclSA7bQRCZIYtFSeQf8d9Ij7y
   DVrJ6SRMoOWfB719IEJCsJXHrb7liu/7G4aaIbbiFBKJ1Wg5J3/OZkbxn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="67805796"
X-IronPort-AV: E=Sophos;i="5.92,255,1650898800"; 
   d="scan'208";a="67805796"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 19:21:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgJ19wEyunaXC2DrJhjOJ1jmON4WfIuAeynDHGhAADCvLjSG8cSHWB1+ohJ1LpkMNFfnIqcUxRFR3wiq8BYKPK2sJWEFuHtlibdaksEp+fOCbaAi9wHDT1CDPUhntujg1DWy/kH7E/OG/d/oCMjo7M2KbrAmU2cZDlgqRn+iygvRWz3tUw08KS5j3YqkFnNfbSeN12M6qLg1w8+WqsP4ai9SPbIzhbkwhZNaehQbxHYtaSOylWuhYr4VH6a4EIP7ryGXJ3lsePel3Z9flPVfFKGFBk9FYW6NLN3AcvQOPYGlJS71mVcStuvNwEfyb8chqgh4gYB7aRIo6KN0lziDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWu16ReoKWjOxCmt0OmCuy1hkLMjHf9TpoNcEXEV5fs=;
 b=jhZ8vINuYPCCxJ+1fJClaykZtuLW6vki1dARc5AWeb11h6TjFHt1DA7CkCx/MZ8T076HYM/vZwB93UROK8ZjQJY1lzUAsAhvN7TY4WP1Oep0sHSoE01mIrn1nmVBYjHXGiYk2WCAgj9GqE+158m31Y2RlT6JuMb63vWdpI3szVjNXGmlrd98Bi58NNOk/GVDlUOYCb/BgrZ0n7quGqfB09FZ2/LV+DsgP/irTgs4JVzYgXkjF1PHZLJXm5boale/DGWwRLb8ZBdjGW3qdAXtOnJPToCsQRBVEk+xizV7FKO4QK/4lo2rdmSsPsXv2WvdmXAig2BXZkoGLbvlx0BGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWu16ReoKWjOxCmt0OmCuy1hkLMjHf9TpoNcEXEV5fs=;
 b=gZPBvHCCaVq7hCwdWtI5UEpJ+nNq4nr68f1wFoUSPpMwJNd9SpawpQK2QR8gR3o1rOuYYPrbsSKahSyx4nZKx/LdWy74F7z8T2+J2jgPV4Mb4qocVswERVrEvzJjhPR1To6/bnrAJbcsX0Wg2Vq2/JZ1/a/ekeK10y1syS2Rl7Q=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSAPR01MB5107.jpnprd01.prod.outlook.com (2603:1096:604:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 10:21:18 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::3151:373d:fb9d:afd1]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::3151:373d:fb9d:afd1%7]) with mapi id 15.20.5395.021; Fri, 8 Jul 2022
 10:21:18 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Sudeep Holla' <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/8] arm64: Create cache sysfs directory without ACPI PPTT
 for hardware prefetch control
Thread-Topic: [PATCH 5/8] arm64: Create cache sysfs directory without ACPI
 PPTT for hardware prefetch control
Thread-Index: AQHYEbs2rD8REiPg/U+HaUWHy1epU6x1HZ8AgAmD11CA9VlfgIAAAbYAgAFFgUA=
Date:   Fri, 8 Jul 2022 10:21:18 +0000
Message-ID: <OSBPR01MB2037F125E8B3CA9483931E0E80829@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
 <20220125071414.811344-6-tarumizu.kohei@fujitsu.com>
 <20220126103614.pcrcuc2kzklkq3xa@bogus>
 <OSBPR01MB2037E92722D372D48F54438E80269@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <4b99cf3c-f40b-cba7-2fa2-b6b311859776@arm.com>
 <20220707144404.pm3qtgfo6fsik77d@bogus>
In-Reply-To: <20220707144404.pm3qtgfo6fsik77d@bogus>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9MWI5ZWJkNWYtZjUxOC00MWQwLTkwMGItNzBh?=
 =?iso-2022-jp?B?OTdlYTc4ZDUwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjItMDctMDhUMTA6MDk6MDVaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af0ad055-a3ec-433c-c611-08da60cb9911
x-ms-traffictypediagnostic: OSAPR01MB5107:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vkQBgtyQ1U3hxrl+vFA3M9SY8MCEFbWOSNGJUFurnWKNmNu9SKyeeBcenH6NeQmQyq7y//v3/6VFlsDUr+sHiTg/C/f+7iky3vTrP/ke09YWycxEGb/vxK8bbb97z1LJ8LznrR74ax8k4zMCXyVvCOMzOmHMJguTZOuGt3i4XJ+tNvDqkHWrb5z2Zr0jkkJIM5FLyZxYYBXgCM5jXjp7yRJmgLe9I2qPRpMb2rxC1c03ARgc0n/Bu7hd+W+M36dKjumuDG37bjjCQ//RMRvnybCsPHDzc5ZLxbPefUw5nOjQEFb6TlkYk8UGAkVmGvKtBScdVUOGY0rjkVatxNy6TkM6GATixVvSglrHdRmV2IjD14vJdtseEeuXgODllsN5uhyaIceQ3jx51baXHjh9HPfc0kyqo+OmrKRMX5WfTdOiEj7a1KFHvJppN02KZ6jfuPT5JnNR+KkxQJ6k963vy4EHbEaJkdoggf67d4AZ+7OmC3VKB0pKgNPi9CaoAW7OH6Ls2IOMkTB9Bm30zAYVY4qTpgi0NbUP3DhJx+kxtPHoXrNIfbIYRmPXrS9CMkMUayw3vldS2KA0MufQKZgx64QDIo4kv5713bXLqN3sLLPm9WyXkqutZWaNcbhdXcSrLx3Fw+cLbeDBFiI38FpvOw1xGnBWtZTe0J2v2K4Pl0TznpfHMCssce+kb737/wnNAyv8liX4hV5njCht4OBmtW8zY9zn4AxJmYra93pLp4s/H+GQxauO04ySMerLIoS9Ddx+dlCpWYqgLmxRrweJqBNG8vICFD5NxI6Y+zFyaSuEqaX4kEVbw2Zn/IVror+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(7416002)(66946007)(122000001)(9686003)(66476007)(54906003)(8936002)(38070700005)(66556008)(86362001)(26005)(52536014)(8676002)(38100700002)(76116006)(5660300002)(7696005)(6506007)(71200400001)(66446008)(478600001)(4326008)(64756008)(41300700001)(55016003)(186003)(316002)(33656002)(110136005)(2906002)(82960400001)(83380400001)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?V3VVRzlGV3EzVnVzak1iZ0d1VWJDdHArQTZPOE5zbjlRL1VWUndUaVVT?=
 =?iso-2022-jp?B?d0kvVEl4b011c3kxOTZ0NUp3T3hqaUFZeVRuVWVIVjhkMDJ6ODhYRVNj?=
 =?iso-2022-jp?B?NTkzQUhUdnVzU0JxbUw5cDNVM3BUR1VSTFZ5VzBPVHdMVTNSWDlvL0xh?=
 =?iso-2022-jp?B?SVJ1NC9WSzgyWEFvYXV3bzgzUGhOeUQ5ODRXZzB0MTBkenRoaTlMMEUy?=
 =?iso-2022-jp?B?THFvOTlpdnNYMlFHNGZub0lIUVI1SU1jRTV6L0EvN05HSEZsR2FNajE0?=
 =?iso-2022-jp?B?VitFVGQ1WjVDMXo4SUxPalI2TnJnU3NBdUVXQlZCbGFmYUtiTXM0Ynph?=
 =?iso-2022-jp?B?aUlVbnAvVTVaNmJSeXcydWNsaEdXZC9DanRoR2xoc0tCbkp5S2VmVC90?=
 =?iso-2022-jp?B?Q1Zmb3lzNnN0Y2huRDNuaFlmbGpzVk92cXMxUVErWjkzUkpQRWd6RkdI?=
 =?iso-2022-jp?B?S2lveHE5bXRLajBpUG1Ka25pZFZWclJrU2lrbDdIWEtON1ltSGNic2pS?=
 =?iso-2022-jp?B?MysxN1VrY3F3RmkzaVd3Zk1VTVB4OExLYnE2cVRiWnZONHVyVHgrRlc2?=
 =?iso-2022-jp?B?ZFZyOWlxcXRVaHEySm1LbWpjZGFoMWoyZHJxbEFTM1hUK29OSXJHcUwz?=
 =?iso-2022-jp?B?eDJLL3ZTekFnTUF4MUt0eE5nWUhDK0lSOE5Oa2xmZHpVdExtVXdVQ2tG?=
 =?iso-2022-jp?B?SjNsQzNhSUQ4b0EzRTVWYXUxR1BBcTh5d3ozcVNJWjl6VHZsVk93RXU4?=
 =?iso-2022-jp?B?VkNNKzdsU3ZQME1Bb3lBdzREVUppcXU4VGgzOHNscTVVSk9HRHRtWFhi?=
 =?iso-2022-jp?B?a0tWQk9DaWFKM1BMWU1PNWlPWkJmVFJwc3p3UTIwbUluUEVQT2FkaUdT?=
 =?iso-2022-jp?B?QjJ3K2NXYUE1M0tqUWRlL1Z6L1dRTEhTcjlxSnUrY3BDOVZUbG9GYk9H?=
 =?iso-2022-jp?B?L3k5VjhwTGhMajdxbVBKRmJLTnhPTlIwMEEybWJCcmhjVWFYM0M1YS9j?=
 =?iso-2022-jp?B?c0R1RU5sWkxiTU5kQVJ2UW02UHVxb0N3TUVkTGJ6YUdHNHU3MmFaSzVF?=
 =?iso-2022-jp?B?cG9sMEZYMmxyRDZRalplWjBlRE5OSG4zYVFPaUo2YjF4bTExanZ5YzFj?=
 =?iso-2022-jp?B?UTc2NEpqbnkvT2doZUcvQ3BoeStVOXI1L2VtdWRYMnY5eXJUemZYNEE2?=
 =?iso-2022-jp?B?SWR2dVdvaU4rNVpkTmdYWWZDOXJSNmdCVW1uQ3dLUVk2VUxUUHRwSFls?=
 =?iso-2022-jp?B?RXVGSXR6ZjVuNTlKdjBXNXg0bTl0WUgxUTBDV0NJSnpCL2t2YTZNWDBV?=
 =?iso-2022-jp?B?Y1pMeXZjRFI5MkdEQm1YZ0o3RG1KZ2FueU0xMGMxeE9kSU9JTXpvUnhY?=
 =?iso-2022-jp?B?a1d4VWRXUFZkS0d0bVdmOGRLSnV1RVZTOHFkZGkxRnRGYjBJeW5nMVdI?=
 =?iso-2022-jp?B?aDU4TDV4UmNuWW5BM0t5a3l2bGQ1OFo1OFBiMWxrV1MvNXEzYmR3Q01Y?=
 =?iso-2022-jp?B?TjRkK2RkRW0zU1p5aFQzRDltV0l4bHlITXV6NTFIOXUzblQvSWZORUhq?=
 =?iso-2022-jp?B?RERHaHVDb1d6Zld1VzQwejViMG42Y25vcEN5c3dKbWpTSXY1VHN6Qmh3?=
 =?iso-2022-jp?B?dTJKTGdzTnBWdmpYemx1M0NYTUpVQVZuMGVLZXJDTjdCZVAvYmhBWEQ1?=
 =?iso-2022-jp?B?VGE3U2tITWNFSlNjYk1YQVFuMVUrVnZOL1NCUVBrQWlPYmlGU3lYMVZ2?=
 =?iso-2022-jp?B?d0dxMWpHRXNrWTFPS3phcWVKZXBVQkpYR2FXSzFMYnRkdHI0dzI1REpx?=
 =?iso-2022-jp?B?a3EwN3BaTEprWnhwWTFpL2Y5dXpMYk9JZHdZeXZRMlJZaHVmL2ZRZlpw?=
 =?iso-2022-jp?B?RkkycE1hQnozTitZQmtQNi8rbnJ6ekpnY0pqaUt6LzZ3TzJ4blhCNnBj?=
 =?iso-2022-jp?B?RGVLd1B6M2NiTE1qaFpweXo1QllBYXBqRWJSNGRLUmJTd1VPdHJnT2hk?=
 =?iso-2022-jp?B?RHlCSGRpTnhzN21ZWEJtVU92UGc3SEg4bkhHQlRMNmdhVklZV2p2UWdZ?=
 =?iso-2022-jp?B?S044cGJScGQ1WE5BMGcyYWFlVVl4eU8vWW5VU3NnZVBIMjB3ekJpYmJQ?=
 =?iso-2022-jp?B?TDRhZHVISElyMlVOMkNmUnpzNmUzdHNCR290VDVVS3BSS1A5NmhNczdx?=
 =?iso-2022-jp?B?UkUzTVJWbHYzb0xUdkpuQVVheHFOL0ZSTHZmZ0dFTkhBM0w2Q0Y1Mzh2?=
 =?iso-2022-jp?B?YnRYQ1dXdnVtMi9QNkN3QmNJMlMzWVVob1l5elBYVFRFem9KMHVRUGFi?=
 =?iso-2022-jp?B?UUpJMGJya0dmRmcxcmJvWGtoUmk4TmNRbGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0ad055-a3ec-433c-c611-08da60cb9911
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:21:18.8427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpeU+qAtILSEOgraibAg6B0kaMdlM+Keaqh7XWLn9oAMQHrcDJndZoqmQc5XXDkeAXTlmLEUhpJOAkRGNrTyQlsnj/SwzePfn/dLTweC7KE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5107
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the comment.

> > > > I am assuming this is ACPI enabled system.
> > >
> > > Yes, it is ACPI enabled system.
> > >
> > > > This looks bit hacky in my opinion. Before I explore better way of
> > > > adding it, I would like to check if you have explored ways to add
> > > > PPTT reading these registers from
> > > > UEFI/EDK2 as PPTT has other topology information which you will nee=
d
> anyways.
> > > > That would simplify handling of these cacheinfo sysfs in the
> > > > kernel. Let me know what are your thoughts ?
> > >
> > > The latest firmware of ARM64 machine, FX700 with the A64FX processor
> > > does not support PPTT.
> > > I think adding PPTT is the best way to generate cacheinfo sysfs.
> > > However, it is difficult to modify the firmware to add PPTT, so it
> > > is not clear when it will be possible.
> > > Therefore, I would like to implement the function in the kernel on
> > > the condition that firmware does not support PPTT.
> >
> > As a bit of a late comment here, I assume you tried injecting the PPTT
> > via the initrd (directions in admin-guide/acpi/initrd_table_override.tx=
t) then?
> > That is one of the usual kernel workarounds for broken/missing ACPI tab=
les.
> >
> > As mentioned above, besides not providing appropriate topology
> > information to userspace, not having the PPTT is also possibly causing
> > suboptimal scheduling decisions in the kernel itself.
> >
>=20
> Thanks a lot for the suggestion Jeremy. For some reason, I missed to foll=
ow up on
> this after my initial response. Anyways I agree injecting PPTT via initrd=
 is a good
> compromise on systems that are shipped without or broken PPTT. I have tes=
ted
> that to be fully functional on v5.19-rc* on one of the servers shipped wi=
th broken
> PPTT.

I will accept this proposal and try to test injecting PPTT via initrd
on my machine. If there are no problems, I remove this patch in the
next version.
