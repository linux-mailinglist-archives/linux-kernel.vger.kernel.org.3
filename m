Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3519F517ED4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiECH1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiECH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:26:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FA6E0C6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:23:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2819F1F747;
        Tue,  3 May 2022 07:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651562588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67aAGOTYZat+zahDrYqYhaHD6inTZdcyAfqIDsVyT/A=;
        b=TfbGSvx0Bxg0s0oLL/ve+Xf8TGbcB6dQPVQ7mi/zY0s4FMh9Xw496dZudSo8txnQKkofv6
        1sXDlt48EO5tXsoU7S6by7MMX1IQg/t2PtFcVTEtnQoGeieSUy5EgbYL+AWJsE6sP27mk9
        MY58tUTusqnoR0OMRhnD3uRezaoT6mE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C479513AA3;
        Tue,  3 May 2022 07:23:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KRGQLlvYcGL8GgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 03 May 2022 07:23:07 +0000
Message-ID: <6bef5d16-3e0e-8107-4068-7ffec2b6b282@suse.com>
Date:   Tue, 3 May 2022 09:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V7 3/6] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220503032107.680190-1-jiangshanlai@gmail.com>
 <20220503032107.680190-4-jiangshanlai@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220503032107.680190-4-jiangshanlai@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------KwRiUTIWkRhKCzpRQZSTzRza"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------KwRiUTIWkRhKCzpRQZSTzRza
Content-Type: multipart/mixed; boundary="------------Em6ASg0TCWU5pwzVxFXaMdAj";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6bef5d16-3e0e-8107-4068-7ffec2b6b282@suse.com>
Subject: Re: [PATCH V7 3/6] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
References: <20220503032107.680190-1-jiangshanlai@gmail.com>
 <20220503032107.680190-4-jiangshanlai@gmail.com>
In-Reply-To: <20220503032107.680190-4-jiangshanlai@gmail.com>

--------------Em6ASg0TCWU5pwzVxFXaMdAj
Content-Type: multipart/mixed; boundary="------------TgIc1mw3wP3KWyvWQvOIOMYK"

--------------TgIc1mw3wP3KWyvWQvOIOMYK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDUuMjIgMDU6MjEsIExhaSBKaWFuZ3NoYW4gd3JvdGU6DQo+IEZyb206IExhaSBK
aWFuZ3NoYW4gPGppYW5nc2hhbi5sanNAYW50Z3JvdXAuY29tPg0KPiANCj4gVGhlIG1hY3Jv
IGlkdGVudHJ5IGNhbGxzIGVycm9yX2VudHJ5KCkgdW5jb25kaXRpb25hbGx5IGV2ZW4gb24g
WEVOUFYuDQo+IEJ1dCB0aGUgY29kZSBYRU5QViBuZWVkcyBpbiBlcnJvcl9lbnRyeSgpIGlz
IFBVU0hfQU5EX0NMRUFSX1JFR1Mgb25seS4NCj4gDQo+IEFuZCBQVVNIX0FORF9DTEVBUl9S
RUdTIGluIGVycm9yX2VudHJ5KCkgbWFrZXMgdGhlIHN0YWNrIG5vdCByZXR1cm4gdG8NCj4g
aXRzIG9yaWdpbmFsIHBsYWNlIHdoZW4gdGhlIGZ1bmN0aW9uIHJldHVybnMsIHdoaWNoIG1l
YW5zIGl0IGlzIG5vdA0KPiBwb3NzaWJsZSB0byBjb252ZXJ0IGl0IHRvIGEgQyBmdW5jdGlv
bi4NCj4gDQo+IE1vdmUgUFVTSF9BTkRfQ0xFQVJfUkVHUyBvdXQgb2YgZXJyb3JfZW50cnko
KSwgYWRkIGEgZnVuY3Rpb24gdG8gd3JhcA0KPiBQVVNIX0FORF9DTEVBUl9SRUdTIGFuZCBj
YWxsIGl0IGJlZm9yZSBlcnJvcl9lbnRyeSgpLg0KPiANCj4gSXQgd2lsbCBhbGxvdyBmb3Ig
ZXJyb3JfZW50cnkoKSB0byBiZSBub3QgY2FsbGVkIG9uIFhFTlBWIGFuZCBmb3INCj4gZXJy
b3JfZW50cnkoKSB0byBiZSBjb252ZXJ0ZWQgdG8gQyBjb2RlLg0KPiANCj4gQ2M6IEp1ZXJn
ZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTGFpIEppYW5n
c2hhbiA8amlhbmdzaGFuLmxqc0BhbnRncm91cC5jb20+DQoNClJldmlld2VkLWJ5OiBKdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------TgIc1mw3wP3KWyvWQvOIOMYK
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------TgIc1mw3wP3KWyvWQvOIOMYK--

--------------Em6ASg0TCWU5pwzVxFXaMdAj--

--------------KwRiUTIWkRhKCzpRQZSTzRza
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJw2FsFAwAAAAAACgkQsN6d1ii/Ey9E
xgf+NCMdVj2Z7sCBaGJEVBROo+/1wSxS/aaNA/QBiF38BfoJZ4YZ67FgVMAzr9KG/Ytq9fBZnIX3
TQIvxG6R6chtV9BBNwNo3hSdO2sZGey3L3+dLQtzxTSAPfpCaDruvH2m+JdQRbec0X0A/uPnTtel
/85ZhYWl5p0SrhU2Sr2YZnMbKA7BWUTG9eYqwrcY4U9lSC9evKi9P1sRzS/VJBiGZFIiKKS0iU4/
4iRS8ikeditSykBU02neQlGpT3C93/0Wfn6I/xzXdSF3ZJH+yPD7V+majybMAa5yBw5PHMgPwCvA
7A40EDYz9pkrHkG8OhC7uCDOazOpyWC6Wt9jMHtECA==
=fLgN
-----END PGP SIGNATURE-----

--------------KwRiUTIWkRhKCzpRQZSTzRza--
