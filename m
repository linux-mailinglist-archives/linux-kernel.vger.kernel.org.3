Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC36E526F1B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiENC4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiENCzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:55:49 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A625558D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 19:20:56 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1CD4E2C02BB;
        Sat, 14 May 2022 02:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652494853;
        bh=u5tJlO+JILJmYqRbvjeTYTRpd1HQ+7pUKgUigtdkfM8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ldn67xWpaMzE1zOxaOpkzOzczX94jBYfDD/wkwPQBeW8BeVKs8M5t2zGonb0ICG9V
         7+Ga/gAZUmkZAWdU7xyNI24dLNGbCby+22cLuYPSfAcYIFIs1sBmL3C0PYiOPSeQ+t
         Ez15oYpEMzOcsXY2u2ifQjjjawDlQgswQz13njwv4TW1zjQgjqUVmjwqSGbDSH7Zjg
         83uB+GuA+Res5bO93ygq4jXdYj+IOpvCszTglu82gjXJq72vfQi+OM1CdXxXqey24I
         tR+lGidPLUCdo0jDE+aHwBsnl6hIRNtxnE31JV3audPOWmvnO2I+MIrJm0IchWOfr8
         lJdvrIASvBDig==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627f12040001>; Sat, 14 May 2022 14:20:52 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.36; Sat, 14 May 2022 14:20:52 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.036; Sat, 14 May 2022 14:20:52 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        "enachman@marvell.com" <enachman@marvell.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: gpio-mvebu: convert txt binding
 to YAML
Thread-Topic: [PATCH v3 1/2] dt-bindings: gpio: gpio-mvebu: convert txt
 binding to YAML
Thread-Index: AQHYZeR1GWszU87KukS0xyAOLq6As60btNMAgAEor4A=
Date:   Sat, 14 May 2022 02:20:52 +0000
Message-ID: <e87482cb-20b1-fe09-7233-d56786d5eda6@alliedtelesis.co.nz>
References: <20220512094125.3748197-1-chris.packham@alliedtelesis.co.nz>
 <32aab734-5890-99b2-09c9-8ec7418c7649@linaro.org>
In-Reply-To: <32aab734-5890-99b2-09c9-8ec7418c7649@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDD280A226FE9F4B8702C0C44363612B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=Xwcevb4goy9m5JrZ2h8A:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
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

DQpPbiAxMy8wNS8yMiAyMDozOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTIv
MDUvMjAyMiAxMTo0MSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IENvbnZlcnQgdGhlIGV4aXN0
aW5nIGRldmljZSB0cmVlIGJpbmRpbmcgdG8gWUFNTCBmb3JtYXQuDQo+Pg0KPj4gVGhlIG9sZCBi
aW5kaW5nIGxpc3RlZCB0aGUgaW50ZXJydXB0LWNvbnRyb2xsZXIgYW5kIHJlbGF0ZWQgcHJvcGVy
dGllcw0KPj4gYXMgcmVxdWlyZWQgYnV0IHRoZXJlIGFyZSBzdWZmaWNpZW50bHkgbWFueSBleGlz
dGluZyB1c2FnZXMgd2l0aG91dCBpdA0KPj4gdGhhdCB0aGUgWUFNTCBiaW5kaW5nIGRvZXMgbm90
IG1ha2UgdGhlIGludGVycnVwdCBwcm9wZXJ0aWVzIHJlcXVpcmVkLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4N
Cj4+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+PiAtLS0NCj4+
DQo+PiBOb3RlczoNCj4+ICAgICAgQ2hhbmdlcyBpbiB2MzoNCj4+ICAgICAgLSBDb3JyZWN0IGlu
ZGVudCBpbiBleGFtcGxlDQo+PiAgICAgIC0gTW92ZSBvZmZzZXQgYW5kIG1hcnZlbGwscHdtLW9m
ZnNldCB0byBzZXBhcmF0ZSBwYXRjaA0KPj4gICAgICAtIENvcnJlY3Qgc29tZSBkb2N1bWVudGF0
aW9uIGNyb3NzIHJlZmVyZW5jZXMNCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBUaGVyZSBp
cyBzb21ldGhpbmcgdG8gZGlzY3Vzcy9pbXByb3ZlLg0KPg0KPj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2dwaW8tbXZlYnUueWFtbCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2dwaW8tbXZlYnUueWFtbA0KPj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMmQ5NWVmNzA3ZjUzDQo+
PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZ3Bpby9ncGlvLW12ZWJ1LnlhbWwNCj4+IEBAIC0wLDAgKzEsMTQzIEBADQo+PiArIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiAr
JVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNv
bS8/Yz0yMDk4OCZkPXJKbi00ZzFzNkVnMEh6bUh1QThiUENvVFYtY2hodEpnNVNHWk4yeENtdyZ1
PWh0dHAlM2ElMmYlMmZkZXZpY2V0cmVlJTJlb3JnJTJmc2NoZW1hcyUyZmdwaW8lMmZncGlvLW12
ZWJ1JTJleWFtbCUyMw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9zY2FubWFpbC50cnVzdHdhdmUuY29t
Lz9jPTIwOTg4JmQ9ckpuLTRnMXM2RWcwSHptSHVBOGJQQ29UVi1jaGh0Smc1U1hLWXo5QmxBJnU9
aHR0cCUzYSUyZiUyZmRldmljZXRyZWUlMmVvcmclMmZtZXRhLXNjaGVtYXMlMmZjb3JlJTJleWFt
bCUyMw0KPj4gKw0KPj4gK3RpdGxlOiBNYXJ2ZWxsIEVCVSBHUElPIGNvbnRyb2xsZXINCj4+ICsN
Cj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5n
QGdtYWlsLmNvbT4NCj4+ICsgIC0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4NCj4g
VGhlc2Ugc2hvdWxkIGJlIHJhdGhlciBwbGF0Zm9ybSBvciBkcml2ZXIgbWFpbnRhaW5lcnMsIG5v
dCBzdWJzeXN0ZW0NCj4gZm9sa3MuIFVubGVzcyBpdCBoYXBwZW5zIHRoYXQgVGhpZXJyeSBhbmQg
TGVlIGFyZSBmb3IgcGxhdGZvcm0/DQoNCkJhc2VkIG9uIGxpbmVzIGF1dGhvcmVkIHRoYXQgd291
bGQgYmUgVGhvbWFzIGFuZCBBbmRyZXcuIEJ1dCBwZXJoYXBzIA0Kc29tZW9uZSBmcm9tIE1hcnZl
bGwgb3IgUExWaXNpb24gaGF2ZSBhbiBpbnRlcmVzdCBpbiBhZG9wdGluZyB0aGUgZHJpdmVyIA0K
YW5kIGl0J3MgYmluZGluZz8NCg0KRm9yIG5vdyBJJ2xsIHB1dCBUaG9tYXMgYW5kIEFuZHJldyB1
bnRpbCBzb21lb25lIGVsc2Ugc3RlcHMgdXAuDQoNCj4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0K
Pj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgb25lT2Y6DQo+PiArICAgICAgLSBlbnVtOg0KPj4g
KyAgICAgICAgICAtIG1hcnZlbGwsYXJtYWRhLThrLWdwaW8NCj4+ICsgICAgICAgICAgLSBtYXJ2
ZWxsLG9yaW9uLWdwaW8NCj4+ICsNCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAt
IGVudW06DQo+PiArICAgICAgICAgICAgICAtIG1hcnZlbGwsbXY3ODIwMC1ncGlvDQo+PiArICAg
ICAgICAgICAgICAtIG1hcnZlbGwsYXJtYWRhLTM3MC1ncGlvDQo+PiArICAgICAgICAgICAgICAt
IG1hcnZlbGwsYXJtYWRheHAtZ3Bpbw0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLG9y
aW9uLWdwaW8NCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsg
ICAgICBBZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIHJlZ2lzdGVyIHNldCBmb3IgdGhlIGRldmlj
ZS4gTm90IHVzZWQgZm9yDQo+PiArICAgICAgbWFydmVsbCxhcm1hZGEtOGstZ3Bpby4NCj4+ICsN
Cj4+ICsgICAgICBGb3IgdGhlICJtYXJ2ZWxsLGFybWFkYXhwLWdwaW8iIHZhcmlhbnQgYSBzZWNv
bmQgZW50cnkgaXMgZXhwZWN0ZWQgZm9yDQo+PiArICAgICAgdGhlIHBlci1jcHUgcmVnaXN0ZXJz
LiBGb3Igb3RoZXIgdmFyaWFudHMgc2Vjb25kIGVudHJ5IGNhbiBiZSBwcm92aWRlZCwNCj4+ICsg
ICAgICBmb3IgdGhlIFBXTSBmdW5jdGlvbiB1c2luZyB0aGUgR1BJTyBCbGluayBDb3VudGVyIG9u
L29mZiByZWdpc3RlcnMuDQo+PiArICAgIG1pbkl0ZW1zOiAxDQo+PiArICAgIG1heEl0ZW1zOiAy
DQo+PiArDQo+PiArICByZWctbmFtZXM6DQo+PiArICAgIGl0ZW1zOg0KPj4gKyAgICAgIC0gY29u
c3Q6IGdwaW8NCj4+ICsgICAgICAtIGNvbnN0OiBwd20NCj4+ICsgICAgbWluSXRlbXM6IDENCj4+
ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+PiArICAgICAg
VGhlIGxpc3Qgb2YgaW50ZXJydXB0cyB0aGF0IGFyZSB1c2VkIGZvciBhbGwgdGhlIHBpbnMgbWFu
YWdlZCBieSB0aGlzDQo+PiArICAgICAgR1BJTyBiYW5rLiBUaGVyZSBjYW4gYmUgbW9yZSB0aGFu
IG9uZSBpbnRlcnJ1cHQgKGV4YW1wbGU6IDEgaW50ZXJydXB0DQo+PiArICAgICAgcGVyIDggcGlu
cyBvbiBBcm1hZGEgWFAsIHdoaWNoIG1lYW5zIDQgaW50ZXJydXB0cyBwZXIgYmFuayBvZiAzMg0K
Pj4gKyAgICAgIEdQSU9zKS4NCj4+ICsgICAgbWluSXRlbXM6IDENCj4+ICsgICAgbWF4SXRlbXM6
IDQNCj4+ICsNCj4+ICsgIGludGVycnVwdC1jb250cm9sbGVyOiB0cnVlDQo+PiArDQo+PiArICAi
I2ludGVycnVwdC1jZWxscyI6DQo+PiArICAgIGNvbnN0OiAyDQo+PiArDQo+PiArICBncGlvLWNv
bnRyb2xsZXI6IHRydWUNCj4+ICsNCj4+ICsgIG5ncGlvczoNCj4+ICsgICAgbWluaW11bTogMQ0K
Pj4gKyAgICBtYXhpbXVtOiAzMg0KPj4gKw0KPj4gKyAgIiNncGlvLWNlbGxzIjoNCj4+ICsgICAg
Y29uc3Q6IDINCj4+ICsNCj4+ICsgICIjcHdtLWNlbGxzIjoNCj4+ICsgICAgZGVzY3JpcHRpb246
DQo+PiArICAgICAgVGhlIGZpcnN0IGNlbGwgaXMgdGhlIEdQSU8gbGluZSBudW1iZXIuIFRoZSBz
ZWNvbmQgY2VsbCBpcyB0aGUgcGVyaW9kDQo+PiArICAgICAgaW4gbmFub3NlY29uZHMuDQo+PiAr
ICAgIGNvbnN0OiAyDQo+PiArDQo+PiArICBjbG9ja3M6DQo+PiArICAgIGRlc2NyaXB0aW9uOg0K
Pj4gKyAgICAgIENsb2NrKHMpIHVzZWQgZm9yIFBXTSBmdW5jdGlvbi4NCj4+ICsgICAgaXRlbXM6
DQo+PiArICAgICAgLSBkZXNjcmlwdGlvbjogQ29yZSBjbG9jaw0KPj4gKyAgICAgIC0gZGVzY3Jp
cHRpb246IEFYSSBidXMgY2xvY2sNCj4+ICsgICAgbWluSXRlbXM6IDENCj4+ICsNCj4+ICsgIGNs
b2NrLW5hbWVzOg0KPj4gKyAgICBpdGVtczoNCj4+ICsgICAgICAtIGNvbnN0OiBjb3JlDQo+PiAr
ICAgICAgLSBjb25zdDogYXhpDQo+PiArICAgIG1pbkl0ZW1zOiAxDQo+PiArDQo+PiArcmVxdWly
ZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gZ3Bpby1jb250cm9sbGVyDQo+PiArICAt
IG5ncGlvcw0KPj4gKyAgLSAiI2dwaW8tY2VsbHMiDQo+PiArDQo+PiArYWxsT2Y6DQo+PiArICAt
IGlmOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBjb21wYXRpYmxlOg0KPj4g
KyAgICAgICAgICBjb250YWluczoNCj4+ICsgICAgICAgICAgICBjb25zdDogbWFydmVsbCxhcm1h
ZGEtOGstZ3Bpbw0KPj4gKyAgICB0aGVuOg0KPj4gKyAgICAgIHJlcXVpcmVkOg0KPj4gKyAgICAg
ICAgLSBvZmZzZXQNCj4+ICsgICAgZWxzZToNCj4+ICsgICAgICByZXF1aXJlZDoNCj4+ICsgICAg
ICAgIC0gcmVnDQo+IG9uZSBibGFuayBsaW5lIHBsZWFzZQ0KPg0KPj4gKyAgLSBpZjoNCj4+ICsg
ICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgY29tcGF0aWJsZToNCj4+ICsgICAgICAgICAg
Y29udGFpbnM6DQo+PiArICAgICAgICAgICAgY29uc3Q6IG1hcnZlbGwsYXJtYWRheHAtZ3Bpbw0K
PiBPcmlnaW5hbCBiaW5kaW5ncyBhcmUgc2F5aW5nIHRoYXQgc2Vjb25kIHJlZyBpcyBvcHRpb25h
bCBmb3INCj4gbWFydmVsbCxhcm1hZGEtMzcwLWdwaW8uIFdoYXQgYWJvdXQgb3RoZXIgY2FzZXMs
IGUuZy4gbXY3ODIwMC1ncGlvPyBJcw0KPiBpdCBhbHNvIGFsbG93ZWQgKGFuZCBvcHRpb25hbCkg
dGhlcmU/DQpUaGlzIGlzIHdoZXJlIHRoaW5ncyBnZXQgaW50ZXJlc3RpbmcuIFRoZSBhcm1hZGF4
cCAoYW5kIG9ubHkgdGhlIA0KYXJtYWRheHApIHJlcXVpcmVzIGEgc2Vjb25kIHJlZ2lzdGVyIHZh
bHVlIGZvciBzb21lIHBlci1jcHUgcmVnaXN0ZXJzLiANCkFsbCBvZiB0aGUgb3RoZXIgU29DcyBj
YW4gaGF2ZSBhbiBvcHRpb25hbCAybmQgcmVnaXN0ZXIgdmFsdWUgaWYgdGhleSANCndhbnQgdG8g
dXNlIHRoZSBQV00gZnVuY3Rpb24uIEkgZ3Vlc3MgdGhhdCBpbXBsaWVzIHRoYXQgdGhlIGFybWFk
YXhwIA0KY2FuJ3QgZG8gUFdNLg0KPj4gKyAgICB0aGVuOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6
DQo+PiArICAgICAgICByZWc6DQo+PiArICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+IFRoZW4geW91
IGFsc28gc2hvdWxkIHJlcXVpcmUgdHdvIHJlZy1uYW1lcy4NCg0KU2ltcGxlIGVub3VnaCB0byBh
ZGQuIEJ1dCBjdXJyZW50bHkgd2UndmUgc2FpZCB0aGF0IHRoZSByZWctbmFtZXMgYXJlIA0KImdw
aW8iIGFuZCAicHdtIiBidXQgb24gdGhlIGFybWFkYXhwIHRoZSAybmQgb25lIGlzIG5vdCAicHdt
IiBidXQgDQpzb21ldGhpbmcgZWxzZSAoInBlci1jcHUiIHBlcmhhcHM/KQ0KDQpPbiB0aGUgb3Ro
ZXIgaGFuZCB0aGlzIGlzIGFsbCBjb21wbGV0ZWx5IG1vb3QgYmVjYXVzZSB0aGUgDQphcm1hZGEt
eHAtbXY3OCouZHRzaSBhY3R1YWxseSB1c2UgdGhlICJtYXJ2ZWxsLGFybWFkYS0zNzAtZ3BpbyIg
DQpjb21wYXRpYmxlIHNvIHRoaXMgYXBwZWFycyB0byBiZSBkb2N1bWVudGluZyBzb21ldGhpbmcg
dGhhdCBpcyBubyBsb25nZXIgDQp1c2VkLiBJbmRlZWQgaXQgYXBwZWFycyB0aGF0IHRoZSBhcm1h
ZGF4cCBzcGVjaWZpYyB1c2FnZSB3YXMgcmVtb3ZlIGluIA0KNWY3OWM2NTFlODFlICgiYXJtOiBt
dmVidTogdXNlIGdsb2JhbCBpbnRlcnJ1cHRzIGZvciBHUElPcyBvbiBBcm1hZGEgWFAiKS4NCg0K
U28gcGVyaGFwcyB0aGUgYmVzdCBjb3Vyc2Ugb2YgYWN0aW9uIGlzIHRvIGRyb3AgbWFydmVsbCxh
cm1hZGF4cC1ncGlvIA0KZnJvbSB0aGUgbmV3IGJpbmRpbmcgKG5vdGluZyB0aGF0IHdlJ3ZlIGRv
bmUgc28gaW4gdGhlIGNvbW1pdCBtZXNzYWdlKS4NCg0KPg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg==
