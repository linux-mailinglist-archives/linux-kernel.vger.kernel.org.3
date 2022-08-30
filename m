Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D3F5A5C13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiH3Gqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiH3Gqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:46:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5ACA00E3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:46:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m16so12813673wru.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:from:to:cc;
        bh=uNEuHOAteazyIC1AyuG6gAPmQRuBflQgsrGFq90AkL8=;
        b=xrxjzN84NNOAPVsknUJjhguvFY7Jm9nDNOw5SxQQrrR0IpFZtQ/cWzc1kLMxeTC9HB
         WwbtoDMMgcs5u5vMMgt0F1OisV1DD7zW8KZR04rZdcF0PBypUgCyR+Cvjb6y4xZfeLur
         v2HeMOnSAIpcdzquU4WAvSS6WCJUlR5j+DCeMrA80WllQzw//G/b97zPaNhct0+excqD
         OZy+YpWX6WKUxsBEW8QCbZGdx5RmBtQ05ASdsiC6Qb9jIIQvRYhBi4re3uec/788bWTu
         YE28suGbqmERGc/PP/nN1GwYKWta9h6uztrIIxJtsGg9SsYXhcqpFwXakLdwbZ+yi+2i
         Y99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc;
        bh=uNEuHOAteazyIC1AyuG6gAPmQRuBflQgsrGFq90AkL8=;
        b=kyfDQ1WErUee68NGwo2vsIBbHmzo7twKn0BW2Iq/uMDW4T6xDuoJl0fjAU1FaWzSyx
         sxN/9+jpTWM0w9XYBean/swiudrzA51I9r2iC+4udzjWQcejvOQ7aSus3L/qGweGj9C+
         ACIr/1fEZLw4DFMbLWTJm0uSBJW/sj69K6ejShApzon50lnOF72mTyHyOVHv2j3DhgC8
         kCTGR0A+jdYpVL5BVVnu0EX7UCgde+Vai45bfTw+2a77UfCISzX1DbVat3zIz9oFCzZG
         YnQ8DCNpfjhZhtBe0huOvwVNEb+kvGiZYPKnNxFeiZCAeubkP0Edp/v1Nk7OS+JRZ++q
         XiQw==
X-Gm-Message-State: ACgBeo2qLC2xkHV82T45dkq5TjAGJ9xU8jiHzh6/3RUt2qvQBQWPLKCy
        A/RomPyhpj0jhz5MLqb3DE2n+g==
X-Google-Smtp-Source: AA6agR4DWkxaJe99oAOEPXlrrxRopc/vUu//vwPgzIo0tcLsvHWV2Vq+65oUCUGF7bxEZ15aEUQTwA==
X-Received: by 2002:a05:6000:18a2:b0:221:7db8:de02 with SMTP id b2-20020a05600018a200b002217db8de02mr8049189wri.132.1661842003316;
        Mon, 29 Aug 2022 23:46:43 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d4346000000b0020fff0ea0a3sm8757749wrr.116.2022.08.29.23.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 23:46:42 -0700 (PDT)
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-4-yu.tu@amlogic.com>
 <1jiln0yzgj.fsf@starbuckisacylon.baylibre.com>
 <ed4038fb-c230-fc27-800c-c99bd1770a1c@amlogic.com>
 <4e3cdd6b-5861-8a4f-1df7-af763f77bad5@amlogic.com>
 <1jsflftm1y.fsf@starbuckisacylon.baylibre.com>
 <0c7e6d90-2ce3-25ab-84b6-026ce8a238a8@amlogic.com>
User-agent: mu4e 1.8.7; emacs 28.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 3/6] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver
Date:   Tue, 30 Aug 2022 08:44:01 +0200
In-reply-to: <0c7e6d90-2ce3-25ab-84b6-026ce8a238a8@amlogic.com>
Message-ID: <1jtu5uz0ry.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUgMzAgQXVnIDIwMjIgYXQgMTQ6MTMsIFl1IFR1IDx5dS50dUBhbWxvZ2ljLmNvbT4g
d3JvdGU6DQoNCj4gT24gMjAyMi84LzI5IDE3OjQ4LCBKZXJvbWUgQnJ1bmV0IHdyb3RlOg0KPj4g
WyBFWFRFUk5BTCBFTUFJTCBdDQo+PiBPbiBNb24gMTUgQXVnIDIwMjIgYXQgMjE6MjAsIFl1IFR1
IDx5dS50dUBhbWxvZ2ljLmNvbT4gd3JvdGU6DQo+PiANCj4+Pj4+PiArDQo+Pj4+Pj4gK3N0YXRp
YyBzdHJ1Y3QgY2xrX3JlZ21hcCBzNF9oZG1pX3BsbF9kY28gPSB7DQo+Pj4+Pj4gK8KgwqDCoCAu
ZGF0YSA9ICYoc3RydWN0IG1lc29uX2Nsa19wbGxfZGF0YSl7DQo+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIC5lbiA9IHsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucmVnX29mZiA9IEFO
QUNUUkxfSERNSVBMTF9DVFJMMCwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc2hp
ZnTCoMKgID0gMjgsDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLndpZHRowqDCoCA9
IDEsDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0sDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5t
ID0gew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yZWdfb2ZmID0gQU5BQ1RSTF9I
RE1JUExMX0NUUkwwLA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zaGlmdMKgwqAg
PSAwLA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC53aWR0aMKgwqAgPSA4LA0KPj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCB9LA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAubiA9IHsNCj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucmVnX29mZiA9IEFOQUNUUkxfSERNSVBMTF9D
VFJMMCwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc2hpZnTCoMKgID0gMTAsDQo+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLndpZHRowqDCoCA9IDUsDQo+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIH0sDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5mcmFjID0gew0KPj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yZWdfb2ZmID0gQU5BQ1RSTF9IRE1JUExMX0NUUkwx
LA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zaGlmdMKgwqAgPSAwLA0KPj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC53aWR0aMKgwqAgPSAxNywNCj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgfSwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLmwgPSB7DQo+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLnJlZ19vZmYgPSBBTkFDVFJMX0hETUlQTExfQ1RSTDAsDQo+Pj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnNoaWZ0wqDCoCA9IDMxLA0KPj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC53aWR0aMKgwqAgPSAxLA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCB9LA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAucnN0ID0gew0KPj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC5yZWdfb2ZmID0gQU5BQ1RSTF9IRE1JUExMX0NUUkwwLA0KPj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zaGlmdMKgwqAgPSAyOSwNCj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAud2lkdGjCoMKgID0gMSwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgfSwN
Cj4+Pj4+PiArwqDCoMKgIH0sDQo+Pj4+Pj4gK8KgwqDCoCAuaHcuaW5pdCA9ICYoc3RydWN0IGNs
a19pbml0X2RhdGEpew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAubmFtZSA9ICJoZG1pX3BsbF9k
Y28iLA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAub3BzID0gJm1lc29uX2Nsa19wbGxfcm9fb3Bz
LA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAucGFyZW50X2RhdGEgPSAoY29uc3Qgc3RydWN0IGNs
a19wYXJlbnRfZGF0YSBbXSkgew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHsgLmZ3
X25hbWUgPSAieHRhbCIsIH0NCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgfSwNCj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgLm51bV9wYXJlbnRzID0gMSwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLyoN
Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIERpc3BsYXkgZGlyZWN0bHkgaGFuZGxlIGhkbWkg
cGxsIHJlZ2lzdGVycyBBVE0sIHdlIG5lZWQNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIE5P
Q0FDSEUgdG8ga2VlcCBvdXIgdmlldyBvZiB0aGUgY2xvY2sgYXMgYWNjdXJhdGUgYXMNCj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqDCoCAqIHBvc3NpYmxlDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAg
Ki8NCj4+Pj4+DQo+Pj4+PiBJcyBpdCByZWFsbHkgPw0KPj4+Pj4NCj4+Pj4+IEdpdmVuIHRoYXQg
SERNSSBzdXBwb3J0IGZvciB0aGUgczQgaXMgdGhlcmUgeWV0LCB0aGUNCj4+Pj4+IGFkZHJlc3Nl
cyBoYXZlIGNoYW5nZXMgYW5kIHRoZSByZWdpb24gaXMgbm8gbG9uZ2VyIGEgc3lzY29uLCBpdCBp
cyB0aW1lDQo+Pj4+PiBmb3IgdGhlIEhETUkgZHJpdmVyIHRvIGdldCBmaXhlZC4NCj4+PiBUaGUg
SERNSSBQTEwgaXMgY29uZmlndXJlZCBpbiB0aGUgVWJvb3QgcGhhc2UgYW5kIGRvZXMgbm90IGNo
YW5nZSB0aGUNCj4+PiBmcmVxdWVuY3kgaW4gdGhlIGtlcm5lbCBwaGFzZS4gU28gd2UgdXNlIHRo
ZSBOT0NBQ0hFIGZsYWcgYW5kDQo+Pj4gInJvX29wcyIuDQo+PiBUaGF0J3Mgbm8gcmVhc29uIHRv
IHB1dCBOT0NBQ0hFIG9yIHJvLW9wcw0KPj4gSWYgeW91IHdhbnQgdGhlIGZyZXF1ZW5jaWVzIHRv
IGJlIHN0YXRpY2FsbHkgYXNzaW5nZWQsIHRoZSBjb3JyZWN0IHdheQ0KPj4gd291bGQgYmUgdGhy
b3VnaCBhc3NpZ25lZC1yYXRlIGluIERUIEkgZ3Vlc3MuDQo+DQo+IE9rYXkuIFlvdSdyZSByaWdo
dC4gSG93ZXZlciwgd2hlbiByZWdpc3RlcmluZyB3aXRoIE9QUywgSERNSSBQTEwgd2lsbCBiZQ0K
PiByZXNldC4gSXQgdGFrZXMgdGltZSBmb3IgUExMIHRvIHN0YWJpbGl6ZSB0aGUgb3V0cHV0IGZy
ZXF1ZW5jeSwgd2hpY2ggd2lsbA0KPiBsZWFkIHRvIHRoZSBzdGFydHVwIHNjcmVlbiBmbGFzaGlu
Zy4NCj4NCj4gSSB3b3VsZCBsaWtlIHRvIGtub3cgaG93IHRvIHNvbHZlIHRoaXMgcHJvYmxlbSBp
ZiBub3QgdXNpbmcgcm9fb3BzLg0KPg0KPj4gDQoNCllvdSBjYW4gYWRkIG5ldyBvcHMgb3IgdHdl
YWsgdGhlIGN1cnJlbnQgaW5pdCBmdW5jdGlvbi4NCg0KU2FmZXN0IHdvdWxkIGJlIHRvIGRvIHRo
ZSBmb2xsb3dpbmcgOg0KICogQ2hlY2sgaWYgdGhlIFBMTHMgaXMgYWxyZWFkeSBvbi4NCiAqIENo
ZWNrIGlmIHRoZSAncGxsLT5pbml0X3JlZ3MnIG1hdGNoZXMgd2hhdCBpcyBhbHJlYWR5IHNldA0K
ICAgLSBpZiBzbywgeW91IGNhbiBza2lwIHRoZSByZXNldA0KICAgLSBpZiBub3QsIHlvdSBuZWVk
IHRvIHJlc2V0IGFzIHVzdWFsDQo=
