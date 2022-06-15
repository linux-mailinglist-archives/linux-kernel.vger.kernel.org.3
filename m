Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC254C79D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbiFOLjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiFOLjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:39:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07113BA75;
        Wed, 15 Jun 2022 04:39:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B0361F461;
        Wed, 15 Jun 2022 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655293142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vWPyTUqt05MY3W5QAH5ZScqNjOJblYblU80W/EAoMTc=;
        b=pj88y/1uhddmJF6+ViziLn3f9btEYgJHUxO+4CVlPd36NF9lAY938X+KI2og6Ej07tIXYB
        SBsHeofB2W5lvCiNCDm5dLIt5a+4W3+x98sMeJ9ncXBSawaUx15hd27sAGSHH2j7Zwq7ip
        Ha0WFC9245O9XEPb68PYRWINOgYLUyg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32972139F3;
        Wed, 15 Jun 2022 11:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +pjUCtbEqWKPdgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 15 Jun 2022 11:39:02 +0000
Message-ID: <c5a521e0-26b1-b1d6-7f7d-00aa9b4b1e0e@suse.com>
Date:   Wed, 15 Jun 2022 13:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20220615084835.27113-1-jgross@suse.com>
 <YqnBZhiLOHnoalbC@infradead.org>
 <9b9785f5-085b-0882-177f-d8418c366beb@suse.com>
 <YqnCZ+EKZeZ5AEnr@infradead.org>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen: don't require virtio with grants for non-PV guests
In-Reply-To: <YqnCZ+EKZeZ5AEnr@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TWmXe532bQQDVPjVheiFhZaA"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TWmXe532bQQDVPjVheiFhZaA
Content-Type: multipart/mixed; boundary="------------cNawxCPRxMUORbcskRskiQnY";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-ID: <c5a521e0-26b1-b1d6-7f7d-00aa9b4b1e0e@suse.com>
Subject: Re: [PATCH] xen: don't require virtio with grants for non-PV guests
References: <20220615084835.27113-1-jgross@suse.com>
 <YqnBZhiLOHnoalbC@infradead.org>
 <9b9785f5-085b-0882-177f-d8418c366beb@suse.com>
 <YqnCZ+EKZeZ5AEnr@infradead.org>
In-Reply-To: <YqnCZ+EKZeZ5AEnr@infradead.org>

--------------cNawxCPRxMUORbcskRskiQnY
Content-Type: multipart/mixed; boundary="------------Sd2TeXFi0Z1F0raD2vPQkxgR"

--------------Sd2TeXFi0Z1F0raD2vPQkxgR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMDYuMjIgMTM6MjgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBXZWQs
IEp1biAxNSwgMjAyMiBhdCAwMToyNjoyN1BNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3Rl
Og0KPj4gT24gMTUuMDYuMjIgMTM6MjQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4+
IEkgZG9uJ3QgdGhpbmsgdGhpcyBjb21tYW5kIGxpbmUgbWVzcyBpcyBhIGdvb2QgaWRlYS4g
IEluc3RlYWQgdGhlDQo+Pj4gYnJhbmQgbmV3IGdyYW50IGRldmljZXMgbmVlZCB0byBiZSBw
cm9wZXJseSBhZHZlcnRpc2VkIGluIHRoZSBkZXZpY2UNCj4+PiB0cmVlLCBhbmQgYW55IGRl
dmljZSB0aGF0IGlzbid0IGEgZ3JhbnQgZGV2aWNlIGRvZXNuJ3QgbmVlZA0KPj4+IFZJUlRJ
T19GX0FDQ0VTU19QTEFURk9STS4gIE5vIG5lZWQgZm9yIGEgY29tbWFuZCBsaW5lIG9yIHVz
ZXINCj4+PiBpbnRlcnZlbnRpb24uDQo+Pg0KPj4gQW5kIG9uIHg4Nj8NCj4gDQo+IEFDUEkg
dGFibGVzIG9yIHdoYXRldmVyIG1lY2hhbmlzbSB5b3Ugb3RoZXJ3aXNlIHVzZSB0byBhZHZl
cnRpc2UgZ3JhbnQNCj4gYmFzZWQgRE1BLiAgQnV0IHRoYXQgaXMgaXJyZWxldmFudCBmb3Ig
bm93LCBhcyB0aGUgY29kZSBpbiBtYWlubGluZQ0KPiBvbmx5IHN1cHBvcnRzIERUIG9uIGFy
bS9hcm02NCBhbnlheS4NCg0KTm8sIGl0IGRvZXNuJ3QuIEknbSB3b3JraW5nIG9uIGEgcWVt
dSBwYXRjaCBzZXJpZXMgZW5hYmxpbmcgdGhlIHFlbXUNCmJhc2VkIGJhY2tlbmRzIHRvIHN1
cHBvcnQgZ3JhbnRzIHdpdGggdmlydGlvLiBUaGUgY29kZSBpcyB3b3JraW5nIGZpbmUNCm9u
IHg4NiwgdG9vIChhcGFydCBmcm9tIHRoZSBmYWN0IHRoYXQgdGhlIGJhY2tlbmRzIGFyZW4n
dCByZWFkeSB5ZXQpLg0KDQpJJ2QgYmUgZmluZSB0byBqdXN0IGRyb3AgdGhlIGNvbW1hbmQg
bGluZSBwYXJhbWV0ZXIsIGJ1dCBJIHRoaW5rIGENCmd1ZXN0IGFkbWluIHNob3VsZCBiZSBh
YmxlIHRvIHNwZWNpZnkgdGhhdCBoZSBkb2Vzbid0IHdhbnQgdGhlIGJhY2tlbmQNCnRvIGJl
IGFibGUgdG8gbWFwIGFyYml0cmFyeSBtZW1vcnkgb2YgdGhlIGd1ZXN0IGluIG9yZGVyIHRv
IGFkZA0KYW5vdGhlciBsaW5lIG9mIGRlZmVuc2UuDQoNCg0KSnVlcmdlbg0K
--------------Sd2TeXFi0Z1F0raD2vPQkxgR
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Sd2TeXFi0Z1F0raD2vPQkxgR--

--------------cNawxCPRxMUORbcskRskiQnY--

--------------TWmXe532bQQDVPjVheiFhZaA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKpxNUFAwAAAAAACgkQsN6d1ii/Ey9B
5Af9F2dY6J4qBYEbMURzj1DkbJAf6MjkmYYThPu+gU3Xfe5zRwpbuutcpumG80XNYnJuWZ/cab36
Lc3zVRHJsmOgqHefGa+F7fqtCW0qPwz7yh9r708cJebFWZFjJcRPlEVZ+xupRoguzb4uvrJHJsv1
CtlbaUesSN+TRatgLjkl88B3VV7rp/Y/+578CdHwy/kKKnNJrKEmtGbDmm0yb/HW5TdKuP/T8I/c
d8ru/eBY2tfF5BPp+pPZswCceiJzItpi4hzrv2fxCqSS5VY42fCaVrdIMaMukAlWe+vZ75iWVfNX
QxN99ml9MQNWob3scGsuaRAIG3cGfWDh15+KfFlePQ==
=hXfX
-----END PGP SIGNATURE-----

--------------TWmXe532bQQDVPjVheiFhZaA--
