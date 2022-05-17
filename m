Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6852AE56
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiEQW4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiEQW4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:56:42 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C467813E9F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:56:39 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 89A822C0547;
        Tue, 17 May 2022 22:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652828196;
        bh=elroB9+Uac6AD8ssPRgpQZO0VH70eB2bWTljZwH3sPg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=FCpBOy+XoDSuXb8zLweqrtEsA9TeNt/dO57QNNz5cY/sR81jQAkG1INg2QweuHwjd
         61tnzfv8hpwtTwXAbGeH2a+z9vGFhJWdStOKoxvZC1VoPmeHFSafz3fLbxAt8f56P7
         nytH9giRujXTiI2pvUHcoeyDN3dvIH8rBIqwjiaYTnR3yHjOilUylNq+NJYrFtoiXH
         aoBUfEhzj4BP65aXoJnJkDFOnyZMmHzD0vaVqYyeVthIajGUljlC97X7w4eW1FMYe/
         TN19U1GDGiJNxmK74zcrgarmxuT29KI5HQfg+0MOCUkx1a2O/kjq5yuT/XwdeiBA3f
         wBq9/H9a3aCOg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B628428240001>; Wed, 18 May 2022 10:56:36 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.36; Wed, 18 May 2022 10:56:35 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.036; Wed, 18 May 2022 10:56:35 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Marc Zyngier <maz@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "vadym.kochan@plvision.eu" <vadym.kochan@plvision.eu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Topic: [PATCH v7 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Index: AQHYZbhCZ5RJjp1rLk+xI3fL/9Lp4q0aEemAgADzhwCAADbcgIAFQ2SAgADLXgCAAJMDAIABEAuA
Date:   Tue, 17 May 2022 22:56:35 +0000
Message-ID: <1b29abc6-7428-1528-864f-2a246332f72b@alliedtelesis.co.nz>
References: <20220512042501.3339775-1-chris.packham@alliedtelesis.co.nz>
 <20220512042501.3339775-3-chris.packham@alliedtelesis.co.nz>
 <87wnermc9c.wl-maz@kernel.org>
 <5c01f20a-acd3-da15-081d-7cf878f8a77a@alliedtelesis.co.nz>
 <a69eaf73-8c3c-dfd7-16e5-70460c68877e@alliedtelesis.co.nz>
 <87mtfh6c58.wl-maz@kernel.org>
 <db5c3366-ac81-261b-ff32-3ccf94a930f6@alliedtelesis.co.nz>
 <87mtfgmzgx.wl-maz@kernel.org>
In-Reply-To: <87mtfgmzgx.wl-maz@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB0F09AB848080489186313F59B8313A@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=fzdkbl53fq4l72-ZKJoA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNy8wNS8yMiAxODo0MiwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiBPbiBNb24sIDE2IE1h
eSAyMDIyIDIyOjU2OjQ0ICswMTAwLA0KPiBDaHJpcyBQYWNraGFtIDxDaHJpcy5QYWNraGFtQGFs
bGllZHRlbGVzaXMuY28ubno+IHdyb3RlOg0KPj4+Pj4+IFBsZWFzZSBmaXggeW91ciBmaXJtd2Fy
ZSB0byBwcm9ncmFtIENOVEZSUV9FTDAsIGFuZA0KPj4+Pj4+IHJlbW92ZSB0aGlzIHVzZWxlc3Mg
cHJvcGVydHkuDQo+Pj4+PiBJJ20ga2luZCBvZiBhdCB0aGUgbWVyY3kgb2Ygd2hhdCBNYXJ2ZWxs
IGhhdmUgcHJvdmlkZWQgZm9yIEFURi4gSSBhbQ0KPj4+Pj4gd29ya2luZyBvbiB0aGUgYm9vdGxv
YWRlciBwb3J0aW9uIGluIHBhcmFsbGVsIGFuZCBhbSBnZXR0aW5nIHRoaW5ncw0KPj4+Pj4gcmVh
ZHkgZm9yIHN1Ym1pdHRpbmcgdGhlIHUtYm9vdCBzdXBwb3J0IHVwc3RyZWFtLiBJIHdhcyBob3Bp
bmcgdG8NCj4+Pj4+IGxlYXZlIEFURiBhbG9uZSBJIGNhbiBhdCBsZWFzdCBzZWUgaWYgdGhleSBo
YXZlbid0IGZpeGVkIHRoaXMgYWxyZWFkeQ0KPj4+Pj4gKHRoZSBvcmlnaW5hbCBkdHNpIEkgc3Rh
cnRlZCB3aXRoIHdhcyBmYWlybHkgb2xkKSBhbmQgaWYgdGhleSBoYXZlbid0DQo+Pj4+PiBJJ2xs
IHJhaXNlIGl0IHZpYSB0aGVpciBzdXBwb3J0IHN5c3RlbS4NCj4+Pj4gU2VlbXMgdG8gd29yayBm
aW5lIHdpdGhvdXQgdGhlIGNsb2NrIHNvIEknbGwgZHJvcCBpdC4NCj4+PiBUaGFua3MuIElmIHlv
dSBjYW4sIHBsZWFzZSB2ZXJpZnkgdGhhdCB0aGlzIGlzIHNldCBvbiBib3RoIENQVXMgKEkNCj4+
PiBoYXZlIHNlZW4gcGxlbnR5IG9mIGZpcm13YXJlIG9ubHkgc2V0dGluZyBpdCBvbiBDUFUwIGlu
IHRoZSBwYXN0KS4NCj4+IFRoZSBhcmNoX3RpbWVyIGludGVycnVwdHMgYXJlIGNvdW50aW5nIHVw
IG9uIGJvdGggQ1BVcyBhbmQgdGhpbmdzDQo+PiBnZW5lcmFsbHkgc2VlbSB0byBiZSBnZXR0aW5n
IHNjaGVkdWxlZCAoSSBkb24ndCBoYXZlIG11Y2ggb2YgYSB1c2VybGFuZA0KPj4gYXQgdGhlIG1v
bWVudCBzbyBpdCdzIG5vdCBleGFjdGx5IGEgc3RyZXNzIHRlc3QpLiBEbyB5b3UgdGhpbmsgdGhh
dCBpcw0KPj4gc3VmZmljaWVudCB0byBzYXkgdGhlIGNsb2NrIHByb3BlcnR5IGlzIHVubmVjZXNz
YXJ5IGFuZCB3aGF0ZXZlcg0KPj4gZmlybXdhcmUgSSBoYXZlIGlzIHdvcmtpbmcgYXMgZXhwZWN0
ZWQuDQo+IE5vLCB0aGUgY291bnRlciBhbHdheXMgY291bnQsIGFuZCBDTlRGUlFfRUwwIGlzIG9u
bHkgYW4gaW5kaWNhdGlvbiBvZg0KPiB0aGUgZnJlcXVlbmN5IGZvciBTVyB0byBmaW5kIG91dC4g
WW91IGNhbiBkaXJlY3RseSByZWFkIENOVEZSUV9FTDANCj4gZnJvbSB1c2Vyc3BhY2Ugb24gZWFj
aCBDUFUgYW5kIGZpbmQgd2hldGhlciB0aGV5IGhhdmUgdGhlIHNhbWUgdmFsdWUuDQoNCkhlcmUn
cyBteSB0ZXN0IHByb2dyYW0NCg0KJCBjYXQgQ05URlJRX0VMMC5jDQojaW5jbHVkZSA8c3RkaW8u
aD4NCiNpbmNsdWRlIDxzdGRpbnQuaD4NCiNpbmNsdWRlIDxpbnR0eXBlcy5oPg0KDQppbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0Kew0KIMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IHZh
bDsNCg0KIMKgwqDCoMKgwqDCoMKgIGFzbSB2b2xhdGlsZSgibXJzICUwLCBDTlRGUlFfRUwwIiA6
ICI9ciIgKHZhbCkpOw0KIMKgwqDCoMKgwqDCoMKgIHByaW50ZigiQ05URlJRX0VMMCA9ICUiIFBS
SXU2NCAiXG4iLCB2YWwpOw0KDQogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQp9DQoNCkFuZCBy
dW5uaW5nIG9uIHRoZSBSRC1BQzVYIGJvYXJkDQoNCltyb290QGxpbnV4Ym94IHRtcF0jIHRhc2tz
ZXQgMHgxIC4vQ05URlJRX0VMMA0KQ05URlJRX0VMMCA9IDI1MDAwMDAwDQpbcm9vdEBsaW51eGJv
eCB0bXBdIyB0YXNrc2V0IDB4MiAuL0NOVEZSUV9FTDANCkNOVEZSUV9FTDAgPSAyNTAwMDAwMA0K
DQoNCj4NCj4+Pj4+PiBZb3UgYXJlIGFsc28gbWlzc2luZyBhIFBQSSBmb3IgdGhlIEVMMiB2aXJ0
dWFsIHRpbWVyIHdoaWNoIGlzIHByZXNlbnQNCj4+Pj4+PiBvbiBhbnkgQVJNdjguMSsgQ1BVIChh
bmQgc2luY2UgdGhpcyBzeXN0ZW0gaXMgdXNpbmcgQTU1LCBpdCBkZWZpbml0ZWx5DQo+Pj4+Pj4g
aGFzIGl0KS4NCj4+Pj4+Pg0KPj4+Pj4+IFsuLi5dDQo+Pj4+PiBXaWxsIGFkZC4NCj4+Pj4gSSBh
c3N1bWUgeW91J3JlIHRhbGtpbmcgYWJvdXQgdGhlIDV0aCBQUEkgcGVyIHRoZQ0KPj4+PiB0aW1l
ci9hcm0sYXJjaF90aW1lci55YW1sICgiaHlwZXJ2aXNvciB2aXJ0dWFsIHRpbWVyIGlycSIpLg0K
Pj4+IEluZGVlZC4NCj4+Pg0KPj4+PiBIZWxwZnVsbHkNCj4+Pj4gTWFydmVsbCBkb24ndCBpbmNs
dWRlIHRoZSBQUEkgaW50ZXJydXB0IG51bWJlcnMgaW4gdGhlaXIgZGF0YXNoZWV0LiBCdXQNCj4+
Pj4gdGhlbiBJIGFsc28gbm90aWNlIHRoYXQgbm9uZSBvZiB0aGUgb3RoZXIgYm9hcmRzIHRoYXQg
aGF2ZSBhDQo+Pj4+ICJhcm0sYXJtdjgtdGltZXIiIHByb3ZpZGUgYSA1dGggaW50ZXJydXB0IGVp
dGhlciwgaGF2ZSBJIG1pc3VuZGVyc3Rvb2QNCj4+Pj4gc29tZXRoaW5nPw0KPj4+IFRoaXMgd2Fz
IG9ubHkgcmVjZW50bHkgYWRkZWQgdG8gdGhlIERUIGJpbmRpbmcsIGJ1dCB0aGUgaW50ZXJydXB0
DQo+Pj4gZGVmaW5pdGVseSBleGlzdCBhdCB0aGUgQ1BVIGxldmVsIGZvciBhbnl0aGluZyB0aGF0
IGltcGxlbWVudHMgQVJNdjguMQ0KPj4+IGFuZCB1cC4gQUZBSUssIHRoZSBNMSBpcyB0aGUgb25s
eSBtYWNoaW5lIHRvIGV4cG9zZSB0aGlzIGludGVycnVwdCBpbg0KPj4+IERULCBidXQgdGhpcyBk
b2Vzbid0IG1lYW4gdGhlIGludGVycnVwdCBkb2Vzbid0IGV4aXN0IG9uIGFsbCB0aGUgb3RoZXIN
Cj4+PiBzeXN0ZW1zIHRoYXQgaGF2ZSB0aGUgc2FtZSBhcmNoaXRlY3R1cmUgcmV2aXNpb24uDQo+
Pj4NCj4+PiBJZiB5b3UgaGF2ZSBjb250YWN0cyBpbiBNYXJ2ZWxsLCBtYXliZSB0cnkgYW5kIGZp
bmQgb3V0IHdoZXRoZXIgdGhleQ0KPj4+IGhhdmUgc2ltcGx5IGRlY2lkZWQgbm90IHRvIHdpcmUg
dGhlIGludGVycnVwdCAoSSB3b3VsZG4ndCBiZQ0KPj4+IHN1cnByaXNlZCkuIEluIHRoaXMgY2Fz
ZSwgcGxlYXNlIGFkZCBhIGNvbW1lbnQuDQo+PiBJJ3ZlIHJlYWNoZWQgb3V0IHZpYSB0aGVpciBj
dXN0b21lciBzdXBwb3J0IHBvcnRhbC4gU28gZmFyIHRoZXkganVzdA0KPj4gd2FudCB0byBrbm93
IHdoeSBJJ20gcmVmdXNpbmcgdG8gdXNlIHRoZWlyIG91dCBvZiBkYXRlIFNESyAobWF5YmUgSQ0K
Pj4gc2hvdWxkIGRpcmVjdCB0aGVtIGF0IHNvbWUgb2YgSm9uIENvcmJldCdzIHByZXNlbnRhdGlv
bnMgOlApLg0KPiBUaGUgZmFjdCB0aGF0IHRoZXkgYXJlIGFza2luZyBpcyBhbHJlYWR5IHNheWlu
ZyBldmVyeXRoaW5nIHRoZXJlIGlzIHRvDQo+IGtub3csIHNhZGx5Li4uDQo+DQo+PiBUaGVzZSBp
bnRlZ3JhdGVkIGNoaXBzIGFyZSBzb21ldGltZXMgYSBiaXQgcHJvYmxlbWF0aWMgYmVjYXVzZSB0
aGUNCj4+IHN1cHBvcnQgZ29lcyB2aWEgdGhlIFN3aXRjaGluZyBncm91cCBidXQgdGhlc2UgcXVl
c3Rpb25zIGFyZSByZWFsbHkNCj4+IGFib3V0IElQIGJsb2NrcyB0aGF0IGhhdmUgYmVlbiB0YWtl
biBmcm9tIHRoZSBTb0MgZ3JvdXAuIEl0IG1heSB0YWtlIGENCj4+IHdoaWxlIGJlZm9yZSBJIGdl
dCBhIHJlc3BvbnNlIGZyb20gc29tZW9uZSB0aGF0IGFjdHVhbGx5IGtub3dzIHRoZQ0KPj4gaW50
ZXJuYWxzLg0KPiBGYWlyIGVub3VnaC4gVW50aWwgdGhlbiwgcGxlYXNlIGRyb3AgYSBjb21tZW50
IGluIHRoZSBEVCBpbmRpY2F0aW5nDQo+IHRoYXQgdGhlIGZhdGUgb2YgdGhpcyBQUEkgaXMgdW5r
bm93bi4gSWYgeW91IGV2ZW50dWFsbHkgZmluZCBvdXQsIGp1c3QNCj4gYWRkIGl0IHRvIHRoZSBE
VCAoaXQgaXMgZWFzeSB0byBhZGQgdGhpbmdzLCBtdWNoIGhhcmRlciB0byByZW1vdmUNCj4gdGhl
bSkuDQoNCkknbGwgaW5jbHVkZSB0aGUgZm9sbG93aW5nIGluIHRoZSBuZXh0IHJvdW5kDQoNCmRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTk4ZHgyNXh4LmR0
c2kgDQpiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtOThkeDI1eHguZHRzaQ0K
aW5kZXggODhlZGM3NDFjMDA4Li43YTM2OTNhMmFkMDQgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTk4ZHgyNXh4LmR0c2kNCisrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWFydmVsbC9hcm1hZGEtOThkeDI1eHguZHRzaQ0KQEAgLTYzLDYgKzYzLDcgQEAg
dGltZXIgew0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDxHSUNfUFBJIDggSVJRX1RZUEVfTEVWRUxfSElHSD4sDQogwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPEdJQ19QUEkgMTAg
SVJRX1RZUEVfTEVWRUxfSElHSD4sDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPEdJQ19QUEkgNyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsN
CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LyogUFBJIGZvciBFTDIgdmlydHVhbCB0aW1lciBpcyB1bmRvY3VtZW50ZWQgKi8NCiDCoMKgwqDC
oMKgwqDCoCB9Ow0KDQogwqDCoMKgwqDCoMKgwqAgcG11IHsNCg0KPiBUaGFua3MsDQo+DQo+IAlN
Lg0KPg==
