Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569D652CB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiESFna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiESFn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:43:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F4AEE2D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:43:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w14so7162568lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=u3+sgWQFNAfOGIZAUaDZ1UcrATcR4oti1GuI3qCNhNE=;
        b=fNNbkGT/rSdAeOwTV3gkL122nqoud/H77U4UQGh1g5HkJdugObHkCQ9yKkPwVbWV20
         sxaWWWyRtmwo1U3+JLerEr1krylWx5w+NaHekxisD4ujZAm5lnXgkipSIxfvKBOASZPQ
         WzlKrsmWvxZIp+y9gemWGYLp5LmUJ+3TlHXNqjQ5j0ijDIIG7Jer6SSeeMkPmhIb+hd+
         OW7xWKpSQMa1no0Uvk7HKVTejuKHppLqmA+PiEmCwopHTIDaP8wH3/Bw4KyyXJhmSFL6
         e5CoDuM+CYUPix4QOhnISlBBFDPEdkrGTb6kT3mzIAegxv9mf/CIyHxaL238+fu9B3Y/
         tZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=u3+sgWQFNAfOGIZAUaDZ1UcrATcR4oti1GuI3qCNhNE=;
        b=0sAlDjBWyE3LitbmcG8Y/Hf+X5TUAKVDTDrC+wDuRK2WgTBcyHgdt3RG+fPsQxZRR9
         lsWKTKay1vRqIPScmIdQTAs1mF2TPyaKT5agOaSjjrx0PJfw2nmM0KrBznKzX8s3n+/x
         vd4+TpdgUjCjbIZ0v+9FJ1UJqgKdRt/OzNbFRfBT7m5t46IpOMd7fnUB/Az8Pbol5ZaG
         WkOmA32qshSMrmPvUft9gL65vAN8VMrKQxapm6O9VBGSNsxSVUwyMCKHHN/jCKHLUNAH
         AoipLjswrgaSCf5bYuRc+1XoPGMXgTjYOMsjHLvAgNyNRQs+ymflAlOe+K+HoHk/wAKp
         uPOg==
X-Gm-Message-State: AOAM5331HX2h6kO+3GCdtMhhIyHnxmJZH+zvXXrFhZ7AOLTkZ/69qplV
        W0a2HxgoSrwcOZ6CVwK6OuA=
X-Google-Smtp-Source: ABdhPJxRplRcw3C73vdfN4WRCsou10nni5advjTFNt0DkL8+ClE/bAS6ml0yIx+dYdu+0d7gFtJDRQ==
X-Received: by 2002:ac2:518b:0:b0:471:f81b:bb9f with SMTP id u11-20020ac2518b000000b00471f81bbb9fmr2072741lfi.638.1652939005595;
        Wed, 18 May 2022 22:43:25 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id u14-20020a056512094e00b0047255d21187sm156305lft.182.2022.05.18.22.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 22:43:24 -0700 (PDT)
Message-ID: <ff322920-6ddd-159d-b2f2-c0e4fc2e518f@gmail.com>
Date:   Thu, 19 May 2022 08:43:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/4] staging: r8188eu: add error handling of rtw_read8
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <cover.1652911343.git.paskripkin@gmail.com>
 <1a9834b705054dcd0b0be0d929084c44a224abaa.1652911343.git.paskripkin@gmail.com>
 <20220519043306.GS4009@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220519043306.GS4009@kadam>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GunZfwRx57uANM4Icokey4Ry"
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GunZfwRx57uANM4Icokey4Ry
Content-Type: multipart/mixed; boundary="------------2uSj0DxMnp10C85nNLvbYSWd";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
 phil@philpotter.co.uk, straube.linux@gmail.com, fmdefrancesco@gmail.com,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Message-ID: <ff322920-6ddd-159d-b2f2-c0e4fc2e518f@gmail.com>
Subject: Re: [PATCH 1/4] staging: r8188eu: add error handling of rtw_read8
References: <cover.1652911343.git.paskripkin@gmail.com>
 <1a9834b705054dcd0b0be0d929084c44a224abaa.1652911343.git.paskripkin@gmail.com>
 <20220519043306.GS4009@kadam>
In-Reply-To: <20220519043306.GS4009@kadam>

--------------2uSj0DxMnp10C85nNLvbYSWd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRGFuLA0KDQpPbiA1LzE5LzIyIDA3OjMzLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBP
biBUaHUsIE1heSAxOSwgMjAyMiBhdCAwMToxMTo1MUFNICswMzAwLCBQYXZlbCBTa3JpcGtp
biB3cm90ZToNCj4+IEBAIC0yNDAsMTIgKzI1OSwxNCBAQCBpbnQgcnRsODE4OGVfZmlybXdh
cmVfZG93bmxvYWQoc3RydWN0IGFkYXB0ZXIgKnBhZGFwdGVyKQ0KPj4gIHsNCj4+ICAJaW50
IHJldCA9IF9TVUNDRVNTOw0KPj4gIAl1OCB3cml0ZV9md19yZXRyeSA9IDA7DQo+PiArCXU4
IHJlZzsNCj4+ICAJdW5zaWduZWQgbG9uZyBmd2RsX3RpbWVvdXQ7DQo+PiAgCXN0cnVjdCBk
dm9ial9wcml2ICpkdm9iaiA9IGFkYXB0ZXJfdG9fZHZvYmoocGFkYXB0ZXIpOw0KPj4gIAlz
dHJ1Y3QgZGV2aWNlICpkZXZpY2UgPSBkdm9ial90b19kZXYoZHZvYmopOw0KPj4gIAlzdHJ1
Y3QgcnRfZmlybXdhcmVfaGRyICpmd2hkciA9IE5VTEw7DQo+PiAgCXU4ICpmd19kYXRhOw0K
Pj4gIAl1MzIgZndfc2l6ZTsNCj4+ICsJaW50IHJlczsNCj4+ICANCj4+ICAJaWYgKCFkdm9i
ai0+ZmlybXdhcmUuZGF0YSkNCj4+ICAJCXJldCA9IGxvYWRfZmlybXdhcmUoJmR2b2JqLT5m
aXJtd2FyZSwgZGV2aWNlKTsNCj4+IEBAIC0yNjksNyArMjkwLDExIEBAIGludCBydGw4MTg4
ZV9maXJtd2FyZV9kb3dubG9hZChzdHJ1Y3QgYWRhcHRlciAqcGFkYXB0ZXIpDQo+PiAgDQo+
PiAgCS8qICBTdWdnZXN0ZWQgYnkgRmlsZW4uIElmIDgwNTEgaXMgcnVubmluZyBpbiBSQU0g
Y29kZSwgZHJpdmVyIHNob3VsZCBpbmZvcm0gRncgdG8gcmVzZXQgYnkgaXRzZWxmLCAqLw0K
Pj4gIAkvKiAgb3IgaXQgd2lsbCBjYXVzZSBkb3dubG9hZCBGdyBmYWlsLiAyMDEwLjAyLjAx
LiBieSB0eW5saS4gKi8NCj4+IC0JaWYgKHJ0d19yZWFkOChwYWRhcHRlciwgUkVHX01DVUZX
REwpICYgUkFNX0RMX1NFTCkgeyAvKiA4MDUxIFJBTSBjb2RlICovDQo+PiArCXJlcyA9IHJ0
d19yZWFkOChwYWRhcHRlciwgUkVHX01DVUZXREwsICZyZWcpOw0KPj4gKwlpZiAocmVzKQ0K
Pj4gKwkJZ290byBleGl0Ow0KPiANCj4gWW91IGRpZG4ndCBpbnRyb2R1Y2UgdGhpcyBidWcs
IGJ1dCB0aGlzIHBhdGggbmVlZHMgdG8gaGF2ZSBhbiBlcnJvciBjb2RlDQo+IHNldC4gIEFs
c28gd2UgcmVhbGx5IG5lZWQgdG8gZ2V0IHJpZCBvZiB0aGUgX0ZBSUwgZ2FyYmFnZS4gIFdo
ZW4gSSBzYXcNCj4gdGhpcywgSSBnb3QgInJldCIgYW5kICJyZXMiIG1peGVkIHVwIHNvIEkg
dGhvdWdodCB3ZSB3ZXJlIHJldHVybmluZw0KPiBuZWdhdGl2ZSBlcnJvciBjb2RlcyBpbnN0
ZWFkIG9mIF9GQUlMLiAgVGhhdCB3b3VsZCAgIEJ1dCB0aGVuIEkgc2F3IHdlDQo+IGFyZSBy
ZXR1cm5pbmcgc3VjY2Vzcy4NCj4gDQoNCkkgc2VlIG5vdywgdGhhdCAncmVzJyBhbmQgJ3Jl
dCcgZ290IG1peGVkIHVwIGluIG15IG1pbmQgdG9vLiBXaWxsIGZpeCB1cA0KDQoNCj4+ICsN
Cj4+ICsJaWYgKHJlZyAmIFJBTV9ETF9TRUwpIHsgLyogODA1MSBSQU0gY29kZSAqLw0KPj4g
IAkJcnR3X3dyaXRlOChwYWRhcHRlciwgUkVHX01DVUZXREwsIDB4MDApOw0KPj4gIAkJcnR3
X3Jlc2V0XzgwNTEocGFkYXB0ZXIpOw0KPj4gIAl9DQo+PiBAQCAtMjc4LDcgKzMwMywxNCBA
QCBpbnQgcnRsODE4OGVfZmlybXdhcmVfZG93bmxvYWQoc3RydWN0IGFkYXB0ZXIgKnBhZGFw
dGVyKQ0KPj4gIAlmd2RsX3RpbWVvdXQgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcyg1
MDApOw0KPj4gIAl3aGlsZSAoMSkgew0KPj4gIAkJLyogcmVzZXQgdGhlIEZXREwgY2hrc3Vt
ICovDQo+PiAtCQlydHdfd3JpdGU4KHBhZGFwdGVyLCBSRUdfTUNVRldETCwgcnR3X3JlYWQ4
KHBhZGFwdGVyLCBSRUdfTUNVRldETCkgfCBGV0RMX0NIS1NVTV9SUFQpOw0KPj4gKwkJcmVz
ID0gcnR3X3JlYWQ4KHBhZGFwdGVyLCBSRUdfTUNVRldETCwgJnJlZyk7DQo+PiArCQlpZiAo
cmVzID09IC1FTk9ERVYpDQo+PiArCQkJYnJlYWs7DQo+PiArDQo+PiArCQlpZiAocmVzKQ0K
Pj4gKwkJCWNvbnRpbnVlOw0KPiANCj4gVGhpcyBjb250aW51ZSBpcyB3cm9uZy4gIElmIHJl
cyA9IC1FUEVSTSB0aGVuIGl0J3MgYSBmb3JldmVyIGxvb3AuDQo+IExldCdzIGp1c3QgYnJl
YWsgZm9yIGV2ZXJ5IGVycm9yLg0KPiANCg0KSSB3YXMgdHJ5aW5nIHRvIGF2b2lkIHN0cmlj
dCBicmVha2luZyB0aGUgbG9vcCBvbiBhbnkgZXJyb3IsIHNpbmNlIEkgYW0gDQphZnJhaWQg
dGhpcyBtaWdodCBicmVhayB0aGUgZHJpdmVyLg0KDQpXaGF0IGFib3V0Og0KDQoJZG8gew0K
CQkvKiByZXNldCB0aGUgRldETCBjaGtzdW0gKi8NCgkJcmV0ID0gcnR3X3JlYWQ4KHBhZGFw
dGVyLCBSRUdfTUNVRldETCwgJnJlZyk7DQoJCWlmIChyZXQgPT0gLUVOT0RFViB8fCByZXQg
PT0gLUVQRVJNKQ0KCQkJYnJlYWs7DQoNCgkJaWYgKHJldCkgew0KCQkJcmV0ID09IF9GQUlM
Ow0KCQkJY29udGludWU7DQoJCX0NCg0KCQlydHdfd3JpdGU4KHBhZGFwdGVyLCBSRUdfTUNV
RldETCwgcmVnIHwgRldETF9DSEtTVU1fUlBUKTsNCg0KCQlyZXQgPSB3cml0ZV9mdyhwYWRh
cHRlciwgZndfZGF0YSwgZndfc2l6ZSk7DQoJfSB3aGlsZSAoIShyZXQgPT0gX1NVQ0NFU1Mg
fHwNCgkJICAgICh0aW1lX2FmdGVyKGppZmZpZXMsIGZ3ZGxfdGltZW91dCkgJiYgd3JpdGVf
ZndfcmV0cnkrKyA+PSAzKSkpDQoNClRoZSBpZGVhIGlzIHRvIGJyZWFrIG9ubHkgb24gZmF0
YWwgZXJyb3JzIHRvIG1ha2UgdGhpbmdzIGxlc3Mgc3RyaWN0DQoNCg0KDQoNCldpdGggcmVn
YXJkcywNClBhdmVsIFNrcmlwa2luDQo=

--------------2uSj0DxMnp10C85nNLvbYSWd--

--------------GunZfwRx57uANM4Icokey4Ry
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmKF2PsFAwAAAAAACgkQbk1w61LbBA23
Bg/9GszjpUZIXl5vvWj1SmgQZhzXuRFPrGTVM0fUfCy8af4aeStmuBHpxfFZ8V4A7LHo2Od2ztun
6NYvaXKui9JPsXwwsUpVuzHNVq7BCeTMs001z71BoXOgxMEfF1u1BZAPX0nwG1OnSPY8w7QreE7e
IOWRwokzheXk7Ux7nzEK8UuAz4eVDlZTeeO9ZKkXVIjkily6rwjZceND64b+nFmFk1JIyAKlQMKR
ibyiWq08jGxroOJJFGmVE8FNm+WlQ7YrbWTu//bF9K3qPYpuPz8Ro61kqXuAzzJMJviT/Ao0ob/l
5qwIT7aF5b5sK5rbjwB10JmBaF+g8W3BEbsOaZL3xNsKmqV5oZR2qmDxCxRoyhXWS/ARoybuFeXk
XGzNz0i6tw4OTYwRKkZkyKC8J+wvWnMCgtE3OT55FGIONreOWizR9I6yJh66ohOSbCU6duQ54YBP
/L4ftmwTo0eqJsMes/FAELNZgynQPZZDZWAVJfGfxvgqtTEcH9EoeyCht57XqjTAsBMN/ZBtwMMi
PByjY2/EK2Yzfm5j2/UsfevRDv+gvh5XQ37UsbDpVmlD9VyD01YuKYVfg8xxJRZQnUzFxkWI75ZC
DsKSrN7g/AXBD09Kxd/5d3kyhmqOC5EZF1op2gcC5QqGazH/O638bSU14/D1Brr/R7ERPPK3pCLo
sA0=
=rxsY
-----END PGP SIGNATURE-----

--------------GunZfwRx57uANM4Icokey4Ry--
