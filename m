Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2379E551445
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiFTJ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbiFTJ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:26:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E4B13D10;
        Mon, 20 Jun 2022 02:25:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB70B21BE8;
        Mon, 20 Jun 2022 09:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655717157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XBlrnCPI0/xnKQl5KGOw1GKuAPUdEdNPBNt5Ay7eoOI=;
        b=dO1NomBeWvEiR64l5uqRAzuOJp2LW7O9huaXuOE7OZQA3ErfInF/7fJLx5SO2xr6kxNqFU
        hjIlOZoc4Nwx95JABhhgUfRNjUSwddfrShPH8m7hWtNla0B1iXsbXkKdfyf5VsKFiIOogb
        gIhnm+uoNJtjqJfOK+Yge+1vm5DkQZs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64040134CA;
        Mon, 20 Jun 2022 09:25:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GQ4iFiU9sGJqQwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 20 Jun 2022 09:25:57 +0000
Message-ID: <c9a84a02-ca69-fc2a-c738-a796b7197693@suse.com>
Date:   Mon, 20 Jun 2022 11:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] s390/kvm: avoid hypfs error message
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20220607123314.10255-1-jgross@suse.com>
 <5431f626-9bd3-ed54-9889-aafbba9ca3e0@suse.com>
 <9ef06123-b44f-b009-5bf5-60ad27bbede7@linux.ibm.com>
 <YrA7lHb38Sj74+4U@osiris>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <YrA7lHb38Sj74+4U@osiris>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4wvW5BnLWg4RPNnojLZUqMbV"
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
--------------4wvW5BnLWg4RPNnojLZUqMbV
Content-Type: multipart/mixed; boundary="------------lg4ubjF34QQKveTbJfDlqdPS";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
Message-ID: <c9a84a02-ca69-fc2a-c738-a796b7197693@suse.com>
Subject: Re: [PATCH] s390/kvm: avoid hypfs error message
References: <20220607123314.10255-1-jgross@suse.com>
 <5431f626-9bd3-ed54-9889-aafbba9ca3e0@suse.com>
 <9ef06123-b44f-b009-5bf5-60ad27bbede7@linux.ibm.com>
 <YrA7lHb38Sj74+4U@osiris>
In-Reply-To: <YrA7lHb38Sj74+4U@osiris>

--------------lg4ubjF34QQKveTbJfDlqdPS
Content-Type: multipart/mixed; boundary="------------OTD3babxZnoRhlLyvx66oRE3"

--------------OTD3babxZnoRhlLyvx66oRE3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDYuMjIgMTE6MTksIEhlaWtvIENhcnN0ZW5zIHdyb3RlOg0KPiBPbiBNb24sIEp1
biAyMCwgMjAyMiBhdCAwOToxODozN0FNICswMjAwLCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIg
d3JvdGU6DQo+PiBBbSAyMC4wNi4yMiB1bSAwODowMyBzY2hyaWViIEp1ZXJnZW4gR3Jvc3M6
DQo+Pj4gUGluZz8NCj4+Pg0KPj4+IE9uIDA3LjA2LjIyIDE0OjMzLCBKdWVyZ2VuIEdyb3Nz
IHdyb3RlOg0KPj4+PiBXaGVuIGJvb3RpbmcgdW5kZXIgS1ZNIHRoZSBmb2xsb3dpbmcgZXJy
b3IgbWVzc2FnZXMgYXJlIGlzc3VlZDoNCj4+Pj4NCj4+Pj4gaHlwZnMuN2Y1NzA1OiBUaGUg
aGFyZHdhcmUgc3lzdGVtIGRvZXMgbm90IHN1cHBvcnQgaHlwZnMNCj4+Pj4gaHlwZnMuN2E3
OWYwOiBJbml0aWFsaXphdGlvbiBvZiBoeXBmcyBmYWlsZWQgd2l0aCByYz0tNjENCj4+Pj4N
Cj4+Pj4gV2hpbGUgYmVpbmcgZG9jdW1lbnRlZCwgdGhleSBjYW4gZWFzaWx5IGJlIGF2b2lk
ZWQgYnkgYmFpbGluZyBvdXQgb2YNCj4+Pj4gaHlwZnNfaW5pdCgpIGVhcmx5IGluIGNhc2Ug
b2YgcnVubmluZyBhcyBhIEtWTSBndWVzdC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
SnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIMKgIGFy
Y2gvczM5MC9oeXBmcy9pbm9kZS5jIHwgMyArKysNCj4+Pj4gIMKgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvczM5MC9o
eXBmcy9pbm9kZS5jIGIvYXJjaC9zMzkwL2h5cGZzL2lub2RlLmMNCj4+Pj4gaW5kZXggNWM5
N2Y0OGNlYTkxLi5iZGYwNzhmM2M2NDEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2FyY2gvczM5MC9o
eXBmcy9pbm9kZS5jDQo+Pj4+ICsrKyBiL2FyY2gvczM5MC9oeXBmcy9pbm9kZS5jDQo+Pj4+
IEBAIC00NjQsNiArNDY0LDkgQEAgc3RhdGljIGludCBfX2luaXQgaHlwZnNfaW5pdCh2b2lk
KQ0KPj4+PiAgwqAgew0KPj4+PiAgwqDCoMKgwqDCoCBpbnQgcmM7DQo+Pj4+ICvCoMKgwqAg
aWYgKE1BQ0hJTkVfSVNfS1ZNKQ0KPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9E
QVRBOw0KPj4+PiArDQo+Pj4+ICDCoMKgwqDCoMKgIGh5cGZzX2RiZnNfaW5pdCgpOw0KPj4+
PiAgwqDCoMKgwqDCoCBpZiAoaHlwZnNfZGlhZ19pbml0KCkpIHsNCj4+DQo+PiBJbiBjYXNl
IEtWTSBpbXBsZW1lbnRzIGh5cGZzIHRoaXMgY2hlY2sgd291bGQgdGhlbiBiZSB3cm9uZy4N
Cj4+IFF1ZXN0aW9uIHRvIHBlb3BsZSBvbiBDQy9UTy4NCj4+IFdvdWxkIGl0IGJlIGFuIG9w
dGlvbiB0byBzdGlsbCBjaGVjayB3aXRoIEtWTSBidXQgYXZvaWQgdGhlIGVycm9yIG1lc3Nh
Z2UuDQo+PiBTbyBiYXNpY2FsbHkgY2hhbmdpbmcgaHlwZnNfZGlhZ19pbml0IGFuZCBmYWls
X2RiZnNfZXhpdCB0byBjaGVjaw0KPj4gZm9yIEtWTSBvbiBlcnJvcj8NCj4+IE9yIGlzIHRo
aXMgd29yc2U/DQo+IA0KPiBJJ2Qgc2F5IGp1c3QgbW92ZSB0aGUgcHJfZXJyKCJJbml0aWFs
aXphdGlvbiBvZiBoeXBmcyBmYWlsZWQgd2l0aC4uLiIpDQo+IG9uZSBsYWJlbCBhYm92ZSB0
byBmYWlsX2h5cGZzX2RpYWdfZXhpdC4gVGhlbiB3ZSBzdGlsbCBnZXQgdGhlIG1lc3NhZ2UN
Cj4gdGhhdCB0aGUgaGFyZHdhcmUgc3lzdGVtIGRvZXNuJ3Qgc3VwcG9ydCBoeXBmcywgd2hp
Y2ggc2VlbXMgdG8gYmUNCj4gd2FudGVkLCBhbmQgdGhlIGVycm9yIG1lc3NhZ2Ugb25seSBh
cHBlYXJzIGZvciBhbiBlcnJvci4NCj4gDQo+IEV2ZW4gdGhvdWdoIEkgcGVyc29uYWxseSBk
aXNsaWtlIHByaW50aW5nIGV2ZXJ5dGhpbmcgdG8gdGhlIGNvbnNvbGUNCj4gdGhpcyBzZWVt
cyB0byBiZSB3aGF0IGlzL3dhcyBwcmVmZXJyZWQuIFNvIGxldCdzIGtlZXAgdGhhdC4NCg0K
V29ya3MgZm9yIG1lLg0KDQpXb3VsZCB5b3UgYmUgZmluZSB3aXRoIGFkZGl0aW9uYWxseToN
Cg0KQEAgX19pbml0IGludCBoeXBmc19kaWFnX2luaXQodm9pZCkNCiAgICAgICAgICBpbnQg
cmM7DQoNCiAgICAgICAgICBpZiAoZGlhZzIwNF9wcm9iZSgpKSB7DQotICAgICAgICAgICAg
ICAgIHByX2VycigiVGhlIGhhcmR3YXJlIHN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IGh5cGZz
XG4iKTsNCisgICAgICAgICAgICAgICAgcHJfaW5mbygiVGhlIGhhcmR3YXJlIHN5c3RlbSBk
b2VzIG5vdCBzdXBwb3J0IGh5cGZzXG4iKTsNCiAgICAgICAgICAgICAgICAgIHJldHVybiAt
RU5PREFUQTsNCiAgICAgICAgICB9DQoNCkFzIHRoaXMgbm90IHJlYWxseSBhbiBlcnJvci4N
Cg0KDQpKdWVyZ2VuDQo=
--------------OTD3babxZnoRhlLyvx66oRE3
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------OTD3babxZnoRhlLyvx66oRE3--

--------------lg4ubjF34QQKveTbJfDlqdPS--

--------------4wvW5BnLWg4RPNnojLZUqMbV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKwPSQFAwAAAAAACgkQsN6d1ii/Ey/8
9gf/UyomhLFdZjBJiJk1gD884zBzv+SMVCnUqOc0z8LFBfwxw6xMAEC16lXezMjGBSTMdUJQ2Xtg
zixPguGJUXP9uhVaoahWiK0Sb0KMUKAvwusTS69iRzVqIu+PJYj0sk+p+PYcHoDmC0cWEMA/rMcH
WJcLpm+SB1P6cgSCeT+JDmlri39tLCX1zszO577CKgXv1cQUOGPCLKKMNVbT66F0+MV5zIt/2bca
NMCKoEMfUFWelfzk4M5j2ZkIg9PbXwhUF0juOXxrybG7O0T68GRz6rAkmysMiRifTM4pqfd2MngZ
vX6Dip+EJ1JI8TwtOEzAqIcPCvKwFeGBZlsWe68Neg==
=I2YW
-----END PGP SIGNATURE-----

--------------4wvW5BnLWg4RPNnojLZUqMbV--
