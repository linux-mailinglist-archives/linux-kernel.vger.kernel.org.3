Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE23C55B0E7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiFZJsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiFZJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:48:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA132100E;
        Sun, 26 Jun 2022 02:48:00 -0700 (PDT)
Received: from [10.0.0.163] (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: david.heidelberg)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 72C3366016D9;
        Sun, 26 Jun 2022 10:47:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656236878;
        bh=ZBhVm6IGWseUER7MkXUlFCT29ycUychI6NdxaG+9H94=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QQSQB7DpPodscJDotm27LdPwtvKQBhPJink12zTUxiTf78vdtog82vhEEXSPVG5xS
         TAIXfK6BsNQyVFktTkAscotdLCOZ5HaqtE3BwSfJ7WotKB0jHMYC/eeeGLqY9tYYXu
         gMZpdTdhxY8KTl+sEE18b3EVcIKv/tIASVu+I89zUF53k3NV0eWN1q2VLD4n5nKy5J
         9Ew89pAXHluttSW+sk3h4VmSObHVTlLErOWFcJDf0rM0aHxGhEQ7Ha5wWZJK7rk76x
         3yZVkhu6Fr1ySgtrmZPuuLHVWF9TWaQyhGDTtLVa0C98brBtkl+apxnTDq0bMKUzrU
         Q71bzJBYLHZ0w==
Message-ID: <728b2c54-0dc0-533f-bab8-fca228f6c1b1@collabora.com>
Date:   Sun, 26 Jun 2022 11:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/7] dt-bindings: clock: mediatek: Add clock driver
 bindings for MT6795
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com>
 <20220624093525.243077-5-angelogioacchino.delregno@collabora.com>
 <cea65d6a-7d9b-7b14-9984-bcd7f115da47@linaro.org>
From:   David Heidelberg <david.heidelberg@collabora.com>
Autocrypt: addr=david.heidelberg@collabora.com; keydata=
 xjMEYlvLOxYJKwYBBAHaRw8BAQdA5CoWEzz4igpwK4h6lK6ZformRk84+ymcfkGNPwqEeILN
 MURhdmlkIEhlaWRlbGJlcmcgPGRhdmlkLmhlaWRlbGJlcmdAY29sbGFib3JhLmNvbT7ClgQT
 FggAPhYhBEo7kSl22BK0F1Np/mn1Z4YcHsAUBQJiW8s7AhsDBQkFo5qABQsJCAcCBhUKCQgL
 AgQWAgMBAh4BAheAAAoJEGn1Z4YcHsAU84kBAK5YqSWAOuIumAqgWvke6BEsaIGWGQzXSuKj
 er/TXuFuAQCwc9ITSVXWWTSpdFt2+4z7Wch8tIGlbIFcS9dCFddwCc44BGJbyzsSCisGAQQB
 l1UBBQEBB0AEk7jXEwDApGOwMH/X0UAPBH8Y3isjxhNMjpyRcnl2CwMBCAfCfgQYFggAJhYh
 BEo7kSl22BK0F1Np/mn1Z4YcHsAUBQJiW8s7AhsMBQkFo5qAAAoJEGn1Z4YcHsAU0PEA/j0Y
 uAOKJCnnwrkf3ozPP0sutA5bojoARwcIaZKO/zvIAP9PwTC9DGLg+8LJm7m2Lyf0LxLA8FXD
 wueLHBdwHg6zAQ==
In-Reply-To: <cea65d6a-7d9b-7b14-9984-bcd7f115da47@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------01SB8j7fsrDg1UCCZJHvnO6w"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------01SB8j7fsrDg1UCCZJHvnO6w
Content-Type: multipart/mixed; boundary="------------igpTnjsExajZs0wD231Hp3a8";
 protected-headers="v1"
From: David Heidelberg <david.heidelberg@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 y.oudjana@protonmail.com, jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
 fparent@baylibre.com, rex-bc.chen@mediatek.com, tinghan.shen@mediatek.com,
 chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com, ikjn@chromium.org,
 miles.chen@mediatek.com, sam.shih@mediatek.com, wenst@chromium.org,
 bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
 martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
 kernel@collabora.com
Message-ID: <728b2c54-0dc0-533f-bab8-fca228f6c1b1@collabora.com>
Subject: Re: [PATCH v3 4/7] dt-bindings: clock: mediatek: Add clock driver
 bindings for MT6795
References: <20220624093525.243077-1-angelogioacchino.delregno@collabora.com>
 <20220624093525.243077-5-angelogioacchino.delregno@collabora.com>
 <cea65d6a-7d9b-7b14-9984-bcd7f115da47@linaro.org>
In-Reply-To: <cea65d6a-7d9b-7b14-9984-bcd7f115da47@linaro.org>

--------------igpTnjsExajZs0wD231Hp3a8
Content-Type: multipart/mixed; boundary="------------4TT4k8GW9tO0EQaIeP92D69x"

--------------4TT4k8GW9tO0EQaIeP92D69x
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUvMDYvMjAyMiAyMjoyOSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24g
MjQvMDYvMjAyMiAxMTozNSwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+
PiBBZGQgdGhlIGJpbmRpbmdzIGZvciB0aGUgY2xvY2sgZHJpdmVycyBvZiB0aGUgTWVkaWFU
ZWsgSGVsaW8gWDEwDQo+PiBNVDY3OTUgU29DLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFu
Z2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNv
bGxhYm9yYS5jb20+DQo+PiAtLS0NCj4+ICAgLi4uL2JpbmRpbmdzL2Nsb2NrL21lZGlhdGVr
LG10Njc5NS1jbG9jay55YW1sIHwgNjYgKysrKysrKysrKysrKysrKysNCj4+ICAgLi4uL2Ns
b2NrL21lZGlhdGVrLG10Njc5NS1zeXMtY2xvY2sueWFtbCAgICAgIHwgNzQgKysrKysrKysr
KysrKysrKysrKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE0MCBpbnNlcnRpb25zKCspDQo+
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvY2xvY2svbWVkaWF0ZWssbXQ2Nzk1LWNsb2NrLnlhbWwNCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9tZWRpYXRl
ayxtdDY3OTUtc3lzLWNsb2NrLnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL21lZGlhdGVrLG10Njc5NS1jbG9jay55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL21lZGlhdGVr
LG10Njc5NS1jbG9jay55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi43OTVmYjE4NzIxYzMNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9tZWRpYXRlayxtdDY3
OTUtY2xvY2sueWFtbA0KPj4gQEAgLTAsMCArMSw2NiBAQA0KPj4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAxLjIN
Cj4+ICstLS0NCj4+ICskaWQ6ICJodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9jbG9j
ay9tZWRpYXRlayxtdDY3OTUtY2xvY2sueWFtbCMiDQo+PiArJHNjaGVtYTogImh0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIyINCj4+ICsNCj4+ICt0aXRs
ZTogTWVkaWFUZWsgRnVuY3Rpb25hbCBDbG9jayBDb250cm9sbGVyIGZvciBNVDY3OTUNCj4+
ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4+ICsgIC0g
Q2h1bi1KaWUgQ2hlbiA8Y2h1bi1qaWUuY2hlbkBtZWRpYXRlay5jb20+DQo+PiArDQo+PiAr
ZGVzY3JpcHRpb246IHwNCj4+ICsgIFRoZSBjbG9jayBhcmNoaXRlY3R1cmUgaW4gTWVkaWFU
ZWsgbGlrZSBiZWxvdw0KPj4gKyAgUExMcyAtLT4NCj4+ICsgICAgICAgICAgZGl2aWRlcnMg
LS0+DQo+PiArICAgICAgICAgICAgICAgICAgICAgIG11eGVzDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLS0+DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y2xvY2sgZ2F0ZQ0KPj4gKw0KPj4gKyAgVGhlIGRldmljZXMgcHJvdmlkZSBjbG9jayBnYXRl
IGNvbnRyb2wgaW4gZGlmZmVyZW50IElQIGJsb2Nrcy4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVz
Og0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgZW51bToNCj4+ICsgICAgICAtIG1lZGlh
dGVrLG10Njc5NS1tZmdjZmcNCj4+ICsgICAgICAtIG1lZGlhdGVrLG10Njc5NS12ZGVjc3lz
DQo+PiArICAgICAgLSBtZWRpYXRlayxtdDY3OTUtdmVuY3N5cw0KPj4gKw0KPj4gKyAgcmVn
Og0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgJyNjbG9jay1jZWxscyc6DQo+
PiArICAgIGNvbnN0OiAxDQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGli
bGUNCj4+ICsgIC0gcmVnDQo+PiArICAtICcjY2xvY2stY2VsbHMnDQo+PiArDQo+PiArYWRk
aXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAt
IHwNCj4+ICsgICAgc29jIHsNCj4+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0K
Pj4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+PiArDQo+PiArICAgICAgICBtZmdj
Zmc6IGNsb2NrLWNvbnRyb2xsZXJAMTMwMDAwMDAgew0KPj4gKyAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ2Nzk1LW1mZ2NmZyI7DQo+PiArICAgICAgICAgICAgcmVn
ID0gPDAgMHgxMzAwMDAwMCAwIDB4MTAwMD47DQo+PiArICAgICAgICAgICAgI2Nsb2NrLWNl
bGxzID0gPDE+Ow0KPj4gKyAgICAgICAgfTsNCj4+ICsNCj4+ICsgICAgICAgIHZkZWNzeXM6
IGNsb2NrLWNvbnRyb2xsZXJAMTYwMDAwMDAgew0KPj4gKyAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ2Nzk1LXZkZWNzeXMiOw0KPj4gKyAgICAgICAgICAgIHJlZyA9
IDwwIDB4MTYwMDAwMDAgMCAweDEwMDA+Ow0KPj4gKyAgICAgICAgICAgICNjbG9jay1jZWxs
cyA9IDwxPjsNCj4+ICsgICAgICAgIH07DQo+PiArDQo+PiArICAgICAgICB2ZW5jc3lzOiBj
bG9jay1jb250cm9sbGVyQDE4MDAwMDAwIHsNCj4+ICsgICAgICAgICAgICBjb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10Njc5NS12ZW5jc3lzIjsNCj4+ICsgICAgICAgICAgICByZWcgPSA8
MCAweDE4MDAwMDAwIDAgMHgxMDAwPjsNCj4+ICsgICAgICAgICAgICAjY2xvY2stY2VsbHMg
PSA8MT47DQo+PiArICAgICAgICB9Ow0KPj4gKyAgICB9Ow0KPj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9tZWRpYXRlayxtdDY3OTUt
c3lzLWNsb2NrLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xv
Y2svbWVkaWF0ZWssbXQ2Nzk1LXN5cy1jbG9jay55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi40NGI5NmFmOWNlYWYNCj4+IC0tLSAvZGV2
L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9j
ay9tZWRpYXRlayxtdDY3OTUtc3lzLWNsb2NrLnlhbWwNCj4+IEBAIC0wLDAgKzEsNzQgQEAN
Cj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1
c2UpDQo+PiArJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiAiaHR0cDovL2RldmljZXRy
ZWUub3JnL3NjaGVtYXMvY2xvY2svbWVkaWF0ZWssbXQ2Nzk1LXN5cy1jbG9jay55YW1sIyIN
Cj4+ICskc2NoZW1hOiAiaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3Jl
LnlhbWwjIg0KPj4gKw0KPj4gK3RpdGxlOiBNZWRpYVRlayBTeXN0ZW0gQ2xvY2sgQ29udHJv
bGxlciBmb3IgTVQ2Nzk1DQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxh
Ym9yYS5jb20+DQo+PiArICAtIENodW4tSmllIENoZW4gPGNodW4tamllLmNoZW5AbWVkaWF0
ZWsuY29tPg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4gKyAgVGhlIE1lZGlhdGVrIHN5
c3RlbSBjbG9jayBjb250cm9sbGVyIHByb3ZpZGVzIHZhcmlvdXMgY2xvY2tzIGFuZCBzeXN0
ZW0gY29uZmlndXJhdGlvbg0KPiBXcmFwIGFjY29yZGluZyB0byBMaW51eCBjb2RpbmcgY29u
dmVudGlvbiwgc28gYXQgODAuDQoNCldoYXQgSSB1bmRlcnN0b29kIHRoYXQgMTAwIGxlbmd0
aCB3YXMgYWdyZWVkIFsxXSBhcyBhIGxpbWl0LiBJIGhhdmVuJ3QgDQpub3RpY2VkIGFueSBy
ZWNlbnQgY2hhbmdlIHJlZ2FyZGluZyB0byBsaW5lIGxlbmd0aC4NCg0KWzFdIA0KaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGlu
dXguZ2l0L2NvbW1pdC8/aWQ9YmRjNDhmYTExZTQ2Zjg2N2VhNGQ3NWZhNTllZTg3YTdmNDhi
ZTE0NA0KDQo+DQo+PiArICBsaWtlIHJlc2V0IGFuZCBidXMgcHJvdGVjdGlvbiBvbiBNVDY3
OTUuDQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAg
IGl0ZW1zOg0KPj4gKyAgICAgIC0gZW51bToNCj4+ICsgICAgICAgICAgLSBtZWRpYXRlayxt
dDY3OTUtYXBtaXhlZHN5cw0KPj4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10Njc5NS1pbmZy
YWNmZw0KPj4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10Njc5NS1wZXJpY2ZnDQo+PiArICAg
ICAgICAgIC0gbWVkaWF0ZWssbXQ2Nzk1LXRvcGNrZ2VuDQo+PiArICAgICAgLSBjb25zdDog
c3lzY29uDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+
PiArICAnI2Nsb2NrLWNlbGxzJzoNCj4+ICsgICAgY29uc3Q6IDENCj4+ICsNCj4+ICsgICcj
cmVzZXQtY2VsbHMnOg0KPj4gKyAgICBjb25zdDogMQ0KPj4gKw0KPj4gK3JlcXVpcmVkOg0K
Pj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0KPj4gKyAgLSAnI2Nsb2NrLWNlbGxz
Jw0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4gKw0KPj4gK2V4
YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgIHNvYyB7DQo+PiArICAgICAgICAjYWRkcmVz
cy1jZWxscyA9IDwyPjsNCj4+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPj4gKw0K
Pj4gKyAgICAgICAgdG9wY2tnZW46IGNsb2NrLWNvbnRyb2xsZXJAMTAwMDAwMDAgew0KPj4g
KyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzk1LXRvcGNrZ2VuIiwg
InN5c2NvbiI7DQo+PiArICAgICAgICAgICAgcmVnID0gPDAgMHgxMDAwMDAwMCAwIDB4MTAw
MD47DQo+PiArICAgICAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICAg
fTsNCj4+ICsNCj4+ICsgICAgICAgIGluZnJhY2ZnOiBwb3dlci1jb250cm9sbGVyQDEwMDAx
MDAwIHsNCj4+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc5NS1p
bmZyYWNmZyIsICJzeXNjb24iOw0KPj4gKyAgICAgICAgICAgIHJlZyA9IDwwIDB4MTAwMDEw
MDAgMCAweDEwMDA+Ow0KPj4gKyAgICAgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsNCj4+
ICsgICAgICAgICAgICAjcmVzZXQtY2VsbHMgPSA8MT47DQo+IE5vIG5lZWQgZm9yIGZvdXIg
ZXhhbXBsZXMgb2YgdGhlIHNhbWUuIFRoZXkgZGlmZmVyIG9ubHkgYnkgY29tcGF0aWJsZSwN
Cj4gc28gdGhpcyBpcyBqdXN0IHVubmVjZXNzYXJ5IGNvZGUuLi4gd2hpY2ggYXMgeW91IGNh
biBzZWUgZG9lcyBub3QgcGFzcw0KPiB0aGUgY2hlY2tzLiBUaGlzIGFsc28gaGFzIHRvIGJl
IGZpeGVkLg0KPg0KPiBNYXliZSBrZWVwIGl0IGFzIGNsb2NrLWNvbnRyb2xsZXI/DQo+DQo+
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+DQotLSANCkRhdmlkIEhlaWRlbGJl
cmcNCkNvbnN1bHRhbnQgU29mdHdhcmUgRW5naW5lZXINCg0KQ29sbGFib3JhIEx0ZC4NClBs
YXRpbnVtIEJ1aWxkaW5nLCBTdCBKb2huJ3MgSW5ub3ZhdGlvbiBQYXJrLCBDYW1icmlkZ2Ug
Q0I0IDBEUywgVUsNClJlZ2lzdGVyZWQgaW4gRW5nbGFuZCAmIFdhbGVzLCBuby4gNTUxMzcx
OA0KDQo=
--------------4TT4k8GW9tO0EQaIeP92D69x
Content-Type: application/pgp-keys; name="OpenPGP_0x69F567861C1EC014.asc"
Content-Disposition: attachment; filename="OpenPGP_0x69F567861C1EC014.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEYlvLOxYJKwYBBAHaRw8BAQdA5CoWEzz4igpwK4h6lK6ZformRk84+ymcfkGN
PwqEeILNMURhdmlkIEhlaWRlbGJlcmcgPGRhdmlkLmhlaWRlbGJlcmdAY29sbGFi
b3JhLmNvbT7ClgQTFggAPhYhBEo7kSl22BK0F1Np/mn1Z4YcHsAUBQJiW8s7AhsD
BQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGn1Z4YcHsAU84kBAK5Y
qSWAOuIumAqgWvke6BEsaIGWGQzXSuKjer/TXuFuAQCwc9ITSVXWWTSpdFt2+4z7
Wch8tIGlbIFcS9dCFddwCc44BGJbyzsSCisGAQQBl1UBBQEBB0AEk7jXEwDApGOw
MH/X0UAPBH8Y3isjxhNMjpyRcnl2CwMBCAfCfgQYFggAJhYhBEo7kSl22BK0F1Np
/mn1Z4YcHsAUBQJiW8s7AhsMBQkFo5qAAAoJEGn1Z4YcHsAU0PEA/j0YuAOKJCnn
wrkf3ozPP0sutA5bojoARwcIaZKO/zvIAP9PwTC9DGLg+8LJm7m2Lyf0LxLA8FXD
wueLHBdwHg6zAQ=3D=3D
=3DOQS+
-----END PGP PUBLIC KEY BLOCK-----

--------------4TT4k8GW9tO0EQaIeP92D69x--

--------------igpTnjsExajZs0wD231Hp3a8--

--------------01SB8j7fsrDg1UCCZJHvnO6w
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRKO5EpdtgStBdTaf5p9WeGHB7AFAUCYrgrSwAKCRBp9WeGHB7A
FI9aAPwKZ9qdy8fkfWuR5+0DNALpnxhA22wMeS/Rr+FJzCIO6wD/Q/q4xqSAb6h2
Q4m/b/mqOFD4AYAJ416vkMM4dwJj0wg=
=NSS0
-----END PGP SIGNATURE-----

--------------01SB8j7fsrDg1UCCZJHvnO6w--
