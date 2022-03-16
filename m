Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B334DA9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353638AbiCPFaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348079AbiCPFaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:30:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E707935DEE;
        Tue, 15 Mar 2022 22:29:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC8B11F38C;
        Wed, 16 Mar 2022 05:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647408541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/PIDCzlHujec2z5GgI/Fxhz1Ptiq+5sj17W7kV26IFg=;
        b=k/sKfbSrYYRa9c1IRzKH1EV1lIJNiMZHAjh0QjBh2f8r2/LjPWIs3T9GHvoWKqtUG43T1A
        SuAP3MeGhbVbhlexyS1BFn6MhAS01BLuoGiqA7y9VVJEr1um9I4VZoJDtsiFHpPTrXcRT4
        4FXFARFp8tWrZKdcpXmTcIDgY1YbVy4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82B1113B93;
        Wed, 16 Mar 2022 05:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l8SgHZ11MWJIKwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 16 Mar 2022 05:29:01 +0000
Message-ID: <78b16b06-9cfe-5bfd-5d23-b7e8010024fd@suse.com>
Date:   Wed, 16 Mar 2022 06:29:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] xen/usb: harden xen_hcd against malicious backends
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220311103509.12908-1-jgross@suse.com>
 <YjDPtRhdrtY6tpvc@kroah.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <YjDPtRhdrtY6tpvc@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eod0dLzbzdUZdsKtS040X2Cp"
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
--------------eod0dLzbzdUZdsKtS040X2Cp
Content-Type: multipart/mixed; boundary="------------dIo5mqVJwQtgAvakBeavLCM7";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <78b16b06-9cfe-5bfd-5d23-b7e8010024fd@suse.com>
Subject: Re: [PATCH] xen/usb: harden xen_hcd against malicious backends
References: <20220311103509.12908-1-jgross@suse.com>
 <YjDPtRhdrtY6tpvc@kroah.com>
In-Reply-To: <YjDPtRhdrtY6tpvc@kroah.com>

--------------dIo5mqVJwQtgAvakBeavLCM7
Content-Type: multipart/mixed; boundary="------------RThCbjbaim80DRYqQ5E0TjUm"

--------------RThCbjbaim80DRYqQ5E0TjUm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMDMuMjIgMTg6NDEsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gT24gRnJp
LCBNYXIgMTEsIDIwMjIgYXQgMTE6MzU6MDlBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90
ZToNCj4+IE1ha2Ugc3VyZSBhIG1hbGljaW91cyBiYWNrZW5kIGNhbid0IGNhdXNlIGFueSBo
YXJtIG90aGVyIHRoYW4gd3JvbmcNCj4+IEkvTyBkYXRhLg0KPj4NCj4+IE1pc3NpbmcgYXJl
IHZlcmlmaWNhdGlvbiBvZiB0aGUgcmVxdWVzdCBpZCBpbiBhIHJlc3BvbnNlLCBzYW5pdGl6
aW5nDQo+PiB0aGUgcmVwb3J0ZWQgYWN0dWFsIEkvTyBsZW5ndGgsIGFuZCBwcm90ZWN0aW9u
IGFnYWluc3QgaW50ZXJydXB0IHN0b3Jtcw0KPj4gZnJvbSB0aGUgYmFja2VuZC4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+PiAt
LS0NCj4+ICAgZHJpdmVycy91c2IvaG9zdC94ZW4taGNkLmMgfCA1NyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNDMgaW5z
ZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+IA0KPiBGYWlscyB0byBhcHBseSB0byBt
eSB0cmVlOg0KPiANCj4gY2hlY2tpbmcgZmlsZSBkcml2ZXJzL3VzYi9ob3N0L3hlbi1oY2Qu
Yw0KPiBIdW5rICMyIHN1Y2NlZWRlZCBhdCA3MjAgKG9mZnNldCAtMSBsaW5lcykuDQo+IEh1
bmsgIzMgc3VjY2VlZGVkIGF0IDgwNyAob2Zmc2V0IC0zIGxpbmVzKS4NCj4gSHVuayAjNCBz
dWNjZWVkZWQgYXQgOTM0IChvZmZzZXQgLTUgbGluZXMpLg0KPiBIdW5rICM1IEZBSUxFRCBh
dCA5ODYuDQo+IEh1bmsgIzYgc3VjY2VlZGVkIGF0IDEwMDMgd2l0aCBmdXp6IDEgKG9mZnNl
dCAtMTAgbGluZXMpLg0KPiBIdW5rICM3IHN1Y2NlZWRlZCBhdCAxMDQ4IChvZmZzZXQgLTEw
IGxpbmVzKS4NCj4gSHVuayAjOCBzdWNjZWVkZWQgYXQgMTA3MiAob2Zmc2V0IC0xMCBsaW5l
cykuDQo+IEh1bmsgIzkgc3VjY2VlZGVkIGF0IDExNjEgKG9mZnNldCAtMTAgbGluZXMpLg0K
PiBIdW5rICMxMCBzdWNjZWVkZWQgYXQgMTUxNiAob2Zmc2V0IC0xMCBsaW5lcykuDQo+IDEg
b3V0IG9mIDEwIGh1bmtzIEZBSUxFRA0KPiANCj4gQW55IGhpbnRzPw0KDQpSZWJhc2UgeW91
ciB0cmVlIHRvIHY1LjE3LXJjOD8gSXQgaXMgbWlzc2luZyB0aGUgcmVjZW50IHNlY3VyaXR5
DQpwYXRjaGVzIHdoaWNoIG1vZGlmaWVkIGRyaXZlcnMvdXNiL2hvc3QveGVuLWhjZC5jLg0K
DQoNCkp1ZXJnZW4NCg==
--------------RThCbjbaim80DRYqQ5E0TjUm
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------RThCbjbaim80DRYqQ5E0TjUm--

--------------dIo5mqVJwQtgAvakBeavLCM7--

--------------eod0dLzbzdUZdsKtS040X2Cp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmIxdZwFAwAAAAAACgkQsN6d1ii/Ey9F
Hwf+LkGaWrpNt9vcE1twmTNgjxj3MDenPvnyDaABq2+G1W36GWL407B+xfrskqVqc/xkM9vw7Vlh
wXEwTWHkGUF+RIXf1KGD1yjqakF5apcrfxZPzUhzWDYAc1nLEJ6a8Ajjs5xz8A0t+Mzw9/WB0IEM
f6+mog8mAn88xCXKmWzM1+Kp06uimKRc776aSvlVj7rwSn5+zrYc+1hdGVUNfP/BtRJcuwTWm06B
cGGd3Dnf7VvB48ehxM6poumJ9wZKZVtweduzCV/6fF/iachj6ERDpVdg4qYqKbXs4s6AHr5yQ7/J
Fq6xOa/M0HxTzTsaosLBpQSIPHMY7bgycGmrCUR6rQ==
=aDhE
-----END PGP SIGNATURE-----

--------------eod0dLzbzdUZdsKtS040X2Cp--
