Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67807551009
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiFTGDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbiFTGDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:03:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865055FF1;
        Sun, 19 Jun 2022 23:03:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 432821F916;
        Mon, 20 Jun 2022 06:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655704999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gv9EGbhHKTU9NAIzd5Fwb9sAZGrgO5CTCjt3oCBuAAc=;
        b=ifGeYyEecXtzyzBHhtx0iLHzGIzv0JnsYRL7bPucqrxYTOX0SwrN6yw/VU0+Z5rd7G0aGg
        ABGHfNibUwmaCy6VpVZJyC1hqBSMA7FgderqocB9nnYm04PsAxftqTeOWMqTXp3SJIrOts
        +9xcLW5uzLdkS+YryOgCvGmUbFjRUQw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0427813638;
        Mon, 20 Jun 2022 06:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id umzVOqYNsGL/YgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 20 Jun 2022 06:03:18 +0000
Message-ID: <5431f626-9bd3-ed54-9889-aafbba9ca3e0@suse.com>
Date:   Mon, 20 Jun 2022 08:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] s390/kvm: avoid hypfs error message
Content-Language: en-US
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20220607123314.10255-1-jgross@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220607123314.10255-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JgAyFWNqVwFMFl2oFcsEXtqa"
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
--------------JgAyFWNqVwFMFl2oFcsEXtqa
Content-Type: multipart/mixed; boundary="------------dhzp00Q81Bwnv5shN4Kh1pv3";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
Message-ID: <5431f626-9bd3-ed54-9889-aafbba9ca3e0@suse.com>
Subject: Re: [PATCH] s390/kvm: avoid hypfs error message
References: <20220607123314.10255-1-jgross@suse.com>
In-Reply-To: <20220607123314.10255-1-jgross@suse.com>

--------------dhzp00Q81Bwnv5shN4Kh1pv3
Content-Type: multipart/mixed; boundary="------------fasRUmpl5lg2YranrntzxJB7"

--------------fasRUmpl5lg2YranrntzxJB7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UGluZz8NCg0KT24gMDcuMDYuMjIgMTQ6MzMsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IFdo
ZW4gYm9vdGluZyB1bmRlciBLVk0gdGhlIGZvbGxvd2luZyBlcnJvciBtZXNzYWdlcyBhcmUg
aXNzdWVkOg0KPiANCj4gaHlwZnMuN2Y1NzA1OiBUaGUgaGFyZHdhcmUgc3lzdGVtIGRvZXMg
bm90IHN1cHBvcnQgaHlwZnMNCj4gaHlwZnMuN2E3OWYwOiBJbml0aWFsaXphdGlvbiBvZiBo
eXBmcyBmYWlsZWQgd2l0aCByYz0tNjENCj4gDQo+IFdoaWxlIGJlaW5nIGRvY3VtZW50ZWQs
IHRoZXkgY2FuIGVhc2lseSBiZSBhdm9pZGVkIGJ5IGJhaWxpbmcgb3V0IG9mDQo+IGh5cGZz
X2luaXQoKSBlYXJseSBpbiBjYXNlIG9mIHJ1bm5pbmcgYXMgYSBLVk0gZ3Vlc3QuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IC0t
LQ0KPiAgIGFyY2gvczM5MC9oeXBmcy9pbm9kZS5jIHwgMyArKysNCj4gICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9zMzkwL2h5
cGZzL2lub2RlLmMgYi9hcmNoL3MzOTAvaHlwZnMvaW5vZGUuYw0KPiBpbmRleCA1Yzk3ZjQ4
Y2VhOTEuLmJkZjA3OGYzYzY0MSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9zMzkwL2h5cGZzL2lu
b2RlLmMNCj4gKysrIGIvYXJjaC9zMzkwL2h5cGZzL2lub2RlLmMNCj4gQEAgLTQ2NCw2ICs0
NjQsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBoeXBmc19pbml0KHZvaWQpDQo+ICAgew0KPiAg
IAlpbnQgcmM7DQo+ICAgDQo+ICsJaWYgKE1BQ0hJTkVfSVNfS1ZNKQ0KPiArCQlyZXR1cm4g
LUVOT0RBVEE7DQo+ICsNCj4gICAJaHlwZnNfZGJmc19pbml0KCk7DQo+ICAgDQo+ICAgCWlm
IChoeXBmc19kaWFnX2luaXQoKSkgew0KDQo=
--------------fasRUmpl5lg2YranrntzxJB7
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------fasRUmpl5lg2YranrntzxJB7--

--------------dhzp00Q81Bwnv5shN4Kh1pv3--

--------------JgAyFWNqVwFMFl2oFcsEXtqa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKwDaYFAwAAAAAACgkQsN6d1ii/Ey/a
BQgAhxz9eio2otyh5DRhmdEQwOo4DB8l1E7hy0c0vIza/9vFFc1+BaB3j/UrMATjWxkmiX2dVagB
ujeBDwMMWM7Q0K9+YRJfkiDFtJaPELYhhWrdSWoo/pACjQKgHh29VklwSTLWAlpK0dC/kWv8b7sR
CFI6XgKkSmpZyWmUhPG5zseruVCA6Q3SEilh2x5yyAoJBq+2b2uF2e7RrWwOtidNe3LDUExuRfn7
dZZUAlYVxXfGuM67589tLE2CQ5/HpnnZACIxsbQ1medTLCEuXb6oBncvR+QxM18/PCweZ/Qwd8y5
4OSDgIlYrZgvnEWfdZ8skAdnOtKC32+tVKAuseZ4DQ==
=8nr5
-----END PGP SIGNATURE-----

--------------JgAyFWNqVwFMFl2oFcsEXtqa--
