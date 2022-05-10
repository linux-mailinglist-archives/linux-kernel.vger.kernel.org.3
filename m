Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628875225F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiEJUz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiEJUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:55:24 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372DB2609DF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:55:22 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6C5612C046F;
        Tue, 10 May 2022 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652216120;
        bh=2Qpn3cSeJ6Ckg5/0EBd3448KCkcv1vPXpuk35DFY0vE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hZcqeHu8yxSmp3Dd4WKaH4zA45aLtSHwpyWsVitZ/Nm0UwJKO89p3xvmoxMj6+7Ni
         ZlnjMaSeffjXs5ghDWSFa7DINx6w5nC3E+AXY9hV1KNMs/ob5yojaEkwMr63wn47Ci
         J24BmeBLenrlGWgePRaKTmUMMvIud2jpuO2n3z0OlWdQO7HWVisiS1ThhQ96hLTpTs
         gvgDiRo36nua29+lAisZjnywxTBopeZ3D38Qjvq8TnxNP3el9pWKtix3G12Wv9x7GK
         LWnzlqpnaEqn3VrmxAUpp512NWr3fGOdUXFS30tbxZ/iArh2NLNj3zxQ/VvH2oyVEQ
         TruHpskndlLEw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627ad1380001>; Wed, 11 May 2022 08:55:20 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May 2022 08:55:20 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Wed, 11 May 2022 08:55:20 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: gpio: gpio-mvebu: convert txt binding to
 YAML
Thread-Topic: [PATCH] dt-bindings: gpio: gpio-mvebu: convert txt binding to
 YAML
Thread-Index: AQHYZFKD08/UItmbQ0e7wNBkJKoFaK0XVTaAgAB5foA=
Date:   Tue, 10 May 2022 20:55:19 +0000
Message-ID: <eaea4c27-05b3-d26f-d091-99e07d14aae6@alliedtelesis.co.nz>
References: <20220510094404.1020307-1-chris.packham@alliedtelesis.co.nz>
 <6db35313-5dcd-c9f2-724c-d157a835c9fc@linaro.org>
In-Reply-To: <6db35313-5dcd-c9f2-724c-d157a835c9fc@linaro.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C3504451A9D124DBB16C208C60E7748@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7GXNjH+ c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=JPAAYGfGNIWfKY3b7Z0A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KHNpZ2ggcmVzZW5kLCBUaHVuZGVyYmlyZCBkZWNpZGVkIHRoYXQgdGhpcyBuZWVkZWQgaHRtbCkN
Cg0KT24gMTEvMDUvMjIgMDE6NDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+PiArICBt
YXJ2ZWxsLHB3bS1vZmZzZXQ6DQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2Rl
ZmluaXRpb25zL3VpbnQzMg0KPj4gKyAgICBkZXNjcmlwdGlvbjogT2Zmc2V0IGluIHRoZSByZWdp
c3RlciBtYXAgZm9yIHRoZSBwd20gcmVnaXN0ZXJzIChpbiBieXRlcykNCj4gSXQncyB0aGUgc2Ft
ZSBhcyBvZmZzZXQuIFdoeSBhbGxvd2luZyBib3RoPyBJc24ndCBvbmUgZGVwcmVjYXRlZD8NCj4N
ClRoaXMgb25lIGlzIGluIGFkZGl0aW9uIHRvIG9mZnNldC4gVGhlICJvZmZzZXQiIGlzIGZvciB0
aGUgZ3BpbyANCnJlZ2lzdGVycyAibWFydmVsbCxwd20tb2Zmc2V0IiBpcyBmb3IgYSBzZXBhcmF0
ZSBwd20gcmVsYXRlZCByZWdpc3RlciANCnRoYXQgaXMgbm90IGluIHRoZSBzYW1lIGNvbnRpZ3Vv
dXMgYmxvY2su
