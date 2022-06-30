Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FC35616B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiF3Jnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiF3Jnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:43:50 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A71740E69;
        Thu, 30 Jun 2022 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656582229; x=1688118229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W0yc1av926wLTaTcH4nk7Lz2caTBheLhjPikjVYmYi8=;
  b=otMTlR85vQmC+RDV+iadeVKCyiDyXrfQ9cHJTLCo5R4wup5P1bYbWdrh
   fQUSkz8B+PGVG5n7YcbUy2WB10OgAepqZ3q18bg8Bd3lGp4Kmb5RRXvvw
   9v6QVXQ8vMnxKOL9R0YUKCZS+Df1CpkuSh3MgPEZeOtGmLh9HbVg3Ok85
   NwiI5I9ra2n217cLDUNHOr/4NLq1vfpkH7KLnRpgF/YOz+IEeY0HPQMym
   hDxy1sQuWu2BnlTrbCKlTSJO1YCdPGBp/wQZLWtpmv9HZTjK8twv73xc/
   PRIA38/rNij6/E6Mt3Y65pZ4xKNadxRydvyNCZyFSIvS6+kDXSXOo330Y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="59348152"
X-IronPort-AV: E=Sophos;i="5.92,233,1650898800"; 
   d="scan'208";a="59348152"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 18:43:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCvXflB+RmuZIKWp7prhmPh/XuNBEj86eF5h/MdWejG7ejUx5cP42h+T3zcV5ataH1YGMqvJGf5X6RDcwgRgzNdRcmTCew3p/xDUNuB+SqWSaoRIhvkx/wqzdjC3DzjoZ68eavmP3OO+ZEpUvZEdBo/Jzn7YRt5DN3vtM7LIr105hFqFhMtjzVBf9c4wD/GCnT6xJCd9+iF5ZpGA7Xgsbtoq//TC75Kd7Jjbp8gPOP4+SUgnkz0V3991IsFd0z0Wk3BN1JSysafDTlYD9HlABa/uGeWeshwe2l8B1GlSfhDRHOoo7SNtoUY5Myw1Tp6l/XNmDrObgsXvU12ufPJUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0yc1av926wLTaTcH4nk7Lz2caTBheLhjPikjVYmYi8=;
 b=V8pGABBV7Wm/x43rP/l8kkIiW8cU39YWHQAiapxt+VwZ4pXESiyCwgRUCA65fEhPBmHjTk3G69OhwfTwGsmshCeHd9ntcuihe7xzNwmreax0uT0gzp8Iicllp1wJmuXWd8f438O9hzvZWbZa02P6RLBnpiBnHhSzE5pSWp66aPdGmIkwlji9NeBhwBP2MWJEo29AeWz9XTlgxxeqDbVaxh5HMJHP6QHK8IAit8Z9iYIfiO1XSp+mc1KdpUBp57XuK1ZhYZ/RSHYgiHTcuWl65tBrn4BPQlhDHz9Gxg1DL+7XJOZchkPKOYPP9qq3hMY4M+CJjRY2VEhxf57WaTOCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0yc1av926wLTaTcH4nk7Lz2caTBheLhjPikjVYmYi8=;
 b=Ct1sY9oA6fo71ndcQ5Jg2nhlNusKtiODnDg2jxlFJxNc0zIdzCpI4JQthYuIuahQttzHYEB197jk+h8sJN5+UZ1gYLqYpk97u9OGYoedFR57B7Bax+Np40ipaoTXZtHawU+AaBjAcmNwSVwntdf8KeQZQoLGq009XrBh6AphIRk=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYYPR01MB6925.jpnprd01.prod.outlook.com (2603:1096:400:d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 09:43:36 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::3151:373d:fb9d:afd1]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::3151:373d:fb9d:afd1%7]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 09:43:36 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
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
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Paolo Valente <paolo.valente@unimore.it>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and
 x86
Thread-Topic: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX
 and x86
Thread-Index: AQHYemckLVPNFhFQbU+IAdEo3cwBO61IoUEAgAYyEhCAAA4dgIAEfPmggA+/dICAAfm5AIAATIAAgAALogCAAiff8A==
Date:   Thu, 30 Jun 2022 09:43:36 +0000
Message-ID: <OSBPR01MB2037621D4E6E65832DD9C95D80BA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com>
 <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YqiAY689pOJbHKUd@kroah.com>
 <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
 <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com>
 <086370dd-281f-5ac6-3a0f-f1b80500c668@intel.com>
 <CACRpkdYTNuszctk=stB+RLr5kKwhR2ebF2MJCYQwMwYYPPReLg@mail.gmail.com>
 <6934b82d-db12-8a17-7dea-7bcbd4fe8566@intel.com>
In-Reply-To: <6934b82d-db12-8a17-7dea-7bcbd4fe8566@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MjE3MmI2YjgtNTNlMS00YTA3LTlhYzYtNzMyZGExZTUy?=
 =?utf-8?B?ZWI2O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wNi0zMFQwNTo1Njo1M1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d371ce42-abbe-4b99-7690-08da5a7d0114
x-ms-traffictypediagnostic: TYYPR01MB6925:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8VYdfgkriqgVqC8Nin7wxTXoYGPfG0dPA6gztQxyvbSsETIUdB3lWMSLF7jcZthlglZYQfVGsFmrq3s9p5Nxb0XajbNlH0uwW9Ql2PoqKIiJxIuRf9j9Xg8ZpkphWerdTDPoirtjbhCtuf+m57W6rf9X1WIcjOBYXETOeltzpHhsglpgZJd4hayeVWAj2IayixNVGsgcRElnZH3dneuyJp4QgwuIyxJSKy4RoLm1lfxentf7m/vx5fuIygw2xN1ee0ZMnDWw+iduF7pFORz74F4Rq5PsoMWCmJrTRqSvgeVs4xJsI4jLrWNUriSIMRDqm3kgpWAWtgdmDyAJNWA2xlHIewo1hdCeW7r+FF54yKtXNYWWCVPKb0/QUZjkazmTgR/lfBcog1ZQQuvtTnnpvLT8Cf1cXbb3iTm7b2nrmgnC5zLKc04nnmmaJD8PfRHlpOlssY4PeAPpAbITDAaGpgQ3rvtQTbID03HroCGlYh2/kcAsTJMJMcNO7jusx9O+8Zh6YXS9lONN706NZ3cW0E7OyZcG8OLWuPdstIjyySjud8G4kM9FaLxdnh7yTwsHnB1adk5DH3LA9ylPWU+obKPNEkDwVdsOHhqwDo7dZncfa4rOwhQ6WvHEEFkc4RIFNiqLmhkEJwlmzbVmH7bTdBMQGYM67QYxhYyOgEooagwzkNgMz87VDpje2KdTkphj4dAGyEoITb3x5Lq4RQgFgnCi75K+8cE4Fc94fHlgAyWxigtck41QiTkI7+eBasHJCHRPQDrKcjCE192m1uMAzz1Oiu2JrRsDZByJsNUJ5KbTzg0XRAs3ajodJhXjMKdHyFD557bF8SlF0KaEdNPnbmzDzHZtRvpCc/LTKhvDFWU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(38100700002)(85182001)(41300700001)(54906003)(186003)(478600001)(110136005)(316002)(2906002)(83380400001)(82960400001)(86362001)(7696005)(66476007)(71200400001)(8676002)(26005)(9686003)(66446008)(76116006)(64756008)(66946007)(4326008)(38070700005)(66556008)(966005)(6506007)(33656002)(52536014)(7406005)(8936002)(7416002)(122000001)(5660300002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1dqUVlRNmlhWEFjUTZUQ1VwanlPb3dsNWR1YkF6NkVjY2ZVYi9hdlJiZ2g1?=
 =?utf-8?B?LzFHOTVEdG9mR1ZaeTVDQlYxZW1sYlh1TitIUUFjeFBHOTJWdW85eGZTNkJ3?=
 =?utf-8?B?R3hvTEpqOFp3OFBjejNxRnJkVlFlNktmcUxQNHJWaC9mMmR5WURGb3YvTGFK?=
 =?utf-8?B?OW5mZlc4akVEVm9GZFVwUDZnZ0FTNEF1czQwd3ZRNzg3MGVaVFVxOUxSS2Z4?=
 =?utf-8?B?V3FBdFIzcWx2cTlDa3BIUXpIVVRwd1N3VnJkOGtOSC82RUEyRjhzenIzbVJW?=
 =?utf-8?B?WXFHWGFRQmU0TnlMUVlzVjJVVzdjYnh5elFBV3ZEQ3JnTEN4K2pYcEI4bE1B?=
 =?utf-8?B?SmhwY2kxa1pwV2JlN1p0WS9oYlVOREFNeFd3a0o2aEdUQlVYL3RHWXpCSHF0?=
 =?utf-8?B?alRKUkxJTjlwRkdZL0lkWGJNSVY2MEtoeENMTGFlRlRqUVB4TlVOM253WEcv?=
 =?utf-8?B?SkFQdXZoY2swR3JXY2VlR0JOV2l2NjlrblAyWFNGalRHVTc5eUR1SWNwcFZF?=
 =?utf-8?B?WWUxTXREbFZSSE9PN3c3OWJYeVNlUU51OEdLOEwzNUxTaEZSc25xM3UySHFE?=
 =?utf-8?B?aHJJN1NaVktTZWlkdHV6cUZlREFCUTB5cEhEZEM4VWVDU0ZZZ0IwdWZuODQ0?=
 =?utf-8?B?eXNhN05XbCtjWGhScGlsKzIxemFWNHBUZEozd2ZTUzVHNWJLS0FBNGFwOVB4?=
 =?utf-8?B?RXpKM1NndmsyL1RVWXUxeUN5VDVTdEdTMjMrWDBaTG9icUNoanlTZlpUYzkz?=
 =?utf-8?B?VjBHaVhsbzZnekZFZ21BTkNGeVl6dXJDWjRWZE85UHEyeUtUUXl2cENSNGJl?=
 =?utf-8?B?bStjOWZ6NHJhL3ExV0FZTTVlbmhNOVA0ZVF5bUE0RCtlTkZqUGxZelJpL2Mr?=
 =?utf-8?B?eGJEclNSOGpnZVlWSE9YVjNEU29GYVVVTGl5S1hGeldFemJweFEzYkZvQ2x0?=
 =?utf-8?B?UG1aTVpGSmlxTS8zV1FXRElKZ2Jnd292STJFcktVVG1EODBuR0FXK0ZnSlZy?=
 =?utf-8?B?VEVkbkp0SStWQTBqWlp4YkpVR2o2YWV4NTdJZ2RyU1drNTBlNE9KVVFKSUth?=
 =?utf-8?B?dUkxL0NNaWFQVWh0S1Y2YmttRkkwR1R3MlBqZ1hlbCt4cUkvczh1dWp0NzBo?=
 =?utf-8?B?Q2R2b1JBbVRHa2hOcHpONmV6RFJkUTkrNWNUcDhRSUpzakZnTCtmczRNaHl4?=
 =?utf-8?B?dnE5aURxT0hId2xMTWJjcDlJcXVaWisreiszK0ZiVWRRM05RbkdFWVhlRnZJ?=
 =?utf-8?B?ZWNUSUZGNHRwZzRobCtTaTRxRVJDL3hSUkdyZ0NVcHhJL3g3dSs4akU0b1Jz?=
 =?utf-8?B?N3ZRL1FNakNUWVAzVWM5ZE5aY0YrYUU2K0YvU2FTYjN1R2tacW1XbmhacnVx?=
 =?utf-8?B?RTY3SGZpTGJKdVg2QWVWTlVGM0VJYXNYRTlhMFhjTUFBRk1jRnhiNVdQOCtP?=
 =?utf-8?B?c2Iwd25nc2c0bWsrd0M4SkwvNHp0YURJRG1PenpldE9nai9ieW9tTUlXbGZP?=
 =?utf-8?B?aTZGbC90UXFMdVpnZ01oYXF2RUxGQUpkN2IxNmNyblBhOWZrbTRSanFkYk45?=
 =?utf-8?B?YW1XT05oT2t3NzFEdW1nMkd2cmh2VFljWWJUVWF3c09VUlNpd1ZROHBYb1kz?=
 =?utf-8?B?dG5MMDRUTnZ2ckRzWTl5dFFlekFKY3BLZ0ZJRWFqbkRwOFdPYitadFFjV2Z6?=
 =?utf-8?B?Wmg3K0g5MWJjeUJEZit2eGpWemp3Z0IySHdCZFRwemtoN0NaS2gzY2J3UWVI?=
 =?utf-8?B?dU5zaDU3NG1iVmFBa3lrS3p1dEF0YTdKMmo2Rk5BeVF5bTVGemJHVXdRdVZq?=
 =?utf-8?B?dXhwUkd3V3p1RE9SNXdkN3pwMTlEY0VJbEllRFNMK09Ldk1NSmRYcmQ4bGFT?=
 =?utf-8?B?Q010ckdsd05Qc0d3WVZTT29hT1hBVzZKOEZDUURjMitWQXh5eGtqUjdtZTFY?=
 =?utf-8?B?bGs4WWVaYzUrTUtiZytaTU9lUTU5VXlsR0x1Y1VJUjBLN0NCbkpnNlU3WjR4?=
 =?utf-8?B?WFQwVHNYVHBiT01ZN1k4bXJkcThzTnlkWSszUXpOVGhNbU8ySG1wVG01ZzVm?=
 =?utf-8?B?QU9SN2x0d0ZIVm1zR0trTkNhSm1ReGdFKzNVamhYbzhUOGlzR2pEN1BHbW1q?=
 =?utf-8?B?M0RkVjZWOFROWTByaVlBcytLbnBlbElyNTE5NTJqWk1OajdhK3c1dEErczMr?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d371ce42-abbe-4b99-7690-08da5a7d0114
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 09:43:36.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ps9wPnJn2E8nFSjpvuR4Z01jnKj6HTpMRePNk4mJPYmgx8WmVCU89DAgoBxlDOn5GZyquuBjed41USntp9UxK9WefrrgtsX/G6z/IMxQ3NA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6925
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2ZSwNCg0KPiBUaGV5IHJ1biB0aGVpciBmb3J0cmFuIGFwcC4gIENoYW5nZSB0aGUgTVNS
cy4gIFJ1biBpdCBhZ2Fpbi4gIFNlZSBpZiBpdA0KPiBzaW11bGF0ZWQgdGhlIG51Y2xlYXIgd2Vh
cG9uIGJsYXN0IGFueSBmYXN0ZXIgb3Igc2xvd2VyLiAgUmluc2UuICBSZXBlYXQuDQo+IA0KPiBP
bmUgdGhpbmcgdGhhdCBpcyBtaXNzaW5nIGZyb20gdGhlIGNoYW5nZWxvZyBhbmQgY292ZXIgbGV0
dGVyIGhlcmU6IE9uIHg4NiwNCj4gdGhlcmUncyBhICd3cm1zcigxKScgdG9vbC4gIFRoYXQgdG9v
ayBwb2tlcyBhdCBNb2RlbCBTcGVjaWZpYyBSZWdpc3RlcnMgKE1TUnMpDQo+IHZpYSB0aGUgL2Rl
di9jcHUvWC9tc3IgaW50ZXJmYWNlLiAgVGhhdCBpbnRlcmZhY2UgaXMgYSB2ZXJ5LCB2ZXJ5IHRo
aW5seS12ZWlsZWQNCj4gd3JhcHBlciBhcm91bmQgdGhlIFdSTVNSIChXUml0ZSBNU1IpIGluc3Ry
dWN0aW9uLg0KPiANCj4gSW4gb3RoZXIgd29yZHMsIG9uIHg4Niwgb3VyIGN1cnJlbnQgaW50ZXJm
YWNlIGFsbG93cyB1c2Vyc3BhY2UgcHJvZ3JhbXMgdG8NCj4gYXJiaXRyYXJpbHkgcG9rZSBhdCBv
dXIgbW9zdCBzZW5zaXRpdmUgaGFyZHdhcmUgY29uZmlndXJhdGlvbiByZWdpc3RlcnMuICBPbmUg
b2YNCj4gdGhlIG1vc3QgY29tbW9uIHJlYXNvbnMgdXNlcnMgaGF2ZSByZXBvcnRlZCBkb2luZyB0
aGlzICh3ZSBoYXZlDQo+IHByX3dhcm4oKWluZ3MgYWJvdXQgaXQpIGlzIGNvbnRyb2xsaW5nIHRo
ZSBwcmVmZXRjaCBoYXJkd2FyZS4NCj4gDQo+IFRoaXMgaW50ZXJmYWNlIHdvdWxkIHRha2UgYSBn
b29kIGNodW5rIG9mIHRoZSB4ODYgd3Jtc3IoMSkgYXVkaWVuY2UgYW5kDQo+IGNvbnZlcnQgdGhl
bSBvdmVyIHRvIGEgbGVzcyBkYW5nZXJvdXMgaW50ZXJmYWNlLiAgVGhhdCdzIGEgd2luIG9uIHg4
Ni4NCj4gV2UgZG9uJ3QgZXZlbiAqcmVtb3RlbHkqIGhhdmUgbGluZS1vZi1zaWdodCBmb3IgYSBn
ZW5lcmljIHNvbHV0aW9uIGZvciB0aGUga2VybmVsDQo+IHRvIGZpZ3VyZSBvdXQgYSBzaW5nbGUg
ImJlc3QiIHZhbHVlIGZvciB0aGVzZSByZWdpc3RlcnMuDQoNClRoYW5rIHlvdSBmb3IgbWVudGlv
bmluZyB3cm1zciB0b29sLg0KDQpUaGlzIGlzIG9uZSBvZiB0aGUgcmVhc29uIHdoeSBJIHdhbnQg
dG8gYWRkIHRoZSBzeXNmcyBpbnRlcmZhY2UuIEkNCndpbGwgYWRkIHRoZSBkZXNjcmlwdGlvbiB0
aGF0IHRoaXMgaW50ZXJmYWNlIGNhbiBiZSB1c2VkIGluc3RlYWQgb2YNCndybXNyIHRvb2wgKG9y
IE1TUiBkcml2ZXIpIGZvciBoYXJkd2FyZSBwcmVmZXRjaCBjb250cm9sIHVzYWdlIHRvIHRoZQ0K
Y292ZXIgbGV0dGVyLg0KDQpJIHJlYWQgYmVsb3cgdGhhdCB3ZSBzaG91bGQgbm90IGFjY2Vzc2Ug
YW55IE1TUiBkaXJlY3RseSBmcm9tDQp1c2Vyc3BhY2Ugd2l0aG91dCByZXN0cmljdGlvbi4NCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAuZ2l0
L2Fib3V0Lw0KDQo=
