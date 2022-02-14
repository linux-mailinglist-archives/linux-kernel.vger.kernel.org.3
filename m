Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377F64B3F64
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiBNCXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:23:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiBNCXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:23:49 -0500
Received: from mg.sunplus.com (mswedge2.sunplus.com [60.248.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7E3650E13;
        Sun, 13 Feb 2022 18:23:41 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(3679:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Mon, 14 Feb 2022 10:23:47 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 14 Feb 2022 10:23:46 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 14 Feb 2022 10:23:46 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH] spi: Fix warning for Clang build
Thread-Topic: [PATCH] spi: Fix warning for Clang build
Thread-Index: AQHYHichnrMLSeAM6EW6YKfSFQS5w6yMHQcAgAGTjCD//5KmAIAAiAKAgAN8jYCAAQ7f8A==
Date:   Mon, 14 Feb 2022 02:23:46 +0000
Message-ID: <c323cc48ade94712aa1520c10090e01d@sphcmbx02.sunplus.com.tw>
References: <691d52b72f978f562136c587319852f5c65f08fe.1644460444.git.lhjeff911@gmail.com>
 <YgT0LMcDpCEYHFYg@sirena.org.uk>
 <99ab624e2af4414bb2a785f64f35bd95@sphcmbx02.sunplus.com.tw>
 <aaaefa2b-e043-2bf8-28aa-d89deb3fbc2a@redhat.com>
 <0b71842ec1b946729e74d73cbd354162@sphcmbx02.sunplus.com.tw>
 <YglJx3kgSFUH7nqX@dev-arch.archlinux-ax161>
In-Reply-To: <YglJx3kgSFUH7nqX@dev-arch.archlinux-ax161>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91LCBJIHdpbGwgcmV2aXNlIGl0IHRvIHRoZSBuZXh0IHN1Ym1pdCBiYXNlZCBvbiB0
aGVzZSBzdWdnZXN0aW9ucw0KDQoNCg==
