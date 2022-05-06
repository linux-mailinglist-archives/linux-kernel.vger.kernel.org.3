Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61451D75B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391684AbiEFMRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378642AbiEFMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:17:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21B6541D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:13:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d15so3737709lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 05:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=v3H5/z08rent5OYfQ6m0ZuJBFAHFt0V/Gv4Dv2dtg5M=;
        b=TV0vqj4WksNrf/neaQ6kHAxCcJ394Arcsj9R4hcOwdb07h9+H3SodGU9+MKyAweGcC
         4Vdb/AQ13sIWsEQE/3kh716QCeHRaLuMQs1FJTDHx18ntZV95RX7dqvWls3sDA3Z8ekH
         iukwtdJjlgGVXlsGyc1ECw16JxQy9j0e3H5rABTJNqXrHllVUjPBGmxUC5SaR67zI6TI
         4wIENC/9+LyGDoYdfm4zg7LYdRwLU6bzaGXc5Iuchc9CDSve4whGj1ZNmUHn+nqRJiH5
         4Cb7v1FLfp5rZ6pRZClZ+z7W1v1JV2lKkQcF9SMnhgNBlg2SQtO2c/ZaRRb6IFLaTgO8
         8mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=v3H5/z08rent5OYfQ6m0ZuJBFAHFt0V/Gv4Dv2dtg5M=;
        b=Lb9Se9DgKpG9irSvgOcj/0RIN+OXiCKq7XK7CUu/6bG5pimDqiaEksY9c/BKl9mvZO
         E/pNh26/NupND0VYnRQPAZi6lr74xQABPBG8f8TzVPtcUvZphEupk4Ypf/CGsNPK77y0
         8vP52jRVDCd9MhzPEsZ4qe2uQnNo3o6SWUbeqZyLYylqKxuE4Hpu+2Stx8KYACoCW0hT
         h78YtSUgGY6se8SqFPZGFXVJSR3t062xrMYnyANgVDkJVjNqxzSrbdt2W7BII53LMPQQ
         vEDlGhToxIKW/LZYdCnUaHyDFP8kFCX11b/bJE9O7bbibjs8FtUiDzpptIW+ZGlFGN9y
         LaMQ==
X-Gm-Message-State: AOAM531cSqsJBUeHNdylvosPfw4Z3s3YztotW/WZzeFbGu8EF03hT3VU
        /OriR/kf7CDF2V1UKFTUjhk=
X-Google-Smtp-Source: ABdhPJwhKnb0/xUetQKAW2aGCpQcmTPOZ7Pni/xP9yFSlkM7Z1UHLzbu3LSXeLrJVpVHowHRdSETZQ==
X-Received: by 2002:a05:6512:3204:b0:472:4792:e29c with SMTP id d4-20020a056512320400b004724792e29cmr2259235lfe.553.1651839204827;
        Fri, 06 May 2022 05:13:24 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.246.114])
        by smtp.gmail.com with ESMTPSA id h4-20020a2eb0e4000000b0024f3d1daea4sm619899ljl.44.2022.05.06.05.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 05:13:24 -0700 (PDT)
Message-ID: <b29ae3f8-c00d-d36d-cdd0-b7a5ccf4cab9@gmail.com>
Date:   Fri, 6 May 2022 15:13:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/3] staging: rtl8712: add error handler in
 r8712_usbctrl_vendorreq()
Content-Language: en-US
To:     Wang Cheng <wanngchenng@gmail.com>, dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1651833575.git.wanngchenng@gmail.com>
 <e33ea53d36c422fbe7eabec5bd9eecb0ebce1bc5.1651833575.git.wanngchenng@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <e33ea53d36c422fbe7eabec5bd9eecb0ebce1bc5.1651833575.git.wanngchenng@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mXZFtjjS4d1g7hinAq9qEikv"
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mXZFtjjS4d1g7hinAq9qEikv
Content-Type: multipart/mixed; boundary="------------z101Pc6ay5qzK0nS66vtISEO";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Wang Cheng <wanngchenng@gmail.com>, dan.carpenter@oracle.com
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <b29ae3f8-c00d-d36d-cdd0-b7a5ccf4cab9@gmail.com>
Subject: Re: [PATCH v3 3/3] staging: rtl8712: add error handler in
 r8712_usbctrl_vendorreq()
References: <cover.1651833575.git.wanngchenng@gmail.com>
 <e33ea53d36c422fbe7eabec5bd9eecb0ebce1bc5.1651833575.git.wanngchenng@gmail.com>
In-Reply-To: <e33ea53d36c422fbe7eabec5bd9eecb0ebce1bc5.1651833575.git.wanngchenng@gmail.com>

--------------z101Pc6ay5qzK0nS66vtISEO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgV2FuZywNCg0KT24gNS82LzIyIDE1OjAxLCBXYW5nIENoZW5nIHdyb3RlOg0KPiBXaGVu
ICdzdGF0dXMnIHJldHVybmVkIGZyb20gdXNiX2NvbnRyb2xfbXNnKCkgaXMgbm90IGVxdWFs
IHRvICdsZW4nLA0KPiB0aGF0IHVzYl9jb250cm9sX21zZygpIGlzIG9uIHBhcnRpYWwgZmFp
bHVyZSwgcjg3MTJfdXNiY3RybF92ZW5kb3JyZXEoKQ0KPiB3aWxsIHRyZWF0IHBhcnRpYWwg
cmVhZHMgYXMgc3VjY2Vzcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdhbmcgQ2hlbmcgPHdh
bm5nY2hlbm5nQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9zdGFnaW5nL3J0bDg3
MTIvdXNiX29wc19saW51eC5jIHwgMjEgKysrKysrKysrKysrKystLS0tLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3J0bDg3MTIvdXNiX29wc19saW51eC5jIGIv
ZHJpdmVycy9zdGFnaW5nL3J0bDg3MTIvdXNiX29wc19saW51eC5jDQo+IGluZGV4IGY5ODRh
NWFiMmM2Zi4uYjIxODFlMWUyZDM4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcv
cnRsODcxMi91c2Jfb3BzX2xpbnV4LmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL3J0bDg3
MTIvdXNiX29wc19saW51eC5jDQo+IEBAIC00OTUsMTQgKzQ5NSwyMSBAQCBpbnQgcjg3MTJf
dXNiY3RybF92ZW5kb3JyZXEoc3RydWN0IGludGZfcHJpdiAqcGludGZwcml2LCB1OCByZXF1
ZXN0LCB1MTYgdmFsdWUsDQo+ICAgCX0NCj4gICAJc3RhdHVzID0gdXNiX2NvbnRyb2xfbXNn
KHVkZXYsIHBpcGUsIHJlcXVlc3QsIHJlcXR5cGUsIHZhbHVlLCBpbmRleCwNCj4gICAJCQkJ
IHBJb19idWYsIGxlbiwgNTAwKTsNCj4gLQlpZiAoc3RhdHVzID4gMCkgeyAgLyogU3VjY2Vz
cyB0aGlzIGNvbnRyb2wgdHJhbnNmZXIuICovDQo+IC0JCWlmIChyZXF1ZXN0dHlwZSA9PSAw
eDAxKSB7DQo+IC0JCQkvKiBGb3IgQ29udHJvbCByZWFkIHRyYW5zZmVyLCB3ZSBoYXZlIHRv
IGNvcHkgdGhlIHJlYWQNCj4gLQkJCSAqIGRhdGEgZnJvbSBwSW9fYnVmIHRvIHBkYXRhLg0K
PiAtCQkJICovDQo+IC0JCQltZW1jcHkocGRhdGEsIHBJb19idWYsICBzdGF0dXMpOw0KPiAt
CQl9DQo+ICsJaWYgKHN0YXR1cyA8IDApDQo+ICsJCWdvdG8gZnJlZTsNCj4gKwlpZiAoc3Rh
dHVzICE9IGxlbikgew0KPiArCQlzdGF0dXMgPSAtRVJFTU9URUlPOw0KPiArCQlnb3RvIGZy
ZWU7DQo+ICsJfQ0KPiArCS8qIFN1Y2Nlc3MgdGhpcyBjb250cm9sIHRyYW5zZmVyLiAqLw0K
PiArCWlmIChyZXF1ZXN0dHlwZSA9PSAweDAxKSB7DQo+ICsJCS8qIEZvciBDb250cm9sIHJl
YWQgdHJhbnNmZXIsIHdlIGhhdmUgdG8gY29weSB0aGUgcmVhZA0KPiArCQkgKiBkYXRhIGZy
b20gcElvX2J1ZiB0byBwZGF0YS4NCj4gKwkJICovDQo+ICsJCW1lbWNweShwZGF0YSwgcElv
X2J1Ziwgc3RhdHVzKTsNCj4gICAJfQ0KPiArDQo+ICtmcmVlOg0KPiAgIAlrZnJlZShwYWxs
b2NfYnVmKTsNCj4gICAJcmV0dXJuIHN0YXR1czsNCj4gICB9DQoNCkFoLCBoZXJlIGl0IGlz
LiBUaGlzIHBhdGNoIHNob3VsZCBiZSAxc3QgaW4gdGhlIHNlcmllcywgc2luY2UgMS8zIG5v
dyANCmxvb2tzIGJ1Z2d5Lg0KDQoNCg0KDQpXaXRoIHJlZ2FyZHMsDQpQYXZlbCBTa3JpcGtp
bg0K

--------------z101Pc6ay5qzK0nS66vtISEO--

--------------mXZFtjjS4d1g7hinAq9qEikv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJ1EOMFAwAAAAAACgkQbk1w61LbBA3E
nRAAi2U0w1EwdR9CoPci5dwsW060wBoq6OqgdQuA/pDjbu5crB2TJeUHlinj3h96jS9DEiEvZoIl
hYmGN9XqGLhAYQCWFmjNNTwQZE2s/xiQZOitNObZO4CWx00D3cAdFYE2Rh/z5xVamMQCedQHBEo9
q8+KvjQJUYfo0tkYr5CJIYvQuiaUg/um77azE/TrX7Ma9G7/XZnnYSd+Vp57oshiLu0DsCXGgX/M
LiO1sPZkBPyguVkrv+4wdnD9iT/VRjZ89OpuP7F03e0EiAkbLXHl9dhHjBJ9iIIH8X3OpvDhYeuj
OtzsnKOrXFlzLYy/XjMe+Xg4Xve94OvIJxLwcc+nGXxoBqYPRp6fAM6d/5mf8z7lJGtOolaQKJQ7
nuFCkFV1h2PtAnuiqjACps5sMV5DQvahxfvi8UlR6CPqtWfpY0qO5NXR42t1f0iqQiMQZ3an371S
aZsGUAkxmQHKq1+5ZC3Xh9bcSd/kfte6IpDVgJDeHpeUXo0WP90DeN0QrMwcq18WDhwb3gMNbl8x
1KJmPLW77G6AOK4kz/MZJyeEbzv19loYwbZJpDKbcvTPWMqq33/XN19PEaeRi/uFw59yWDNEu2Ki
Eje8KsA+9Z+b2gxmnSxmkDJuO2OJ7DUFCk2Uti2SdLulGWKFan4ibReeCexHP5Oo6JOyrMUQwNsD
sPc=
=Ef7O
-----END PGP SIGNATURE-----

--------------mXZFtjjS4d1g7hinAq9qEikv--
