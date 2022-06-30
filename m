Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926425612C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiF3GzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiF3GzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:55:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DA31203
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:55:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 92BEF21BDB;
        Thu, 30 Jun 2022 06:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656572120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RF/ULgtrScEhpqsg3bxhvLTrzwOjtLWFPehDqVa0fCo=;
        b=qq83zVvbHqhf+2CanqC0MRm5gJI/WePJIe12XbvBwcuw9wk1WwaPqLeD/tA3pEa6gusFtr
        gj43vYHOqjqvp0vGKLMxs+mn0w839YteDNMsZl18jnaA8klwoI4yL0+uukZHil887VODhg
        6AMiCA9pJBpBnSAZgG2sS8cRNXqpK84=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EE7E139E9;
        Thu, 30 Jun 2022 06:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qm21EdhIvWLOIwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 30 Jun 2022 06:55:20 +0000
Message-ID: <1df188eb-4a31-75a3-146b-b930002c1e68@suse.com>
Date:   Thu, 30 Jun 2022 08:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220623094608.7294-1-jgross@suse.com>
 <20220623094608.7294-3-jgross@suse.com>
 <20220629171457.amdsrgaxady55hds@treble>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 2/3] x86: fix setup of brk area
In-Reply-To: <20220629171457.amdsrgaxady55hds@treble>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------As0kU50ZH0ob1d2LlJUV8Ybw"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------As0kU50ZH0ob1d2LlJUV8Ybw
Content-Type: multipart/mixed; boundary="------------PAESI0u0tYlmqcip1P1ThpgM";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <1df188eb-4a31-75a3-146b-b930002c1e68@suse.com>
Subject: Re: [PATCH v2 2/3] x86: fix setup of brk area
References: <20220623094608.7294-1-jgross@suse.com>
 <20220623094608.7294-3-jgross@suse.com>
 <20220629171457.amdsrgaxady55hds@treble>
In-Reply-To: <20220629171457.amdsrgaxady55hds@treble>

--------------PAESI0u0tYlmqcip1P1ThpgM
Content-Type: multipart/mixed; boundary="------------2e5h808bXWIRiOw5ZHQ6qSLB"

--------------2e5h808bXWIRiOw5ZHQ6qSLB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDYuMjIgMTk6MTQsIEpvc2ggUG9pbWJvZXVmIHdyb3RlOg0KPiBIaSBKdWVyZ2Vu
LA0KPiANCj4gSXQgaGVscHMgdG8gYWN0dWFsbHkgQ2MgdGhlIHBlcnNvbiB3aG8gYnJva2Ug
aXQgOy0pDQo+IA0KPiBPbiBUaHUsIEp1biAyMywgMjAyMiBhdCAxMTo0NjowN0FNICswMjAw
LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gQ29tbWl0IGUzMjY4M2M2ZjdkMiAoIng4Ni9t
bTogRml4IFJFU0VSVkVfQlJLKCkgZm9yIG9sZGVyIGJpbnV0aWxzIikNCj4+IHB1dCB0aGUg
YnJrIGFyZWEgaW50byB0aGUgLmJzcy4uYnJrIHNlY3Rpb24gKHBsYWNlZCBkaXJlY3RseSBi
ZWhpbmQNCj4+IC5ic3MpLA0KPiANCj4gSG0/IEl0IGRpZG4ndCBhY3R1YWxseSBkbyB0aGF0
Lg0KPiANCj4gRm9yIGluZGl2aWR1YWwgdHJhbnNsYXRpb24gdW5pdHMsIGl0IGRpZCByZW5h
bWUgdGhlIHNlY3Rpb24gZnJvbQ0KPiAiLmJya19yZXNlcnZhdGlvbiIgdG8gIi5ic3MuLmJy
ayIuICBCdXQgdGhlbiBkdXJpbmcgbGlua2luZyBpdCdzIHN0aWxsDQo+IHBsYWNlZCBpbiAu
YnJrIGluIHZtbGludXgsIGp1c3QgbGlrZSBiZWZvcmUuDQoNClNvcnJ5LCBJIG1pc3JlYWQg
dGhlIHBhdGNoIGNvbW1pdCBtZXNzYWdlIGFuZCB3YXMgZm9vbGVkIGJ5IHRoZSBmYWN0IHRo
YXQNCmJpc2VjdGlvbiBjbGVhcmx5IHBvaW50ZWQgYXQgdGhpcyBwYXRjaCB0byBoYXZlIGlu
dHJvZHVjZWQgdGhlIHByb2JsZW0uDQoNCkkgb25seSBkaXNjb3ZlcmVkIGxhdGVyIHRoYXQg
dGhlIG1haW4gaXNzdWUgd2FzIHRoZSBhZGRlZCAiTk9MT0FEIg0KYXR0cmlidXRlLg0KDQo+
PiBjYXVzaW5nIGl0IG5vdCB0byBiZSBjbGVhcmVkIGluaXRpYWxseS4gQXMgdGhlIGJyayBh
cmVhIGlzIHVzZWQNCj4+IHRvIGFsbG9jYXRlIGVhcmx5IHBhZ2UgdGFibGVzLCB0aGVzZSBt
aWdodCBjb250YWluIGdhcmJhZ2UgaW4gbm90DQo+PiBleHBsaWNpdGx5IHdyaXR0ZW4gZW50
cmllcy4NCj4+DQo+PiBUaGlzIGlzIGVzcGVjaWFsbHkgYSBwcm9ibGVtIGZvciBYZW4gUFYg
Z3Vlc3RzLCBhcyB0aGUgaHlwZXJ2aXNvciB3aWxsDQo+PiB2YWxpZGF0ZSBwYWdlIHRhYmxl
cyAoY2hlY2sgZm9yIHdyaXRhYmxlIHBhZ2UgdGFibGVzIGFuZCBoeXBlcnZpc29yDQo+PiBw
cml2YXRlIGJpdHMpIGJlZm9yZSBhY2NlcHRpbmcgdGhlbSB0byBiZSB1c2VkLiBUaGVyZSBo
YXZlIGJlZW4gcmVwb3J0cw0KPj4gb2YgZWFybHkgY3Jhc2hlcyBvZiBQViBndWVzdHMgZHVl
IHRvIGlsbGVnYWwgcGFnZSB0YWJsZSBjb250ZW50cy4NCj4+DQo+PiBGaXggdGhhdCBieSBs
ZXR0aW5nIGNsZWFyX2JzcygpIGNsZWFyIHRoZSBicmsgYXJlYSwgdG9vLg0KPiANCj4gV2hp
bGUgaXQgZG9lcyBtYWtlIHNlbnNlIHRvIGNsZWFyIHRoZSBicmsgYXJlYSwgSSBkb24ndCB1
bmRlcnN0YW5kIGhvdw0KPiBteSBwYXRjaCBicm9rZSB0aGlzLiAgSG93IHdhcyBpdCBnZXR0
aW5nIGNsZWFyZWQgYmVmb3JlPw0KDQpJdCBzZWVtZWQgdG8gaGF2ZSB3b3JrZWQgYnkgY2hh
bmNlLiBUaGUgWGVuIGh5cGVydmlzb3IgaXMgY2xlYXJpbmcgYWxsDQphbGxvYy1vbmx5IHNl
Y3Rpb25zIHdoZW4gbG9hZGluZyBhIGtlcm5lbCAodGhpcyB3aWxsICJmaXgiIHRoZSBkb20w
DQpjYXNlIHJlbGlhYmx5IHRvZ2V0aGVyIHdpdGggcGF0Y2ggMyBvZiB0aGlzIHNlcmllcyku
DQoNCkdydWIgbWlnaHQgZG8gdGhlIGNsZWFyaW5nLCB0b28gKGZvciB0aGUgUFYgZG9tVSBj
YXNlKSwgYnV0IEkgaGF2ZW4ndA0KdmVyaWZpZWQgdGhhdCBieSBjb2RlIGluc3BlY3Rpb24u
DQoNCkknbGwgZHJvcCB0aGUgIkZpeGVzOiIgdGFnLg0KDQoNCkp1ZXJnZW4NCg==
--------------2e5h808bXWIRiOw5ZHQ6qSLB
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

--------------2e5h808bXWIRiOw5ZHQ6qSLB--

--------------PAESI0u0tYlmqcip1P1ThpgM--

--------------As0kU50ZH0ob1d2LlJUV8Ybw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmK9SNcFAwAAAAAACgkQsN6d1ii/Ey+G
UQf+JnCTpsTiEn78EDDRe0nYXqWPAXGLTBCbA3hsMUyKSO/TpzMqrUXJzxVqxbNK0IMOfinQftuu
ybZFa2awaHzu9Gk3fBKvRt1rNGvTXd5XAgmgnOIVDhw1jxsHYcarXsN7cuIMhnrIqUAABArcdZ5K
fciHlP1RtnWwudWzye/kaU6JhFFU/geizDiIF5Owlzg28cpQX9blC/e4kl9bZUVoEgEjCa7Tfsey
FuCqz7MqAcnU1Rg2l7oqsKm/eAGeQ0RMGLuitFLyUerM9PRXy9KB7CqmIsA4Vq0xVmW+zduRqLj/
IRKJ1o96rAEIauwQyFV/aDKPIw51lLsGG4fdIKLVUA==
=uW1p
-----END PGP SIGNATURE-----

--------------As0kU50ZH0ob1d2LlJUV8Ybw--
