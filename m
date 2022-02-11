Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AC54B23DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349318AbiBKLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:01:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiBKLBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:01:40 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E661D57;
        Fri, 11 Feb 2022 03:01:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b9so15741892lfq.6;
        Fri, 11 Feb 2022 03:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to;
        bh=eGRY2PoQXp1AipKZqM/k5vpG/2CESNc4EYBGMyYBWHc=;
        b=ZnpA7AzePRNaGm9TDD8UEuMag1kIOJ2su9DvfT1+lDF+czvzgpmh+0WVvBrIg0F86o
         F26DI6HeaYVuZ1eL/qvvSV+5zpsmbi0vzzi229liY+a9voREc/vniRNHQ4x1w33Bfod/
         4vF9oyDTq4DnQrPAQLbdzu4RU13tg0f/K06RtIIYWjztC5OGBfpMOgkdBaMCNhW1Ol1w
         8HdFFQGsO/g3dX7qNZJBXC9d7OSC5UqtHdqkpk6I8P65L+zlNk1a2JBb6L7kuOv9YRoD
         JprO8fxAzjvbYD6QHHukD59AvXeyl5I3LZSizFQgMVTR8AJTd01t3XxdSswDmZo+Fcd+
         d/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to;
        bh=eGRY2PoQXp1AipKZqM/k5vpG/2CESNc4EYBGMyYBWHc=;
        b=kVIQoX6DFR+qwg9/rWMXME9ytql4Ch8+B7kHyYGazhwnWpmXvLLJsZYb1lxG/hNeFm
         vDzWbZxBUr81kFps4uxqBf6xBnAyljetbxNZqUdKJdZj/2qWUzZujLd71+LamvluiZ1q
         d7O4y6gB1NlhfcLA+J82v1qpD1VFnaKdvg4wYhAV9Bgzg7Tlm+n4RRsG84WkbF44WjCt
         cieh7tZLUxuo4W5DBRhxGBXOy/KlvNx2BMphj2ztgAReeDKI2N6L+XbgxQ4Eui0TH7sL
         pC/9Uahfxu7GF9G/O8DC6D5x4Fm8oZb9Z6Uy8zgBSIWcaFrdw8+ez1+lbf79me7KJDKh
         ru8A==
X-Gm-Message-State: AOAM531kh5Roxq/oO6/pSp+BUeOg+lwmlo0kgAqwNfG7FJaO7wfI5tPW
        ByAb2zyc0lg5JUGO/wCZ5zI=
X-Google-Smtp-Source: ABdhPJyMF5KrN+3pnAQP2xfIUFeqW+krn7kB4sWkR6VCur3yI6PFJc4o8ht2EeiJU586USYkWw2IZw==
X-Received: by 2002:a05:6512:1528:: with SMTP id bq40mr797187lfb.572.1644577297731;
        Fri, 11 Feb 2022 03:01:37 -0800 (PST)
Received: from [172.16.186.81] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id u6sm3075412lfs.159.2022.02.11.03.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 03:01:36 -0800 (PST)
Message-ID: <828ffa4e-d098-071f-1b5f-3bf414c0ed80@gmail.com>
Date:   Fri, 11 Feb 2022 13:01:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Satya Priya <quic_c_skakit@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH V5 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
In-Reply-To: <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------58mvgZE2qMT113Uf9AnSpdKZ"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------58mvgZE2qMT113Uf9AnSpdKZ
Content-Type: multipart/mixed; boundary="------------kSbMAg55iFRpo0zFlCeJPAsn";
 protected-headers="v1"
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Satya Priya <quic_c_skakit@quicinc.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Das Srinagesh <gurus@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, swboyd@chromium.org,
 quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
 quic_jprakash@quicinc.com
Message-ID: <828ffa4e-d098-071f-1b5f-3bf414c0ed80@gmail.com>
Subject: Re: [PATCH V5 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
In-Reply-To: <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>

--------------kSbMAg55iFRpo0zFlCeJPAsn
Content-Type: multipart/mixed; boundary="------------WunJwVgUBD4U30WkUQktVqT0"

--------------WunJwVgUBD4U30WkUQktVqT0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU2F0eWEsDQoNCkl0J3MgYWx3YXlzIG5pY2UgdG8gc2VlIG5ldyBQTUlDIGRyaXZlcnMg
OikgSSBqdXN0IG9uZSBxdWVzdGlvbiBhZnRlciANCnJlYWRpbmcgeW91ciBwYXRjaCAtIHBs
ZWFzZSBpZ25vcmUgaXQgaWYgaXQgaGFzIGFscmVhZHkgYmVlbiBkaXNjdXNzZWQgDQpiZWZv
cmUgLSBmb3Igc29tZSByZWFzb24gdGhpcyB2ZXJzaW9uIHdhcyBjYXVnaHQgYnkgbXkgZmls
dGVycyB3aGVyZSB0aGUgDQpwcmV2aW91cyB2ZXJzaW9ucyBkaWRuJ3QuIEl0IG1lYW5zIEkg
ZG8gbm90IGtub3cgdGhlIGZ1bGwgaGlzdG9yeS4NCg0KT24gMi84LzIyIDE2OjUyLCBTYXR5
YSBQcml5YSB3cm90ZToNCj4gUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIFBNODAwOCBp
cyBhbiBJMkMgY29udHJvbGxlZCBQTUlDDQo+IGNvbnRhaW5pbmcgNyBMRE8gcmVndWxhdG9y
cy4gIEFkZCBhIFBNODAwOCByZWd1bGF0b3IgZHJpdmVyIHRvDQo+IHN1cHBvcnQgUE1JQyBy
ZWd1bGF0b3IgbWFuYWdlbWVudCB2aWEgdGhlIHJlZ3VsYXRvciBmcmFtZXdvcmsuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBTYXR5YSBQcml5YSA8cXVpY19jX3NrYWtpdEBxdWljaW5jLmNv
bT4NCj4gLS0tDQoNCnNuaXANCg0KPiArDQo+ICtzdGF0aWMgaW50IHBtODAwOF9yZWd1bGF0
b3Jfb2ZfcGFyc2Uoc3RydWN0IGRldmljZV9ub2RlICpub2RlLA0KPiArCQkJY29uc3Qgc3Ry
dWN0IHJlZ3VsYXRvcl9kZXNjICpkZXNjLA0KPiArCQkJc3RydWN0IHJlZ3VsYXRvcl9jb25m
aWcgKmNvbmZpZykNCj4gK3sNCj4gKwlzdHJ1Y3QgcG04MDA4X3JlZ3VsYXRvciAqcG04MDA4
X3JlZyA9IGNvbmZpZy0+ZHJpdmVyX2RhdGE7DQo+ICsJaW50IHJjOw0KPiArCXVuc2lnbmVk
IGludCByZWc7DQo+ICsNCj4gKwkvKiBnZXQgc2xldyByYXRlICovDQo+ICsJcmMgPSByZWdt
YXBfYnVsa19yZWFkKHBtODAwOF9yZWctPnJlZ21hcCwNCj4gKwkJCUxET19TVEVQUEVSX0NU
TF9SRUcocG04MDA4X3JlZy0+YmFzZSksICZyZWcsIDEpOw0KPiArCWlmIChyYyA8IDApIHsN
Cj4gKwkJZGV2X2VycihwbTgwMDhfcmVnLT5kZXYsDQo+ICsJCQkiJXM6IGZhaWxlZCB0byBy
ZWFkIHN0ZXAgcmF0ZSBjb25maWd1cmF0aW9uIHJjPSVkXG4iLA0KPiArCQkJcG04MDA4X3Jl
Zy0+cmRlc2MubmFtZSwgcmMpOw0KPiArCQlyZXR1cm4gcmM7DQo+ICsJfQ0KPiArCXJlZyAm
PSBTVEVQX1JBVEVfTUFTSzsNCj4gKwlwbTgwMDhfcmVnLT5zdGVwX3JhdGUgPSBERUZBVUxU
X1ZPTFRBR0VfU1RFUFBFUl9SQVRFID4+IHJlZzsNCj4gKw0KPiArCXJldHVybiAwOw0KPiAr
fQ0KDQpJIHdvbmRlciB3aHkgdGhpcyBpcyBkb25lIGluIHRoZSBvZl9wYXJzZV9jYj8gQ291
bGQgdGhpcyBwZXJoYXBzIGJlIGRvbmUgDQpkaXJlY3RseSBpbiBwcm9iZSAtIEkgZG9uJ3Qg
dGhpbmsgdGhpcyBpcyBhY3R1YWxseSBwYXJzaW5nIHRoZSANCmRldmljZV9ub2RlIHByb3Bl
cnRpZXMsIHJpZ2h0Pw0KDQpPdmVyYWxsIHRoaXMgbG9va3MgcHJldHR5IG5pY2UgdG8gbWUu
DQoNCkJlc3QgUmVnYXJkcw0KCS0tIE1hdHRpDQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBn
dXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRl
dmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmlo
YXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlz
IHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
--------------WunJwVgUBD4U30WkUQktVqT0
Content-Type: application/pgp-keys; name="OpenPGP_0x40497F0C4693EF47.asc"
Content-Disposition: attachment; filename="OpenPGP_0x40497F0C4693EF47.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
bJdDT4nPrGpMQWvFLTScS7sTfKC8lx6/+/w=3D
=3DfJFG
-----END PGP PUBLIC KEY BLOCK-----

--------------WunJwVgUBD4U30WkUQktVqT0--

--------------kSbMAg55iFRpo0zFlCeJPAsn--

--------------58mvgZE2qMT113Uf9AnSpdKZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmIGQg8FAwAAAAAACgkQeFA3/03aocWF
OQf+K8Z9mrvfb/XGfUCBdVohzZMs84zEj61nw6DrkYgWo9V12Fa1Vmv/bVdDZ3/kHfA4PZFUR4VI
9QiA01cSVA8BCuwlQDxMZoE1eXGAULNe/aCy2Dhv5RY1JfqcFRhSUzLP+PeR31quURitMHzkxaIq
W/OG41vUxU/dHZd1vzpyTOV30OrEe+wZM4wAw1Fun/eBBUjqwwX4+e6AO87BGS8X8GSNK4Dx+8tz
KBwGXwVyUyC/2uvEFwC3rRKOssB1y+/zApDujESQcQpovcQApoQpoE0NpFGIlodZZz24IkQ1hQvf
8nX+xi8N3RzcGaduC85qYPMqx7XwyXSf5IGH9bcNew==
=MpRZ
-----END PGP SIGNATURE-----

--------------58mvgZE2qMT113Uf9AnSpdKZ--
