Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EDB509A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386258AbiDUIA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386264AbiDUIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:00:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290F214088
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:57:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D753321115;
        Thu, 21 Apr 2022 07:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650527854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZDsaqZmsX1WpM5fCrR8a4mXklVUCBN6p9dIP3+CxwgE=;
        b=sTCHxZVJFMhUSgNv/9WpNzbnD7dmmZQybsZs7SER/cVnJ2caWeKRwLK+9iIsyMFSJSrpap
        LX9eqI48H27rFdWNHohuFVxgMNwitBqsC1euICtBdZ/Ky6+m9l8S/bExdunchcMuy4lJvH
        sYpXOggBN4c3kgmRU/5vK6+FTorxVXk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB32913A84;
        Thu, 21 Apr 2022 07:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5LZ4KG4OYWKBGwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 21 Apr 2022 07:57:34 +0000
Message-ID: <c60ed330-a21b-24e1-e77d-c40f773c2298@suse.com>
Date:   Thu, 21 Apr 2022 09:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20220420150942.31235-1-jgross@suse.com>
 <20220420150942.31235-10-jgross@suse.com>
 <0d5ae87a-be43-ce7c-57b2-4567bb7e9f4d@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 09/18] xen/xenbus: add xenbus_setup_ring() service
 function
In-Reply-To: <0d5ae87a-be43-ce7c-57b2-4567bb7e9f4d@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vB2y5WggVz3Q8yeTQtMS7igE"
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vB2y5WggVz3Q8yeTQtMS7igE
Content-Type: multipart/mixed; boundary="------------6zMPaf8astR48LP1vGQmTDoa";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <c60ed330-a21b-24e1-e77d-c40f773c2298@suse.com>
Subject: Re: [PATCH 09/18] xen/xenbus: add xenbus_setup_ring() service
 function
References: <20220420150942.31235-1-jgross@suse.com>
 <20220420150942.31235-10-jgross@suse.com>
 <0d5ae87a-be43-ce7c-57b2-4567bb7e9f4d@oracle.com>
In-Reply-To: <0d5ae87a-be43-ce7c-57b2-4567bb7e9f4d@oracle.com>

--------------6zMPaf8astR48LP1vGQmTDoa
Content-Type: multipart/mixed; boundary="------------WQKVgk7KonRnY0qz39V6KC7l"

--------------WQKVgk7KonRnY0qz39V6KC7l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjIgMjA6NDQsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4gDQo+IE9uIDQv
MjAvMjIgMTE6MDkgQU0sIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiArLyoNCj4+ICsgKiB4
ZW5idXNfc2V0dXBfcmluZw0KPj4gKyAqIEBkZXY6IHhlbmJ1cyBkZXZpY2UNCj4+ICsgKiBA
dmFkZHI6IHBvaW50ZXIgdG8gc3RhcnRpbmcgdmlydHVhbCBhZGRyZXNzIG9mIHRoZSByaW5n
DQo+PiArICogQG5yX3BhZ2VzOiBudW1iZXIgb2YgcGFnZXMgdG8gYmUgZ3JhbnRlZA0KPj4g
KyAqIEBncmVmczogZ3JhbnQgcmVmZXJlbmNlIGFycmF5IHRvIGJlIGZpbGxlZCBpbg0KPj4g
KyAqDQo+PiArICogQWxsb2NhdGUgcGh5c2ljYWxseSBjb250aWd1b3VzIHBhZ2VzIGZvciBh
IHNoYXJlZCByaW5nIGJ1ZmZlciBhbmQgZ3JhbnQgaXQNCj4+ICsgKiB0byB0aGUgcGVlciBv
ZiB0aGUgZ2l2ZW4gZGV2aWNlLiBUaGUgcmluZyBidWZmZXIgaXMgaW5pdGlhbGx5IGZpbGxl
ZCB3aXRoDQo+PiArICogemVyb2VzLiBUaGUgdmlydHVhbCBhZGRyZXNzIG9mIHRoZSByaW5n
IGlzIHN0b3JlZCBhdCBAdmFkZHIgYW5kIHRoZQ0KPj4gKyAqIGdyYW50IHJlZmVyZW5jZXMg
YXJlIHN0b3JlZCBpbiB0aGUgQGdyZWZzIGFycmF5LiBJbiBjYXNlIG9mIGVycm9yIEB2YWRk
cg0KPj4gKyAqIHdpbGwgYmUgc2V0IHRvIE5VTEwgYW5kIEBncmVmcyB3aWxsIGJlIGZpbGxl
ZCB3aXRoIElOVkFMSURfR1JBTlRfUkVGLg0KPj4gKyAqLw0KPj4gK2ludCB4ZW5idXNfc2V0
dXBfcmluZyhzdHJ1Y3QgeGVuYnVzX2RldmljZSAqZGV2LCBnZnBfdCBnZnAsIHZvaWQgKip2
YWRkciwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgbnJf
cGFnZXMsIGdyYW50X3JlZl90ICpncmVmcykNCj4+ICt7DQo+PiArwqDCoMKgIHVuc2lnbmVk
IGxvbmcgcmluZ19zaXplID0gbnJfcGFnZXMgKiBYRU5fUEFHRV9TSVpFOw0KPj4gK8KgwqDC
oCB1bnNpZ25lZCBpbnQgaTsNCj4+ICvCoMKgwqAgaW50IHJldDsNCj4+ICsNCj4+ICvCoMKg
wqAgKnZhZGRyID0gYWxsb2NfcGFnZXNfZXhhY3QocmluZ19zaXplLCBnZnAgfCBfX0dGUF9a
RVJPKTsNCj4+ICvCoMKgwqAgaWYgKCEqdmFkZHIpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBy
ZXQgPSAtRU5PTUVNOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gZXJyOw0KPj4gK8KgwqDC
oCB9DQo+PiArDQo+PiArwqDCoMKgIHJldCA9IHhlbmJ1c19ncmFudF9yaW5nKGRldiwgKnZh
ZGRyLCBucl9wYWdlcywgZ3JlZnMpOw0KPj4gK8KgwqDCoCBpZiAocmV0KQ0KPj4gK8KgwqDC
oMKgwqDCoMKgIGdvdG8gZXJyOw0KPj4gKw0KPj4gK8KgwqDCoCByZXR1cm4gMDsNCj4+ICsN
Cj4+ICsgZXJyOg0KPj4gK8KgwqDCoCBpZiAoKnZhZGRyKQ0KPj4gK8KgwqDCoMKgwqDCoMKg
IGZyZWVfcGFnZXNfZXhhY3QoKnZhZGRyLCByaW5nX3NpemUpOw0KPj4gK8KgwqDCoCBmb3Ig
KGkgPSAwOyBpIDwgbnJfcGFnZXM7IGkrKykNCj4+ICvCoMKgwqDCoMKgwqDCoCBncmVmc1tp
XSA9IElOVkFMSURfR1JBTlRfUkVGOw0KPj4gK8KgwqDCoCAqdmFkZHIgPSBOVUxMOw0KPj4g
Kw0KPj4gK8KgwqDCoCByZXR1cm4gcmV0Ow0KPj4gK30NCj4gDQo+IA0KPiBXZSBjYW4gY3Jl
YXRlIGEgd3JhcHBlciBhcm91bmQgdGhpcyBmdW5jdGlvbiB0aGF0IHdpbGwgYWxzbyBjYWxs
IA0KPiBTSEFSRURfUklOR19JTklUKCkgYW5kIEZST05UX1JJTkdfSU5JVCgpLiBBIGJ1bmNo
IG9mIGRyaXZlcnMgZG8gdGhhdC4NCg0KVGhpcyB3cmFwcGVyIHdvdWxkIG5lZWQgdG8gYmUg
YSBtYWNybywgc28gSSBkZWNpZGVkIG5vdCB0byBkbyB0aGF0Lg0KDQpJdCB3b3VsZCBtYWtl
IHNlbnNlIHRvIG1lcmdlIHRoZSBjYWxsIG9mIFNIQVJFRF9SSU5HX0lOSVQoKSBpbnRvDQpG
Uk9OVF9SSU5HX0lOSVQoKSAob3IgYmV0dGVyLCBoYXZlIGEgbmV3IG1hY3JvIGNvbWJpbmlu
ZyB0aGUgdHdvKSwNCnRob3VnaCwgYXMgdGhlcmUgaXMgbm8gdXNlIGNhc2Ugb2YgRlJPTlRf
UklOR19JTklUKCkgd2l0aG91dCBhDQpjYWxsIG9mIFNIQVJFRF9SSU5HX0lOSVQoKSBkaXJl
Y3RseSBiZWZvcmUgaXQuDQoNCg0KSnVlcmdlbg0K
--------------WQKVgk7KonRnY0qz39V6KC7l
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------WQKVgk7KonRnY0qz39V6KC7l--

--------------6zMPaf8astR48LP1vGQmTDoa--

--------------vB2y5WggVz3Q8yeTQtMS7igE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJhDm4FAwAAAAAACgkQsN6d1ii/Ey/i
Swf6AoqYqbKuaciaFv0odbbSswm1dEbDVYrJGDhoPDBAqHexAFBHhPicVL7mA8O/IJ5V2x0gvdH7
F8F6EI4Tm1JcuCAgSPVy4bv81yY5hYc9mTWiz8lgjDuDORW2kiGIXMDEeAhyedFjzoypQ55vuPsz
upqDRKj/KX25o0mm6d75CkdJgQJ1dnzyOyi9FhlIWd/udnNihpq9NNVFgbQr02x3Zuzhvf2TJG8f
UzEAw9k+xxRgfsr+RazUPJJwOlJKM1wHe1j1IAcs1g1QWIdaN6ZW+HxgooKehJ1x/u/9GOf8jViq
6QPxvuVoVkq+jZOy55p0hTBpGROp0+LI3MY2cCraaQ==
=gBpF
-----END PGP SIGNATURE-----

--------------vB2y5WggVz3Q8yeTQtMS7igE--
