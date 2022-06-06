Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0656553EE2D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiFFSwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiFFSwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:52:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A09237DA;
        Mon,  6 Jun 2022 11:52:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so8355573wms.3;
        Mon, 06 Jun 2022 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=M6a0QX9jnoEdjA2xipAqhJj4OHRbKSKkjBpi1Q71zkw=;
        b=An2Fq9Cgiv7dS39/rRr8JJvUL0wzuKZzHtevrGq5ao7maT7ehzgxTNJ463z+rfCoYz
         pLRPs0MKmVkOGzjdKc8736CVfkOOr3uJooha3JjYS9a4hxYzpGhOkNeczVPmpVh2f/Js
         BXJlTkG5PCstSAklrKZxAsBIm/NAvYXFoNHwmWtpBsDn1NEfEk5bXNoxLWbjWjzccnOY
         n+ppBnOkepLCeWurIGstXNveUvSZWfuhXXPHeKsIsiaktor6GUBr9xaSVeV/j/RPlkmI
         JjSSHidmnASBOBL2suWzMcItzuZBYKHcjjbBybc+OQ6Lq4QtENCyLooarGo+Y8C+xMNO
         vGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=M6a0QX9jnoEdjA2xipAqhJj4OHRbKSKkjBpi1Q71zkw=;
        b=gIU978Wb+0HVE3+NWp7ZWX6dQs5IHjyQ/bVtb0E5DhXU/0D8uiT2IRORK4zKhWfiH7
         KHDxsZNZP8HLeODu0FspRofGfOLKjyYcHaHXgrCCOeRzzZBYREnMzVIGEGT039Zlkge1
         VsCaylwQGYDYLPrk1aOeIKctYfAaVYDUQW5PZADfcvyXFjQehP8xJkC/xU/YH+F0ZvUX
         2GnjPWLoGbsdIqXxFuaortwcG+888CPYCDlyotymOazXCmHjwIO0wJd3hqhQ2JbaehrA
         F7//HUn/HIuyTNnQgLgR609zagWZCpWs0+wCg85H42cX2UfT6ZXFL3/eVH8XUl9urNLV
         xNsw==
X-Gm-Message-State: AOAM533VcDAE16au2gSLSgA4VXCG/PjtQHHDVUtxXRlh/tJIJ1n8JFuv
        z+qhC4vyKNsa8LqovyIIqjErn5f+Yj4=
X-Google-Smtp-Source: ABdhPJxL88zPMc2YwX5Y3sRHTEk08zYhFtRrqmqrgrsP/aFnWahRoUrtv9+8YsV5aR5KVBWuYzLRCA==
X-Received: by 2002:a05:600c:3b89:b0:39c:490b:888b with SMTP id n9-20020a05600c3b8900b0039c490b888bmr11955984wms.77.1654541558023;
        Mon, 06 Jun 2022 11:52:38 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b00397402ae674sm24054673wmg.11.2022.06.06.11.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 11:52:37 -0700 (PDT)
Message-ID: <7acfdeb8-5dd3-dfe2-5717-b64006281a8f@gmail.com>
Date:   Mon, 6 Jun 2022 20:52:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 0/2] userfaultfd.2: Update to latest
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220603173736.62581-1-peterx@redhat.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220603173736.62581-1-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------S4iKNrDaEAMWEo1KEA79P3tm"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------S4iKNrDaEAMWEo1KEA79P3tm
Content-Type: multipart/mixed; boundary="------------f3m4KdN8yVxEIMZh03cLij5N";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-man@vger.kernel.org, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, Nadav Amit
 <nadav.amit@gmail.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Message-ID: <7acfdeb8-5dd3-dfe2-5717-b64006281a8f@gmail.com>
Subject: Re: [PATCH v2 0/2] userfaultfd.2: Update to latest
References: <20220603173736.62581-1-peterx@redhat.com>
In-Reply-To: <20220603173736.62581-1-peterx@redhat.com>

--------------f3m4KdN8yVxEIMZh03cLij5N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUGV0ZXIsDQoNCk9uIDYvMy8yMiAxOTozNywgUGV0ZXIgWHUgd3JvdGU6DQo+IHYyOg0K
PiAtIFVzZSBzZW1hbnRpYyBuZXdsaW5lcyBhbHdheXMgaW4gcGF0Y2ggMSBbQWxleF0NCj4g
LSBGaXggcy8uQlIvLkIvIGluIHBhdGNoIDIgW0FsZXhdDQo+IC0gUmViYXNlZCB0byBodHRw
Oi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzL3NyYy9hbHgvbGludXgvbWFuLXBhZ2VzL21h
bi1wYWdlcy5naXQNCj4gDQo+IEFkZCB0aGUgdHdvIG1pc3NpbmcgcGllY2VzIHRpbGwgbGF0
ZXN0IDUuMTktcmMxOiB0aGUgVUZGRF9VU0VSX01PREVfT05MWQ0KPiBmbGFnLCBhbmQgYWxz
byB0aGUgcmVjZW50IHdyLXByb3RlY3Qgc3VwcG9ydCBvbiBzaG1lbSBhbmQgaHVnZXRsYmZz
Lg0KPiANCj4gUGxlYXNlIHJldmlldywgdGhhbmtzLg0KPiANCj4gUGV0ZXIgWHUgKDIpOg0K
PiAgICB1c2VyZmF1bHRmZC4yOiBBZGQgc2VjdGlvbiBmb3IgVUZGRF9VU0VSX01PREVfT05M
WQ0KPiAgICB1c2VyZmF1bHRmZC4yOiBVcGRhdGUgb24gd3JpdGUtcHJvdGVjdGlvbiBzdXBw
b3J0DQo+IA0KPiAgIG1hbjIvdXNlcmZhdWx0ZmQuMiB8IDIzICsrKysrKysrKysrKysrKysr
Ky0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KDQoNCkkgdGhpbmsgdGhlIHBhdGNoIGJlbG93IHdvdWxkIGltcHJvdmUg
YSBsaXR0bGUgYml0IHRoZSB3b3JkaW5nIChhbmQgDQpuZXdsaW5lcykuICBJIHN0aWxsIGhh
dmUgYSBiaXQgb2YgdHJvdWJsZSB1bmRlcnN0YW5kaW5nICJXaGVuIGEgDQprZXJuZWwtb3Jp
Z2luYXRlZCBmYXVsdCB3YXMgdHJpZ2dlcmVkIG9uIHRoZSByZWdpc3RlcmVkIHJhbmdlIHdp
dGggdGhpcyANCnVzZXJmYXVsdGZkIi4gIERpZCB5b3UgbWF5YmUgbWVhbiAicmFuZ2UgcmVn
aXN0ZXJlZCIgaW5zdGVhZCBvZiANCiJyZWdpc3RlcmVkIHJhbmdlIj8NCg0KVGhhbmtzLA0K
DQpBbGV4DQoNCg0KZGlmZiAtLWdpdCBhL21hbjIvdXNlcmZhdWx0ZmQuMiBiL21hbjIvdXNl
cmZhdWx0ZmQuMg0KaW5kZXggOWI1ZWMwMzU4Li4wYzBhNGY2ODcgMTAwNjQ0DQotLS0gYS9t
YW4yL3VzZXJmYXVsdGZkLjINCisrKyBiL21hbjIvdXNlcmZhdWx0ZmQuMg0KQEAgLTYyLDEx
ICs2MiwxMSBAQCBmbGFnIGluDQogIC5CUiBvcGVuICgyKS4NCiAgLlRQDQogIC5CIFVGRkRf
VVNFUl9NT0RFX09OTFkNCi1UaGlzIGlzIGFuIHVzZXJmYXVsdGZkIHNwZWNpZmljIGZsYWcg
dGhhdCB3YXMgaW50cm9kdWNlZCBzaW5jZSBMaW51eCA1LjExLg0KLVdoZW4gc2V0LCB0aGUg
dXNlcmZhdWx0ZmQgb2JqZWN0IHdpbGwgb25seSBiZSBhYmxlIHRvIGhhbmRsZSBwYWdlIGZh
dWx0cw0KLW9yaWdpbmF0ZWQgZnJvbSB0aGUgdXNlcnNwYWNlIG9uIHRoZSByZWdpc3RlcmVk
IHJlZ2lvbnMuDQotV2hlbiBhIGtlcm5lbCBvcmlnaW5hdGVkIGZhdWx0IHdhcyB0cmlnZ2Vy
ZWQgb24gdGhlIHJlZ2lzdGVyZWQgcmFuZ2Ugd2l0aA0KLXRoaXMgdXNlcmZhdWx0ZmQsIGEN
CitUaGlzIGlzIGFuIHVzZXJmYXVsdGZkLXNwZWNpZmljIGZsYWcgdGhhdCB3YXMgaW50cm9k
dWNlZCBpbiBMaW51eCA1LjExLg0KK1doZW4gc2V0LCB0aGUgdXNlcmZhdWx0ZmQgb2JqZWN0
IHdpbGwgb25seSBiZSBhYmxlIHRvIGhhbmRsZQ0KK3BhZ2UgZmF1bHRzIG9yaWdpbmF0ZWQg
ZnJvbSB0aGUgdXNlciBzcGFjZSBvbiB0aGUgcmVnaXN0ZXJlZCByZWdpb25zLg0KK1doZW4g
YSBrZXJuZWwtb3JpZ2luYXRlZCBmYXVsdCB3YXMgdHJpZ2dlcmVkDQorb24gdGhlIHJlZ2lz
dGVyZWQgcmFuZ2Ugd2l0aCB0aGlzIHVzZXJmYXVsdGZkLCBhDQogIC5CIFNJR0JVUw0KICBz
aWduYWwgd2lsbCBiZSBkZWxpdmVyZWQuDQogIC5QUA0KQEAgLTI3Nyw4ICsyNzcsOSBAQCBp
b2N0bCBhZ2FpbnN0IHRoZSBmZWF0dXJlIGJpdA0KICAuQiBVRkZEX0ZFQVRVUkVfUEFHRUZB
VUxUX0ZMQUdfV1ANCiAgYmVmb3JlIHVzaW5nIHRoaXMgZmVhdHVyZS4NCiAgLlBQDQotU2lu
Y2UgTGludXggNS4xOSwgdGhlIHdyaXRlLXByb3RlY3Rpb24gbW9kZSB3YXMgYWxzbyBzdXBw
b3J0ZWQgb24gc2htZW0gDQphbmQgaHVnZXRsYmZzDQotbWVtb3J5IHR5cGVzLg0KK1NpbmNl
IExpbnV4IDUuMTksDQordGhlIHdyaXRlLXByb3RlY3Rpb24gbW9kZSB3YXMgYWxzbyBzdXBw
b3J0ZWQgb24NCitzaG1lbSBhbmQgaHVnZXRsYmZzIG1lbW9yeSB0eXBlcy4NCiAgSXQgY2Fu
IGJlIGRldGVjdGVkIHdpdGggdGhlIGZlYXR1cmUgYml0DQogIC5CUiBVRkZEX0ZFQVRVUkVf
V1BfSFVHRVRMQkZTX1NITUVNIC4NCiAgLlBQDQoNCg0KLS0gDQpBbGVqYW5kcm8gQ29sb21h
cg0KPGh0dHA6Ly93d3cuYWxlamFuZHJvLWNvbG9tYXIuZXMvPg0K

--------------f3m4KdN8yVxEIMZh03cLij5N--

--------------S4iKNrDaEAMWEo1KEA79P3tm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmKeTOkACgkQnowa+77/
2zKmHxAAnYf5WvOx8pulh1lQX2hHZAWWTeqeXagGTRNOZzGWhXuAYiXGvjTQPoZI
H2Ya72QruPB3Tu6tx05teSnBK+m+kNEO8v1bN4SGqJOFJ01jCyUDUxNQU7fOv8mE
F9gKwZtHYFOqiW2pRNhsRyNpiGuAgEth+n68YVLE9jbZiQtb7CqBUnVTLoTnO8E3
TUfgL4Y5/ddJGYtWva/H2vJ52qfzpvrG14zgi0ASmArMuo+K4uKiIZAn7am1Gl0N
+JhPYf72piijV2ls57Iaj7tJOguUceLGKs/MdrMP4bB1QdHJnUi+g9j2NHAHbcoB
xgw1HyyIADf/Jxqr66G0qhntZM5TruBGmLPUFaOuMKgYEyeYYU4AlDy/rDklqiSU
2lkQKOFW+wORlye5kJB/riPbPAhtKu1y9u4qjjOO3GSFTndNVqWJ00ZAcj7JKd1m
OfRjHV+AIs00ylG0Zflb8KA9T7m9CeNDss+5iggpfDp8IHZ8G7ZYpHUya5uZ7MOF
p/LZDQE/HiKTnE5p1Kl0VoJax6MgmEvFnjY9I0H4whsx+YnKUDNuSpmQPYHWIfOV
qhtboF7WsBWN02RmI8UNHqGoTH8n/1tHaxP5l43BxnB7L9y6DQk3k7QLRMme1MAm
3gV76s+hw4xQ7rtnIUkKMYb/u9AnLtcxFkgxQk8dKOYAnu6QL5s=
=Yvs8
-----END PGP SIGNATURE-----

--------------S4iKNrDaEAMWEo1KEA79P3tm--
