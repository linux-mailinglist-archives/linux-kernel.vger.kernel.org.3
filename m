Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0E494A96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiATJXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:23:11 -0500
Received: from mswedge1.sunplus.com ([60.248.182.113]:43868 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235634AbiATJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:23:05 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(11298:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Thu, 20 Jan 2022 17:23:12 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Thu, 20 Jan 2022 17:23:06 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Thu, 20 Jan 2022 17:23:06 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
Thread-Topic: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
Thread-Index: AQHYDEdoNQA4Z8mYU0mSuzI8gOIgg6xqY3GAgAE/t3A=
Date:   Thu, 20 Jan 2022 09:23:06 +0000
Message-ID: <a354d7c1dce4463ea57706dd5443fe7a@sphcmbx02.sunplus.com.tw>
References: <cover.1642494310.git.lhjeff911@gmail.com>
 <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
 <CAHp75VdKc3UDzaqM2G5J5+G90U6Spqyhz_vuOYKhqJ4V-uf=wg@mail.gmail.com>
In-Reply-To: <CAHp75VdKc3UDzaqM2G5J5+G90U6Spqyhz_vuOYKhqJ4V-uf=wg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSBTaGV2Y2hlbmtvIDoNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQsIEkgaGF2ZSBz
b21lIHF1ZXN0aW9ucyBhcyBiZWxvdy4NCg0KPiA+ICsgICAgICAgaWYgKHhmZXItPnR4X2J1ZikN
Cj4gPiArICAgICAgICAgICAgICAgZG1hX3VubWFwX3NpbmdsZShkZXYsIHhmZXItPnR4X2RtYSwg
eGZlci0+bGVuLCBETUFfVE9fREVWSUNFKTsNCj4gPiArICAgICAgIGlmICh4ZmVyLT5yeF9idWYp
DQo+ID4gKyAgICAgICAgICAgICAgIGRtYV91bm1hcF9zaW5nbGUoZGV2LCB4ZmVyLT5yeF9kbWEs
IHhmZXItPmxlbiwNCj4gPiArIERNQV9GUk9NX0RFVklDRSk7DQo+IA0KPiBXaHkgY2FuJ3QgeW91
IHVzZSBTUEkgY29yZSBETUEgbWFwcGluZyBjb2RlPw0KDQpJIGRpZG4ndCBmaW5kIHRoZSBTUEkg
Y29yZSBETUEgbWFwcGluZyBjb2RlIGZvciBzaW5nbGUgbWFwaW5nLiANClRoZSBtZXRob2QgY3Vy
cmVudGx5IHVzZWQgaXMgdGhlIGdlbmVyYWwgRE1BIHNpbmdsZS1tYXAgY29kZSB1c2FnZSBtZXRo
b2QuDQoNCg0KPiANCj4gPiArICAgICAgIGRldmljZV9zZXRfbm9kZSgmY3Rsci0+ZGV2LCBwZGV2
LT5kZXYuZndub2RlKTsNCj4gDQo+IFVzZSBkZXZfZndub2RlKCkgaW4gdGhlIHNlY29uZCBhcmd1
bWVudC4NCj4NCg0KWW91IG1lYW4gYXMgYmVsb3cgPw0KDQpkZXZpY2Vfc2V0X25vZGUoJmN0bHIt
PmRldiwgZGV2X2Z3bm9kZShkZXYpKTsNCg0KQmVzdCBSZWdhcmRzLA0KTGktaGFvIEt1bw0K
