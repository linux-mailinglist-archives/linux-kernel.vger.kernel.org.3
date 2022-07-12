Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B1571214
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiGLGCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGLGCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:02:49 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB17B31DE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657605768; x=1689141768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EZJLbKPa5FBtwWpdPfWs43VPJgV04cgjaVJvUyTyZ/I=;
  b=J2QrA98/bz5hCPv++rs0kNQIYay3mhMnywNvZVHD3SiOEgE3reyMPjc8
   pn06Ntz3vteqySB0OKhIpluQsIOiFKsdYtfKGAIR+V66A4H6W27oWKSA5
   1pfejveogNkBG9jUeY4HoE6EVrmLD1jTHalysvc8swQF+hcDsYw3zO/Jc
   ry7X4apIsB8JF1naMHspz14GwsopuJ17nv4YakiV0CztGNMqgsKj7KJze
   6Zy4W5aDamoyimO/AVsI+gsINrwI0ow+gE83JVfmIBrqJcB0y2gw/QD9X
   iqGLtlYFiF3W/Ex5KjERtQfZsoXVJHK+wvBP5sV9SFkk69dyTsNHzGtBh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="68236818"
X-IronPort-AV: E=Sophos;i="5.92,264,1650898800"; 
   d="scan'208";a="68236818"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 15:02:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/11QZppDY47IjWSnd0uP/EnOwZBR597yHRC32NqIzKk2dF1A5PE63fhpvGENHjdX0fz7Dr0ZOyBLpeJdWWjgpkys/jN1pPHnyVRoT5Sd2WxOoe333qQ5AhAk5+Cq5C8uiX0D/HsxVdgdyw3CqMyWkoxqi/8yLe4U3/pohKiTBwK5n7DajVNdZzsf79tkqZ/sMWIyFDUpNBHeC3Hau2VhyERrAjqr8Dwz/XqCTNoialSnUvZPBzpDMszMSYOzrfmowKqbESEzxIzuZ1PPXeWEvLfKQIHaPRruLXhiT/fBS+rWgahfI6fpuzbdVHJvjbJhVsI5b6eHfj5Pvv3+KE1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZJLbKPa5FBtwWpdPfWs43VPJgV04cgjaVJvUyTyZ/I=;
 b=gwj2sedm56xZH4FXAmyYi4FJxcy0k7IuX9AmxQXzqFwOfHFA9uIQdiq9i6vhsOOXA4/zn6+GCoVrIy1zZPaFBKDYCIfkCzywXWirn+2gFoLXDI9AgBTlpBAxFZCLr2eHJsCXKkqtCw2hWuf4apk+WGhEoOXC3B7YxGDnMbOqOQzwoLais+PlEq9UhZQfSZCElOehzFoz9OO0SPzzip4cCEVU3AbQ5KhmwrKIUUb6QtggjwgaAEuaWzc7R9KdW0gZVwbyMjQTKSPFMVTKoZA8uQTpR6SF9zq+ccb6JIjsLbwznka9d0WVZsgWC4m9a7Mshi2c8s8Mv7Gu0QQ4TNBodQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZJLbKPa5FBtwWpdPfWs43VPJgV04cgjaVJvUyTyZ/I=;
 b=HDUE9/WnUBR6AgYUqnJz2sHK3rTi8Dygkjj2pbTMWNCkDOSCuhN9MtXa7XfseribposrGWYEQI512EjeOA/OgXzsvi4g7f7rK/60nD5t9cGvDEJhdFbGBw17XlOPih4Q/rCw/0Q/n5vXtOh79aqACBYmZhAZKhFgx6az/WUdNRE=
Received: from TYAPR01MB2031.jpnprd01.prod.outlook.com (2603:1096:404:2::12)
 by TYWPR01MB8855.jpnprd01.prod.outlook.com (2603:1096:400:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 06:02:40 +0000
Received: from TYAPR01MB2031.jpnprd01.prod.outlook.com
 ([fe80::8d4:191d:4d98:721]) by TYAPR01MB2031.jpnprd01.prod.outlook.com
 ([fe80::8d4:191d:4d98:721%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 06:02:40 +0000
From:   "itaru.kitayama@fujitsu.com" <itaru.kitayama@fujitsu.com>
To:     'Anshuman Khandual' <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "german.gomez@arm.com" <german.gomez@arm.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers/perf: arm_spe: Fix consistency of
 SYS_PMSCR_EL1.CX
Thread-Topic: [PATCH] drivers/perf: arm_spe: Fix consistency of
 SYS_PMSCR_EL1.CX
Thread-Index: AQHYla5bgqrtlTiPgUqr049Gonl2V616NTvggAAHT4CAAAGzAA==
Date:   Tue, 12 Jul 2022 06:02:40 +0000
Message-ID: <TYAPR01MB2031476E9079243EAF38751281869@TYAPR01MB2031.jpnprd01.prod.outlook.com>
References: <20220712051404.2546851-1-anshuman.khandual@arm.com>
 <TYAPR01MB2031EDAB65B9F7514AE6C06081869@TYAPR01MB2031.jpnprd01.prod.outlook.com>
 <8545ca2b-ece8-83e1-7709-8e483bced83b@arm.com>
In-Reply-To: <8545ca2b-ece8-83e1-7709-8e483bced83b@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDctMTJUMDY6MDI6?=
 =?utf-8?B?MzlaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD03MDBmMjJmZi1jM2ZlLTQ4N2Yt?=
 =?utf-8?B?YjNmZS02ZGY4NmUwZTM5M2E7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cc289f2-ff46-4f7c-5e0b-08da63cc213e
x-ms-traffictypediagnostic: TYWPR01MB8855:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l30SuzU5TrvzdoNEL07k6gAa3nhoYITExrDR0Pkax3+t4SBHuPJJ/eAK2OLs+aBPuwvg9vwtc/9HmOIJVr5spiUeamOHnRAoZctlQJMj1xYDCwtuLMAKhZtdi9AWPd3XZBvdOhxoVRcPe55jAdrfHJJe5cWkAFSoBfOv5pb3JKPHRCMtGrE3Gmtb2fLTVsK2dIxCTk4irhv+ZqpeZcN1sFBDc1TKfS3Fd5u1LKOEMVv+1aVwTVXrntD22rtX2Iozn1spYDCQPFRPR7QzNmcxFpO8miRWHCxakTXlUUiAXeVQiIrmBQYxhIcDim8m6lmYhdyRmjuhayGUuBvizgW7qaL/P6J/jSfJSB1XDGVBF+pa5PJkyPIYaUuPv77Q7MJzf5FJiAQyD/ADRIWhhRLb8R1W3iAGWZLXAyrG7x2XX0nD4zkcBwBR/BlJTi2C1uzcRCaraJ7SAzRHS3D6f+ldYw6PdICjvyCU8qJb5BF6UXitnDV9LZ7n64szuqvrZ+BhrfyV8qDdQAgs6wp6ExcOMD5DgouYeoRepU3FT1oM1WNJcGHKKGC92tINERbKJISBde6NswQvQ8799x38NAqrY6nlvpwQtNW8tXokbc8X5J4gyDwOW2MYRfr48zCbauVpjD0Eg+9YoPI1V2prmOd/j4w4HUclFg/DHItK0vKMZEvRl9qx1A5l1OAJeOp4CSR1TbLPTp0Y5duY/cQ1T8vhaW75WTgKb9RCr8F5S4O5/z81oO24OBEEVIZmCBpQy0W7r4O4DVDu7aZNC4Qk7Vw1UEel3TWNzYMVc40+yLAyzmLUP4swvyeQdWV2LOUEgimMyKSCg0nHheQGM1MyDuozq+GF+/SHDaClvnxIdDfnJaqZkkZT50mgWVere6V5U1KR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB2031.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(110136005)(2906002)(966005)(64756008)(8936002)(53546011)(71200400001)(54906003)(26005)(316002)(7696005)(9686003)(41300700001)(4326008)(33656002)(5660300002)(86362001)(85182001)(8676002)(52536014)(6506007)(83380400001)(186003)(122000001)(66556008)(66946007)(55016003)(66476007)(38100700002)(76116006)(82960400001)(38070700005)(66446008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFNUS3hSUWpEdXJFRnV4SmFpQkxMR3dyQzFzUHVGb0ZNSFl4bnpyZGovK1Mv?=
 =?utf-8?B?M0kxTXBJdnlFaFZJRGdNbkF5cVM4NTZhYXlZc0lvSUtVRkxhQUtCbXppaXVC?=
 =?utf-8?B?NURyV1plOXZmbG9PYTdZbytrVU5abmlVWDZkL1ZSK3dPd014bWF3ZFRTYlg0?=
 =?utf-8?B?aEpnYUp2eXRQY3hhOG9WM3F6L0hFN3NuTHpCUkp6Y3JHeDM0aWVRT0R5WTZU?=
 =?utf-8?B?WUNMSlladUQzc2ViZTBnb2NYbnY2NVdWR25GaFpXTWM1dkVCdDdsenB2Qzli?=
 =?utf-8?B?L3BmdElLUWdWMUFoMW8yejhVQVowZE96ak0yMkVZcmxaYnJxZSthanhGcjdx?=
 =?utf-8?B?RnBmZm5YK1d0cy8wZjBRTTFNMFJiUzFEYkplV1lKa29LbmZJdUo3SzBEMVg3?=
 =?utf-8?B?MEU3cW9TZUw1dERJQUZlbkFERUJoSFdCRVVMVjhVcTNRNnVrQ1EzcUw2M1pW?=
 =?utf-8?B?WXNpeFZkMzlvNmwrdVg2aGc4SWNZVzFQL1U5WGRtZlpSN1FiMDI2REovd2RH?=
 =?utf-8?B?ZVpocGR5K2hCT2FVY2hHd2xqZEduYVd0UFZtWm9FZm1hRnhTY0JFOFVoNHla?=
 =?utf-8?B?bkRab0wxdFkyWFlTSmxPSnYrRW4rU1Awa2ZRTk9kTnA2cGhCNnlXVmF1VGhP?=
 =?utf-8?B?NUhxaUlpRkE1bnJZN1NkYVBHdEhvMll0Y0ZzalJyZkhWTlBYUVNOc3ZoQ3lG?=
 =?utf-8?B?MFBiZ3liZzJzS1pJckxYd0xEdHpnUjFMdURqa29lejIyZVU3UUlSMityYnFF?=
 =?utf-8?B?aGR3OWZWR1gwb3E4R09Ha2hFaDFreG1SemZFWUJmSHFxODBpRzBlK0dOODVp?=
 =?utf-8?B?bVJCbnVzN2g4V29tN3A0enF1a2NKNGU0dDJ2SFlIUk5kRGgxbW9qWXBBNmZN?=
 =?utf-8?B?cnFKWmlFZHlXaVJibG5HNjBRd3Q5bW9zTnpyUGU2T2pXNHVCWnY2RVVISDJD?=
 =?utf-8?B?dXArYXBkVXJUQ1NxaWFlYncvWXg0VEE5dHUyV21sdkg4aXEyVlJFSWdzYVBs?=
 =?utf-8?B?TmFia3ZNWW1qdkJLQUlnUlNmbXdyMldMUlJ4WE02Z2ZBTzRJTEg2aTdZN1dW?=
 =?utf-8?B?dTh5RklGak85R1NvV0FNQWhzemRURkkrMWx0R2lsOFROYzRodnUrNzdxT1Bz?=
 =?utf-8?B?WmtvaWFFNXEwUkt1Tm1Bb2VZSUVuRGVDRWMyRmxTMU1PaEVnaVE2MkZqZ01B?=
 =?utf-8?B?dlhNZVFIVGdpV2RFbkljUjBURjBXM0FOVG1hUzZYMzhGS0Y0OThXSTIwSkx4?=
 =?utf-8?B?OTRDcGVnZit6TDI5a3BqZ3hFdzVtK3VTc2M5czZicnViM3NjSi9aVlhEeE1C?=
 =?utf-8?B?NGJ6b0xmNnhoZlVsclVKcVVKWVZGbDdrUzN0cXVmbkRHaDQvaW9waFlHanFW?=
 =?utf-8?B?RlNhajZnYUo0ZFYxNXpkZWdkZTVEMjZBVDk0WWpTN3JOVUUwZkVpMkNPc1hI?=
 =?utf-8?B?RHMrYmxmOFlOVThKT0dBRTFVVW40dnpRYjFaV1lTakc1bEZ1bzdUb3JhR2Fa?=
 =?utf-8?B?TkNBWk85ZGpiNTg0ZXNvdGh4b3FHcVFwZDlQYnJQdmxaTFB0S1hPa0VreENs?=
 =?utf-8?B?VnFqYXRGYWRLQU9qeWorQ0taam1SemdnbFpCR0djVllVVFhMQ0NGWkpkS2J1?=
 =?utf-8?B?TlNoM0JxZlJhZElscUg0QVFDWThMVERZdHg3UjhLYk0rcWFIWWMvb0hMbUJJ?=
 =?utf-8?B?V1Z2eEFhR0Z1di9GQ3ROQjh0b3JGMklOQlJPUVU5MFk4bUZYd3FqM0VXMFVO?=
 =?utf-8?B?ZTRpYmEwMk40N3g4NzNuT0FwTlJCazhtZGxLcUxuZWF6WVM0dk0vUktTYnl4?=
 =?utf-8?B?VFpMdHB1NGEybXNRZHlLbXdCTUwrOHEvc3dkQStmRVFFbk1YTGFDZ0ZCN3Fv?=
 =?utf-8?B?MXZYNDNTZ1R4OWFlSU1nTis1VjJ1bkM0Vm1ad1RqSnk1MFNITjVOUkl5K2xq?=
 =?utf-8?B?VVl3WDRXQmI3ZVk0MFVkMkNPT3djWmdaOEtTT2Rlc0xzc0RFWGE0WUNWckl6?=
 =?utf-8?B?SU1QMmtkQmYweC9KNUlFUjY4ZGdVOHBpYkIyK2lqbERYZnl4eFZiNXZSYUxk?=
 =?utf-8?B?clFCcjBoQWJtSDBXU1hwTUJZaVVGOHpyNTcxRWpJN053Rno3bUc2d01RTThH?=
 =?utf-8?B?YzBjd3lqZ1RVZTdZRG9ncnlxNHJwaUw4Z2E0L1hYUVNUQkdMSmVKNW02aitX?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2031.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc289f2-ff46-4f7c-5e0b-08da63cc213e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 06:02:40.7935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJZGODXYHmperqcM1CNNrqQSplqZuQvHCoDeyCp7y6am3VcvtIaaLjzAzu0mHDLp42q27GPMpOHsGd1AYP++j2Sz4cMccMzADciBm0570zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8855
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbnNodW1hbiBLaGFuZHVhbCA8
YW5zaHVtYW4ua2hhbmR1YWxAYXJtLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBKdWx5IDEyLCAyMDIy
IDI6NTUgUE0NClRvOiBLaXRheWFtYSwgSXRhcnUv5L6G5bGxIOiHsyA8aXRhcnUua2l0YXlhbWFA
ZnVqaXRzdS5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCkNjOiBn
ZXJtYW4uZ29tZXpAYXJtLmNvbTsgamFtZXMuY2xhcmtAYXJtLmNvbTsgc3V6dWtpLnBvdWxvc2VA
YXJtLmNvbTsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFy
ay5ydXRsYW5kQGFybS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0
OiBSZTogW1BBVENIXSBkcml2ZXJzL3BlcmY6IGFybV9zcGU6IEZpeCBjb25zaXN0ZW5jeSBvZiBT
WVNfUE1TQ1JfRUwxLkNYDQoNCg0KT24gNy8xMi8yMiAxMDo1OSwgaXRhcnUua2l0YXlhbWFAZnVq
aXRzdS5jb20gd3JvdGU6DQo+IEFuc2h1bWFuLA0KPiBEbyB5b3UgbWFrZSB5b3VyIGdpdCB0cmVl
IHB1YmxpYyBzbyB3ZSBjYW4gcHVsbCBhbmQgZXhhbWluZT8NCg0KRG9udCBoYXZlIGEgcHVibGlj
IGdpdCB0cmVlIHdpdGggdGhpcyBjaGFuZ2UsIGJ1dCBpdCdzIGp1c3QgYSBzaW5nbGUgcGF0Y2gg
d2hpY2ggY291bGQgYmUgYXBwbGllZCBzdGFuZCBhbG9uZSBvbiBjdXJyZW50IG1haW5saW5lIHJl
bGVhc2UgNS4xOS1yYzYuDQpXaGF0IGlzIHRoZSBwcm9ibGVtID8NCg0KTm90IGEgcHJvYmxlbSwg
YnV0IHdoZW4geW91IHNlbmQgb3V0IGEgc2VyaWVzIGluIGZ1dHVyZSwgSSB0aG91Z2h0IHB1bGxp
bmcgZnJvbSBhIGdpdCB0cmVlIHdvdWxkIGJlIGVhc2llciB0aGFuIGFwcGx5aW5nIG1hbnVhbGx5
Lg0KDQpJdGFydS4gDQogDQo+IA0KPiBUaGFua3MsDQo+IEl0YXJ1Lg0KPiANCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYXJtLWtlcm5lbCA8bGludXgtYXJtLWtl
cm5lbC1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmc+IA0KPiBPbiBCZWhhbGYgT2YgQW5zaHVt
YW4gS2hhbmR1YWwNCj4gU2VudDogVHVlc2RheSwgSnVseSAxMiwgMjAyMiAyOjE0IFBNDQo+IFRv
OiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGdlcm1hbi5nb21l
ekBhcm0uY29tOyBqYW1lcy5jbGFya0Bhcm0uY29tOyBzdXp1a2kucG91bG9zZUBhcm0uY29tOyAN
Cj4gQW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1bWFuLmtoYW5kdWFsQGFybS5jb20+OyBXaWxsIERl
YWNvbiANCj4gPHdpbGxAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFy
bS5jb20+OyANCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFU
Q0hdIGRyaXZlcnMvcGVyZjogYXJtX3NwZTogRml4IGNvbnNpc3RlbmN5IG9mIA0KPiBTWVNfUE1T
Q1JfRUwxLkNYDQo+IA0KPiBUaGUgYXJtX3NwZV9wbXUgZHJpdmVyIHdpbGwgZW5hYmxlIFNZU19Q
TVNDUl9FTDEuQ1ggaW4gb3JkZXIgdG8gYWRkIENPTlRFWFQgcGFja2V0cyBpbnRvIHRoZSB0cmFj
ZXMsIGlmIHRoZSBvd25lciBvZiB0aGUgcGVyZiBldmVudCBydW5zIHdpdGggcmVxdWlyZWQgY2Fw
YWJpbGl0aWVzIGkuZSBDQVBfUEVSRk1PTiBvciBDQVBfU1lTX0FETUlOIHZpYSBwZXJmbW9uX2Nh
cGFibGUoKSBoZWxwZXIuDQo+IA0KPiBUaGUgdmFsdWUgb2YgdGhpcyBiaXQgaXMgY29tcHV0ZWQg
aW4gdGhlIGFybV9zcGVfZXZlbnRfdG9fcG1zY3IoKSBmdW5jdGlvbiBidXQgdGhlIGNoZWNrIGZv
ciBjYXBhYmlsaXRpZXMgaGFwcGVucyBpbiB0aGUgcG11IGV2ZW50IGluaXQgY2FsbGJhY2sgaS5l
IGFybV9zcGVfcG11X2V2ZW50X2luaXQoKS4gVGhpcyBzdWdnZXN0cyB0aGF0IHRoZSB2YWx1ZSBv
ZiB0aGUgQ1ggYml0IHNob3VsZCByZW1haW4gY29uc2lzdGVudCBmb3IgdGhlIGR1cmF0aW9uIG9m
IHRoZSBwZXJmIHNlc3Npb24uDQo+IA0KPiBIb3dldmVyLCB0aGUgZnVuY3Rpb24gYXJtX3NwZV9l
dmVudF90b19wbXNjcigpIG1heSBiZSBjYWxsZWQgbGF0ZXIgZHVyaW5nIHRoZSBldmVudCBzdGFy
dCBjYWxsYmFjayBpLmUgYXJtX3NwZV9wbXVfc3RhcnQoKSB3aGVuIHRoZSAiY3VycmVudCIgcHJv
Y2VzcyBpcyBub3QgdGhlIG93bmVyIG9mIHRoZSBwZXJmIHNlc3Npb24sIGhlbmNlIHRoZSBDWCBi
aXQgc2V0dGluZyBpcyBjdXJyZW50bHkgbm90IGNvbnNpc3RlbnQuDQo+IA0KPiBPbmUgd2F5IHRv
IGZpeCB0aGlzLCBpcyBieSBjYWNoaW5nIHRoZSByZXF1aXJlZCB2YWx1ZSBvZiB0aGUgQ1ggYml0
IGR1cmluZyB0aGUgaW5pdGlhbGl6YXRpb24gb2YgdGhlIFBNVSBldmVudCwgc28gdGhhdCBpdCBy
ZW1haW5zIGNvbnNpc3RlbnQgZm9yIHRoZSBkdXJhdGlvbiBvZiB0aGUgc2Vzc2lvbi4gSXQgdXNl
cyBjdXJyZW50bHkgdW51c2VkICdldmVudC0+aHcuZmxhZ3MnIGVsZW1lbnQgdG8gY2FjaGUgcGVy
Zm1vbl9jYXBhYmxlKCkgdmFsdWUsIHdoaWNoIGNhbiBiZSByZWZlcnJlZCBkdXJpbmcgZXZlbnQg
c3RhcnQgY2FsbGJhY2sgdG8gY29tcHV0ZSBTWVNfUE1TQ1JfRUwxLkNYLiBUaGlzIGVuc3VyZXMg
Y29uc2lzdGVudCBhdmFpbGFiaWxpdHkgb2YgY29udGV4dCBwYWNrZXRzIGluIHRoZSB0cmFjZSBh
cyBwZXIgZXZlbnQgb3duZXIgY2FwYWJpbGl0aWVzLg0KPiANCj4gQ2M6IFdpbGwgRGVhY29uIDx3
aWxsQGtlcm5lbC5vcmc+DQo+IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29t
Pg0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEFuc2h1bWFuIEtoYW5k
dWFsIDxhbnNodW1hbi5raGFuZHVhbEBhcm0uY29tPg0KPiAtLS0NCj4gVGhpcyBhcHBsaWVzIG9u
IHY1LjE5LXJjNiBhbmQgYnVpbHQgb24gYW4gZWFybGllciB2ZXJzaW9uIHBvc3RlZCBieSANCj4g
R2VybWFuIA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjAxMTcxMjQ0MzIuMzEx
OTEzMi0xLWdlcm1hbi5nb21lekBhcm0uDQo+IGNvbS8NCj4gDQo+ICBkcml2ZXJzL3BlcmYvYXJt
X3NwZV9wbXUuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGVyZi9hcm1fc3BlX3BtdS5jIGIvZHJpdmVycy9wZXJmL2FybV9zcGVfcG11LmMg
DQo+IGluZGV4IGRiNjcwYjI2NTg5Ny4uMDExZTk4NDI4MjMzIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3BlcmYvYXJtX3NwZV9wbXUuYw0KPiArKysgYi9kcml2ZXJzL3BlcmYvYXJtX3NwZV9wbXUu
Yw0KPiBAQCAtMzksNiArMzksMjYgQEANCj4gICNpbmNsdWRlIDxhc20vbW11Lmg+DQo+ICAjaW5j
bHVkZSA8YXNtL3N5c3JlZy5oPg0KPiAgDQo+ICsvKg0KPiArICogZXZlbnQuaHcuZmxhZ3MgcmVt
YWluIHVudXNlZCBmb3IgZXZlbnRzIGNyZWF0ZWQgZm9yIHRoaXMNCj4gKyAqIFBNVSBkcml2ZXIu
IEEgc2luZ2xlIGJpdCB0aGVyZSBpLmUgQklUKDApLCBjb3VsZCBiZSB1c2VkDQo+ICsgKiB0byBy
ZW1lbWJlciBpbml0aWF0aW5nIHByb2Nlc3MncyBwZXJmbW9uX2NhcGFibGUoKSB2YWx1ZQ0KPiAr
ICogd2hpY2ggY2FuIGJlIHN1YnNlcXVlbnRseSB1c2VkIHRvIGVuYWJsZSBTWVNfUE1TQ1JfRUwu
Q1gNCj4gKyAqIHRodXMgZW5hYmxpbmcgY29udGV4dCBpbmZvcm1hdGlvbiBpbiB0aGUgdHJhY2Uu
DQo+ICsgKi8NCj4gKyNkZWZpbmUgU1BFX1BNVV9IV19GTEFHU19DWAkJCUJJVCgwKQ0KPiArDQo+
ICtzdGF0aWMgdm9pZCBldmVudF9od19mbGFnc19zZXRfY3goc3RydWN0IHBlcmZfZXZlbnQgKmV2
ZW50KSB7DQo+ICsJaWYgKHBlcmZtb25fY2FwYWJsZSgpKQ0KPiArCQlldmVudC0+aHcuZmxhZ3Mg
fD0gU1BFX1BNVV9IV19GTEFHU19DWDsgfQ0KPiArDQo+ICtzdGF0aWMgYm9vbCBldmVudF9od19m
bGFnc19oYXNfY3goc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50KSB7DQo+ICsJcmV0dXJuICEhKGV2
ZW50LT5ody5mbGFncyAmIFNQRV9QTVVfSFdfRkxBR1NfQ1gpOyB9DQo+ICsNCj4gICNkZWZpbmUg
QVJNX1NQRV9CVUZfUEFEX0JZVEUJCQkwDQo+ICANCj4gIHN0cnVjdCBhcm1fc3BlX3BtdV9idWYg
ew0KPiBAQCAtMjcyLDcgKzI5Miw3IEBAIHN0YXRpYyB1NjQgYXJtX3NwZV9ldmVudF90b19wbXNj
cihzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQpDQo+ICAJaWYgKCFhdHRyLT5leGNsdWRlX2tlcm5l
bCkNCj4gIAkJcmVnIHw9IEJJVChTWVNfUE1TQ1JfRUwxX0UxU1BFX1NISUZUKTsNCj4gIA0KPiAt
CWlmIChJU19FTkFCTEVEKENPTkZJR19QSURfSU5fQ09OVEVYVElEUikgJiYgcGVyZm1vbl9jYXBh
YmxlKCkpDQo+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1BJRF9JTl9DT05URVhUSURSKSAmJg0K
PiArZXZlbnRfaHdfZmxhZ3NfaGFzX2N4KGV2ZW50KSkNCj4gIAkJcmVnIHw9IEJJVChTWVNfUE1T
Q1JfRUwxX0NYX1NISUZUKTsNCj4gIA0KPiAgCXJldHVybiByZWc7DQo+IEBAIC03MTAsNyArNzMw
LDggQEAgc3RhdGljIGludCBhcm1fc3BlX3BtdV9ldmVudF9pbml0KHN0cnVjdCBwZXJmX2V2ZW50
ICpldmVudCkNCj4gIAkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiAgDQo+ICAJcmVnID0gYXJtX3Nw
ZV9ldmVudF90b19wbXNjcihldmVudCk7DQo+IC0JaWYgKCFwZXJmbW9uX2NhcGFibGUoKSAmJg0K
PiArCWV2ZW50X2h3X2ZsYWdzX3NldF9jeChldmVudCk7DQo+ICsJaWYgKCFldmVudF9od19mbGFn
c19oYXNfY3goZXZlbnQpICYmDQo+ICAJICAgIChyZWcgJiAoQklUKFNZU19QTVNDUl9FTDFfUEFf
U0hJRlQpIHwNCj4gIAkJICAgIEJJVChTWVNfUE1TQ1JfRUwxX0NYX1NISUZUKSB8DQo+ICAJCSAg
ICBCSVQoU1lTX1BNU0NSX0VMMV9QQ1RfU0hJRlQpKSkpDQo+IC0tDQo+IDIuMjUuMQ0KPiANCj4g
DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwNCg==
