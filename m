Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2C4AAE39
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 07:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiBFGS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 01:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBFGS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 01:18:57 -0500
X-Greylist: delayed 340 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 22:18:55 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F3BC06173B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 22:18:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 566A11F388;
        Sun,  6 Feb 2022 06:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644127994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9j627IG0HosD/OkE7yv/PUGv9f5Phy0U58ez6FidSA=;
        b=qZuYxtySHuOFdLvYOZGS1P08ZpAk5JDRAKNpQLNKCkAp/N8Id85O7GMCq+zHItGqw634m9
        Bh75uuZ5KkaUn9M34PDXTA251R284uNygPMTj1pHO4j+JsoJK6NPsgu2ZMTc6Z1JxT4/I5
        rOmRuNfK8K9mg30mgd2FmSu0vjeUuks=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31E09139EF;
        Sun,  6 Feb 2022 06:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mzC4Cvpm/2HaTgAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 06 Feb 2022 06:13:14 +0000
Message-ID: <2ad6d8db-9926-4a69-94c9-ae669e24f404@suse.com>
Date:   Sun, 6 Feb 2022 07:13:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [GIT PULL] xen: branch for v5.17-rc3
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20220205110717.16946-1-jgross@suse.com>
 <CAHk-=wjp-h4bFWsWSPQ+5o6iuiPwiFNRNxfDSaDjURzVU6Af7A@mail.gmail.com>
 <CAHk-=wj_ObnioAixXdec63_aXXaS8SUEAsMQgfiHwhXNOYMn5Q@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <CAHk-=wj_ObnioAixXdec63_aXXaS8SUEAsMQgfiHwhXNOYMn5Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CMKgQ4RDZI8wpr20AGMwomTw"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CMKgQ4RDZI8wpr20AGMwomTw
Content-Type: multipart/mixed; boundary="------------f0d5uFHCDvNCO6K6U4UOXrXq";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <2ad6d8db-9926-4a69-94c9-ae669e24f404@suse.com>
Subject: Re: [GIT PULL] xen: branch for v5.17-rc3
References: <20220205110717.16946-1-jgross@suse.com>
 <CAHk-=wjp-h4bFWsWSPQ+5o6iuiPwiFNRNxfDSaDjURzVU6Af7A@mail.gmail.com>
 <CAHk-=wj_ObnioAixXdec63_aXXaS8SUEAsMQgfiHwhXNOYMn5Q@mail.gmail.com>
In-Reply-To: <CAHk-=wj_ObnioAixXdec63_aXXaS8SUEAsMQgfiHwhXNOYMn5Q@mail.gmail.com>

--------------f0d5uFHCDvNCO6K6U4UOXrXq
Content-Type: multipart/mixed; boundary="------------zi2i02yO9nq6JwG4192Jh06i"

--------------zi2i02yO9nq6JwG4192Jh06i
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDIuMjIgMTk6NDIsIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPiBPbiBTYXQsIEZl
YiA1LCAyMDIyIGF0IDk6NTggQU0gTGludXMgVG9ydmFsZHMNCj4gPHRvcnZhbGRzQGxpbnV4
LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+DQo+PiBPbiBTYXQsIEZlYiA1LCAyMDIyIGF0
IDM6MDcgQU0gSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPiB3cm90ZToNCj4+Pg0K
Pj4+IFBsZWFzZSBnaXQgcHVsbCB0aGUgZm9sbG93aW5nIHRhZzoNCj4+Pg0KPj4+ICAgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3hlbi90aXAuZ2l0
IGZvci1saW51cy01LjE3YS1yYzMtdGFnDQo+Pg0KPj4gRGlmZnN0YXQ/IFNob3J0bG9nPw0K
Pj4NCj4+IFRoaXMgaXMgbm90IGEgdmFsaWQgcHVsbCByZXF1ZXN0Lg0KDQpPaCwgSSdtIHNv
cnJ5IGZvciB0aGF0Lg0KDQpTZWVtcyBhcyBpZiBhIHJlY2VudCBzeXN0ZW0gdXBkYXRlIHB1
bGxlZCBpbiBhIG5ld2VyIHZlcnNpb24gb2YgZ2l0IHdpdGgNCmNoYW5nZWQgYmVoYXZpb3Is
IGFuZCBteSBzY3JpcHQgZ2VuZXJhdGluZyB0aGUgcHVsbCByZXF1ZXN0IHNpbGVudGx5DQpp
Z25vcmVkIHRoZSBlcnJvciB3aGVuIHRyeWluZyB0byBhZGQgdGhlIGRpZmZzdGF0IGFuZCBz
aG9ydGxvZy4NCg0KSSd2ZSBmaXhlZCBteSBnaXQgY29uZmlnIGFuZCBteSBzY3JpcHQuDQoN
Cj4gT2ggd2VsbC4gWW91J3JlIGxpa2VseSBvZmZsaW5lIC0gSSBlbmRlZCB1cCBqdXN0IGNo
ZWNraW5nIHlvdXINCj4gZGVzY3JpcHRpb24gaW5zdGVhZC4NCg0KVGhhbmsgeW91IHZlcnkg
bXVjaCwNCg0KDQpKdWVyZ2VuDQo=
--------------zi2i02yO9nq6JwG4192Jh06i
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------zi2i02yO9nq6JwG4192Jh06i--

--------------f0d5uFHCDvNCO6K6U4UOXrXq--

--------------CMKgQ4RDZI8wpr20AGMwomTw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmH/ZvkFAwAAAAAACgkQsN6d1ii/Ey/2
eQf+KWt5Kw+RsNxYlOG+m/x2Q5y5B9P/pxgtPxG3Txx1Zp7Dk8HpVCu9NHRdrZOL/1AQ0sL+qrnp
vb3OB/vsrbdcPqlotTTtUwUwRVORAmKRshB40eMOwTII+PTaQQREYmd7jZqzM9kIXFcjg3JPNkZu
WAWIwkZ/MYWwTLJxWI4g636LoUPfxHam1gfwSEN5NZE/sXDHY91gdLjFgGrURxUqg0G1bZ6kJOmY
b5d/OabusR0XTOJoSSDEt7yo5iKzpWWZ8y6H2EtLv/QUSNKCVav2nt/zdstTespM1FJqFfdNMAi7
oMNdVGHTTnaat8MaxX5HgAiP8ZP07ycNOfpQigffuw==
=wNJW
-----END PGP SIGNATURE-----

--------------CMKgQ4RDZI8wpr20AGMwomTw--
