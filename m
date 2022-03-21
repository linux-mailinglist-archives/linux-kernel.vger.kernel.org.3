Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B534E1E80
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 01:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbiCUA3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 20:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbiCUA26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 20:28:58 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C72FDF4A1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 17:27:28 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 830512C05F3;
        Mon, 21 Mar 2022 00:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647822445;
        bh=Rz96f5sjJQKWQ0HhnNfpbrE6GlGWm8SFIyHhy6QKXrg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PKiSthMC+Bm36Tj/3T5Ruc29yxDAWuwTrPm7ZjVFdzP8/QH7WJkOZXmCdssoK8MZR
         i/uJAPLqE7eKB4SFVHAVlXcFkGLwZjcU1wQehDhFrr/fyWkfOfW87hjcM5tNom2rDq
         qijlMvZlSkBtx7NsM358QZ1cCuFy64TI4UP3L2XuUnOHBwapB4T/P1a7WG/7y78LeJ
         +vUieyRzhZPqwNTQr/TGCfa2efUQt9DI404xE+K42om89AtD5heL7u6EmXKMFGMZ+z
         hijfXpnq/zbnVMrDzj4J5pJrynOulNii0Z5gRexVW4FQ+Rv8D/Njrt0/p31CwyW6CZ
         WB6x11EWtrx+Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6237c66d0001>; Mon, 21 Mar 2022 13:27:25 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 21 Mar 2022 13:27:25 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Mon, 21 Mar 2022 13:27:25 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] hwmon: (adt7475) Use enum chips when loading
 attenuator settings
Thread-Topic: [PATCH v2 3/3] hwmon: (adt7475) Use enum chips when loading
 attenuator settings
Thread-Index: AQHYOk6t2MAzos32V0mfrGePR/IVEazEW2uAgAPK54A=
Date:   Mon, 21 Mar 2022 00:27:24 +0000
Message-ID: <84514187-1170-0932-3a31-9e8ce6b07e9d@alliedtelesis.co.nz>
References: <20220317223051.1227110-1-chris.packham@alliedtelesis.co.nz>
 <20220317223051.1227110-4-chris.packham@alliedtelesis.co.nz>
 <20220318143223.GA673001@roeck-us.net>
In-Reply-To: <20220318143223.GA673001@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4915410CF2A284680B5EA72E2BB5226@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=Q6Hju86AWDR5xJoMpMYA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxOS8wMy8yMiAwMzozMiwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gT24gRnJpLCBNYXIg
MTgsIDIwMjIgYXQgMTE6MzA6NTBBTSArMTMwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IFNp
bXBsaWZ5IGxvYWRfYXR0ZW51YXRvcnMoKSBieSBtYWtpbmcgdXNlIG9mIGVudW0gY2hpcHMgaW5z
dGVhZCBvZiBpbnQuDQo+Pg0KPiBUaGF0IGlzbid0IHRoZSBvbmx5IHRoaW5nIHRoZSBwYXRjaCBp
cyBkb2luZy4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2to
YW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+IC0tLQ0KPj4NCj4+IE5vdGVzOg0KPj4gICAgICBD
aGFuZ2VzIGluIHYyOg0KPj4gICAgICAtIE5ldw0KPj4NCj4+ICAgZHJpdmVycy9od21vbi9hZHQ3
NDc1LmMgfCA0ICsrLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9hZHQ3NDc1LmMg
Yi9kcml2ZXJzL2h3bW9uL2FkdDc0NzUuYw0KPj4gaW5kZXggNmRlNTAxZGU0MWIyLi5lYmU0YTg1
ZWI2MmUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2h3bW9uL2FkdDc0NzUuYw0KPj4gKysrIGIv
ZHJpdmVycy9od21vbi9hZHQ3NDc1LmMNCj4+IEBAIC0xNTY5LDcgKzE1NjksNyBAQCBzdGF0aWMg
aW50IHNldF9wcm9wZXJ0eV9iaXQoY29uc3Qgc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgY2hh
ciAqcHJvcGVydHksDQo+PiAgIAlyZXR1cm4gcmV0Ow0KPj4gICB9DQo+PiAgIA0KPj4gLXN0YXRp
YyBpbnQgbG9hZF9hdHRlbnVhdG9ycyhjb25zdCBzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LCBp
bnQgY2hpcCwNCj4+ICtzdGF0aWMgaW50IGxvYWRfYXR0ZW51YXRvcnMoY29uc3Qgc3RydWN0IGky
Y19jbGllbnQgKmNsaWVudCwgZW51bSBjaGlwcyBjaGlwLA0KPj4gICAJCQkgICAgc3RydWN0IGFk
dDc0NzVfZGF0YSAqZGF0YSkNCj4+ICAgew0KPj4gICAJaW50IHJldDsNCj4+IEBAIC0xNTg4LDcg
KzE1ODgsNyBAQCBzdGF0aWMgaW50IGxvYWRfYXR0ZW51YXRvcnMoY29uc3Qgc3RydWN0IGkyY19j
bGllbnQgKmNsaWVudCwgaW50IGNoaXAsDQo+PiAgIAkJCQkJCWRhdGEtPmNvbmZpZzQpOw0KPj4g
ICAJCWlmIChyZXQgPCAwKQ0KPj4gICAJCQlyZXR1cm4gcmV0Ow0KPj4gLQl9IGVsc2UgaWYgKGNo
aXAgPT0gYWR0NzQ3MyB8fCBjaGlwID09IGFkdDc0NzUpIHsNCj4+ICsJfSBlbHNlIHsNCj4gVGhp
cyBpcyB0aGUgcmVhbCBjaGFuZ2UuIFdlbGwsIGluIHRoZW9yeS4gSXQgZG9lc24ndCByZWFsbHkg
bWFrZSBhIGRpZmZlcmVuY2UsDQo+IGl0IGlzIGp1c3QgKGN1cnJlbnRseSkgdW5uZWNlc3Nhcnkg
YnV0IGNsYXJpZmllcyB0aGF0IHRoZSBmb2xsb3dpbmcgY29kZSBvbmx5DQo+IGFwcGxpZXMgdG8g
dGhlIHR3byBjaGlwcy4gSXQgbWF5IGJlIGJldHRlciB0byByZXBsYWNlIHRoZSBpZi9lbHNlIHdp
dGggYSBzd2l0Y2gNCj4gc3RhdGVtZW50IHRvIGNsYXJpZnkgdGhpcy4gRHJvcHBpbmcgdGhlIGNv
bmRpdGlvbmFsIHdvdWxkIG5vdCByZXF1aXJlIHRvIGNoYW5nZQ0KPiB0aGUgcGFyYW1ldGVyIHR5
cGUuIFRoYXQgb25seSByZWFsbHkgYWRkcyB2YWx1ZSBpZiB5b3UgYWxzbyB1c2UgYSBzd2l0Y2gN
Cj4gc3RhdGVtZW50ICh3aXRob3V0IGR1bW15IGRlZmF1bHQpLg0KDQpJJ3ZlIHdyaXR0ZW4gYSB2
MyB0aGF0IHVwZGF0ZXMgdGhpcyB0byB1c2UgYSBzd2l0Y2ggc3RhdGVtZW50IGJ1dCBJJ2xsIA0K
d2FpdCB0byBzZW5kIGl0IGluIGNhc2UgdGhlcmUgaXMgYW55IGZlZWRiYWNrIG9uIHRoZSBmaXJz
dCAyIHBhdGNoZXMuDQoNCj4gVGhhbmtzLA0KPiBHdWVudGVyDQo+DQo+PiAgIAkJc2V0X3Byb3Bl
cnR5X2JpdChjbGllbnQsICJhZGksYnlwYXNzLWF0dGVudWF0b3ItaW4xIiwNCj4+ICAgCQkJCSAm
ZGF0YS0+Y29uZmlnMiwgNSk7DQo+PiAgIA==
