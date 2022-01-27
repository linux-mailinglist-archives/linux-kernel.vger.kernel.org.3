Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21B749D80E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiA0C3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:29:42 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:24034 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiA0C3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:29:40 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 21:29:39 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1643250579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ykfRMl3wqOcjPxqDcPE9OzN+LPFFEeFILoghPp0F4ww=;
  b=EMus1DZBJuLHwHlYudlm5XvD+5ej2wop6fNZphjxw7e1T1apxwdvauSQ
   /r1Ldg7FMJBPyTegR+2V80lgmPDlGsAfwQI33rYNdEWMzlTSJzctLairl
   KIhI2p2YHWnb/tuNgTCGmPjtKnDWEbuqX2miGY+EG817d4YlgtUI0AztF
   Q=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: G6RyTN+5fD3Knt3fBi3n1tSXXrL1rBz45c8cUsKltg13Nv2WfTB+4l7ucNIQnBM7YIx/dqwLQU
 yZm/Wm5uN5O1BH41ZeDX+ZF6kYs5QQhElKURHuPtr/rQRjtSXDHkeY12RjNFaPji7zoUwOv/Lb
 t9oUj26baeWJMYrkyttYusCyKVJC2MiiYR8CDMZA5jsZ62zz0bGaShM0iIAIRGUBcLv1ZsM0/L
 7Nz1gIwDXKL0Hg/tSFm2kdqEqlpcFYtIktYLNaas6upQrkVxV8AQD+XsKSPequWerClB8I4TmK
 /Db59Xke8U8t/OkZOYZ4w++n
X-SBRS: 5.2
X-MesageID: 63260309
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xtGpBK8rlGtNlNp603duk+F+db1zdoMgy1knxilNoENuHPBwxv
 rAoB1E73PJYW4qKQ0dcdDpAtjlfZtFnaQFoLX5To3SIzUO31HYbL2KjLGSjQEIfheeygcz79
 YZT0ETMqyTMbE+t7eG3ODaKadi/DDkytHSuQ629R4EJmsGC9AC0+46MHfgLqQffngaOXNTLu
 v62iMznUvYRZ1hVLXcOpBqZZmnm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYL6w
 H+4k7Ez5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwizyveJ9qV9S5zXUISaCUmRIXee
 v30lEd1vdImirsl6aO0EPQMjzboXETArnZuASlaDXY0JbErXkBerR8bMpiA2rkAgwbzY1BOe
 twrhGkX9A8N2KxoA3to9fPTB1kjUyyvD4rlvMSlWVWVc8EZKZWtpF3xjIZLH4sJlOw1GkcKp
 glMCgc3ocgTXqKK3TC+mV/yt2lWXo+Wh+AX0gZo8SQlzxbhmpwwUcUzNEW2i5ozuNzd7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUKsHJ3XOoZjq56hd3pDnRLUYiJ8p3J
 jRWlJRsmA/P0roFM2VxZVOtgvARW2sNA6dgv22J6IJ84EUaICbRBFreWpe5fdI+c9vcPEzc8
 zDTK5rPw==
X-IronPort-AV: E=Sophos;i="5.88,319,1635220800"; 
   d="scan'208";a="63260309"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXY6WGC08NLzFzGB/VRB96eZb3FIMp0nk1Hfy54XkAfzcKg7PPlkYAkYQ/mli++01BI05cATuC9FO2Wc19iceuuW5Ia/BbB+ddcH+hDdVXIX/vXC5WSSbRyPb2jaauptXQQ2+/LOPtL0JZeK7bdNSxFYUdZz1QYNIqzXG7B1rh8ObFSimyBv1cgQqlL0j2mKI+WFZPDQzreG+w+SzMP++pOcrAFXqgJA009AcoJ0yvVh0UgL9gWn42zTbutyaBbyiD3ZDIUSF/z4cBIkEbhfua76jbIbksp3S9RWCw9XYgCOeAKwP0hjg2eSWmKxiBe9SFiYeR3rwrDLkbT5iu1NVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykfRMl3wqOcjPxqDcPE9OzN+LPFFEeFILoghPp0F4ww=;
 b=LkFIb19HOZOS4eqZ2OGIftmK/vldtCPDc4GODAWpM3/cnQeGaZz/j7Hl9Q/F69vilQ8Fe1I4qsWp32tbNENw+xMjX+kijN8OqIQpfi1gxLLJoPHFP+Xw1Iv2rvoLuLu7NHXXZFcEU0VKUJr3W+ZLh7YC+fxkPNN00hs1VxYZW3JKFayXGHU5dT8yJ09rmoZhFhplyAwSpsyzbo1gvzGyPwbsTyjy0EBQtXuKcabVAoDitgr4QAYsfw4kntyukZBrXN3Af88REiVQAH2L+M7JmHosmxzhtbwF3xuyWSz2VybQouRVqed5E339M2OW7HJkxreUTD3Lf24jnr3bsiNT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykfRMl3wqOcjPxqDcPE9OzN+LPFFEeFILoghPp0F4ww=;
 b=gn/tElQ1aT46ewazqVCA2COyrX5CgH7wB+dBASQHaHAIRlLG5wCJo1DDvyvbMzw5CUS/e2C3XDW1LxbY7jjPMpYEYBN58y34eh9hNOr5clM8zkGpcY6kH2lNWT7wrhIT2tlx6LqrtvPOKZw6CePM31bw/T/GtITjcqGCNgiy6i4=
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Kyle Huey <me@kylehuey.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Keno Fischer" <keno@juliacomputing.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Thread-Topic: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Thread-Index: AQHYExD1HG4KmrLRmkWVrC55RIbhw6x2I0wA
Date:   Thu, 27 Jan 2022 02:22:23 +0000
Message-ID: <878929bb-39e7-f1b1-a6a2-f6057517058f@citrix.com>
References: <20220122072644.92292-1-khuey@kylehuey.com>
In-Reply-To: <20220122072644.92292-1-khuey@kylehuey.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d10ab437-0c30-4ebc-9a3c-08d9e13bda5e
x-ms-traffictypediagnostic: BN7PR03MB3921:EE_
x-microsoft-antispam-prvs: <BN7PR03MB39215DB10659C63E56EC401CBA219@BN7PR03MB3921.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WlkBEJoT7Y/iY0TCEXk/6gHCf+WOiAkcufeY68d/1G+ukXFYFgl7Dr68gJ7sszX/e6YcVGMZjgNqHu3lpBXY8EXt6DnWirsgU7G9K3h5Bc6suR7nrNMc14iX1BDhzTPnCzs8vXmXvOqmB1CBLYgqmD/sjU7UrPtTv4NCqL2g8rpdizF7R61O6YIhEjlQTf3P2H+hTXZJfor9YjmKHw9clybWXPCRQRMbOeFmgyed4mhQuGnVvbgcePcaKpxX1nB1QDLKyVrpTutl3CKkHZIERhMk+6tlB0mIoSCaRmS00eVcauWPYQz7xu+FCtuu+57X1lxtjIDcVhCTi1FL5Fek7O190QVhJWAv9FI71OMcmCYh8o/Gylps/rg7rxo1cZmLdlUj3YBs4YbwveMgQt8xm7Pk1zIKh03HcASMjjEJeFpiGpE5eLfW/SrDk88U5zdDQrxq3vX2kDa4gOCV4h6UHGfV5Ov0N9NuB/1/7KbzrMwnhP7plV14bu0JSryUXH0jnBaFHE+Rm+Oh5mWNHp0Ac3ehze+M8PrRLVTOUoyTg2pOyscDVp6K47yp6VFhrbMAhNjoqypjjQZNuhVd44OxBxn4Q9ulOo5Is2+hTk4cteHixOEGbA2yF83FyVtxhD++kxe2lxIt7b1/8iRkaxK0I9iQS/KIQ5c8HZ5JSN+G5KSEo0eUUNPbU3c1PWkEKGIbamxm6Vg6VJTvIjShMZ8gF+mypnt53XuhyC0CVBDwqrLRPMx5infjKwvinlIYJzISW0xtE195DRd8hTgoRNApAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6506007)(54906003)(31696002)(71200400001)(53546011)(110136005)(6486002)(86362001)(83380400001)(2616005)(26005)(186003)(316002)(76116006)(66446008)(2906002)(38100700002)(91956017)(31686004)(107886003)(6512007)(5660300002)(82960400001)(36756003)(38070700005)(122000001)(64756008)(66476007)(66556008)(66946007)(7416002)(8936002)(4326008)(8676002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2QzeXNqQmFJTG8zdzhSdnRKYStpQU9xK1dmWkp4OUpVMXE4OFZzN1RFVVFn?=
 =?utf-8?B?K2ZVZCtMSVdiUG91TjBNbFdUTjR0Y0JHUjF4d25FY0puT3duc2pmU3ZMeEdD?=
 =?utf-8?B?QlBIOFdxcUxUVU9nWldUZHlkRlRScjNiWU9IOFc0d1NiVXdVMUlOb21wdm1p?=
 =?utf-8?B?T1NOeURVZTV6eUs0OFJsQlJiOVpyeXk5Vm9tRG9hM2lKWEZvWFhpMzZXTm5B?=
 =?utf-8?B?Lzd4M0x2bjVZd0E3bk1laXByNm1VMlIvdXFKbXNTK3dTNkN0dndRcTIwa3pl?=
 =?utf-8?B?S3oyeEYrbGNkMkJxeEJtMWFLVk9OV2lYaVJWRXVoUmFJcDVnblZ2N1FFSVFp?=
 =?utf-8?B?S3dNUitHVFJHWmpDZGVrb0NZUVVuaXI5Z1RhVEtSd2p1NWdKWmxiUnJoOCtq?=
 =?utf-8?B?dW4wSUMwc1BIUlpaTjVpQmYxaHh5YzkwS1h3bm90ZDhvOXNJMEJ4Qjh5dWlw?=
 =?utf-8?B?U1pyU3hBWjJDWmwxQXdITjRsaVJKS0I3Y2paZlU5TmVSZ1FKRVJydjVNbXBj?=
 =?utf-8?B?azFNRkMxU0EzOEJhdjVHL0VlZ3ZDWHI1cHVKdzIvMk5Md2I2d2g5UjlRSHhB?=
 =?utf-8?B?bzVOdWFieHhNRkxDMjN3WlJGM0JUbTRnS1ZaNThKd1Rvd2JNamw1Ri9VZEN5?=
 =?utf-8?B?SS9CVmludUVpNmdyK2JORGQ1ekJOaDcwbm5jbVZZQ0lZbm42MXJHZFRrUFNY?=
 =?utf-8?B?WXhUdExBSk9PTzdPMThtQjF3aDFXL2kydzlzTFJiRllFTDFMb2ZBd2Jrd3lY?=
 =?utf-8?B?UEV6Tm93VFNHQ25iMzdnYWxXc1RIRFZYRmZtZXRMaUs3aExPZklzaFpySU5I?=
 =?utf-8?B?dkpobW1JclcxeS9PYXlqbGJYc3pTVXBpVTMwVWFCRzVzbmRPY1ZXSzJsVWpC?=
 =?utf-8?B?NnNhdk5vMXlxaDI0WUNHSGllUGlJMGg5LytuUC8rSUd5YnNJYytVQlRJd004?=
 =?utf-8?B?L0FuM2hHYmtDT3dTVXFhdFpBRHg5bFMyeGVBNGlzakMzK0xNczhrOGp1cFR2?=
 =?utf-8?B?OUN2akRkSGdHU0p6Y1drcUp3cFZpM0hrTVR0MWcrTmFJUHJ4ZlJjeHJCdmVY?=
 =?utf-8?B?bmQxZGJYOTl4dCtjWTlWQ0NwVTNWTmRKRGJyZHZZclZIQVgvN1l3UzJtWVZF?=
 =?utf-8?B?WHU0MG1YYXZnYXIxRTJUMjFIWFNsVWt1Rll4ZS9RZ3ZqTWg0TEVMN04zSFRC?=
 =?utf-8?B?NDZIdEpXcWZsa0VBbmhrV0pFK1ZhcDJpQ1BMdXRtbXdxK0JOblFVRFBBNkkr?=
 =?utf-8?B?RXd1eHd2SVo2MXJGdUlZcWRRTGlqZzIyL1MvOHhYVXArVFJoMEtidGludHNP?=
 =?utf-8?B?Y2dIblBnc2VDYm03b3AzR1hHQTduMlhwKyszWU5xNE02VklBanZLb1hxN1hx?=
 =?utf-8?B?NVY4NTBCZGQxaWoxMnMzRnY2MTNxYXZ3V09uTGVHR1ByTFdXZGJZeFVqTlBo?=
 =?utf-8?B?ajdFV0NXbzNXT0lUSzExM2NXVlI1Rnc0aHBmMHdMak82V1BFcDhwMG0yVkZm?=
 =?utf-8?B?alg0NXozeU5RNzc1RE1Kd0hQTHdGZStMMlpwRkU4RUxGbzRGQnpRZkZnTXRZ?=
 =?utf-8?B?UGM4eXNRbmN4Uldrb3N6dEFjS3VySTV1c21oeS9DV2V6QkRhcU82bG1Bc2sx?=
 =?utf-8?B?Q3JnbjNzUWQvN2g5aEUwdW0xVDdPUUd1aEFwVk9GZVJUY1gxNDBMSkZEMHJB?=
 =?utf-8?B?MkNPY1QzcEVJZXVYRlZoczdhLzFTaUM1NXJOeHlWRUIxVG8zNXZmaTBYaVRo?=
 =?utf-8?B?aURyQmEvSE9lK2ZPY1Q2Y3hUdW5mT0R6MzNXVDhVZ09zZFV1SjhVQUpLOVha?=
 =?utf-8?B?Y2dURHUvazZsSHJLcGg3WkRLR2h1SXFmWk5MaEVPY0pIUVgwRm5xRG1QcDZk?=
 =?utf-8?B?bUh5ODVRdlFaMDhPcUZFRUZYUGxoN1NVeml6RlhsbEo3K2pZVlNkOU9Pcm1I?=
 =?utf-8?B?NGpSK3JvMGNrbWp2aXpoa1F0QjdDdzU2UFhWUnJGMDBpemhCVlU2alFQb3lk?=
 =?utf-8?B?d3NHNUJQVTMvUjczdlhZZ3ZweitLWWt5eExvZmtmcGZsUHE2WTJ3UFl2T0I3?=
 =?utf-8?B?UXR5MTg2bHR1Rk0zRXZBWFZHSFRUa2lVTVIxa2lOMXRvQm82dzZjb3R2R3Nr?=
 =?utf-8?B?cGg3cFR3WXFWdjFMY0hhQ0hyQmQ2akcvOGFqWHBnRFpBT3REeC9YNUFqRW1w?=
 =?utf-8?B?ais4OUpKQW11NFhPWGhDUTZrRjRMVktHOHRCL1dsa04xUlVDbGxKNmViRDFT?=
 =?utf-8?B?QTRET2lESDB5VFVOeHpBeGZ2Tmx3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A60725E6F4B61409439F9AE986A91B0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10ab437-0c30-4ebc-9a3c-08d9e13bda5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 02:22:23.1807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiCocpGsOV9Wf1lQxmfoDJOXzbTuAVzQna8nGOWSTp64W5LssVVkE5Lo0h/OciP7jjg9QmfOwpxVWWuJko4ITkh/bT61oqBe1DDeSPdPvqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3921
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMDEvMjAyMiAwNzoyNiwgS3lsZSBIdWV5IHdyb3RlOg0KPiBCZWdpbm5pbmcgaW4gQ29t
ZXQgTGFrZSwgSW50ZWwgZXh0ZW5kZWQgdGhlIGNvbmNlcHQgb2YgcHJpdmlsZWdlIHJpbmdzIHRv
DQo+IFNNTS5bMF0NCg0KU01NIGhhcyBhbHdheXMgaGFzIGZ1bGwgYWNjZXNzIHRvIGFsbCA0IHJp
bmdzIG9mIHByb3RlY3Rpb24uDQoNCkJsYW1lIGFueW9uZSB3aG8gdXNlcyB0aGUgdGVybXMgIlJp
bmcgLTEvLTIiLCBiZWNhdXNlIHRoZXkgYXJlIGhvcnJpYmx5DQptaXNsZWFkaW5nIHRlcm1zIGFu
ZCBzaG93IGEgZnVuZGFtZW50YWwgbWlzdW5kZXJzdGFuZGluZyBvZiBob3cgdGhpcyB3b3Jrcy4N
Cg0KT24gZW50cnkgdG8gU01NLCB0aGUgcHJvY2Vzc29ycyBpcyBpbiBSZWFsIE1vZGUsIHdoaWNo
IGlzIENQTDAuwqAgUHJldHR5DQptdWNoIGV2ZXJ5IGhhbmRsZXIgc3dpdGNoZXMgdG8gUHJvdGVj
dGVkIE1vZGUgYXMgc29vbiBhcyBwb3NzaWJsZQ0KKGJlY2F1c2UgcHJvZ3JhbW1pbmcgZm9yIFVu
cmVhbCBNb2RlIGlzIGV2aWwpLsKgIFVFRkkgc3lzdGVtcyB3aXRoIDY0Yml0DQpmaXJtd2FyZSB3
aWxsIHNldCB1cCBwYWdldGFibGVzIGFuZCBzd2l0Y2ggaW50byBMb25nIG1vZGUuDQoNCkJ1dCBm
cm9tIGEgY29kZSBvcmdhbmlzYXRpb24gcG9pbnQgb2YgdmlldywgU01NIGhhcyB0cmFkaXRpb25h
bGx5IGJlZW4gYQ0KUldYIGZyZWUtZm9yLWFsbCB3aXRoIG1vcmUtdGhhbi1rZXJuZWwgcHJpdmls
ZWdlcyBhbmQgYWxsIHRoZSBpbnB1dA0KaGFuZGxpbmcgZ290Y2hhcy9ldGMuwqAgSXQncyBubyB3
b25kZXIgdGhhdCBTTU0gaXMgYSBmZXJ0aWxlIHNvdXJjZSBvZg0Kc2VjdXJpdHkgaXNzdWVzLg0K
DQo+IEEgc2lkZSBlZmZlY3Qgb2YgdGhpcyBpcyB0aGF0IGV2ZW50cyBjYXVzZWQgYnkgZXhlY3V0
aW9uIG9mIGNvZGUNCj4gaW4gU01NIGFyZSBub3cgdmlzaWJsZSB0byBwZXJmb3JtYW5jZSBjb3Vu
dGVycyB3aXRoIElBMzJfUEVSRkVWVFNFTHguVVNSDQo+IHNldC4NCg0KV2hhdCBpcyBuZXcgaW4g
Q29tZXQgTGFrZSBpcyBhIGtlcm5lbCBydW5uaW5nIGluIFNNTSBDUEwwIHdoaWNoIHNldHMgdXAN
CnVzZXJtb2RlIHRvIHJ1biB0aGUgbWFpbiBsb2dpYy4NCg0KSG93ZXZlciwgaWYgZS5nLiBhbiBl
bnRlcnByaXNpbmcgQ29yZWJvb3QgZGV2ZWxvcGVyIHdlcmUgdG8gZGVjaWRlIHRoYXQNCnRoaXMg
Q1BMMyBTTU0gcGxhbiBtaWdodCBiZSBhIGdvb2QgaWRlYSwgb2xkZXIgQ1BVcyB3b3VsZCBzdGFy
dA0KbWFuaWZlc3RpbmcgdGhlIHNhbWUgYmVoYXZpb3VyLg0KDQo+IHJyWzFdIGRlcGVuZHMgb24g
ZXhhY3QgY291bnRzIG9mIHBlcmZvcm1hbmNlIGV2ZW50cyBmb3IgdGhlIHVzZXIgc3BhY2UNCj4g
dHJhY2VlLCBzbyB0aGlzIGNoYW5nZSBpbiBiZWhhdmlvciBpcyBmYXRhbCBmb3IgdXMuIEl0IGlz
LCBob3dldmVyLCBlYXNpbHkNCj4gY29ycmVjdGVkIGJ5IHNldHRpbmcgSUEzMl9ERUJVR0NUTC5G
UkVFWkVfV0hJTEVfU01NIHRvIDEgKHZpc2libGUgaW4gc3lzZnMNCj4gYXMgL3N5cy9kZXZpY2Vz
L2NwdS9mcmVlemVfb25fc21pKS4gV2hpbGUgd2UgY2FuIGFuZCB3aWxsIHRlbGwgb3VyIHVzZXJz
IHRvDQo+IHNldCBmcmVlemVfb25fc21pIG1hbnVhbGx5IHdoZW4gYXBwcm9wcmlhdGUsIGJlY2F1
c2Ugb2JzZXJ2aW5nIGV2ZW50cyBpbg0KPiBTTU0gaXMgcmFyZWx5IHVzZWZ1bCB0byBhbnlvbmUs
IHdlIHByb3Bvc2UgdG8gY2hhbmdlIHRoZSBkZWZhdWx0IHZhbHVlIG9mDQo+IHRoaXMgc3dpdGNo
Lg0KDQpGcmFua2x5LCBpdCBpcyBhbiBlcnJvciB0aGF0IEZSRUVaRV9XSElMRV9TTU0gaXMgdW5k
ZXIgdGhlIGtlcm5lbHMNCmNvbnRyb2wsIGFuZCBub3QgU01NJ3MgY29udHJvbC7CoCBBZnRlciBh
bGwsIGl0J3MgU01NIGhhbmRsaW5nIGFsbCB0aGUNClVFRkkgc2VjcmV0cy9ldGMuDQoNCkxpbnV4
IG91Z2h0IHRvIHNldCBGUkVFWkVfV0hJTEVfU01NIHVuaWxhdGVyYWxseSwgYmVjYXVzZSBtb3N0
IGtlcm5lbA0KcHJvZmlsaW5nIHByb2JhYmx5IHdvbid0IHdhbnQgaW50ZXJmZXJlbmNlIGZyb20g
U01NLsKgIFJvb3QgY2FuIGFsd2F5cw0KZGlzYWJsZSBGUkVFWkVfV0hJTEVfU01NIGlmIHByb2Zp
bGluZyBpcyByZWFsbHkgd2FudGVkLg0KDQpJJ20gbm90IHN1cmUgaWYgYW55dGhpbmcgY2FuIGJl
IGRvbmUgb24gcHJlLUZSRUVaRV9XSElMRV9TTU0gQ1BVcy7CoCBOb3INCkFNRCBDUFVzIHdoaWNo
IGFyZSBhbHNvIGdhaW5pbmcgQ1BMMyBTTU0gbG9naWMsIGFuZCBkb24ndCBhcHBlYXIgdG8gaGF2
ZQ0KYW55IGVxdWl2YWxlbnQgZnVuY3Rpb25hbGl0eS4NCg0KfkFuZHJldw0K
