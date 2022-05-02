Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3D3516FBD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385072AbiEBMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385060AbiEBMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:46:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982CF13EA8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:42:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49F2C1F38D;
        Mon,  2 May 2022 12:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651495371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xgm4ncx470cGggZLgVgaWjDmGH77PXuStFOsEvpnKuA=;
        b=GesygcDIQ6YbGF8QBPFDxalMykXY+FjBGWk3ktEBvjeCFM4+0p2hnni6kuVDa/eyEdvwzS
        Ha+bTdqQkymGS7IYXjmxJe01IMgxTFem4ahcUeE+fYrSSoHGtyEgQfRknuFsx9ScjzN94H
        ji83OdQQFw7pWN8/MqkIj3/gVa5YO1Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC691133E5;
        Mon,  2 May 2022 12:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GjU6NMrRb2K8fwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 02 May 2022 12:42:50 +0000
Message-ID: <6c0dd7c7-593b-d8cf-347b-3d32310fcc11@suse.com>
Date:   Mon, 2 May 2022 14:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-4-jiangshanlai@gmail.com> <YmmBHABKMk7Ctx46@zn.tnic>
 <CAJhGHyANWhu-HX20_4XhgACE8tUd8SFa5BTH-ynJscNQ7QxBRw@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH V6 3/8] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
In-Reply-To: <CAJhGHyANWhu-HX20_4XhgACE8tUd8SFa5BTH-ynJscNQ7QxBRw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1JwBUxJAdhW3J26I4MnuZyS9"
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1JwBUxJAdhW3J26I4MnuZyS9
Content-Type: multipart/mixed; boundary="------------YqP1iwCRBUTIZeXz0804kjpB";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 X86 ML <x86@kernel.org>, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6c0dd7c7-593b-d8cf-347b-3d32310fcc11@suse.com>
Subject: Re: [PATCH V6 3/8] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-4-jiangshanlai@gmail.com> <YmmBHABKMk7Ctx46@zn.tnic>
 <CAJhGHyANWhu-HX20_4XhgACE8tUd8SFa5BTH-ynJscNQ7QxBRw@mail.gmail.com>
In-Reply-To: <CAJhGHyANWhu-HX20_4XhgACE8tUd8SFa5BTH-ynJscNQ7QxBRw@mail.gmail.com>

--------------YqP1iwCRBUTIZeXz0804kjpB
Content-Type: multipart/mixed; boundary="------------dcDkuqcQuUZZxGvU0KNv8qYn"

--------------dcDkuqcQuUZZxGvU0KNv8qYn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDQuMjIgMDI6MzMsIExhaSBKaWFuZ3NoYW4gd3JvdGU6DQo+IE9uIFRodSwgQXBy
IDI4LCAyMDIyIGF0IDE6NDUgQU0gQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+IHdy
b3RlOg0KPj4NCj4+IE9uIFRodSwgQXByIDIxLCAyMDIyIGF0IDEwOjEwOjUwUE0gKzA4MDAs
IExhaSBKaWFuZ3NoYW4gd3JvdGU6DQo+Pj4gRnJvbTogTGFpIEppYW5nc2hhbiA8amlhbmdz
aGFuLmxqc0BhbnRncm91cC5jb20+DQo+Pj4NCj4+PiBUaGUgbWFjcm8gaWR0ZW50cnkgY2Fs
bHMgZXJyb3JfZW50cnkoKSB1bmNvbmRpdGlvbmFsbHkgZXZlbiBvbiBYRU5QVi4NCj4+PiBC
dXQgdGhlIGNvZGUgWEVOUFYgbmVlZHMgaW4gZXJyb3JfZW50cnkoKSBpcyBQVVNIX0FORF9D
TEVBUl9SRUdTIG9ubHkuDQo+Pj4gQW5kIGVycm9yX2VudHJ5KCkgYWxzbyBjYWxscyBzeW5j
X3JlZ3MoKSB3aGljaCBoYXMgdG8gZGVhbCB3aXRoIHRoZQ0KPj4+IGNhc2Ugb2YgWEVOUFYg
dmlhIGFuIGV4dHJhIGJyYW5jaCBzbyB0aGF0IGl0IGRvZXNuJ3QgY29weSB0aGUgcHRfcmVn
cy4NCj4+DQo+PiBXaGF0IGV4dHJhIGJyYW5jaD8NCj4+DQo+PiBEbyB5b3UgbWVhbiB0aGUN
Cj4+DQo+PiAgICAgICAgICBpZiAocmVncyAhPSBlcmVncykNCj4+DQo+PiB0ZXN0IGluIHN5
bmNfcmVncygpPw0KPiANCj4gSGVsbG8sIEJvcmlzbGF2DQo+IA0KPiBZZXMuDQo+IA0KPj4N
Cj4+IEknbSBjb25mdXNlZC4gQXJlIHlvdSwgcGVyIGNoYW5jZSwgYWltaW5nIHRvIG9wdGlt
aXplIFhFTlBWIGhlcmUgb3INCj4+IHdoYXQncyB1cD8NCj4gDQo+IA0KPiBUaGUgYnJhbmNo
IGluIHN5bmNfcmVncygpIGNhbiBiZSBvcHRpbWl6ZWQgb3V0IGZvciB0aGUgbm9uLVhFTlBW
IGNhc2UNCj4gc2luY2UgWEVOUFYgZG9lc24ndCBjYWxsIHN5bmNfcmVncygpIGFmdGVyIHBh
dGNoNSB3aGljaCBtYWtlcyBYRU5QVg0KPiBub3QgY2FsbCBlcnJvcl9lbnRyeSgpLg0KPiAN
Cj4gVGhlIGFpbSBvZiB0aGlzIHBhdGNoIGFuZCBtb3N0IG9mIHRoZSBwYXRjaHNldCBpcyB0
byBtYWtlDQo+IGVycm9yX2VudHJ5KCkgYmUgYWJsZSB0byBiZSBjb252ZXJ0ZWQgdG8gQy4g
IEFuZCBYRU5QViBjYXNlcyBjYW4NCj4gYWxzbyBiZSBvcHRpbWl6ZWQgaW4gdGhlIHBhdGNo
c2V0IGFsdGhvdWdoIGl0IGlzIG5vdCB0aGUgbWFqb3IgbWFpbi4NCj4gDQo+Pg0KPj4+IEFu
ZCBQVVNIX0FORF9DTEVBUl9SRUdTIGluIGVycm9yX2VudHJ5KCkgbWFrZXMgdGhlIHN0YWNr
IG5vdCByZXR1cm4gdG8NCj4+PiBpdHMgb3JpZ2luYWwgcGxhY2Ugd2hlbiB0aGUgZnVuY3Rp
b24gcmV0dXJucywgd2hpY2ggbWVhbnMgaXQgaXMgbm90DQo+Pj4gcG9zc2libGUgdG8gY29u
dmVydCBpdCB0byBhIEMgZnVuY3Rpb24uDQo+Pj4NCj4+PiBNb3ZlIFBVU0hfQU5EX0NMRUFS
X1JFR1Mgb3V0IG9mIGVycm9yX2VudHJ5KCksIGFkZCBhIGZ1bmN0aW9uIHRvIHdyYXANCj4+
PiBQVVNIX0FORF9DTEVBUl9SRUdTIGFuZCBjYWxsIGl0IGJlZm9yZSBlcnJvcl9lbnRyeSgp
Lg0KPj4+DQo+Pj4gVGhlIG5ldyBmdW5jdGlvbiBjYWxsIGFkZHMgdHdvIGluc3RydWN0aW9u
cyAoQ0FMTCBhbmQgUkVUKSBmb3IgZXZlcnkNCj4+PiBpbnRlcnJ1cHQgb3IgZXhjZXB0aW9u
Lg0KPj4NCj4+IE5vdCBvbmx5IC0gaXQgcHVzaGVzIGFsbCB0aGUgcmVncyBpbiBQVVNIX0FO
RF9DTEVBUl9SRUdTIHRvby4gSSBkb24ndA0KPj4gdW5kZXJzdGFuZCB3aHkgdGhhdCBtYXR0
ZXJzIGhlcmU/IEl0IHdhcyBkb25lIGluIGVycm9yX2VudHJ5IGFueXdheS4NCj4+DQo+IA0K
PiBDb21wYXJlZCB0byB0aGUgb3JpZ2luYWwgY29kZSwgYWRkaW5nIHRoZSBuZXcgZnVuY3Rp
b24gY2FsbCBhZGRzIHR3bw0KPiBpbnN0cnVjdGlvbnMgKENBTEwgYW5kIFJFVCkgZm9yIGV2
ZXJ5IGludGVycnVwdCBvciBleGNlcHRpb24uDQo+IA0KPiBQVVNIX0FORF9DTEVBUl9SRUdT
IGlzIG5vdCBleHRyYSBpbnN0cnVjdGlvbnMgYWRkZWQgaGVyZS4NCj4gDQo+IFNpbmNlIHRo
aXMgcGF0Y2ggYWRkcyBleHRyYSBvdmVyaGVhZCAoQ0FMTCBhbmQgUkVUKSwgdGhlIGNoYW5n
ZWxvZw0KPiBoYXMgdG8gZXhwbGFpbiB3aHkgaXQgaXMgd29ydGggaXQgbm90IGp1c3QgZm9y
IGNvbnZlcnRpbmcgQVNNIHRvIEMuDQo+IA0KPiBUaGUgZXhwbGFuYXRpb24gaW4gdGhlIGNo
YW5nZWxvZyBpcyB0aGF0IGl0IGNhbiBiZSBvZmZzZXR0ZWQgYnkgbGF0ZXINCj4gcmVkdWNl
ZCBvdmVyaGVhZC4NCg0KSSB0aGluayB5b3UgY291bGQgYXZvaWQgdGhlIGV4dHJhIGNhbGwv
cmV0IGJ5IGRvaW5nIHNvbWV0aGluZyBsaWtlOg0KDQpTWU1fQ09ERV9TVEFSVF9MT0NBTChl
cnJvcl9leGl0X3B1c2hfYW5kX3NhdmUpDQoJVU5XSU5EX0hJTlRfRlVOQw0KCVBVU0hfQU5E
X0NMRUFSX1JFR1Mgc2F2ZV9yZXQ9MQ0KCUVOQ09ERV9GUkFNRV9QT0lOVEVSIDgNCglqbXAg
ZXJyb3JfZXhpdA0KU1lNX0NPREVfRU5EKGVycm9yX2V4aXRfcHVzaF9hbmRfc2F2ZSkNCg0K
Li4uIGFuZCB1c2UgdGhpcyBpbnN0ZWFkIG9mIHBhdGNoIDU6DQoNCglBTFRFUk5BVElWRSAi
Y2FsbCBlcnJvcl9lbnRyeV9wdXNoX2FuZF9zYXZlOyBtb3ZxICVyYXgsICVyc3AiLCBcDQoJ
CSJjYWxsIHB1c2hfYW5kX2NsZWFyX3JlZ3MiLCBYODZfRkVBVFVSRV9YRU5QVg0KDQoNCkp1
ZXJnZW4NCg0K
--------------dcDkuqcQuUZZxGvU0KNv8qYn
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------dcDkuqcQuUZZxGvU0KNv8qYn--

--------------YqP1iwCRBUTIZeXz0804kjpB--

--------------1JwBUxJAdhW3J26I4MnuZyS9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJv0coFAwAAAAAACgkQsN6d1ii/Ey9t
cQf/T/qaEXMWEP2zMxRuVzZ+BNzlimARvAKy4BUlLdBuxZbEnQW0E9QIoXzcJQqxkZIMWn4vYgVu
1a2Gv7ln+t+PsnsMQDJdQ9yRgQOprGJJIcHL2lUwQ+YC8r2HZ5eLq6rtZbxbeHcnd/xbaglNhATL
hy3jtjsysmP5NmqjfC8g2NlH2Kdlx9rRAa58OLungD5vzpdou0U5xr/lKU2w2GkIc0cK2F8v1CRE
0DPC+6A8TZEPgc2TyPeEB0wwgNbOWeom4mhB+zlwQPvt2iOTGw001umPEjffZ4E4wO4RvdEu9err
sBF0nNSd1acPHS/ClA5SrqCbJi06ht9bwKGpWD70fA==
=IuUX
-----END PGP SIGNATURE-----

--------------1JwBUxJAdhW3J26I4MnuZyS9--
