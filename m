Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD814A5BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbiBAMEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:04:33 -0500
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:44739 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237661AbiBAMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:04:16 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Feb 2022 07:04:16 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643717057; x=1675253057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HcmGHzNrDvE9mcS7PialAowwhzY2NrAbxJtW1izGtVw=;
  b=xt2xLE9zLQiAgLbpigcmIn5nrTCXfS1XG19rErNSNLp/6Xusy1X+AMM/
   +JPjWLe4T8Os+QJMbbJYUuTpcNMNgnNhVC1jOZnaE5SfB6Pb8rf3HP151
   nkZTAW77y9yW6vGXQ3eP8yLhiiH+3RAnNyD4LtSSBtQKmN2USvshPMX82
   arDPcN530kQBW+3YZ6liizd/XfzUwpHhmPJWIX3YUeC5l/Ektl97uV027
   FxWSBtTefjLigX280RZuMcxV6AjuvYLBhIOe5BLP9CpW90nD5hngnNL8C
   YOqWjTko9bixeLjnm4iQGTGVpI9XKGcERWTpVlKMS63SiXqn6hp2gQOQY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="48840013"
X-IronPort-AV: E=Sophos;i="5.88,333,1635174000"; 
   d="scan'208";a="48840013"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 20:57:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ2IdyCbcqAmyLrbZEJmUz7sHguN7mio9ilQRf6v6k90eEgKmBriL7LWc2Nm0EAQRVwP/JnNqG5MA7VANFbudCZLnvsqO8TOqsFxHt9zs+CjwMBiqg9vOH/By2s95584/QHvPY+BAUvqxe4bowrrHcwTguGfCWRNwQwH0L8WQkPEozQP093I5QBK1INz7OB9a4b7ApgUgKSGcdd9u/AVwvb4oBXOHASsz+9gWCxF/50qfZADdFWyBhSYtIuT5xY1mRCqOGYUvFsqp5/9fXsQBJrVKTATN8sSr0q0WpSR6yEu7brAmLpd0dE4wuOB9Sgk0iIHZ3k1R2ICeoaEx/Izog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcmGHzNrDvE9mcS7PialAowwhzY2NrAbxJtW1izGtVw=;
 b=X8hVKd+nQHDxW2YguzqbFIFBPDQpCWkpntsm1w3r+k3d8INW48lG3TGm5Hf3BQGZcRg/R76sJT50RcIpoa21PRN6KgINCFP4oUwELFbrpjAQ5M237z0ax/nTolPhDWHD7kOl5bIBqpDWFdTgJrvGu8eqb7s2MSRtyrRB0fONV8AKXQWmpffLhRUt8oiYQMIkX/xNrvE5oHjcipwth5VDL60AHS5sf4i0Wno6sWs7RtsI6XjsyJuX6cfaiFi+npru3pB/Z19i+Sp7263NXRsXBbJFJFML0OrtFLDa8Chl1xhA47XjTgWYfTzn7hTRA5xa4DyK7BgZfH0+I5+AnrLGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcmGHzNrDvE9mcS7PialAowwhzY2NrAbxJtW1izGtVw=;
 b=cnRfILrsSL1Yr27GmY7CDCMqfZz2AzC4o6ocyOaokDjhay2Q0g51Bxy8hCzsmSqPZuOoP7b1xQAOb3ih51dhj1UWXQSWcVTHkBwZ1/X9dIVkQC4ltcMYioWKhjKDVdxToY/Av5JZvUW45CgyW6KcuJ57js3SUCJHFtTORnou+Qc=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSBPR01MB4661.jpnprd01.prod.outlook.com (2603:1096:604:76::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Tue, 1 Feb
 2022 11:56:59 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::b596:877c:caf1:e443]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::b596:877c:caf1:e443%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 11:56:59 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Sudeep Holla' <sudeep.holla@arm.com>
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
Thread-Index: AQHYEbs2rD8REiPg/U+HaUWHy1epU6x1HZ8AgAmD11A=
Date:   Tue, 1 Feb 2022 11:56:59 +0000
Message-ID: <OSBPR01MB2037E92722D372D48F54438E80269@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
 <20220125071414.811344-6-tarumizu.kohei@fujitsu.com>
 <20220126103614.pcrcuc2kzklkq3xa@bogus>
In-Reply-To: <20220126103614.pcrcuc2kzklkq3xa@bogus>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98d781a3-d2b8-4ae5-aa82-08d9e579f3da
x-ms-traffictypediagnostic: OSBPR01MB4661:EE_
x-microsoft-antispam-prvs: <OSBPR01MB466194AF9CE3AA3CFFFE679C80269@OSBPR01MB4661.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMLCmn0EiYp5b0dQZJxaZmfdaXw3QGkJdTg2RAq93R0jbAFgYIeTWkN8uhFbujq5Ifk1MZC85baA5D2OZsHOZ5hG60ej7RJ9Rj+guZRxdueDh/U9fecRX5CW+pn9QbiH70ahhtO9OqZw8x0N0S0FhjaLEaL8InE0ksjlTip5V8J0ElNLJ8r05Ij8Z4pRQokp/BGGgIEc6+s1yFkm8nvfh4Bvp9ozZM1sBerg1P7wk2KCtseZFdEDF6KZwTfJr3lpifJ7BAtvGXBwOr6VTiymhjA09/I2GHFLZmOz2rfaiDxbEssm9n7p2+mE0Yw5DuAbEqCQxUKydXM09sUWiRBe2zjUWZe+1B3UsLqUwK02MFUIJFYfy23tH72dslMEyq7ZU0+BijgcwlZwx+lx6xEznXEztzPyl9NMuiv8BD19XAm52Rpl/H26/9ppMZet07cYEVhkFs6MMc5Tqxm2T9CJQtXatgSGU8YQ7rOUvLMQgI8yU8zWw9DoEiV/LBbgeOgOz//X0xEIOJWobTd+vqHyKgK/DpykCj69JJDvPxe+PaJ70nxwAqalhr7GHTxFmeU3jWD1XyCqtYJR/CKqX0926nzEXNbhAZztWzrwk2Id1Gq4HxflBe58tfFReHI4cDV0axFkZMJnzB0Z0YeI4TRNwtctP5DALc4z6ue4yOLdqjgeZKQhZsfCbm4G3zB7Srwvcn9ENBY3TuOhdkP4J4OqHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(85182001)(38070700005)(6916009)(54906003)(508600001)(83380400001)(316002)(52536014)(86362001)(186003)(26005)(4326008)(2906002)(8676002)(4744005)(8936002)(7416002)(71200400001)(82960400001)(55016003)(66556008)(64756008)(66476007)(66946007)(66446008)(38100700002)(5660300002)(76116006)(33656002)(122000001)(6506007)(9686003)(7696005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?R2RLeTZhb1hZeEZkeG05MFVlOFBOUFVSamE2WDFDZkFWWFE1UkIyUDFX?=
 =?iso-2022-jp?B?bXhhYXhocFFYTUllVW5JR3JoOUFFRE8yeitJcTY1L2NTMTFiWExkNS96?=
 =?iso-2022-jp?B?MnhydmtGVFRrOXM2Zlp0cUNFNTdhRnlobDRLS1R0Nk5IQzlId3JrM285?=
 =?iso-2022-jp?B?Sk8rVWFuSVRscjVLcnFuVCt3dVpGM3BTMVlSS1d3akpoNlBhbWc2Zk5P?=
 =?iso-2022-jp?B?WnBqakt4U1laY1VNeVErQXRIZm5Xa0NBUzM4Z0NqSFpKbUozUVNLWWMy?=
 =?iso-2022-jp?B?RkR4WkNDTW9vWERrZS9YaUhrT3ZjbXh6eER4ZzB1ZklkV2QyR2s4S1dR?=
 =?iso-2022-jp?B?Y2VqNk45Tm4ydmdlRzBXSjBYQmdtNnRkd01PbG5EREhGd2NXR0dKRXQw?=
 =?iso-2022-jp?B?KzQzZzZWazhXTFR1UkpQTHpGVlNhNTNld1dQUWZNUmZoZGJ5cE9LTy85?=
 =?iso-2022-jp?B?cmJ6SE9HUjg4cStWUmtaNG92QXkzU2l4M3ZDZ29XbFR4TTBBb0c3WkpB?=
 =?iso-2022-jp?B?UVBqc25zeGdmTklLdjNMSUFiK3dLT0lmam05SXdIZnlQWjFGOHJJSi8x?=
 =?iso-2022-jp?B?clhjZ1k4SUg3ZDJObzR4b1BEQnVZUmlDUmk5eW1hK1RXeWIxV1ZqQms5?=
 =?iso-2022-jp?B?RlhOemdZUXFuek1uSzVRWGpWVTkxUXgzck0vY0VtQlUwbmlDWGgvdTVn?=
 =?iso-2022-jp?B?dmUvaWcreGlLTmFETUd2Mk1DOWFuaHVZMDRtZmJ1Y2VzNnlELzIrK2dl?=
 =?iso-2022-jp?B?RXRJYWo5TUhvU200MVFvV0VjbFc5Rzc4Sk0zUERyY3MraFQ4UzJ4WjE0?=
 =?iso-2022-jp?B?TDFZb2RQVGxQRXYwMThtcmlFOFRoM3c1ZWhGVDJ6WHo1OHR4T3pONXFl?=
 =?iso-2022-jp?B?bVdMb3VpVVJueitQQWx0VkJxMm9wMW1jM1BTbUVZZWN5VnYyR2dFQmI4?=
 =?iso-2022-jp?B?QmR5ZFZvSlpoZ01PMzhjaDFFTzNFeisyeDAxU1VsOGVMQ0FYZ1hGWWh1?=
 =?iso-2022-jp?B?MUJuMWlKd0c5dmlHQVVYZWdYYTNCQU1IaWtFeGZLcHIzNk12d3dpb1Vq?=
 =?iso-2022-jp?B?NlY1OElDU0ZzdXlvcnhHekZVQ3phNEpOeUwxZGl4dlRpcnhtUmhQM2lq?=
 =?iso-2022-jp?B?ZktEVy9EeTE2ZEFoQitLNWhEcnpUVUVvRVFpTW9sZ0NseEMvWkdvQUdm?=
 =?iso-2022-jp?B?SlEwekc2THAzODZHVDM2NERyVnkydDR3YW9oQlMvUXZlSEs1Z1d0Qnln?=
 =?iso-2022-jp?B?eUV4UEx4UHVQbklGd2x6dy8rTnlHejNhYjA0dHBGYnNzajBrOHM5KzUv?=
 =?iso-2022-jp?B?WERJTVRrckZEa05aeDg0cFMxOWxwWnNUSFBYdjZURzFUSXhSL1FUVVpM?=
 =?iso-2022-jp?B?UmpKK1lLZmp6YmFZeVNmNy9FT1pnVDV6azczVjc3YU9ldTlkSEliUXVQ?=
 =?iso-2022-jp?B?Y1EweHAvcFhsdzYrV2JQbnlROUdoOUFBVDVvN0pqNTNPMUxsMjIyOTlD?=
 =?iso-2022-jp?B?YVFGWGxtSVZSU2VOWFg5emJPOUs4aHAzV0ZhRTVmQlMzYllxNmFpNm5y?=
 =?iso-2022-jp?B?UGZ0dWZlckQ2MFVESkR6MURYT0ZKcG42ampGMmZ4VTFKOXU0ZzJXc3E2?=
 =?iso-2022-jp?B?NkVOMk5xU2hqVjZQVDVOSFJIMEs2Mzlld2sxZWNuN2E1aVZiamxCRW5y?=
 =?iso-2022-jp?B?aEVhSDFQR3VrOEtBZWx5NnpWdW8rQnBSS3l2R1V4T0w4bVI4QUdzRFZk?=
 =?iso-2022-jp?B?VlZtaTgwZ3Y3NlV0czVtWEZvSTFzeXAvKzgvdXIrMDB4Z2ltSFl4M1po?=
 =?iso-2022-jp?B?T1U4WU02WW1jeDV6eDBYTU5FOHNudExpWStUSVh2RnorU3BTWVYzVndh?=
 =?iso-2022-jp?B?RGo4a09SdW00UTFodE96OWRBcXFOWTY2WHc1Z0RKamI4R3pOLzFPL2Fz?=
 =?iso-2022-jp?B?U3NQZUhhSmUyUWNpS0Y3NWZGTVlPQmIwbVFobUNvajVuNkZLeFR2L0tx?=
 =?iso-2022-jp?B?SU9WMFErVGFyRlJLVVJodDgyV0FGaDdYQUlXa0FxaDF3VldpUlBDVDlI?=
 =?iso-2022-jp?B?b1dXSkppbzRTdDZUUFZsUWdyRTJWbVFncnJZU1ljVElGS0loMkFqMmNJ?=
 =?iso-2022-jp?B?UmNPVzkrK3U0YmEvcVRHck5jMGJEQU1TVmxTWUNzamlONWpOTDlmNEcx?=
 =?iso-2022-jp?B?UnRGS1BMdWU2Y0dSL3U5alRqcmRGSDI1ejBqbFBhYTJ4RzdmSEg0dm9n?=
 =?iso-2022-jp?B?MFliSXRJQnFxa1dwTXFiV1h1Lzd4T2hiZThuViswUWJpaHhrY0ZVYWJ5?=
 =?iso-2022-jp?B?TUIxQXIwdzZtU0lNcXFJbU5BMlNBbkw2Vi9uL1B5VXA0ZExNUEh1VXpZ?=
 =?iso-2022-jp?B?UFRwTUVsSk94SnNwbU5WZW5ST0Y5MjNsODY0T0l4UHhDZmQxQ1U0cUhh?=
 =?iso-2022-jp?B?YnEzT3FRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d781a3-d2b8-4ae5-aa82-08d9e579f3da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 11:56:59.4164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmpEaIBbGxymWfhRVC9zSWGNBVd4hTN+xS46l/ONTDKO6dIZTw2jt9fve0ojgA8DRZ6NmKQD9MLamGQa/6WvT0kNSPnIXOA34Ru+qkdkT0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4661
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am assuming this is ACPI enabled system.

Yes, it is ACPI enabled system.

> This looks bit hacky in my opinion. Before I explore better way of adding=
 it, I would
> like to check if you have explored ways to add PPTT reading these registe=
rs from
> UEFI/EDK2 as PPTT has other topology information which you will need anyw=
ays.
> That would simplify handling of these cacheinfo sysfs in the kernel. Let =
me know
> what are your thoughts ?

The latest firmware of ARM64 machine, FX700 with the A64FX processor
does not support PPTT.
I think adding PPTT is the best way to generate cacheinfo sysfs.
However, it is difficult to modify the firmware to add PPTT, so
it is not clear when it will be possible.
Therefore, I would like to implement the function in the kernel on
the condition that firmware does not support PPTT.
