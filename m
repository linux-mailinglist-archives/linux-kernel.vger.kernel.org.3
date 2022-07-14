Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36212575342
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbiGNQqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbiGNQps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:45:48 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5EC6871D;
        Thu, 14 Jul 2022 09:44:20 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 98A2A462034;
        Thu, 14 Jul 2022 18:44:09 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7C95D46166E;
        Thu, 14 Jul 2022 18:44:09 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Thu, 14 Jul 2022 18:44:09 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 14 Jul
 2022 18:44:08 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Thu, 14 Jul 2022 18:44:08 +0200
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEtvaGxzY2jDvHR0ZXI=?= 
        <christian@kohlschutter.com>, Robin Murphy <robin.murphy@arm.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?utf-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
Thread-Topic: [PATCH v2] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
Thread-Index: AQHYl56CKm68niEykEeE+sqK07QWzK1+EKag
Date:   Thu, 14 Jul 2022 16:44:08 +0000
Message-ID: <eec07acea8694191a75880acc397dafe@hyperstone.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
 <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
In-Reply-To: <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27016.001
X-TMASE-Result: 10--3.063700-10.000000
X-TMASE-MatchedRID: QfHZjzml1E/RbDQWs/vjTP7FEhWgo0y89u0so3sONfgSgmfkOsgfKrCN
        7xgFqHGJ7DBK8KB1N1/CABvr2i15oWjb3BwZs8hXrMZ+BqQt2NrUtXfJ7mutAbV5fSMRD1zquxW
        P7AlD8NMORPqUJpjuj+NSIM1P3ba035n3zfl6vmuyAEyENeP8ZafV6VlwBmU0tU0lCTMMyfCJzv
        yP4u0tgCqq0O5S3DJ8YASlu1An0J4v+0FNnM7lDQPZZctd3P4BrOCEGIPhtwiYb2HRMAdbi4uVC
        Dz2gMcK4vM1YF6AJbY9l7H+TFQgdY2j49Ftap9EOwBXM346/+yeBqJ8tFEKajjrYa78T5wg3BzY
        WenF8C5oZumtA5oTaFO4kVfDSJaF
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 30397a4e-fd32-4b05-8ccc-83571dca0cc6-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBvbmx5IGJyaWVmbHkgc2tpbW1lZCB0aGUgZGlzY3Vzc2lvbiwgYnV0IGRvZXMgdGhpcyBtZWFu
IHRoYXQgYSBzb2Z0LXJlc2V0IChDTUQwKSBvZiBhIFVIUyAocG9zdC12b2x0YWdlLXN3aXRjaCkg
d2lsbCBub3Qgd29yaz8NCihBcyB0aGUgY2FyZC9zcGVjIHJlcXVpcmVzIGEgcG93ZXItY3ljbGUg
YnkgdGhlIGhvc3Qgd2hpY2ggd2lsbCBub3QgY29tZSwgcmlnaHQ/KQ0KQ2FuIHlvdSB0cnkgdGhp
cyByZWFsIHF1aWNrPyBJIGNhbiBnaXZlIHlvdSBhIG1tYy11dGlscyBzbmlwcGV0IGlmIHlvdSBo
YXZlIHRyb3VibGUgaXNzdWluZyBvbmUuDQpJZiB0aGF0IGRvZXMgaW5kZWVkIG5vdCB3b3JrIEkg
dGhpbmsgdGhlIGdlbmVyYWwgYXBwcm9hY2ggaXMgdG8gZGlzYWJsZSB1aHMgaW4gdGhlIGR0cyBv
ciBhdCBsZWFzdCBkb2N1bWVudCB0aGF0Lg0KUmVnYXJkcywNCkNocmlzdGlhbg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEtvaGxzY2jDvHR0ZXIgPGNocmlz
dGlhbkBrb2hsc2NodXR0ZXIuY29tPiANClNlbnQ6IERvbm5lcnN0YWcsIDE0LiBKdWxpIDIwMjIg
MTg6MjcNClRvOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPjsgTWFya3VzIFJl
aWNobCA8bS5yZWljaGxAZml2ZXRlY2huby5kZT47IEhlaWtvIFN0w7xibmVyIDxoZWlrb0BzbnRl
Y2guZGU+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXJvY2tj
aGlwQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExp
bnV4IE1NQyBMaXN0IDxsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogW1BBVENI
IHYyXSBhcm02NDogZHRzOiByb2NrY2hpcDogRml4IFNEIGNhcmQgaW5pdCBvbiByazMzOTktbmFu
b3BpNA0KDQptbWMvU0QtY2FyZCBpbml0aWFsaXphdGlvbiBtYXkgZmFpbCBvbiBOYW5vUGkgcjRz
IHdpdGgNCiJtbWMxOiBwcm9ibGVtIHJlYWRpbmcgU0QgU3RhdHVzIHJlZ2lzdGVyIiAvDQoibW1j
MTogZXJyb3IgLTExMCB3aGlsc3QgaW5pdGlhbGlzaW5nIFNEIGNhcmQiDQoNCk1vcmVvdmVyLCBy
ZWJvb3Rpbmcgd291bGQgYWxzbyBzb21ldGltZXMgaGFuZy4NCg0KVGhpcyBpcyBjYXVzZWQgYnkg
dGhlIGdwaW8gZW50cnkgZm9yIHRoZSB2Y2MzdjAtc2QgcmVndWxhdG9yOw0KZXZlbiB0aG91Z2gg
aXQgYXBwZWFycyB0byBiZSB0aGUgY29ycmVjdCBHUElPIHBpbiwgdGhlIHByZXNlbmNlDQpvZiB0
aGUgYmluZGluZyBjYXVzZXMgdGhlc2UgZXJyb3JzLg0KDQpGaXggdGhlIHJlZ3VsYXRvciB0byBk
cm9wIHRoZSBncGlvIGJpbmRpbmcgYW5kIGFkZCBhIGNvbW1lbnQNCnRvIHByZXZlbnQgYWNjaWRl
bnRhbCByZWludHJvZHVjdGlvbiBvZiB0aGF0IGVudHJ5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS29obHNjaMO8dHRlciA8Y2hyaXN0aWFuQGtvaGxzY2h1dHRlci5jb20+DQotLS0NCiBh
cmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzM5OS1uYW5vcGk0LmR0c2kgfCAyICstDQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzM5OS1uYW5vcGk0LmR0c2kgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzM5OS1uYW5vcGk0LmR0c2kNCmluZGV4IDhj
MGZmNmM5NmUwMy4uZDVmOGE2MmUwMWJlIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9yb2NrY2hpcC9yazMzOTktbmFub3BpNC5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L3JvY2tjaGlwL3JrMzM5OS1uYW5vcGk0LmR0c2kNCkBAIC02Nyw3ICs2Nyw3IEBAIHZjYzF2OF9z
MzogdmNjMXY4LXMzIHsNCiAJdmNjM3YwX3NkOiB2Y2MzdjAtc2Qgew0KIAkJY29tcGF0aWJsZSA9
ICJyZWd1bGF0b3ItZml4ZWQiOw0KIAkJZW5hYmxlLWFjdGl2ZS1oaWdoOw0KLQkJZ3BpbyA9IDwm
Z3BpbzAgUktfUEExIEdQSU9fQUNUSVZFX0hJR0g+Ow0KKwkJLy8gZ3BpbyA9IDwmZ3BpbzAgUktf
UEExIEdQSU9fQUNUSVZFX0hJR0g+OyAvLyBicmVha3MgU0RIQyBjYXJkIHN1cHBvcnQNCiAJCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogCQlwaW5jdHJsLTAgPSA8JnNkbW1jMF9wd3JfaD47
DQogCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KLS0gDQoyLjM2LjENCg0KDQoNCkh5cGVyc3RvbmUg
R21iSCB8IFJlaWNoZW5hdXN0ci4gMzlhICB8IDc4NDY3IEtvbnN0YW56Ck1hbmFnaW5nIERpcmVj
dG9yOiBEci4gSmFuIFBldGVyIEJlcm5zLgpDb21tZXJjaWFsIHJlZ2lzdGVyIG9mIGxvY2FsIGNv
dXJ0czogRnJlaWJ1cmcgSFJCMzgxNzgy

