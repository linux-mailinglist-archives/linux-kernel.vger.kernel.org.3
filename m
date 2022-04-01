Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5B4EE584
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiDAAzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiDAAzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:55:23 -0400
Received: from mg.sunplus.com (mswedge1.sunplus.com [60.248.182.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12DF15131A;
        Thu, 31 Mar 2022 17:53:29 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(8686:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Fri, 01 Apr 2022 08:53:05 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 1 Apr 2022 08:53:01 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 1 Apr 2022 08:53:01 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Subject: RE: [PATCH v5 2/2] mmc: Add mmc driver for Sunplus SP7021
Thread-Topic: [PATCH v5 2/2] mmc: Add mmc driver for Sunplus SP7021
Thread-Index: AQHYQ3s7ORyaR4vCu0uQF2nts2U94azV8Q6AgAM9naD//5VMAIABeSpQ
Date:   Fri, 1 Apr 2022 00:53:01 +0000
Message-ID: <b93772c707074f14ae3f2eeaf5e348ab@sphcmbx02.sunplus.com.tw>
References: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
 <46aad49867912fc57b669fc54fdb28638cccfcd9.1648551070.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a0CLA33CTerXJ=bK+myhyHp_utoLnTX-NzMgjeb7icAGg@mail.gmail.com>
 <7c4b66f7fe4940cba1b0158803767f6e@sphcmbx02.sunplus.com.tw>
 <CAK8P3a3edkGMyypwchiJjHDvO4ro6RsOvrhUbEDmP1Obs94mXw@mail.gmail.com>
In-Reply-To: <CAK8P3a3edkGMyypwchiJjHDvO4ro6RsOvrhUbEDmP1Obs94mXw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
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

RGVhciBBcm5kOg0KDQo+IDx0b255Lmh1YW5nQHN1bnBsdXMuY29tPiB3cm90ZToNCj4gPiA+ID4g
K3N0YXRpYyB2b2lkIHNwbW1jX3JlcXVlc3Qoc3RydWN0IG1tY19ob3N0ICptbWMsIHN0cnVjdA0K
PiA+ID4gPiArbW1jX3JlcXVlc3QNCj4gPiA+ID4gKyptcnEpIHsNCj4gPiA+ID4gKyAgICAgICBz
dHJ1Y3Qgc3BtbWNfaG9zdCAqaG9zdCA9IG1tY19wcml2KG1tYyk7DQo+ID4gPiA+ICsgICAgICAg
c3RydWN0IG1tY19kYXRhICpkYXRhOw0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBtbWNfY29tbWFu
ZCAqY21kOw0KPiA+ID4gPiArICAgICAgIGludCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAg
ICAgICByZXQgPSBtdXRleF9sb2NrX2ludGVycnVwdGlibGUoJmhvc3QtPm1ycV9sb2NrKTsNCj4g
PiA+ID4gKyAgICAgICBpZiAocmV0KQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0K
PiA+ID4NCj4gPiA+IEkgZG9uJ3QgdGhpbmsgaXQncyB2YWxpZCB0byBqdXN0IHJldHVybiBoZXJl
IHdoZW4geW91IGdldCBhIHNpZ25hbC4NCj4gPiA+IElmIG5vdGhpbmcgY2FuIGhhbmRsZSB0aGUg
c2lnbmFsLCBkb2Vzbid0IGl0IGp1c3QgaGFuZz8NCj4gPiA+DQo+ID4gPiBJdCBhbHNvIGFwcGVh
cnMgdGhhdCB5b3UgZG9uJ3QgcmVsZWFzZSB0aGUgbXV0ZXggdW50aWwgdGhlIHRhc2tsZXQNCj4g
PiA+IHJ1bnMsIGJ1dCBpdCBpcyBub3QgdmFsaWQgdG8gcmVsZWFzZSBhIG11dGV4IGZyb20gYSBk
aWZmZXJlbnQgY29udGV4dC4NCj4gPiA+DQo+ID4gPiBZb3Ugc2hvdWxkIGdldCBhIHdhcm5pbmcg
YWJvdXQgdGhpcyB3aGVuIHJ1bm5pbmcgYSBrZXJuZWwgd2l0aA0KPiA+ID4gbG9ja2RlcCBlbmFi
bGVkIGF0IGNvbXBpbGUgdGltZS4gUGxlYXNlIHJld29yayB0aGUgbG9ja2luZyB0byBtYWtlIHRo
aXMNCj4gd29yay4NCj4gPiA+DQo+ID4gICAgICAgICBSZW9tdmUgY29kZToNCj4gPiAgICAgcmV0
ID0gbXV0ZXhfbG9ja19pbnRlcnJ1cHRpYmxlKCZob3N0LT5tcnFfbG9jayk7DQo+ID4gICAgIGlm
IChyZXQpDQo+ID4gICAgICAgICAgcmV0dXJuOw0KPiA+DQo+ID4gICAgICAgICBCZWxvdyBpcyBt
eSBtb2RpZmljYXRpb246DQo+ID4gLiAgICBtdXRleF9sb2NrKCZob3N0LT5tcnFfbG9jayk7DQo+
IA0KPiBUaGF0IGFkZHJlc3NlcyB0aGUgcHJvYmxlbSB3aXRoIHRoZSBzaWduYWwgaGFuZGxpbmcs
IGJ1dCBub3QgdGhlIGxvY2sNCj4gaW1iYWxhbmNlLiBQbGVhc2UgZml4IHRoYXQgYXMgd2VsbC4N
Cg0KT2ssIEkgd2lsbCBtb2RpZnkgbG9jayBpbWJhbGFuY2UgaXNzdWUuDQoNCj4gPiA+DQo+ID4g
PiBJdCdzIGJldHRlciB0byB1c2UgU1lTVEVNX1NMRUVQX1BNX09QUy9SVU5USU1FX1BNX09QUyBp
bnN0ZWFkIG9mDQo+IHRoZQ0KPiA+ID4gU0VUXyB2ZXJzaW9uLCB0aGVuIHlvdSBjYW4gcmVtb3Zl
IGFsbCB0aGUgI2lmZGVmIGNoZWNrcy4NCj4gPiA+DQo+ID4NCj4gPiAgICAgICAgIEkgdXNlIFNZ
U1RFTV9TTEVFUF9QTV9PUFMvUlVOVElNRV9QTV9PUFMuDQo+ID4gICAgICAgICBDb21waWxlIHNo
b3dzIGVycm9yLiBFcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gPyA/DQo+
IFNZU1RFTV9TTEVFUF9QTV9PUFM/ID8gRGlkIHlvdSBtZWFuID8gPyBTRVRfU1lTVEVNX1NMRUVQ
X1BNX09QUz8gPw0KPiBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4g
DQo+IE1heWJlIHlvdSBhcmUgb24gYW4gb2xkIGtlcm5lbCByZWxlYXNlPw0KPiANCg0KT0ssSSB3
aWxsIHVzZSBuZXcga2VybmVsIHJlbGVhc2UgdG8gY29tcGlsZXIuDQoNCj4gPiAgICAgICAgIEkg
cmVmZXJlbmNlIG90aGVyIG1tYyBkcml2ZXIuDQo+ID4gICAgICAgICBCZWxvdyBpcyBteSBtb2Rp
ZmljYXRpb246DQo+ID4gICAgIENvbXBpbGVyIGlzIHBhc3MuDQo+ID4NCj4gPiAgICAgICAgICNp
ZmRlZiBDT05GSUdfUE1fU0xFRVANCj4gPiAgICAgICAgIHN0YXRpYyBpbnQgc3BtbWNfcG1fc3Vz
cGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICAgICAgICB7DQo+ID4gICAgICAgICAgICAg
ICAgIHBtX3J1bnRpbWVfZm9yY2Vfc3VzcGVuZChkZXYpOw0KPiA+DQo+ID4gICAgICAgICAgICAg
ICAgIHJldHVybiAwOw0KPiA+ICAgICAgICAgfQ0KPiANCj4gV2Ugc2hvdWxkIGZpeCB0aGUgb3Ro
ZXIgZHJpdmVycyBhcyB3ZWxsLiBGb3IgdGhlIG1vbWVudCwganVzdCBkbyBpdCB0aGUgcmlnaHQN
Cj4gd2F5IG5vdyBpbnN0ZWFkIG9mIGNvcHlpbmcgdGhlICNpZmRlZnMuDQo+IA0KT0ssIEkgd2ls
bCBmb2xsb3cgcmlnaHQgd2F5IHRvIHJlbW92ZSAjaWZkZWYuDQoNCg0KDQo=
