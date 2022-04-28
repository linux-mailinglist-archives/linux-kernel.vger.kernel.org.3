Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33029512C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbiD1HJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244902AbiD1HJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:09:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2EA996A4;
        Thu, 28 Apr 2022 00:06:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0916A1F37F;
        Thu, 28 Apr 2022 07:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651129588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iIl0kSrYwn7J67McRY3rj6P7/4D8GhVWuP0EZQDyNcc=;
        b=OzwPEuSvd/SxcnLPObUc+fL5oc0eLhd8EYMB3xD40ITgZrVB3OF/73YX/dS2t5HLwrzeAu
        6DsuLLy0tSyQBxEq4EAADLICRMA5tYvhaZNlBx2eD743xcs2he2bEDxJPY0Slp5eU24B2/
        wpSgv1NZF+3FC48hmlLqb1o89vyDzlk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C490D13491;
        Thu, 28 Apr 2022 07:06:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4jyNLvM8amKXXwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Apr 2022 07:06:27 +0000
Message-ID: <239ae645-7fb1-ca8c-1b37-2238313d6d1f@suse.com>
Date:   Thu, 28 Apr 2022 09:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/4] xen/scsiback: use new command result macros
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20220420092503.11123-1-jgross@suse.com>
 <20220420092503.11123-3-jgross@suse.com>
 <e4bce8f1-c6f5-cb99-8a1e-97b09ea1f840@oracle.com>
 <bf19c5f8-badd-5afb-fcaa-a16483783a27@suse.com>
 <d4d36fb2-a26a-9fbd-acc6-fe97ab93fa66@oracle.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <d4d36fb2-a26a-9fbd-acc6-fe97ab93fa66@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------W4XcMcPkdQvvBS00Fc09wj6a"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------W4XcMcPkdQvvBS00Fc09wj6a
Content-Type: multipart/mixed; boundary="------------VT11Vb06Hc6uJBuYS6rHFzIN";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <239ae645-7fb1-ca8c-1b37-2238313d6d1f@suse.com>
Subject: Re: [PATCH 2/4] xen/scsiback: use new command result macros
References: <20220420092503.11123-1-jgross@suse.com>
 <20220420092503.11123-3-jgross@suse.com>
 <e4bce8f1-c6f5-cb99-8a1e-97b09ea1f840@oracle.com>
 <bf19c5f8-badd-5afb-fcaa-a16483783a27@suse.com>
 <d4d36fb2-a26a-9fbd-acc6-fe97ab93fa66@oracle.com>
In-Reply-To: <d4d36fb2-a26a-9fbd-acc6-fe97ab93fa66@oracle.com>

--------------VT11Vb06Hc6uJBuYS6rHFzIN
Content-Type: multipart/mixed; boundary="------------0IRJFSWGRfIdvbdiiR0qmSeH"

--------------0IRJFSWGRfIdvbdiiR0qmSeH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDQuMjIgMjI6NTYsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4gDQo+IE9uIDQv
MjEvMjIgNDo0MCBBTSwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IE9uIDIwLjA0LjIyIDE4
OjEyLCBCb3JpcyBPc3Ryb3Zza3kgd3JvdGU6DQo+Pj4gQW5kIGFsc28gbG9va2luZyBhdCBp
bnZvY2F0aW9ucyBvZiBzY3NpYmFja19kb19yZXNwX3dpdGhfc2Vuc2UoKSBJIHRoaW5rIA0K
Pj4+IHRob3NlIG1heSBuZWVkIHRvIGJlIGFkanVzdGVkIGFzIHdlbGwuDQo+Pg0KPj4gTm8s
IHRoZSBpbnZvY2F0aW9ucyBhcmUgZmluZSwgYnV0IHNjc2liYWNrX3Jlc3VsdCgpIG5lZWRz
IHRvIHBhc3MgdGhyb3VnaA0KPj4gdGhlIGxvd2VzdCAxNiBiaXRzIGluc3RlYWQgb2Ygb25s
eSB0aGUgbG93ZXN0IDggYml0cyBvZiB0aGUgcmVzdWx0IHZhbHVlLg0KPj4NCj4gDQo+IFdo
YXQgSSB3YXMgdGhpbmtpbmcgd2FzIHRoYXQgdGhpcyBjb3VsZCB1c2UgdGhlIHJldmVyc2Ug
b2YgDQo+IFhFTl9WU0NTSUlGX1JTTFRfSE9TVCgpLCBpLmUuIHNvbWV0aGluZyBsaWtlDQo+
IA0KPiAjZGVmaW5lIFJTTFRfSE9TVF9UT19YRU5fVlNDU0lJRih4KcKgwqAgKCh4KTw8MTYp
DQo+IA0KPiB0byBiZSBleHBsaWNpdCBhYm91dCBuYW1lc3BhY2VzLg0KDQpJIGRvbid0IHRo
aW5rIHRoaXMgaXMgbmVlZGVkLg0KDQo+IEJUVywgc2hvdWxkIHNjc2liYWNrX3Jlc3VsdCgp
IHVzZSBYRU5fVlNDU0lJRl9SU0xUX0hPU1QoKSBhdCB0aGUgdG9wPw0KDQpZZXMsIEknbGwg
ZG8gdGhhdC4NCg0KDQpKdWVyZ2VuDQo=
--------------0IRJFSWGRfIdvbdiiR0qmSeH
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0IRJFSWGRfIdvbdiiR0qmSeH--

--------------VT11Vb06Hc6uJBuYS6rHFzIN--

--------------W4XcMcPkdQvvBS00Fc09wj6a
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJqPPMFAwAAAAAACgkQsN6d1ii/Ey98
0Af/cu4+aD/v3Zce3V2IKE9L12srwwjDIhtpEYBJMuvjnHTLV15NF2J7ePzUrbqO4tORvQ+RuCY4
otgC6p39v1tD1CGW/zdSd2asFuBEwqSYjmUq3gwvG2wB27O8wXPLFMFVfJG21s2ACRyP0w6zr0VK
fEV6HVBbDv1ldWnBLyv0rpm/cFvr0snC/TtvVwieEJ/n4FwSq+S82QaSaoMnUeVlQIuzD05bu+F7
mtSWK5S4ZUS+gCXQfSMFJ1jbOcE1Lsy3BAD4LKp7UeBN7+6/zu6jGTdTMUbf3O8bBa3E5eCFrAEN
Iohw/oSsL+a0bk51DqobJxslBmh9ZZYoBa/aDduvww==
=uOXA
-----END PGP SIGNATURE-----

--------------W4XcMcPkdQvvBS00Fc09wj6a--
