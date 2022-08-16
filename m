Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA849595BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiHPMWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiHPMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:22:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B561217065;
        Tue, 16 Aug 2022 05:22:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C37837345;
        Tue, 16 Aug 2022 12:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660652526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YZdKJUujIVhtSIXvaGEXXbp4ZWZrHyQ4cBO+Ol5Uzc=;
        b=jR/qir+F1KvQkprGo27HCBr/wg+RgDRjFlUcYrQpq0in+tS2B9OYkys3SX01TXNf104tpd
        /b7YMDFrE0stbEzgGS7Y/LKHseiM7PdSdXhr4YtNarFcIV7kg6WUIVIIzMu6qBJtb/IaBG
        weR4np2ArM4V5RHr4xxQV3Kmptm7xks=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 292381345B;
        Tue, 16 Aug 2022 12:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /Q6iCO6L+2KjSgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 16 Aug 2022 12:22:06 +0000
Message-ID: <6ded15cd-381d-24f2-ab0f-bae31117bbc5@suse.com>
Date:   Tue, 16 Aug 2022 14:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] block: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220816120952.56713-1-yuanjilin@cdjrlc.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220816120952.56713-1-yuanjilin@cdjrlc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9TcQLo8nP9HQ5Mkv0SO1vvUj"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------9TcQLo8nP9HQ5Mkv0SO1vvUj
Content-Type: multipart/mixed; boundary="------------cSoRuB31Eb67XX0KMBZ92bgR";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jilin Yuan <yuanjilin@cdjrlc.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <6ded15cd-381d-24f2-ab0f-bae31117bbc5@suse.com>
Subject: Re: [PATCH] block: fix repeated words in comments
References: <20220816120952.56713-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220816120952.56713-1-yuanjilin@cdjrlc.com>

--------------cSoRuB31Eb67XX0KMBZ92bgR
Content-Type: multipart/mixed; boundary="------------0vTlOk0UD9WPngsIONQ8xbHp"

--------------0vTlOk0UD9WPngsIONQ8xbHp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDguMjIgMTQ6MDksIEppbGluIFl1YW4gd3JvdGU6DQo+ICAgRGVsZXRlIHRoZSBy
ZWR1bmRhbnQgd29yZCAnY2FuJy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppbGluIFl1YW4g
PHl1YW5qaWxpbkBjZGpybGMuY29tPg0KPiAtLS0NCj4gICBibG9jay9iaW8uYyB8IDIgKy0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9ibG9jay9iaW8uYyBiL2Jsb2NrL2Jpby5jDQo+IGluZGV4IGY5
MmQwMjIzMjQ3Yi4uYzg4M2Y4OTYzYzE0IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9iaW8uYw0K
PiArKysgYi9ibG9jay9iaW8uYw0KPiBAQCAtNTY3LDcgKzU2Nyw3IEBAIEVYUE9SVF9TWU1C
T0woYmlvX2FsbG9jX2Jpb3NldCk7DQo+ICAgICogYmUgcmV1c2VkIGJ5IGNhbGxpbmcgYmlv
X3VuaW5pdCgpIGJlZm9yZSBjYWxsaW5nIGJpb19pbml0KCkgYWdhaW4uDQo+ICAgICoNCj4g
ICAgKiBOb3RlIHRoYXQgdW5saWtlIGJpb19hbGxvYygpIG9yIGJpb19hbGxvY19iaW9zZXQo
KSBhbGxvY2F0aW9ucyBmcm9tIHRoaXMNCj4gLSAqIGZ1bmN0aW9uIGFyZSBub3QgYmFja2Vk
IGJ5IGEgbWVtcG9vbCBjYW4gY2FuIGZhaWwuICBEbyBub3QgdXNlIHRoaXMgZnVuY3Rpb24N
Cj4gKyAqIGZ1bmN0aW9uIGFyZSBub3QgYmFja2VkIGJ5IGEgbWVtcG9vbCBjYW4gZmFpbC4g
IERvIG5vdCB1c2UgdGhpcyBmdW5jdGlvbg0KDQpUaGlzIHNlbnRlbmNlIGlzIHN0aWxsIG5v
dCBjb3JyZWN0LiBJIGd1ZXNzIHRoZSBmaXJzdCAiY2FuIiBzaG91bGQgYmUgcmVwbGFjZWQN
CndpdGggImFuZCIuDQoNCg0KSnVlcmdlbg0K
--------------0vTlOk0UD9WPngsIONQ8xbHp
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0vTlOk0UD9WPngsIONQ8xbHp--

--------------cSoRuB31Eb67XX0KMBZ92bgR--

--------------9TcQLo8nP9HQ5Mkv0SO1vvUj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmL7i+0FAwAAAAAACgkQsN6d1ii/Ey8k
LggAgZc3cEIadhgiZZHfY8EMvIFJiPwY2h0WMqyNt2D/Hii0QEa7cl60yU0AVOMD06CdnAu/oQOf
zFo3LH5uPU8XO6t8g0n9WCwwDQWvievfcfgOMea+9fWICpZbuDJ4UwD4dUQKMnLYRDvSABpEMRVA
vsvp0t7/Q7hlgnMsGKtWXbEYCIzpIatj0EFzKRn3tw9U17ClAnnD7VyngGLjgypevPINMXU3g7TX
POSbGQsFQOPyUITVsNx8HGtRQy+vmuT8MAif3YAq8F6sO3QR0372lm87ZqhaGb9j/Yobdop7buHJ
crbJivkDK29iDyMMOiga1VkN/4bWTs3EekM/GzfWkA==
=UwQO
-----END PGP SIGNATURE-----

--------------9TcQLo8nP9HQ5Mkv0SO1vvUj--
