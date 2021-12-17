Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51669478965
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhLQLD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:03:29 -0500
Received: from 113.196.136.146.ll.static.sparqnet.net ([113.196.136.146]:47292
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232148AbhLQLD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:03:28 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(9398:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Fri, 17 Dec 2021 19:03:37 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 17 Dec 2021 19:03:36 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 17 Dec 2021 19:03:36 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?6buD5oe35Y6a?= <tonyhuang.sunplus@gmail.com>
Subject: RE: [PATCH v4 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v4 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX8mCd69RkrTnSM0GRURxouCuBCKw1+gLA///W7ICAALVacA==
Date:   Fri, 17 Dec 2021 11:03:36 +0000
Message-ID: <d7db8a508e9b4eb8933f4862087919b2@sphcmbx02.sunplus.com.tw>
References: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
 <c3a3b64c38807b2f344c3df500eb4c60b885eadf.1639557112.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a0CnCK-Dfodp-jTzZApM_1NpdY7DV2fRqnO=gaju5xGwg@mail.gmail.com>
 <CAHpW4oQmtd-gG1HYZT-Dk=QAvXKsKebzcOaVtrEeoujwoL9zSg@mail.gmail.com>
 <316c16afbff74160b07bd74444f3b8e1@sphcmbx02.sunplus.com.tw>
 <CAK8P3a0cA7iL=ug6hiqWAV1-qFSoCN-R7jrXv0cqByUDJV4x0Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0cA7iL=ug6hiqWAV1-qFSoCN-R7jrXv0cqByUDJV4x0Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBcm5kOg0KPiANCj4gPiAzLlNvIHlvdSBhc2sgbWUgdG8gY29udHJvbCBJT1AoODA1MSkg
dGhyb3VnaCBmaWxlX29wZXJhdGlvbnMsIG5vdA0KPiA+IHRocm91Z2ggREVWSUNFX0FUVFINCj4g
DQo+IE5vLCBuZWl0aGVyIG9mIHRoZW0uIFVzZSB0aGUgYXBwcm9wcmlhdGUgZHJpdmVycy8qLyBz
dWJzeXN0ZW1zIGZvciBhbnkNCj4gZnVuY3Rpb25hbGl0eSB0aGF0IGhhcyBhbiBleGlzdGluZyBz
dWJzeXN0ZW0uIElmIHRoZXJlIGlzIHNvbWV0aGluZyB0aGF0IHRoZSBpb3ANCj4gZG9lcyB0aGF0
IGRvZXMgbm90IHlldCBoYXZlIGEgc3Vic3lzdGVtLCB0aGF0IHJlcXVpcmVzIGEgbW9yZSB0aG9y
b3VnaCBkZXNpZ24NCj4gZGlzY3Vzc2lvbiBmb3IgY3JlYXRpbmcgYSBuZXcgdXNlciBpbnRlcmZh
Y2UsIGlkZWFsbHkgaW4gYSBoYXJkd2FyZS1pbmRlcGVuZGVudA0KPiB3YXkuIFlvdSBzaG91bGQg
bm90IHN0YXJ0IHdpdGggdGhhdCB1bnRpbCBhbGwgdGhlIG5vcm1hbCBmZWF0dXJlcyAocnRjLCB3
YWtldXAsDQo+IHN1c3BlbmQsIGdwaW8sIC4uLikgYXJlIHN1cHBvcnRlZC4NCj4gDQoNCklPUCg4
MDUxKSBoYXMgMTIgYnl0ZXMgTWFpbGJveCByZWdpc3RlcnMsIHdoaWNoIGNhbiBiZSByZWFkIGFu
ZCB3cml0dGVuIGJ5IElPUCg4MDUxKSBhbmQgU3lzdGVtLCB1c2VkIHRvIGV4Y2hhbmdlIGluZm9y
bWF0aW9uIHdpdGggdGhlIHN5c3RlbSwgZmFzdGVyIHRoYW4gc2hhcmVkIG1lbW9yeS4NCg0KVGhh
bmtzCQkJDQo=
