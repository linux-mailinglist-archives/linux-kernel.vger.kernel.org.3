Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59C8509D49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383823AbiDUKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiDUKQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:16:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBB938B5;
        Thu, 21 Apr 2022 03:13:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D3EB21100;
        Thu, 21 Apr 2022 10:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650535995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iTHgU/VhRSYINu0e4T89zlNvUmi6qAAkVLRmZM6LFy4=;
        b=fLK/bCzL6N4pKlVEnPBdiSOKnJDrosHyJRKfKSYy195AcKfYXo2NJDqpHvpPp1Aj+MSoWX
        IKrioCdTwXCuw890w9BKEX41jL5vl5VCkwfmT5dvDMOYZ8qFiuOyboS0ru5qthKOgDFmHh
        rA2lhyttvLU5TD+14XfN365K3zA1QJ0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27E5213A84;
        Thu, 21 Apr 2022 10:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RQFzCDsuYWLIWAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 21 Apr 2022 10:13:15 +0000
Message-ID: <9d8c453b-7147-d80c-3d4f-666a3b530929@suse.com>
Date:   Thu, 21 Apr 2022 12:13:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] xen/scsifront: harden driver against malicious
 backend
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20220420092503.11123-1-jgross@suse.com>
 <20220420092503.11123-5-jgross@suse.com>
 <00c1cd38-5164-edfa-6c47-606803629dcf@oracle.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <00c1cd38-5164-edfa-6c47-606803629dcf@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bOVcQ0bMgi1fIjeAQlOPmOe5"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bOVcQ0bMgi1fIjeAQlOPmOe5
Content-Type: multipart/mixed; boundary="------------H0kwBUjQOfwijdKXCQgtrTrx";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <9d8c453b-7147-d80c-3d4f-666a3b530929@suse.com>
Subject: Re: [PATCH 4/4] xen/scsifront: harden driver against malicious
 backend
References: <20220420092503.11123-1-jgross@suse.com>
 <20220420092503.11123-5-jgross@suse.com>
 <00c1cd38-5164-edfa-6c47-606803629dcf@oracle.com>
In-Reply-To: <00c1cd38-5164-edfa-6c47-606803629dcf@oracle.com>

--------------H0kwBUjQOfwijdKXCQgtrTrx
Content-Type: multipart/mixed; boundary="------------Cd0FSXteRQcyaOcd2VGwU4Qp"

--------------Cd0FSXteRQcyaOcd2VGwU4Qp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjIgMTg6MTMsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4gSnVzdCBhIGNv
dXBsZSBvZiBuaXRzLg0KPiANCj4gDQo+IE9uIDQvMjAvMjIgNToyNSBBTSwgSnVlcmdlbiBH
cm9zcyB3cm90ZToNCj4+IC1zdGF0aWMgaW50IHNjc2lmcm9udF9yaW5nX2RyYWluKHN0cnVj
dCB2c2NzaWZybnRfaW5mbyAqaW5mbykNCj4+ICtzdGF0aWMgaW50IHNjc2lmcm9udF9yaW5n
X2RyYWluKHN0cnVjdCB2c2NzaWZybnRfaW5mbyAqaW5mbywNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50ICplb2lmbGFnKQ0KPj4gwqAgew0KPj4g
LcKgwqDCoCBzdHJ1Y3QgdnNjc2lpZl9yZXNwb25zZSAqcmluZ19yc3A7DQo+PiArwqDCoMKg
IHN0cnVjdCB2c2NzaWlmX3Jlc3BvbnNlIHJpbmdfcnNwOw0KPj4gwqDCoMKgwqDCoCBSSU5H
X0lEWCBpLCBycDsNCj4+IMKgwqDCoMKgwqAgaW50IG1vcmVfdG9fZG8gPSAwOw0KPj4gLcKg
wqDCoCBycCA9IGluZm8tPnJpbmcuc3JpbmctPnJzcF9wcm9kOw0KPj4gLcKgwqDCoCBybWIo
KTvCoMKgwqAgLyogb3JkZXJpbmcgcmVxdWlyZWQgcmVzcGVjdGl2ZSB0byBkb20wICovDQo+
PiArwqDCoMKgIHJwID0gUkVBRF9PTkNFKGluZm8tPnJpbmcuc3JpbmctPnJzcF9wcm9kKTsN
Cj4+ICvCoMKgwqAgdmlydF9ybWIoKTvCoMKgwqAgLyogb3JkZXJpbmcgcmVxdWlyZWQgcmVz
cGVjdGl2ZSB0byBiYWNrZW5kICovDQo+PiArwqDCoMKgIGlmIChSSU5HX1JFU1BPTlNFX1BS
T0RfT1ZFUkZMT1coJmluZm8tPnJpbmcsIHJwKSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIHNj
c2lmcm9udF9zZXRfZXJyb3IoaW5mbywgImlsbGVnYWwgbnVtYmVyIG9mIHJlc3BvbnNlcyIp
Ow0KPiANCj4gDQo+IEluIG5ldCBhbmQgYmxvY2sgZHJpdmVycyB3ZSByZXBvcnQgbnVtYmVy
IG9mIHN1Y2ggcmVzcG9uc2VzLiAoQnV0IG5vdCBpbiB1c2IpDQpJJ20gbm90IHN1cmUgdGhl
IHNwZWNpZmljIHZhbHVlIGlzIG9mIGFueSBpbnRlcmVzdC4NCg0KPj4gK8KgwqDCoMKgwqDC
oMKgIHJldHVybiAwOw0KPj4gK8KgwqDCoCB9DQo+PiDCoMKgwqDCoMKgIGZvciAoaSA9IGlu
Zm8tPnJpbmcucnNwX2NvbnM7IGkgIT0gcnA7IGkrKykgew0KPj4gLcKgwqDCoMKgwqDCoMKg
IHJpbmdfcnNwID0gUklOR19HRVRfUkVTUE9OU0UoJmluZm8tPnJpbmcsIGkpOw0KPj4gLcKg
wqDCoMKgwqDCoMKgIHNjc2lmcm9udF9kb19yZXNwb25zZShpbmZvLCByaW5nX3JzcCk7DQo+
PiArwqDCoMKgwqDCoMKgwqAgUklOR19DT1BZX1JFU1BPTlNFKCZpbmZvLT5yaW5nLCBpLCAm
cmluZ19yc3ApOw0KPj4gK8KgwqDCoMKgwqDCoMKgIHNjc2lmcm9udF9kb19yZXNwb25zZShp
bmZvLCAmcmluZ19yc3ApOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChpbmZvLT5ob3N0X2Fj
dGl2ZSA9PSBTVEFURV9FUlJPUikNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAwOw0KPj4gK8KgwqDCoMKgwqDCoMKgICplb2lmbGFnID0gMDsNCj4gDQo+IA0KPiAqZW9p
ZmxhZ3MgJj0gflhFTl9FT0lfRkxBR19TUFVSSU9VUzsgPw0KDQpZZXMsIHByb2JhYmx5IGJl
dHRlci4NCg0KPiBXZSBhbHNvIHVzZSBlb2lfZmxhZ3MgbmFtZSBpbiBvdGhlciBpbnN0YW5j
ZXMgaW4gdGhpcyBmaWxlLg0KDQpJJ2xsIHVuaWZ5IHRoZSBuYW1lLg0KDQoNCkp1ZXJnZW4N
Cg==
--------------Cd0FSXteRQcyaOcd2VGwU4Qp
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Cd0FSXteRQcyaOcd2VGwU4Qp--

--------------H0kwBUjQOfwijdKXCQgtrTrx--

--------------bOVcQ0bMgi1fIjeAQlOPmOe5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJhLjoFAwAAAAAACgkQsN6d1ii/Ey+y
twf+JqOrjEDh+gBA4bWZhNG3Gy1PCHVM7nXXibEBKsiBNfvIQPUa18GPWuDYfrdKijjNSi2SB+f6
Sxhp3iIwWkptvZhVBH+95OMfoOz8fyHOsATnRfDMV8h/JYvxHF4Kr87RtRCb/okeg6Z4aTMJ71FC
WnU+CSsxtQciPtct18b+h0o1YVj95rjevV2KWMv3afQx6DhtNU4V1FCEMPK36GIZYQ/43t1qtk1/
0pXEIWjT+WZG4R3nVATsoUYwbc5wpi08F0n6H+vtYwdW6hFQy+08w3/XyEEZXVRBeiZV+Ggyoljk
6QiLZIhdCIbUMhXjnpsF6XFRCZYO17zMveBlKKjuog==
=8nvY
-----END PGP SIGNATURE-----

--------------bOVcQ0bMgi1fIjeAQlOPmOe5--
