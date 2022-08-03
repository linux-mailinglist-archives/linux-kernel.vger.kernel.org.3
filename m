Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECB558925A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiHCSkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiHCSkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:40:11 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAA15A2EA;
        Wed,  3 Aug 2022 11:40:08 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 3C42F5FD36;
        Wed,  3 Aug 2022 21:40:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659552005;
        bh=AFS79+dO5ikd1qNd+wJdt8tTXYQwYhcVieR97AhPH3Y=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=BAeaxim9CAU+amvAX4NHDEXMsp7dIuSrcWpHX1VmzB/Osu7OGMHq2Zg8AT1POx6H/
         nl41hH8V88HC5TwvP054amUGr4Phy72ZIftTE1TVd6/LvXJQaICYjdUy4hfjviXMrK
         I5RDeonvwaL/s0LF+vR7LHnCn/zSKDSSvbLcJ35GnOvPOSGm06DrMlDpXxilukIwCY
         ap/g+7zIs7pcMAlZW9uLfs1sxksegtsM7J+1H4GaxjlH0LjPrQK4fnaCYU6uSywa0Q
         lhEw2JULCOiFJPz2t2vzuLJSOP7uvpQsaD/Pr8fJtqmxvbcq48wba58dl+3KnLlc4q
         /DQtL//dRSBhw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed,  3 Aug 2022 21:40:04 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYpzqIoQnaRj7vNkq2cXUUGjAB/62dSAuAgAAIFYA=
Date:   Wed, 3 Aug 2022 18:39:49 +0000
Message-ID: <20220803184001.fcappv7grdjyaetn@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
 <67041dbe-ad6c-c53f-9760-bd7b5988d137@wanadoo.fr>
In-Reply-To: <67041dbe-ad6c-c53f-9760-bd7b5988d137@wanadoo.fr>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <08B9D705C7259E4B936A7AF48D49D8D2@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/03 16:08:00 #20044033
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQ2hyaXN0b3BoZSwNCg0KVGhhbmsgeW91IGZvciBxdWljayByZXZpZXcNCg0KT24gV2Vk
LCBBdWcgMDMsIDIwMjIgYXQgMDg6MTE6MDVQTSArMDIwMCwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdy
b3RlOg0KPiBMZSAwMy8wOC8yMDIyIMOgIDE1OjExLCBEbWl0cnkgUm9rb3NvdiBhIMOpY3JpdMKg
Og0KPiA+IE1TQTMxMSBpcyBhIHRyaS1heGlhbCwgbG93LWcgYWNjZWxlcm9tZXRlciB3aXRoIEky
QyBkaWdpdGFsIG91dHB1dCBmb3INCj4gPiBzZW5zaXRpdml0eSBjb25zdW1lciBhcHBsaWNhdGlv
bnMuIEl0IGhhcyBkeW5hbWljIHVzZXItc2VsZWN0YWJsZSBmdWxsDQo+ID4gc2NhbGVzIHJhbmdl
IG9mICstMmcvKy00Zy8rLThnLystMTZnIGFuZCBhbGxvd3MgYWNjZWxlcmF0aW9uIG1lYXN1cmVt
ZW50cw0KPiA+IHdpdGggb3V0cHV0IGRhdGEgcmF0ZXMgZnJvbSAxSHogdG8gMTAwMEh6Lg0KPiA+
IA0KPiA+IFNwZWM6IGh0dHBzOi8vY2RuLXNob3AuYWRhZnJ1aXQuY29tL3Byb2R1Y3QtZmlsZXMv
NTMwOS9NU0EzMTEtVjEuMS1FTkcucGRmDQo+ID4gDQo+ID4gVGhpcyBkcml2ZXIgc3VwcG9ydHMg
Zm9sbG93aW5nIE1TQTMxMSBmZWF0dXJlczoNCj4gPiAgICAgIC0gSUlPIGludGVyZmFjZQ0KPiA+
ICAgICAgLSBEaWZmZXJlbnQgcG93ZXIgbW9kZXM6IE5PUk1BTCBhbmQgU1VTUEVORCAodXNpbmcg
cG1fcnVudGltZSkNCj4gPiAgICAgIC0gT0RSIChPdXRwdXQgRGF0YSBSYXRlKSBzZWxlY3Rpb24N
Cj4gPiAgICAgIC0gU2NhbGUgYW5kIHNhbXBfZnJlcSBzZWxlY3Rpb24NCj4gPiAgICAgIC0gSUlP
IHRyaWdnZXJlZCBidWZmZXIsIElJTyByZWcgYWNjZXNzDQo+ID4gICAgICAtIE5FV19EQVRBIGlu
dGVycnVwdCArIHRyaWdnZXINCj4gPiANCj4gPiBCZWxvdyBmZWF0dXJlcyB0byBiZSBkb25lOg0K
PiA+ICAgICAgLSBNb3Rpb24gRXZlbnRzOiBBQ1RJVkUsIFRBUCwgT1JJRU5ULCBGUkVFRkFMTA0K
PiA+ICAgICAgLSBMb3cgUG93ZXIgbW9kZQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERtaXRy
eSBSb2tvc292IDxkZHJva29zb3YtaTRyOG9BK2VMbEg5OXJIa1ArRnhJd0BwdWJsaWMuZ21hbmUu
b3JnPg0KPiA+IC0tLQ0KPiA+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgfCAgICA2ICsN
Cj4gPiAgIGRyaXZlcnMvaWlvL2FjY2VsL0tjb25maWcgIHwgICAxMyArDQo+ID4gICBkcml2ZXJz
L2lpby9hY2NlbC9NYWtlZmlsZSB8ICAgIDIgKw0KPiA+ICAgZHJpdmVycy9paW8vYWNjZWwvbXNh
MzExLmMgfCAxMzIzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAg
NCBmaWxlcyBjaGFuZ2VkLCAxMzQ0IGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL2lpby9hY2NlbC9tc2EzMTEuYw0KPiA+IA0KPiANCj4gSGksDQo+IGEgZmV3
IG5pdHMgYmVsb3cuDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArc3RhdGljIGludCBtc2EzMTFfY2hl
Y2tfcGFydGlkKHN0cnVjdCBtc2EzMTFfcHJpdiAqbXNhMzExKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSBtc2EzMTEtPmRldjsNCj4gPiArCXVuc2lnbmVkIGludCBwYXJ0aWQ7
DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCWVyciA9IHJlZ21hcF9yZWFkKG1zYTMxMS0+
cmVncywgTVNBMzExX1BBUlRJRF9SRUcsICZwYXJ0aWQpOw0KPiA+ICsJaWYgKGVycikNCj4gPiAr
CQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIGVyciwNCj4gPiArCQkJCSAgICAgImZhaWxlZCB0
byByZWFkIHBhcnRpZCAoJWQpXG4iLCBlcnIpOw0KPiANCj4gTm8gbmVlZCBmb3IgIiglZCkiIGFu
ZCBlcnIuDQo+IA0KDQpEbyB5b3UgbWVhbiBmb3IgYWxsIGRldl9lcnIoKSBjYWxscz8gSSB0aGlu
ayBzb21ldGltZXMgaXQncyBoZWxwZnVsIHRvDQprbm93IHRoZSBhY3R1YWwgZXJyb3IgdmFsdWUg
Z290IGZyb20gZXh0ZXJuYWwgQVBJLCBpc24ndD8gQ291bGQgeW91IHBsZWFzZQ0KZXhwbGFpbiB5
b3VyIHBvaW50IGlmIHBvc3NpYmxlPw0KDQo+ID4gKw0KPiA+ICsJaWYgKHBhcnRpZCA9PSBNU0Ez
MTFfV0hPX0FNX0kpDQo+ID4gKwkJZGV2X2RiZyhkZXYsICJmb3VuZCBNU0EzMTEgY29tcGF0aWJs
ZSBjaGlwWyUjeF1cbiIsIHBhcnRpZCk7DQo+ID4gKwllbHNlDQo+ID4gKwkJZGV2X3dhcm4oZGV2
LCAiaW52YWxpZCBwYXJ0aWQgKCUjeCksIGV4cGVjdGVkICglI3gpXG4iLA0KPiA+ICsJCQkgcGFy
dGlkLCBNU0EzMTFfV0hPX0FNX0kpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+
IA0KPiBbLi4uXQ0KPiANCj4gPiArc3RhdGljIGludCBtc2EzMTFfcHJvYmUoc3RydWN0IGkyY19j
bGllbnQgKmkyYykNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJmkyYy0+ZGV2
Ow0KPiA+ICsJc3RydWN0IG1zYTMxMV9wcml2ICptc2EzMTE7DQo+ID4gKwlzdHJ1Y3QgaWlvX2Rl
diAqaW5kaW9fZGV2Ow0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4gKwlpbmRpb19kZXYgPSBk
ZXZtX2lpb19kZXZpY2VfYWxsb2MoZGV2LCBzaXplb2YoKm1zYTMxMSkpOw0KPiA+ICsJaWYgKCFp
bmRpb19kZXYpDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRU5PTUVNLA0KPiA+
ICsJCQkJICAgICAiaWlvIGRldmljZSBhbGxvY2F0aW9uIGZhaWxlZFxuIik7DQo+ID4gKw0KPiA+
ICsJbXNhMzExID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiArCW1zYTMxMS0+ZGV2ID0gZGV2
Ow0KPiA+ICsJaTJjX3NldF9jbGllbnRkYXRhKGkyYywgaW5kaW9fZGV2KTsNCj4gPiArDQo+ID4g
KwllcnIgPSBtc2EzMTFfcmVnbWFwX2luaXQobXNhMzExKTsNCj4gPiArCWlmIChlcnIpDQo+ID4g
KwkJcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKwltdXRleF9pbml0KCZtc2EzMTEtPmxvY2spOw0K
PiA+ICsNCj4gPiArCW1zYTMxMS0+dmRkID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKGRl
diwgInZkZCIpOw0KPiA+ICsJaWYgKElTX0VSUihtc2EzMTEtPnZkZCkpIHsNCj4gPiArCQllcnIg
PSBQVFJfRVJSKG1zYTMxMS0+dmRkKTsNCj4gPiArCQlpZiAoZXJyID09IC1FTk9ERVYpDQo+ID4g
KwkJCW1zYTMxMS0+dmRkID0gTlVMTDsNCj4gPiArCQllbHNlDQo+ID4gKwkJCXJldHVybiBkZXZf
ZXJyX3Byb2JlKGRldiwgUFRSX0VSUihtc2EzMTEtPnZkZCksDQo+ID4gKwkJCQkJICAgICAiY2Fu
bm90IGdldCB2ZGQgc3VwcGx5XG4iKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAobXNhMzEx
LT52ZGQpIHsNCj4gPiArCQllcnIgPSByZWd1bGF0b3JfZW5hYmxlKG1zYTMxMS0+dmRkKTsNCj4g
PiArCQlpZiAoZXJyKQ0KPiA+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIGVyciwNCj4g
PiArCQkJCQkgICAgICJjYW5ub3QgZW5hYmxlIHZkZCBzdXBwbHlcbiIpOw0KPiA+ICsNCj4gPiAr
CQllcnIgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCBtc2EzMTFfdmRkX2Rpc2FibGUs
DQo+ID4gKwkJCQkJICAgICAgIG1zYTMxMS0+dmRkKTsNCj4gPiArCQlpZiAoZXJyKSB7DQo+ID4g
KwkJCXJlZ3VsYXRvcl9kaXNhYmxlKG1zYTMxMS0+dmRkKTsNCj4gDQo+IERvdWJsZSByZWd1bGF0
b3JfZGlzYWJsZSgpLCBiZWNhdXNlIG9mIHRoZSBfb3JfcmVzZXQoKT8NCj4gDQoNClllcC4gSWYg
ZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCkgcmV0dXJucyBhbiBlcnJvciwgd2Ugd2lsbCBub3QN
CmNhbGwgcmVndWxhdG9yX2Rpc2FibGUoKSBieSBkZXZtIHN1YnN5c3RlbS4gSXQgbWVhbnMsIHdl
IGhhdmUgdG8NCmNhbGwgaXQgZGlyZWN0bHkuDQoNCj4gPiArCQkJcmV0dXJuIGRldl9lcnJfcHJv
YmUoZGV2LCBlcnIsDQo+ID4gKwkJCQkJICAgICAiY2Fubm90IGFkZCB2ZGQgZGlzYWJsZSBhY3Rp
b25cbiIpOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gKwllcnIgPSBtc2EzMTFfY2hl
Y2tfcGFydGlkKG1zYTMxMSk7DQo+ID4gKwlpZiAoZXJyKQ0KPiA+ICsJCXJldHVybiBlcnI7DQo+
ID4gKw0KPiA+ICsJZXJyID0gbXNhMzExX3NvZnRfcmVzZXQobXNhMzExKTsNCj4gPiArCWlmIChl
cnIpDQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKwllcnIgPSBtc2EzMTFfc2V0X3B3
cl9tb2RlKG1zYTMxMSwgTVNBMzExX1BXUl9NT0RFX05PUk1BTCk7DQo+ID4gKwlpZiAoZXJyKQ0K
PiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgZXJyLA0KPiA+ICsJCQkJICAgICAiZmFp
bGVkIHRvIHBvd2VyIG9uIGRldmljZSAoJWQpXG4iLCBlcnIpOw0KPiANCj4gTm8gbmVlZCBmb3Ig
IiglZCkiIGFuZCBlcnINCg0KQXNrZWQgZm9yIHRoZSBjbGFyaWZpY2F0aW9uIGFib3ZlLg0KDQo+
IA0KPiBDSg0KDQotLSANClRoYW5rIHlvdSwNCkRtaXRyeQ==
