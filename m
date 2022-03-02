Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFF74C9F23
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiCBI24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240112AbiCBI2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:28:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB2239688
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:28:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c18-20020a7bc852000000b003806ce86c6dso2722396wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HxGOuYmY7LiA4iGOdF2v4hBw9/NxWKDxW/pX0o8XeQY=;
        b=0U55S0NEEaImFGWugryXcG5PJIByCAy7/NHh6Eu7A5Fj3ar/XFGG/uye977EUG+E53
         kmdrPzzzSePStaFeGuLpLY2hHoFjIRoU/xwcRAwJAS/hG83UxMJBVPfLBJJy8LDwWpAc
         yG8h8lLC/S0UmDDny122K5dphkBrswi91zslmzK9vgxt3L21VTrbVLjWTOVpxTaMIgB5
         eZdTkaCO56H4Wwga0+YVUP2hgG4d/IPLBO9ow/0cDogK3HIXK+mTQdFeOtdAzznTWP1J
         7hjIrgn4MtunhIoWwOkohx5hPhkVX0UuyTXkkz/QfRTNE1SKlCXyjEj3ean/VfH4mPKz
         LinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HxGOuYmY7LiA4iGOdF2v4hBw9/NxWKDxW/pX0o8XeQY=;
        b=KAPps+TKual/lvv21HM9XpahKf6H9pbLR8bSt4QoZvpi2bVlM0RR0/rvwmygXtHzRf
         7QceRkFS9VLR0fNAmvL5kz5dFqzvSA5eDlHD8BwGVHWa/ALsfhSb56MGUVnGZybWAFY1
         NVbftkfWCZ1p2bW2wn5bBSAMPwt9mGqyYBNS/fytT2C+2DBFk0ShAcgSiqG1v5MgMZOZ
         AOr6CrSZ0o4e/pWn2hm8H7zn/G6KDyIVbuS00aJ78vvdjenEgV+Oteq1gKETZgFBBEF+
         s0e46OvmDTDzT6N9dugQrsfI0dHrTHvM1X4Ln7Tq3f4SF1P5j3sWtUohf94B77ZzKr+m
         u//w==
X-Gm-Message-State: AOAM532r9dm2c+QmSB4nt43BH/3+22MDhNCTPH8Ycicg/TwVKgmzbP7K
        eRRwo7jZodXJ8jihLjxvnOlPbA==
X-Google-Smtp-Source: ABdhPJw+rAizsnXWw82JpOop6PVVpVwgNfC4DCBaFHUIX7R//EsA8IkQlLb3ax3IfwmPlq0Qpu7x5w==
X-Received: by 2002:a05:600c:3b10:b0:381:3b9f:e382 with SMTP id m16-20020a05600c3b1000b003813b9fe382mr18332369wms.9.1646209687407;
        Wed, 02 Mar 2022 00:28:07 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:3530:ddb:a61:e8db? ([2001:861:44c0:66c0:3530:ddb:a61:e8db])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b001e30e81afd1sm15903883wrv.2.2022.03.02.00.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 00:28:07 -0800 (PST)
Message-ID: <09756faa-5bfd-beac-0c77-976601141ad1@baylibre.com>
Date:   Wed, 2 Mar 2022 09:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V5 0/2] Power: meson-s4: add s4 power domain driver
Content-Language: en-US
To:     "shunzhou.jiang@amlogic.com" <shunzhou.jiang@amlogic.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        khilman <khilman@baylibre.com>, jbrunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "jianxin.pan" <jianxin.pan@amlogic.com>
References: <20220301015849.827634-1-shunzhou.jiang@amlogic.com>
 <9c35b653-6cf4-a13e-ce7b-b186cf4b68f4@baylibre.com>
 <2022030211175891410963@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <2022030211175891410963@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDAyLzAzLzIwMjIgMDQ6MTcsIHNodW56aG91LmppYW5nQGFtbG9naWMuY29t
IHdyb3RlOg0KPiBIaSwNCj4gT0ssIHRoYW5rcyB5b3VyIHJlcGx5DQo+IEkgd2lsbCBjaGVj
ayB0aGlzIGlzc3VlDQoNCkFub3RoZXIgeDggc2V0IG9mIG1haWxzIGFycml2ZWQgb24gdGhl
IG1haWxpbmctbGlzdCBmcm9tIHlvdXIgc2lkZSwgcGxlYXNlIGZpeCB0aGUgcHJvYmxlbS4N
Cg0KTmVpbA0KDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBTaHVuemhvdSBKaWFuZw0KPiBT
VyBEZXBhcnRtZW50DQo+IA0KPiAgICAgKkZyb206KiBOZWlsIEFybXN0cm9uZyA8bWFpbHRv
Om5hcm1zdHJvbmdAYmF5bGlicmUuY29tPg0KPiAgICAgKkRhdGU6KsKgMjAyMi0wMy0wMcKg
MTY6MzkNCj4gICAgICpUbzoqIFNodW56aG91IEppYW5nIDxtYWlsdG86c2h1bnpob3Uuamlh
bmdAYW1sb2dpYy5jb20+DQo+ICAgICAqQ0M6KiBsaW51eC1hcm0ta2VybmVsIDxtYWlsdG86
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgtYW1sb2dpYyA8
bWFpbHRvOmxpbnV4LWFtbG9naWNAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGxpbnV4LWtlcm5l
bCA8bWFpbHRvOmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBkZXZpY2V0cmVlIDxt
YWlsdG86ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBraGlsbWFuIDxtYWlsdG86a2hp
bG1hbkBiYXlsaWJyZS5jb20+OyBqYnJ1bmV0IDxtYWlsdG86amJydW5ldEBiYXlsaWJyZS5j
b20+OyBtYXJ0aW4uYmx1bWVuc3RpbmdsIDxtYWlsdG86bWFydGluLmJsdW1lbnN0aW5nbEBn
b29nbGVtYWlsLmNvbT47IGppYW54aW4ucGFuIDxtYWlsdG86amlhbnhpbi5wYW5AYW1sb2dp
Yy5jb20+DQo+ICAgICAqU3ViamVjdDoqwqBSZTogW1BBVENIIFY1IDAvMl0gUG93ZXI6IG1l
c29uLXM0OiBhZGQgczQgcG93ZXIgZG9tYWluIGRyaXZlcg0KPiAgICAgWyBFWFRFUk5BTCBF
TUFJTCBdDQo+ICAgICBIaSwNCj4gICAgIE9uIDAxLzAzLzIwMjIgMDI6NTgsIFNodW56aG91
IEppYW5nIHdyb3RlOg0KPiAgICAgID4gVGhpcyBwYXRjaHNldCBhZGRzIFBvd2VyIGNvbnRy
b2xsZXIgZHJpdmVyIHN1cHBvcnQgZm9yIE1lc29uLVM0IFNvQw0KPiAgICAgID4gTGlrZXMg
TWVzb24tQTEsIHRoZSBwb3dlciBkb21haW5zIHJlZ2lzdGVyIG9ubHkgY2FuIGFjY2VzcyBp
biBzZWN1cmUgd29ybGQNCj4gICAgICA+DQo+ICAgICAgPiBTaHVuemhvdSBKaWFuZyAoMik6
DQo+ICAgICAgPsKgwqDCoCBkdC1iaW5kaW5nczogcG93ZXI6IGFkZCBBbWxvZ2ljIHM0IHBv
d2VyIGRvbWFpbnMgYmluZGluZ3MNCj4gICAgICA+wqDCoMKgIHNvYzogczQ6IEFkZCBzdXBw
b3J0IGZvciBwb3dlciBkb21haW5zIGNvbnRyb2xsZXINCj4gICAgICA+DQo+ICAgICAgPsKg
wqAgLi4uL3Bvd2VyL2FtbG9naWMsbWVzb24tc2VjLXB3cmMueWFtbMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDMgKystDQo+ICAgICAgPsKgwqAgZHJpdmVycy9zb2MvYW1sb2dpYy9tZXNvbi1z
ZWN1cmUtcHdyYy5jwqDCoMKgwqDCoMKgIHwgMjIgKysrKysrKysrKysrKysrKysrKw0KPiAg
ICAgID7CoMKgIGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbWVzb24tczQtcG93ZXIuaMKg
wqDCoCB8IDE5ICsrKysrKysrKysrKysrKysNCj4gICAgICA+wqDCoCAzIGZpbGVzIGNoYW5n
ZWQsIDQzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gICAgICA+wqDCoCBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tZXNvbi1zNC1wb3dl
ci5oDQo+ICAgICAgPg0KPiAgICAgID4NCj4gICAgICA+IGJhc2UtY29tbWl0OiAzNDQ4YTAx
OGRlZDAzY2NkNDA5M2Q2Njc1ZjRhMzllYjJkMWExOGVmDQo+ICAgICBJIHRoaW5rIHlvdSBo
YXZlIGFuIGlzc3VlIHdpdGggeW91ciBtYWlsIHNldHVwLCB5b3Ugc2VudCA1IHRpbWVzIHRo
ZSBzYW1lICJbUEFUQ0ggVjUgMC8yXSBQb3dlcjogbWVzb24tczQ6IGFkZCBzNCBwb3dlciBk
b21haW4gZHJpdmVyIiBwYXRjaHNldC4NCj4gICAgIFBsZWFzZSBmaXggaXQgYW5kIG1ha2Vy
IGl0IGRvZXNuJ3QgaGFwcGVuIGFnYWluLg0KPiAgICAgVGhhbmtzLA0KPiAgICAgTmVpbA0K
PiANCg0K
