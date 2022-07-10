Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E670D56CD42
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 07:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiGJFef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 01:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJFed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 01:34:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128414D24
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 22:34:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A100B21F58;
        Sun, 10 Jul 2022 05:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657431270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OLa6hNL7L9C4iErVzQN4e+EJTyfdTuUa1Bz+P0yvcJ8=;
        b=rVKk/ARhgwFZbLuWWt4ixIllgMVJDOW502fqQEAGP0eWmeS3OwQTzseIkH+7OQ1FXEdoOV
        opKd4IziHCXYhTFiC2vik2TqhXKFG+lPGgb2ZntY5zRAVGoK1FRlP4NDmwhL7Bu3+tSLpZ
        OccpKHJM/NbqGitwGFjvDRLusOj18wg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 799DF13638;
        Sun, 10 Jul 2022 05:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XEIdHOZkymIiTAAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 10 Jul 2022 05:34:30 +0000
Message-ID: <995c95e2-6df7-4c96-94c0-f069635a1044@suse.com>
Date:   Sun, 10 Jul 2022 07:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <9d547826-d4f8-1547-c842-6eded10a7584@molgen.mpg.de>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: Lots of XEN init functions called in non-XEN environment
In-Reply-To: <9d547826-d4f8-1547-c842-6eded10a7584@molgen.mpg.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ywijOeQYnMfu4NtG09TwKltv"
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
--------------ywijOeQYnMfu4NtG09TwKltv
Content-Type: multipart/mixed; boundary="------------oYe1aFiOOeipbheLAp7LvbiM";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <995c95e2-6df7-4c96-94c0-f069635a1044@suse.com>
Subject: Re: Lots of XEN init functions called in non-XEN environment
References: <9d547826-d4f8-1547-c842-6eded10a7584@molgen.mpg.de>
In-Reply-To: <9d547826-d4f8-1547-c842-6eded10a7584@molgen.mpg.de>

--------------oYe1aFiOOeipbheLAp7LvbiM
Content-Type: multipart/mixed; boundary="------------xnv5yJeidzGvavarsLLO21j8"

--------------xnv5yJeidzGvavarsLLO21j8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMDcuMjIgMTg6MjksIFBhdWwgTWVuemVsIHdyb3RlOg0KPiBEZWFyIExpbnV4IGZv
bGtzLA0KPiANCj4gDQo+IEJvb3RpbmcgRGViaWFu4oCZcyBMaW51eCBrZXJuZWwgd2l0aCBg
aW5pdGNhbGxfZGVidWdgIG9uIGEgbGFwdG9wIHdpdGggbm8gWEVOIA0KPiBiZWluZyB1c2Vk
LCBJIHNlZSBhIGxvdCBvZiBYZW4gcmVsYXRlZCBpbml0IGZ1bmN0aW9ucyB0byBiZSBjYWxs
ZWQuDQo+IA0KPiBgYGANCj4gJCBzdWRvIGRtZXNnIHwgZ3JlcCAtZSBiYWxsb29uIC1lIHhl
bg0KPiBbwqDCoMKgIDAuMDY2MjA3XSBjYWxsaW5nwqAgeGVuX2NvbnNfaW5pdCsweDAvMHg1
MCBAIDANCj4gW8KgwqDCoCAwLjA2NjIxMF0gaW5pdGNhbGwgeGVuX2NvbnNfaW5pdCsweDAv
MHg1MCByZXR1cm5lZCAwIGFmdGVyIDAgdXNlY3MNCj4gW8KgwqDCoCAwLjA5NjQ5MV0gY2Fs
bGluZ8KgIHhlbl9wdmhfZ250dGFiX3NldHVwKzB4MC8weDM0IEAgMQ0KPiBbwqDCoMKgIDAu
MDk2NDkxXSBpbml0Y2FsbCB4ZW5fcHZoX2dudHRhYl9zZXR1cCsweDAvMHgzNCByZXR1cm5l
ZCAtMTkgYWZ0ZXIgMCB1c2Vjcw0KPiBbwqDCoMKgIDAuMTAwMzUzXSBjYWxsaW5nwqAgeGVu
YnVzX2luaXQrMHgwLzB4MzIyIEAgMQ0KPiBbwqDCoMKgIDAuMTAwMzUzXSBpbml0Y2FsbCB4
ZW5idXNfaW5pdCsweDAvMHgzMjIgcmV0dXJuZWQgLTE5IGFmdGVyIDAgdXNlY3MNCj4gW8Kg
wqDCoCAwLjEwMDM1M10gY2FsbGluZ8KgIHJlZ2lzdGVyX3hlbl9wY2lfbm90aWZpZXIrMHgw
LzB4MmQgQCAxDQo+IFvCoMKgwqAgMC4xMDAzNTNdIGluaXRjYWxsIHJlZ2lzdGVyX3hlbl9w
Y2lfbm90aWZpZXIrMHgwLzB4MmQgcmV0dXJuZWQgMCBhZnRlciAwIHVzZWNzDQo+IFvCoMKg
wqAgMC4xMDAzNTNdIGNhbGxpbmfCoCB4ZW5fcGNwdV9pbml0KzB4MC8weGI1IEAgMQ0KPiBb
wqDCoMKgIDAuMTAwMzUzXSBpbml0Y2FsbCB4ZW5fcGNwdV9pbml0KzB4MC8weGI1IHJldHVy
bmVkIC0xOSBhZnRlciAwIHVzZWNzDQo+IFvCoMKgwqAgMC4xNjk0NjVdIGNhbGxpbmfCoCBi
YWxsb29uX2luaXQrMHgwLzB4MWUwIEAgMQ0KPiBbwqDCoMKgIDAuMTY5NDY3XSBpbml0Y2Fs
bCBiYWxsb29uX2luaXQrMHgwLzB4MWUwIHJldHVybmVkIC0xOSBhZnRlciAwIHVzZWNzDQo+
IFvCoMKgwqAgMC4xNjk0NzBdIGNhbGxpbmfCoCB4ZW5fc2V0dXBfc2h1dGRvd25fZXZlbnQr
MHgwLzB4MzAgQCAxDQo+IFvCoMKgwqAgMC4xNjk0NzNdIGluaXRjYWxsIHhlbl9zZXR1cF9z
aHV0ZG93bl9ldmVudCsweDAvMHgzMCByZXR1cm5lZCAtMTkgYWZ0ZXIgMCANCj4gdXNlY3MN
Cj4gW8KgwqDCoCAwLjE2OTQ3Nl0gY2FsbGluZ8KgIHhlbmJ1c19wcm9iZV9iYWNrZW5kX2lu
aXQrMHgwLzB4NmIgQCAxDQo+IFvCoMKgwqAgMC4xNjk0ODJdIGluaXRjYWxsIHhlbmJ1c19w
cm9iZV9iYWNrZW5kX2luaXQrMHgwLzB4NmIgcmV0dXJuZWQgMCBhZnRlciAwIHVzZWNzDQo+
IFvCoMKgwqAgMC4xNjk0ODVdIGNhbGxpbmfCoCB4ZW5idXNfcHJvYmVfZnJvbnRlbmRfaW5p
dCsweDAvMHg0ZiBAIDENCj4gW8KgwqDCoCAwLjE2OTQ4OV0gaW5pdGNhbGwgeGVuYnVzX3By
b2JlX2Zyb250ZW5kX2luaXQrMHgwLzB4NGYgcmV0dXJuZWQgMCBhZnRlciAwIA0KPiB1c2Vj
cw0KPiBbwqDCoMKgIDAuMTY5NDkxXSBjYWxsaW5nwqAgeGVuX2FjcGlfcGFkX2luaXQrMHgw
LzB4M2MgQCAxDQo+IFvCoMKgwqAgMC4xNjk0OTNdIGluaXRjYWxsIHhlbl9hY3BpX3BhZF9p
bml0KzB4MC8weDNjIHJldHVybmVkIC0xOSBhZnRlciAwIHVzZWNzDQo+IFvCoMKgwqAgMC4y
NTc2NDBdIGNhbGxpbmfCoCB4ZW5mYl9pbml0KzB4MC8weDNiIEAgMQ0KPiBbwqDCoMKgIDAu
MjU3NjQyXSBpbml0Y2FsbCB4ZW5mYl9pbml0KzB4MC8weDNiIHJldHVybmVkIC0xOSBhZnRl
ciAwIHVzZWNzDQo+IFvCoMKgwqAgMC4yNTk0OThdIGNhbGxpbmfCoCB4ZW5idXNfcHJvYmVf
aW5pdGNhbGwrMHgwLzB4NmYgQCAxDQo+IFvCoMKgwqAgMC4yNTk1OTldIGluaXRjYWxsIHhl
bmJ1c19wcm9iZV9pbml0Y2FsbCsweDAvMHg2ZiByZXR1cm5lZCAwIGFmdGVyIDk4IHVzZWNz
DQo+IFvCoMKgwqAgMC4yNTk2MTVdIGNhbGxpbmfCoCB4ZW5idXNfaW5pdCsweDAvMHgzYiBA
IDENCj4gW8KgwqDCoCAwLjI1OTYxN10gaW5pdGNhbGwgeGVuYnVzX2luaXQrMHgwLzB4M2Ig
cmV0dXJuZWQgLTE5IGFmdGVyIDAgdXNlY3MNCj4gW8KgwqDCoCAwLjI1OTYyMF0gY2FsbGlu
Z8KgIHhlbmJ1c19iYWNrZW5kX2luaXQrMHgwLzB4NDQgQCAxDQo+IFvCoMKgwqAgMC4yNTk2
MjJdIGluaXRjYWxsIHhlbmJ1c19iYWNrZW5kX2luaXQrMHgwLzB4NDQgcmV0dXJuZWQgLTE5
IGFmdGVyIDAgdXNlY3MNCj4gW8KgwqDCoCAwLjI1OTY2Nl0gY2FsbGluZ8KgIHhlbl9sYXRl
X2luaXRfbWNlbG9nKzB4MC8weDVlIEAgMQ0KPiBbwqDCoMKgIDAuMjU5NjY4XSBpbml0Y2Fs
bCB4ZW5fbGF0ZV9pbml0X21jZWxvZysweDAvMHg1ZSByZXR1cm5lZCAtMTkgYWZ0ZXIgMCB1
c2Vjcw0KPiBbwqDCoMKgIDAuMjU5ODExXSBjYWxsaW5nwqAgeGVuX2h2Y19pbml0KzB4MC8w
eDFkZSBAIDENCj4gW8KgwqDCoCAwLjI1OTgxM10gaW5pdGNhbGwgeGVuX2h2Y19pbml0KzB4
MC8weDFkZSByZXR1cm5lZCAtMTkgYWZ0ZXIgMCB1c2Vjcw0KPiBbwqDCoMKgIDAuMjYzNzk0
XSBjYWxsaW5nwqAgeGVua2JkX2luaXQrMHgwLzB4M2IgQCAxDQo+IFvCoMKgwqAgMC4yNjM3
OTZdIGluaXRjYWxsIHhlbmtiZF9pbml0KzB4MC8weDNiIHJldHVybmVkIC0xOSBhZnRlciAw
IHVzZWNzDQo+IFvCoMKgwqAgMC4yODUxODFdIGNhbGxpbmfCoCBiYWxsb29uX3dhaXRfZmlu
aXNoKzB4MC8weGRhIEAgMQ0KPiBbwqDCoMKgIDAuMjg1MTgzXSBpbml0Y2FsbCBiYWxsb29u
X3dhaXRfZmluaXNoKzB4MC8weGRhIHJldHVybmVkIC0xOSBhZnRlciAwIHVzZWNzDQo+IGBg
YA0KPiANCj4gQWxsIHRoZXNlIGRyaXZlcnMoPykgYXJlIGVuYWJsZWQgaW4gRGViaWFu4oCZ
cyBMaW51eCBjb25maWd1cmF0aW9uIHRvIGFsc28gc3VwcG9ydCANCj4gWEVOIHNldHVwcywg
YnV0IEkgd29uZGVyLCBpZiB0aGUgc3lzdGVtIGNhbuKAmXQgZGV0ZWN0IG9uY2UgaWYgaXTi
gJlzIHJ1bm5pbmcgaW4gYSANCj4gWEVOIGVudmlyb25tZW50LCBhbmQgaWYgaXTigJlzIG5v
dCB0aGVuIHRvIHNraXAgYWxsIHRoZSBYRU4gcmVsYXRlZCBpbml0IGZ1bmN0aW9ucy4NCg0K
WW91IGFyZSBhd2FyZSBob3cgaW5pdGNhbGwgaXMgd29ya2luZz8gSWYgbm90LCBJJ2QgcmVj
b21tZW5kIHRvIHJlYWQgdGhlDQpjb2RlLg0KDQpTbyBob3cgd291bGQgeW91IHNraXAgaW5p
dGNhbGxzIGZvciBYZW4gb3RoZXIgdGhhbiBiYWlsaW5nIG91dCBlYXJseSBpbg0KZWFjaCBY
ZW4gcmVsYXRlZCBpbml0Y2FsbCBpZiB0aGUgc3lzdGVtIGlzIG5vdCBydW5uaW5nIGFzIGEg
WGVuIGd1ZXN0LA0Kd2hpY2ggaXMgaG93IGl0IHdvcmtzIHRvZGF5Pw0KDQoNCkp1ZXJnZW4N
Cg==
--------------xnv5yJeidzGvavarsLLO21j8
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------xnv5yJeidzGvavarsLLO21j8--

--------------oYe1aFiOOeipbheLAp7LvbiM--

--------------ywijOeQYnMfu4NtG09TwKltv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmLKZOUFAwAAAAAACgkQsN6d1ii/Ey+U
4gf+LF41bcvmCYRBeAaUf3PhXYcT1NWhqRd3zJEGMZGZo62OP4LH/qAY6QU6zzdwRkmyNOxgBlc4
pv0/nKmYNT/+d5IqGJ6gAi601kxZUbxKx+tPjAzzYgYnglNg5O/cASSReRq2kkS6leADuDJi9fVq
Q8FaSBKAOiXI5iK1GuaqDlYLmrDuX6n0QidY4sU2wyUiHt1zcjDQvpTBRmr5MoXxunNaNK49/njd
vV21Y5vjECt3tI2v4S5NrbpzhtwKgQSw4xk9u6R6diYo4RnWz6kPCYu1uA0EANoR7Y9SE5tZezEp
1ORsmtPxHBHAK41b07jRS3TeUeX+dUTqlPvZLpzuMQ==
=E3ne
-----END PGP SIGNATURE-----

--------------ywijOeQYnMfu4NtG09TwKltv--
