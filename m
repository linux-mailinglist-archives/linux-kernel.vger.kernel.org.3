Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B824B1D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245522AbiBKE66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:58:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiBKE65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:58:57 -0500
Received: from mg.sunplus.com (mswedge2.sunplus.com [60.248.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57B312651;
        Thu, 10 Feb 2022 20:58:54 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(3694:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Fri, 11 Feb 2022 12:59:01 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 11 Feb 2022 12:59:00 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 11 Feb 2022 12:59:00 +0800
From:   =?big5?B?TGggS3VvILOipE+7qA==?= <lh.Kuo@sunplus.com>
To:     Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>,
        Li-hao Kuo <lhjeff911@gmail.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>
Subject: RE: [PATCH] spi: Fix warning for Clang build
Thread-Topic: [PATCH] spi: Fix warning for Clang build
Thread-Index: AQHYHichnrMLSeAM6EW6YKfSFQS5w6yMHQcAgAGTjCD//5KmAIAAiAKA
Date:   Fri, 11 Feb 2022 04:59:00 +0000
Message-ID: <0b71842ec1b946729e74d73cbd354162@sphcmbx02.sunplus.com.tw>
References: <691d52b72f978f562136c587319852f5c65f08fe.1644460444.git.lhjeff911@gmail.com>
 <YgT0LMcDpCEYHFYg@sirena.org.uk>
 <99ab624e2af4414bb2a785f64f35bd95@sphcmbx02.sunplus.com.tw>
 <aaaefa2b-e043-2bf8-28aa-d89deb3fbc2a@redhat.com>
In-Reply-To: <aaaefa2b-e043-2bf8-28aa-d89deb3fbc2a@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="big5"
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

WWVzLiBJIHRoaW5rIHRoZSBmdW5jdGlvbiBjYW4gYmUgc2ltcGxpZmllZCBhcyBmb2xsb3dzDQoN
CnN0YXRpYyBpbnQgc3A3MDIxX3NwaV9zbGF2ZV90cmFuc2Zlcl9vbmUoc3RydWN0IHNwaV9jb250
cm9sbGVyICpjdGxyLCBzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLA0KCQkJCSAgICAgICBzdHJ1Y3Qg
c3BpX3RyYW5zZmVyICp4ZmVyKQ0Kew0KCXN0cnVjdCBzcDcwMjFfc3BpX2N0bHIgKnBzcGltID0g
c3BpX21hc3Rlcl9nZXRfZGV2ZGF0YShjdGxyKTsNCglzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwc3Bp
bS0+ZGV2Ow0KCWludCByZXQ7DQoNCgltb2RlID0gU1A3MDIxX1NQSV9JRExFOw0KCWlmICh4ZmVy
LT50eF9idWYgJiYgeGZlci0+cnhfYnVmKSB7DQoJCWRldl9kYmcoJmN0bHItPmRldiwgIiVzKCkg
d3JvbmcgY29tbWFuZFxuIiwgX19mdW5jX18pOw0KCQlyZXR1cm4gLUVJTlZBTDsNCgl9IGVsc2Ug
aWYgKHhmZXItPnR4X2J1Zikgew0KCQl4ZmVyLT50eF9kbWEgPSBkbWFfbWFwX3NpbmdsZShkZXYs
ICh2b2lkICopeGZlci0+dHhfYnVmLA0KCQkJCQkgICAgICB4ZmVyLT5sZW4sIERNQV9UT19ERVZJ
Q0UpOw0KCQlpZiAoZG1hX21hcHBpbmdfZXJyb3IoZGV2LCB4ZmVyLT50eF9kbWEpKQ0KCQkJcmV0
dXJuIC1FTk9NRU07DQoJCXJldCA9IHNwNzAyMV9zcGlfc2xhdmVfdHgoc3BpLCB4ZmVyKTsNCgl9
IGVsc2UgaWYgKHhmZXItPnJ4X2J1Zikgew0KCQl4ZmVyLT5yeF9kbWEgPSBkbWFfbWFwX3Npbmds
ZShkZXYsIHhmZXItPnJ4X2J1ZiwgeGZlci0+bGVuLA0KCQkJCQkgICAgICBETUFfRlJPTV9ERVZJ
Q0UpOw0KCQlpZiAoZG1hX21hcHBpbmdfZXJyb3IoZGV2LCB4ZmVyLT5yeF9kbWEpKQ0KCQkJcmV0
dXJuIC1FTk9NRU07DQoJCXJldCA9IHNwNzAyMV9zcGlfc2xhdmVfcngoc3BpLCB4ZmVyKTsNCgl9
DQoNCglpZiAoeGZlci0+dHhfYnVmKQ0KCQlkbWFfdW5tYXBfc2luZ2xlKGRldiwgeGZlci0+dHhf
ZG1hLCB4ZmVyLT5sZW4sIERNQV9UT19ERVZJQ0UpOw0KCWlmICh4ZmVyLT5yeF9idWYpDQoJCWRt
YV91bm1hcF9zaW5nbGUoZGV2LCB4ZmVyLT5yeF9kbWEsIHhmZXItPmxlbiwgRE1BX0ZST01fREVW
SUNFKTsNCg0KCXNwaV9maW5hbGl6ZV9jdXJyZW50X3RyYW5zZmVyKGN0bHIpOw0KCXJldHVybiBy
ZXQ7DQp9DQoNCg0KDQo=
