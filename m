Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6A53028A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbiEVLGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiEVLGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:06:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE791B783
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 04:06:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6BE1421A8F;
        Sun, 22 May 2022 11:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653217598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPbwnbUgotrmzB4jGp5Bg5QUjYbKcc8XqzYjsj4lnbY=;
        b=SdaitK8omDqJoMkyD/xB9FFK1tl6wGSoL6uoMjmWDbq2A18q7xirKe7onTBM+LEIBqKgAy
        RS/lTuwoTYIn9BPD6+LQHv9lB9FBZeV9Emae7M+A2Lafjr3lpoyMMrvyEGODJS2+h7xkKf
        6QqVVHNBs4Mr6SRvQgEsL66Nvic42cM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E5EB13ADF;
        Sun, 22 May 2022 11:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ntitDT4ZimK7bgAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 22 May 2022 11:06:38 +0000
Message-ID: <eec480a6-763d-35f4-6f0a-c87c79bfaac0@suse.com>
Date:   Sun, 22 May 2022 13:06:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] xen-blk{back,front}: Update contact points for
 buffer_squeeze_duration_ms and feature_persistent
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
Cc:     roger.pau@citrix.com, mheyne@amazon.de,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20220420072734.1692-1-sj@kernel.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220420072734.1692-1-sj@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1fZZKOQew5jH6WG0AeQeAli1"
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
--------------1fZZKOQew5jH6WG0AeQeAli1
Content-Type: multipart/mixed; boundary="------------JQQRCi2NjgNJke0jkpCz9jff";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: SeongJae Park <sj@kernel.org>
Cc: roger.pau@citrix.com, mheyne@amazon.de, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Message-ID: <eec480a6-763d-35f4-6f0a-c87c79bfaac0@suse.com>
Subject: Re: [PATCH v2] xen-blk{back,front}: Update contact points for
 buffer_squeeze_duration_ms and feature_persistent
References: <20220420072734.1692-1-sj@kernel.org>
In-Reply-To: <20220420072734.1692-1-sj@kernel.org>

--------------JQQRCi2NjgNJke0jkpCz9jff
Content-Type: multipart/mixed; boundary="------------1F3xaqsmVc0wAx3Q0X4fxlid"

--------------1F3xaqsmVc0wAx3Q0X4fxlid
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjIgMDk6MjcsIFNlb25nSmFlIFBhcmsgd3JvdGU6DQo+IFNlb25nSmFlIGlz
IGN1cnJlbnRseSBsaXN0ZWQgYXMgYSBjb250YWN0IHBvaW50IGZvciBzb21lIGJsa3tiYWNr
LGZyb250fQ0KPiBmZWF0dXJlcywgYnV0IGhlIHdpbGwgbm90IHdvcmsgZm9yIFhFTiBmb3Ig
YSB3aGlsZS4gIFRoaXMgY29tbWl0DQo+IHRoZXJlZm9yZSB1cGRhdGVzIHRoZSBjb250YWN0
IHBvaW50IHRvIGhpcyBjb2xsZWFndWUsIE1heGltaWxpYW4sIHdobyBpcw0KPiB1bmRlcnN0
YW5kaW5nIHRoZSBjb250ZXh0IGFuZCBhY3RpdmVseSB3b3JraW5nIHdpdGggdGhlIGZlYXR1
cmVzIG5vdy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlb25nSmFlIFBhcmsgPHNqQGtlcm5l
bC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE1heGltaWxpYW4gSGV5bmUgPG1oZXluZUBhbWF6
b24uZGU+DQo+IEFja2VkLWJ5OiBSb2dlciBQYXUgTW9ubsOpIDxyb2dlci5wYXVAY2l0cml4
LmNvbT4NCg0KUHVzaGVkIHRvIHhlbi90aXAuZ2l0IGZvci1saW51cy01LjE5DQoNCg0KSnVl
cmdlbg0K
--------------1F3xaqsmVc0wAx3Q0X4fxlid
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------1F3xaqsmVc0wAx3Q0X4fxlid--

--------------JQQRCi2NjgNJke0jkpCz9jff--

--------------1fZZKOQew5jH6WG0AeQeAli1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKKGT0FAwAAAAAACgkQsN6d1ii/Ey/h
8ggAnpPBFYomNQI9YwXgCQmQuksbKJQ+yf4MIGwi6oiv7ntKHX580j771eTKV+crht49BRPK5MuG
7DVEzH55TBG87XBcQ0kzUcRb5dQ+faQ7CQIcLZiJfviFlRMtGP8Pz5KDQT2Rsx0YUjyVqbAA3U3s
E3JHrJGpV9LOvUl97BT31328WG5yhEYKyTPq2n9wYam3XF4DnhouQz68s7RSYBl/vb32GzB2yoW0
H2Ol02AgxeDe7NU7/lw/EtF+QUwfQeQuWehob0LhT5SDrExm5IiBFAWLX+0D5YvrGuV2iKBQDSFE
eOy1tXWuxWuBQlix61NSls2/aEzK7bYyOZJxx82b7A==
=FrVy
-----END PGP SIGNATURE-----

--------------1fZZKOQew5jH6WG0AeQeAli1--
