Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D447358F8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiHKIPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiHKIPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:15:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AD2901A7;
        Thu, 11 Aug 2022 01:14:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70134204AC;
        Thu, 11 Aug 2022 08:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660205696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PaJgcu1r/fNWNO3/MUU3R3hquZ1u52WfpLIFgH34afg=;
        b=LvuoTF9h8MCh66kzKulEEnQdNGikTnYlQ25b7JEHSpDtSY3BXFsBDuAHisRlbCjzU1oJvF
        1pEujAdfa0q2khprwySzh6c1rlYDpbi+k9NWIZ/qk2hAN87e/Cmvt7Ai4T9PjWSnJCDrQY
        tqjJs1ai4/FA5IHxultXDxKkuitkVOM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C76D13A9B;
        Thu, 11 Aug 2022 08:14:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YUlWCYC69GKJTAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 11 Aug 2022 08:14:56 +0000
Message-ID: <040024a3-77dd-8869-1e64-0a67a438d1f6@suse.com>
Date:   Thu, 11 Aug 2022 10:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] s390/kvm: avoid hypfs error message
Content-Language: en-US
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20220620094534.18967-1-jgross@suse.com>
 <YrBarz+NVJmS+bBb@tuxmaker.boeblingen.de.ibm.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <YrBarz+NVJmS+bBb@tuxmaker.boeblingen.de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jRIM0HWCsPAAbPRMLNlc0rMy"
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
--------------jRIM0HWCsPAAbPRMLNlc0rMy
Content-Type: multipart/mixed; boundary="------------RpZURpkJ8zm0qA6QhyJgb8AJ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>
Message-ID: <040024a3-77dd-8869-1e64-0a67a438d1f6@suse.com>
Subject: Re: [PATCH v2] s390/kvm: avoid hypfs error message
References: <20220620094534.18967-1-jgross@suse.com>
 <YrBarz+NVJmS+bBb@tuxmaker.boeblingen.de.ibm.com>
In-Reply-To: <YrBarz+NVJmS+bBb@tuxmaker.boeblingen.de.ibm.com>

--------------RpZURpkJ8zm0qA6QhyJgb8AJ
Content-Type: multipart/mixed; boundary="------------b3VQy0qMrjsX0PNJOLYHLrkS"

--------------b3VQy0qMrjsX0PNJOLYHLrkS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDYuMjIgMTM6MzEsIEFsZXhhbmRlciBHb3JkZWV2IHdyb3RlOg0KPiBPbiBNb24s
IEp1biAyMCwgMjAyMiBhdCAxMTo0NTozNEFNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3Rl
Og0KPj4gV2hlbiBib290aW5nIHVuZGVyIEtWTSB0aGUgZm9sbG93aW5nIGVycm9yIG1lc3Nh
Z2VzIGFyZSBpc3N1ZWQ6DQo+Pg0KPj4gaHlwZnMuN2Y1NzA1OiBUaGUgaGFyZHdhcmUgc3lz
dGVtIGRvZXMgbm90IHN1cHBvcnQgaHlwZnMNCj4+IGh5cGZzLjdhNzlmMDogSW5pdGlhbGl6
YXRpb24gb2YgaHlwZnMgZmFpbGVkIHdpdGggcmM9LTYxDQo+Pg0KPj4gRGVtb3RlIHRoZSBz
ZXZlcml0eSBvZiBmaXJzdCBtZXNzYWdlIGZyb20gImVycm9yIiB0byAiaW5mbyIgYW5kIGlz
c3VlDQo+PiB0aGUgc2Vjb25kIG1lc3NhZ2Ugb25seSBpbiBvdGhlciBlcnJvciBjYXNlcy4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
DQo+IA0KPiBBcHBsaWVkLCB0aGFua3MhDQoNCkhtbSwgYXBwbGllZCB0byB3aGljaCB0cmVl
IGFuZCBicmFuY2g/DQoNCkkgd291bGQgaGF2ZSB0aG91Z2h0IHRoaXMgcGF0Y2ggc2hvdWxk
IGhhdmUgcmVhY2hlZCB1cHN0cmVhbSBieSBub3cuLi4NCg0KDQpKdWVyZ2VuDQo=
--------------b3VQy0qMrjsX0PNJOLYHLrkS
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------b3VQy0qMrjsX0PNJOLYHLrkS--

--------------RpZURpkJ8zm0qA6QhyJgb8AJ--

--------------jRIM0HWCsPAAbPRMLNlc0rMy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmL0un8FAwAAAAAACgkQsN6d1ii/Ey+E
oggAiK1EGgD9df/XW0TSM7hbmca86sRXSqaDNY2xEhBxRIgtG1eX5Ie6x82EmmLb8GxyrCmoo/CL
9JU5Ugk3wVQ11wLw6XRVXNBgMOFaOqaLO88tpPVebSoMVsAIoWggtmq3CStr5PL82X9qapmx5FXn
KDnIh2PaN8YgUdIQQHz+5xoXK+xT5P3zAXoAjozDNciRAUo9g04C23b5ZB3Y3LL1wKCXtodiSRy/
8hv7v9wlrWzYH27xcyKiEpeAORIq7XjMa4KaWcbbRdq6N5UII6fuc+7pGyrgTb04hmR+OjLHmcBe
Q+PCTNP5JUp7hArdNaieCWZjEjO7tFD6t/sZ28oH/g==
=bJ+v
-----END PGP SIGNATURE-----

--------------jRIM0HWCsPAAbPRMLNlc0rMy--
