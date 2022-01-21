Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3301495A28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378809AbiAUGzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:55:12 -0500
Received: from mswedge1.sunplus.com ([60.248.182.113]:52670 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1378799AbiAUGzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:55:10 -0500
X-Greylist: delayed 77525 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jan 2022 01:55:10 EST
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(11299:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Fri, 21 Jan 2022 14:55:16 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 21 Jan 2022 14:55:11 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 21 Jan 2022 14:55:11 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Li-hao Kuo <lhjeff911@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
Thread-Topic: [PATCH v6 1/2] spi: Add spi driver for Sunplus SP7021
Thread-Index: AQHYDEdoNQA4Z8mYU0mSuzI8gOIgg6xqY3GAgAE/t3D//4TFAIABjwHA
Date:   Fri, 21 Jan 2022 06:55:11 +0000
Message-ID: <ee5838c307f84bb99ace070292167a26@sphcmbx02.sunplus.com.tw>
References: <cover.1642494310.git.lhjeff911@gmail.com>
 <37998e515d561e762ee30d0ac4fca25a948e0c5c.1642494310.git.lhjeff911@gmail.com>
 <CAHp75VdKc3UDzaqM2G5J5+G90U6Spqyhz_vuOYKhqJ4V-uf=wg@mail.gmail.com>
 <a354d7c1dce4463ea57706dd5443fe7a@sphcmbx02.sunplus.com.tw>
 <CAHp75VcCpye1u3+PK=C3CT8fMHPSOsXTL5AhbLVy0YyGWfyfkQ@mail.gmail.com>
In-Reply-To: <CAHp75VcCpye1u3+PK=C3CT8fMHPSOsXTL5AhbLVy0YyGWfyfkQ@mail.gmail.com>
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

PiA+ID4gPiArICAgICAgIGlmICh4ZmVyLT50eF9idWYpDQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICBkbWFfdW5tYXBfc2luZ2xlKGRldiwgeGZlci0+dHhfZG1hLCB4ZmVyLT5sZW4sIERNQV9UT19E
RVZJQ0UpOw0KPiA+ID4gPiArICAgICAgIGlmICh4ZmVyLT5yeF9idWYpDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICBkbWFfdW5tYXBfc2luZ2xlKGRldiwgeGZlci0+cnhfZG1hLCB4ZmVyLT5sZW4s
DQo+ID4gPiA+ICsgRE1BX0ZST01fREVWSUNFKTsNCj4gPiA+DQo+ID4gPiBXaHkgY2FuJ3QgeW91
IHVzZSBTUEkgY29yZSBETUEgbWFwcGluZyBjb2RlPw0KPiA+DQo+ID4gSSBkaWRuJ3QgZmluZCB0
aGUgU1BJIGNvcmUgRE1BIG1hcHBpbmcgY29kZSBmb3Igc2luZ2xlIG1hcGluZy4NCj4gPiBUaGUg
bWV0aG9kIGN1cnJlbnRseSB1c2VkIGlzIHRoZSBnZW5lcmFsIERNQSBzaW5nbGUtbWFwIGNvZGUg
dXNhZ2UgbWV0aG9kLg0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIHNpbmdsZSBwYWdlIG1hcHBpbmc/
DQo+IFdoYXQncyB3cm9uZyB3aXRoIFNHIG1hcHBpbmcgdGhhdCBTUEkgY29yZSBwcm92aWRlcz8N
Cg0KU1A3MDIxIFNQSSBzbGF2ZSBkbWEgb25seSBzdXBwb3J0cyBzaW5nbGUgZG1hIGluIG9uZSB0
cmlnZ2VyLiANCkl0IGlzIG5vdCBzdWl0YWJsZSBmb3IgdXNpbmcgU0cgbWFwcGluZy4NCklmIHRo
ZSBsZW5ndGggb2YgdGhlIHRyYW5zZmVyIGlzIGxhcmdlciB0aGFuIHRoZSBsZW5ndGggb2YgdGhl
IFNHLW1hcHBpbmcsIA0KU2xhdmUtbW9kZSB3aWxsIGdldCBlcnJvciBpbiB0aGUgdHJhbnNmZXIu
DQo=
