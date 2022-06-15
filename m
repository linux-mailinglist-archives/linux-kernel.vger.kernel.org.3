Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DEB54BFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbiFOCdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345406AbiFOCda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:33:30 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF04A140F1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:33:10 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(28633:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Wed, 15 Jun 2022 10:25:26 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 15 Jun 2022 10:25:22 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Wed, 15 Jun 2022 10:25:22 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v18 05/10] clk: Add Sunplus SP7021 clock driver
Thread-Topic: [PATCH v18 05/10] clk: Add Sunplus SP7021 clock driver
Thread-Index: AQHYf8r5uo30wfgQ7kKLEgfDFgKMD61Ow22AgAD0FaA=
Date:   Wed, 15 Jun 2022 02:25:22 +0000
Message-ID: <aaf96491f1a94b5694003797853aa732@cqplus1.com>
References: <cover.1655194858.git.qinjian@cqplus1.com>
 <42ed93cf0e5cfeaffdf50d63da558a3f1f6c1021.1655194858.git.qinjian@cqplus1.com>
 <20220614192555.86436C3411B@smtp.kernel.org>
In-Reply-To: <20220614192555.86436C3411B@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGstc3A3MDIxLmMgYi9kcml2ZXJzL2Nsay9j
bGstc3A3MDIxLmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAw
MC4uMGNhZWYxYmM3DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Ns
ay1zcDcwMjEuYw0KPiA+IEBAIC0wLDAgKzEsNzI1IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gDQo+IFRoaXMgaXNu
J3QgYSBjb21tb24gbGljZW5zZSBvbiBkcml2ZXIgZmlsZXMuIElzIGl0IGludGVuZGVkPyBPcg0K
PiBjb3B5L3Bhc3RlIGZyb20gRFQ/DQoNClllcywgSSBjb3B5L3Bhc3RlIGZyb20gRFQuDQpEaWQg
SSBuZWVkIGNoYW5nZWQgaXQgdG8gJ0dQTC0yLjAtb25seSc/DQoNCj4gDQo+ID4gKy8qDQo+ID4g
KyAqIENvcHlyaWdodCAoQykgU3VucGx1cyBUZWNobm9sb2d5IENvLiwgTHRkLg0KPiA+ICsgKiAg
ICAgICBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPiA+ICsgKi8NCj4gWy4uLl0NCj4gPiArDQo+ID4g
K3N0YXRpYyBpbnQgc3A3MDIxX2Nsa19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+ICt7DQo+IFsuLi5dDQo+ID4gKw0KPiA+ICsgICAgICAgLyogZ2F0ZXMgKi8NCj4gPiAr
ICAgICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHNwX2Nsa19nYXRlcyk7IGkrKykgew0K
PiA+ICsgICAgICAgICAgICAgICBjaGFyIG5hbWVbMTBdOw0KPiA+ICsgICAgICAgICAgICAgICB1
MzIgaiA9IHNwX2Nsa19nYXRlc1tpXS5yZWc7DQo+ID4gKyAgICAgICAgICAgICAgIHN0cnVjdCBj
bGtfcGFyZW50X2RhdGEgKnBkID0gc3BfY2xrX2dhdGVzW2ldLmV4dF9wYXJlbnQgPyAmcGRfZXh0
IDogJnBkX3N5czsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHNwcmludGYobmFtZSwgIiUw
MmRfMHglMDJ4IiwgaSwgaik7DQo+ID4gKyAgICAgICAgICAgICAgIGh3c1tpXSA9IGNsa19od19y
ZWdpc3Rlcl9nYXRlX3BhcmVudF9kYXRhKGRldiwgbmFtZSwgcGQsIDAsDQo+IA0KPiBUaGlzIG5l
ZWRzIHRvIGJlIGRldm0gYXMgd2VsbC4gT3RoZXJ3aXNlIGlmIHRoZSBkcml2ZXIgaXMgdW5ib3Vu
ZCB3ZSdsbA0KPiBsZWFrIHRoZXNlIHJlZ2lzdGVyZWQgY2xrcy4NCj4gDQoNCmNsay1wcm92aWRl
ci5oOg0Kc3RydWN0IGNsa19odyAqX19kZXZtX2Nsa19od19yZWdpc3Rlcl9nYXRlKHN0cnVjdCBk
ZXZpY2UgKmRldiwNCgkJc3RydWN0IGRldmljZV9ub2RlICpucCwgY29uc3QgY2hhciAqbmFtZSwN
CgkJY29uc3QgY2hhciAqcGFyZW50X25hbWUsIGNvbnN0IHN0cnVjdCBjbGtfaHcgKnBhcmVudF9o
dywNCgkJY29uc3Qgc3RydWN0IGNsa19wYXJlbnRfZGF0YSAqcGFyZW50X2RhdGEsDQoJCXVuc2ln
bmVkIGxvbmcgZmxhZ3MsDQoJCXZvaWQgX19pb21lbSAqcmVnLCB1OCBiaXRfaWR4LA0KCQl1OCBj
bGtfZ2F0ZV9mbGFncywgc3BpbmxvY2tfdCAqbG9jayk7DQojZGVmaW5lIGRldm1fY2xrX2h3X3Jl
Z2lzdGVyX2dhdGUoZGV2LCBuYW1lLCBwYXJlbnRfbmFtZSwgZmxhZ3MsIHJlZywgYml0X2lkeCxc
DQoJCQkJICBjbGtfZ2F0ZV9mbGFncywgbG9jaykJCQkgICAgICBcDQoJX19kZXZtX2Nsa19od19y
ZWdpc3Rlcl9nYXRlKChkZXYpLCBOVUxMLCAobmFtZSksIChwYXJlbnRfbmFtZSksIE5VTEwsIFwN
CgkJCSAgICAgICBOVUxMLCAoZmxhZ3MpLCAocmVnKSwgKGJpdF9pZHgpLAkJICAgICAgXA0KCQkJ
ICAgICAgIChjbGtfZ2F0ZV9mbGFncyksIChsb2NrKSkNCg0KU2hvdWxkIEkgdXNlIF9fZGV2bV9j
bGtfaHdfcmVnaXN0ZXJfZ2F0ZSgpIHdpdGggcGFyZW50X2RhdGENCm9yDQpkZXZtX2Nsa19od19y
ZWdpc3Rlcl9nYXRlKCkgd2l0aCBwYXJlbnRfbmFtZT8NCg0K
