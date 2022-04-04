Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1404F1425
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiDDL6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiDDL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:58:35 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DDB3BFAD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649073401; x=1680609401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2YKbwjy9xahERxuuujeTeWxDbJSujxOVYKKgPyDybVk=;
  b=OLkalKfQTGbyU18LcnRH0RNR8oFBWNykOankFtdHMSAy1sI550rkByYq
   WY8WVtMoQuWqot8yiGX6cRMbJxaDHE1G6UQteK8tWtixs21ceIjYVV0DR
   sov0qmzhazxKEoyoPhjoq7JFKlh9ghQi5nR1Piap1p5XdnxLQaSNw3AtN
   xncWsvUHoG3+QvkwbsU+SM3cOL5plPd8GTAmu0dcNkmNmZat7ddZCtsGF
   V0yxb2xUQH7Im+cb94+mCEIZius39JrzaJM06uces9d/SW4zeTgZwsmvj
   LuxOCRVZIW+a3imHSErr+rlxIuXrYRUSiY8M6pQ7/pLhuhGMvV/crg4AT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="53167682"
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200"; 
   d="scan'208";a="53167682"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 20:56:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKKNb2VSQoMsm43HzwyBFk9RAxGGvbPsSKfbwG0O2OvY83kZii1F9U0RqN6qJ724ECrtY9cruZ7pqxkpR1ZcryW0h/5hptnmZcr7H1dHWR2RZaEbsjIogbglvWZoi+k7tXCwicAVpzGYo3gchO56ctfiR/Byb2F27AZMfnYKq+lZi4JgMJdbUL7pm+lwYTq6F+RqCEDtT9dKTKo/vMG+S1gZ9v/g626QgLHaVDsWRkXaCKEj1d0Y3s1itXuafRFcuvKvgSNgtyGjiw5zcV1SD4EuV8KUnoCbBomIzQkjr1LcCQdIUI1fbDNnizS7IpV/zGh0IIl/2zMmSqlNTvtL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YKbwjy9xahERxuuujeTeWxDbJSujxOVYKKgPyDybVk=;
 b=oNEZcmixGYDZPiW55xKpUQqzT+HBnRXV14k5bMxTKBPwA+jj74jxCac4mZlSv0sDxlKJywdXJAsobkSNvhNFkJ1+teoPR7QTt/fCWZWrGMS8BlI+VP2nj28Z/Y5q9ultHUzX95+XEsF9QNWiTaNMJKdw270Ug3XT61NdUEaj3vfChe3WWFC9qScCcsaxCOq6hmLx47626krwnh8GkuuLXqbUtVEfLSJjD5MuslV27qI0WDymvtUNyanFuk0nOgb0ghXTinAC+Pbsylqbofa7spz9EE4Z1t4gvjR9LAkgdEHMSJK20X1WMpS7sK0zng2v3S5dBWO0UoFcRmSkrmt5nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YKbwjy9xahERxuuujeTeWxDbJSujxOVYKKgPyDybVk=;
 b=UTJQfdqOMtejImgXIJqGYSfAV0RQY9/uyk97rsiNOcH+hzLk24WpMN673B1j7eLEP9ck7TrX3XYsKbV5wU+gqkmoZAfntXtKhMHiKokSUYZxCRC8vJ4vB6FjIPRzD+ZfJsYgHER4jIaIfLYoGNWMZmk/mr12QWir7T+PcMH3sL8=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSBPR01MB2710.jpnprd01.prod.outlook.com (2603:1096:604:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 11:56:32 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a01d:8cfb:2889:a316]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a01d:8cfb:2889:a316%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 11:56:32 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Rob Herring' <robh@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/8] arm64: Add hardware prefetch control support for
 ARM64
Thread-Topic: [PATCH v2 3/8] arm64: Add hardware prefetch control support for
 ARM64
Thread-Index: AQHYNTHKCWofGIybF0m7Nxc76R+vA6zYm+sAgAcqSXA=
Date:   Mon, 4 Apr 2022 11:56:32 +0000
Message-ID: <OSBPR01MB2037C11072121E5C01F8F17080E59@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
 <20220311101940.3403607-4-tarumizu.kohei@fujitsu.com>
 <CAL_JsqLfDQid2WFDnFDp237wQ+hAx=0g=rumYWWpdJ=aoGf5MA@mail.gmail.com>
In-Reply-To: <CAL_JsqLfDQid2WFDnFDp237wQ+hAx=0g=rumYWWpdJ=aoGf5MA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87d31fd3-bcc5-455d-f6ec-08da16322975
x-ms-traffictypediagnostic: OSBPR01MB2710:EE_
x-microsoft-antispam-prvs: <OSBPR01MB2710628213283497B2D2868480E59@OSBPR01MB2710.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FnHUtCUrHKw0igeJhrVZ8CpATOWGb5zuraQaLbg+9YW1RK/wCY16CQbqangXUpHubov1Ai80xRTeiIa5YWaAt2uirMQsJXYRDdoYyUusDtEQZubOTfeHBb73DpYrlQpmRfQTZ9zAwaEbAT2xs0dUMOguMwUHI0sbMtVdz7ET+BniWhpoXxMI3hnYJFzDPy8PEsFFXRTznfjyf2TmXqado/a7VuPOLdbWaMq2kO+Dz9BJuunPvRQeWNUtYAiH/vq33ifDpA/11z0KV1PCFPe8QvOLHXvGTYHg7/iDAeii4Up0d/BhBvjDYdczv316aoLe6awlvLZ1gqcREruF4GMM2Ev0ctY0/qvfXBUFm2+aB/v6fESkBClBOKkcr/2ZJKA/hK0op6URTnWbC6aU+aWDRm1a6SwgZ7dMIJmoIQe0HWtkt83M7lv1Voi2Az/S94MGu8mQ2FynwWiJ5hs+OqmiFFmW0XYd7quCR/qLEth6BUpt9qGL6a6Gvd4spARMaRp+F+tPuZa4Dnm9y68GZy+VelDwPsKcE3lqZOHAAgYc8mRXlIYvisP111wjVhspKrN02gKpaJaahzIf812PRbuzAwda9P3oKwpyIQVdhJnjJWZZNWjUmDwrPUYqCPTfiGBShVjhnIBeGioLUYzgtmjApc3xKan22UraP92Nbi1IRlmLwk4VLQ5le4ChvO1Bh97BYpJtyd8DAWo3AJRDebKxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(8936002)(316002)(52536014)(85182001)(71200400001)(6916009)(54906003)(9686003)(508600001)(7696005)(33656002)(6506007)(66446008)(66476007)(83380400001)(86362001)(8676002)(66946007)(64756008)(26005)(4326008)(186003)(76116006)(66556008)(55016003)(4744005)(82960400001)(7416002)(2906002)(122000001)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3loS3FCcjBTL1luSWRsNkRvRXFUa1grMFBoSWRDcGE2cFVvOTA3VGx1NEJJ?=
 =?utf-8?B?SlZhWFBhTVVzOWNYMmZMay9SK0pHTXB4K09oNEdPV1k0b0xvMm85MURTaUxw?=
 =?utf-8?B?L0dCaXFPWjZDSTM1N1ZMR0VMbEhhUkhzUTVXUlNVWkZhZXBLWXBobFlqbmRk?=
 =?utf-8?B?YjRtaThaSXRXZ0pkcWw4MTY0V1NkNUxvK0lCY1NpTWdtamU1bHJheWREYUx0?=
 =?utf-8?B?TVFNOGVmRXpSTjF1N3dOQjRITnh0YXcwSGJQdHVGZllXTmxIWWxkK2pxOHZI?=
 =?utf-8?B?WGFIeDRZdFBQb2x3enpybHpoVXdBdW9Qb2hLTW96NjlRUXhEVExlSUd0RUhR?=
 =?utf-8?B?NTU4Smk2MEEwRjI2SlNRQjBGU0cvdTBxWnlLT0tZcENJeWdYdk9Db0xBeVF2?=
 =?utf-8?B?eW9iamNtWHIwRmRaRDYxQjhLS01UUmo2dGxLRkFjTk4xUTdCY0lMbUJMWkVW?=
 =?utf-8?B?V2F2cHFMUEdXN0c3TEZWU1Z4V0JRVTU2eW5TaFBONzFVa0krVFZZVGJtRTE1?=
 =?utf-8?B?aHErenZvb0dDZnpOQVJPT3FlQ1d6ZkRtNFo5MTJySG5teWhFN3lIK0Rkd0dD?=
 =?utf-8?B?UkJSS3V6NHhJWFk3TTB4MitGb0dCMzU3d1FLSmtnZE15d1pJUnE0Y0pBSGkz?=
 =?utf-8?B?c0F1WktJSnJOTzNybFA0OWNwQ25sL2h2L2I0S2U2Y1MwODBtMVpGUTlVTXlD?=
 =?utf-8?B?NnlRN040U2J1K2lzeThFM2RQRnVjbnNzRXVucVRjdzdma2xiTUV0VnZ6cXVV?=
 =?utf-8?B?anV0aEdCTGQxMCt5c2V4VzF1RXBqRmhuUEJOMTlYNS9QQm1rN0tna0RpQjIz?=
 =?utf-8?B?ajVjQjhXT2tqaTUxYUhnL0phczA5Tys5ZWxweW5adHhUOWp1bnR0NVdXQWlO?=
 =?utf-8?B?V1Z1Y0hxWlVSWWJuZGdWOUEvUkp4N2RvOEZyYzBXb0FJeXpTWkZ3Vy9zSHQy?=
 =?utf-8?B?YXhRVVgxNTNtWHkzblkvMkhkRS83V2M3VlFma1dCZVIwdjhabCtvN3FiREdQ?=
 =?utf-8?B?blFUUDgyVzcvczkxQkhXTnhnV1RhUmFjb2I2dmliWUU2ay84RU1ybVNNNEgw?=
 =?utf-8?B?V2VJRFBxd0FyQ1JtWmY3M1ZNdzJsV2FnWTFjQTQ2YzdTVitKWGVlcGxPQ3NX?=
 =?utf-8?B?dnU0ZVJEckdRWmpMZEJaUkZFdmtieEJLNVlMUFppWHNCbGtSRGpVemhoT3dh?=
 =?utf-8?B?Y0lWVWRZM3BEK2Q5UWQrd1A4TXBmOFp2czMzQU5WK0dRSldiUWRGWlRjZnQ3?=
 =?utf-8?B?UDNkUS90Y2pGUmp0QjNBME1obHlJTkx5U0NMcmpGcDlhRmsxb1EyRE5RNkdk?=
 =?utf-8?B?MlU3dXJ4RXY5SGswbnRWVlFrK2NYVVgrakw2WXRGMGZaS2RINE84Vkg4dzJ0?=
 =?utf-8?B?eFp0VVp6U0pTTWFlUEZhS3Nrdk1lWGwvU3VpNXEzZlp5MXJMZFFsSWE3KzNq?=
 =?utf-8?B?TFM5dUttRHZ4OUc5RU1CcUxOb0hZMjdET2NMdmt5OGpleVcwMXY0TmFaWEZT?=
 =?utf-8?B?N0NDK2kxS3R4Q3JlQkJ4eEFKRWNpbkx0cE5VVFEvZFN6anVEZFQ5aGZMQS95?=
 =?utf-8?B?MWI3ZGVEMVVtdDNNcTVpQXQrcFR3b1Jzay9DYndIL1Q3WUNvYXFCR1FENWx2?=
 =?utf-8?B?eGYwZitPSU02cGtpNjBURVFDSTZiNnQ4d05GSGl5cFRTUUlZQm5iSTJZR05R?=
 =?utf-8?B?RC9EaGsvbzJjc2QyQTdEeUlnN013Qk1UbEFOU1Jtc0tjc0Q5SmtTSFZyb0pj?=
 =?utf-8?B?UHA1TDJsamxpL3hqN0hYTllBdVpHQys1NXRjd3ZITGw0dm9wUDZUYlV1OU1Y?=
 =?utf-8?B?dHdGaHk1OVFrYXk5Vkx2QzBxTXBXd25va3RieGlIdjljYWRLNmRqVEV1RWZT?=
 =?utf-8?B?ZjRucnBkWGxFbnhoNzYzWm1wZTdleklMWU4wNFJsU0h0eGxXTzNocWN0eCsx?=
 =?utf-8?B?dk1XMDNuM1J2RklJUzZKNkIvSDhIVG80RUU1STV6bW95WWFIU0NSa2V2VlZu?=
 =?utf-8?B?dHRUNUF6VWg5ZXc5NXJEMHh5YVlZZEQ2Q3E2dXNPaGdRTVdXcnpZa29zaG9X?=
 =?utf-8?B?SGNIb2ZRS2pxMGQ0VGYySEgwWlBkUEpKWFV1ZHQ2aDVSOUw5ZjcwWUJ0REI0?=
 =?utf-8?B?LzIycGJCSDh1eUNLRGhScHJuVER2N2R5WlBzMjRCSW1UL2t2cFVLbTlsZjJK?=
 =?utf-8?B?MlVoN1JWclVYMk9nUTNyeUswTjk4dWVrVWFVTlErMFo1QnZjMmdOMWF3OFRN?=
 =?utf-8?B?enZKUzJ0T0oyYmQwdEc0eVM3dDQ4b3pkMEpOb0VYMC84aEpaQzMzNVEwRllY?=
 =?utf-8?B?TUZ6WVVQWkJMRG4wMkczOS82UHUzbnhFNml4VlpRTVdIMHZrelVRMUdSZmUz?=
 =?utf-8?Q?hVEArWkSTP1DAXP0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d31fd3-bcc5-455d-f6ec-08da16322975
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 11:56:32.3463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+7duglqleDH6cfuajrXJwr/rgCnF0j5g4NSH84DBrOB5dgaKwUiKdnliAgi/xUviFk7jtlXEOk6o01gkUhOA6vDhVdZRTCPSI1IOoT+q3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2710
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggYXJtNjQgYXJjaCBvdGhlciB0aGFuIHlvdSBh
Y2Nlc3MgcmVnaXN0ZXJzIGFzIHN5c3JlZ3MuDQo+IFRoYXQncyBub3QgZW5vdWdoIG9mIGEgcmVh
c29uIHRvIHB1dCBpbiBhcmNoL2FybTY0LiBNb3ZlIHRoaXMgdG8gZHJpdmVycy8NCj4gYXNzdW1p
bmcgaXQgY29udGludWVzLiBJIGFncmVlIHRoYXQgdGhpcyBzZWVtcyBxdWVzdGlvbmFibGUgdG8g
ZXhwb3NlIHRvDQo+IHVzZXJzcGFjZSBpbiB0aGUgZmlyc3QgcGxhY2UuLi4NCg0KSSBtb3ZlIGl0
IHVuZGVyIGRyaXZlcnMvIGluIHRoZSBuZXh0IHZlcnNpb24uDQo=
