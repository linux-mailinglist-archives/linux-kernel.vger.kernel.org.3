Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB804F1DCF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383346AbiDDVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380367AbiDDTsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:48:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DFE30F6A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:46:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7279C210F5;
        Mon,  4 Apr 2022 19:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649101574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=arS7X2LHNqa4sxdjtLmxV0a2CCuA+m4T1CHAXBE/p8k=;
        b=M5r8BKv1tF+JTWsTiUSfGcyFQjOlSCRgtQ0lm+ZiAa96okVKDHQqgIS03WvsyyPmGiah0K
        0QquP4ywC4WIlwOAUoYeR11a3WcTIwB+/yy4zwbX63M4TxlEXO00edOqIsbAkw/PNrvZyf
        sK832Q2qJSCTNRW3WZ0b1e3RrG4KzH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649101574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=arS7X2LHNqa4sxdjtLmxV0a2CCuA+m4T1CHAXBE/p8k=;
        b=Z8j4cejUohNa6LXRcidYBRPabz1h17trLk9iOBCIfDZHHeui67WgXixUw23t1L26yGMmGb
        +wdgw+RzqlSQOSDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48BF012FC5;
        Mon,  4 Apr 2022 19:46:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LmhrEAZLS2JbPAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 04 Apr 2022 19:46:14 +0000
Message-ID: <1116eb70-516e-13b3-0697-4af00430bae8@suse.de>
Date:   Mon, 4 Apr 2022 21:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: regression: NULL pointer dereference due to 27599aacbaef ("fbdev:
 Hot-unplug firmware fb devices on forced removal")
Content-Language: en-US
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <YkHXO6LGHAN0p1pq@debian>
 <787d309d-f0b6-4f27-ed31-6811fd7c9293@suse.de>
 <CADVatmM0mP9u9H_LY8qm+ZpezyELdeBSWqQameZnb0dP7TUsQw@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CADVatmM0mP9u9H_LY8qm+ZpezyELdeBSWqQameZnb0dP7TUsQw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ohNxY3fSePnNk9NoIR7jI0ls"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ohNxY3fSePnNk9NoIR7jI0ls
Content-Type: multipart/mixed; boundary="------------xMwbG8rrGDJejXD095GZsfdj";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Zack Rusin <zackr@vmware.com>, Hans de Goede <hdegoede@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-ID: <1116eb70-516e-13b3-0697-4af00430bae8@suse.de>
Subject: Re: regression: NULL pointer dereference due to 27599aacbaef ("fbdev:
 Hot-unplug firmware fb devices on forced removal")
References: <YkHXO6LGHAN0p1pq@debian>
 <787d309d-f0b6-4f27-ed31-6811fd7c9293@suse.de>
 <CADVatmM0mP9u9H_LY8qm+ZpezyELdeBSWqQameZnb0dP7TUsQw@mail.gmail.com>
In-Reply-To: <CADVatmM0mP9u9H_LY8qm+ZpezyELdeBSWqQameZnb0dP7TUsQw@mail.gmail.com>

--------------xMwbG8rrGDJejXD095GZsfdj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMzEuMDMuMjIgdW0gMTA6MjUgc2NocmllYiBTdWRpcCBNdWtoZXJqZWU6DQo+
IE9uIFRodSwgTWFyIDMxLCAyMDIyIGF0IDg6MDcgQU0gVGhvbWFzIFppbW1lcm1hbm4gPHR6
aW1tZXJtYW5uQHN1c2UuZGU+IHdyb3RlOg0KPj4NCj4+DQo+Pg0KPj4gQW0gMjguMDMuMjIg
dW0gMTc6NDEgc2NocmllYiBTdWRpcCBNdWtoZXJqZWU6DQo+Pj4gSGkgVGhvbWFzLA0KPj4+
DQo+Pj4gV2UgdXN1YWxseSBydW4gYm9vdCB0ZXN0cyB3aXRoIGxpbnV4IG1haW5saW5lIEhF
QUQgY29tbWl0IGFsbW9zdCBldmVyeQ0KPj4+IG5pZ2h0IG9uIHBwYzY0IHFlbXUuIEFuZCBt
eSB0ZXN0cyBoYWQgYmVlbiBmYWlsaW5nIGZvciBsYXN0IGZldyBkYXlzLg0KPj4NCj4+IENv
dWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB5b3VyIGtlcm5lbCdzIGNvbmZpZyBmaWxlPw0KPiAN
Cj4gVGhhbmtzIGZvciB0YWtpbmcgYSBsb29rIGF0IGl0Lg0KPiBUaGUgY29uZmlnIGlzIGF0
dGFjaGVkLg0KPiANCj4gDQoNCkkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIGFuZCBmaXggdGhl
IGlzc3VlIGxvY2FsbHkuIFBsZWFzZSBoYXZlIGEgbG9vayBhdCANClsxXSBmb3IgdGhlIHBh
dGNoLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsu
ZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzQ4MDY0OC8NCg0KLS0gDQpUaG9tYXMgWmltbWVybWFu
bg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkN
CihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90
ZXYNCg==

--------------xMwbG8rrGDJejXD095GZsfdj--

--------------ohNxY3fSePnNk9NoIR7jI0ls
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmJLSwUFAwAAAAAACgkQlh/E3EQov+C2
Hg/6A0LCk+bGxbWkA8FJQU+iU3XisJ/NKUTXKFIgr101Gn6JPyaFKMZDRK5nCTniC3hwVSTBderk
8/l+rWQA02gSM0a1XMlGQLRlMRE+T2yfD6vYS/1B4oDbK2dLRo6s9CZkJrN1lrkOnVYNkk/LJh1u
7YD4fxn9KI9YzgUZPBYoeECQGvnWtJtBu0XdIKkS1T9gb8RmkFnPOYBN8x/XPtr1+9aLfBw81wYD
ItecoLJ0nQvrkrMawlmCGMHw4l1vuEV2pu50VDnfFG/r7Tppzt9xio7vq1Ky0qUwMoRenhQjLTsO
R8HBav7GtILZNtHe6u+9o4MXyT56quG+t4f0gjOXZ9vZ4TxvzyEPLPREGvBK7Aet0SY5nktfjh6Z
zQc/OlmfmY3s2fh6uLH3U78+dnuovYG8x06fjZuG2CBxoRtBndMSGr1erbTE2kIsPgkL+rMXy1Uo
oviJc4Xdj9taKIAVkurNxlOhvHPPUl7Us+WnJIZX0BjUAIXLeW/AC6XLhIPdAcKf4l4Q+gzmIJ4D
l9T3Xnojfkr8GxLTT0jbz2J7ffDXB51nqdI4XvTUv1e/06XmhrZvzsaq8MDrdz2Q3+hksXK0usDP
hXox678mwLTttBt16zB0uGD2CaYtx0xAYb/5B5lfVqDVZJ7ipUVUbSFbrqqQ3OHl7/ZgeqMf0v7r
AiM=
=9dC8
-----END PGP SIGNATURE-----

--------------ohNxY3fSePnNk9NoIR7jI0ls--
