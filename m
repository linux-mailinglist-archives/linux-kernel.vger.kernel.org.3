Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135D950C884
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiDWJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiDWJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:13:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92E22F013
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:10:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9677D21107;
        Sat, 23 Apr 2022 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650705008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZcBEsRf4H4TUD/LeIhDCJzVbvZV1c9YPF146laEEeM=;
        b=EEpJluR3Y0YyLokU3njES4XnOYjNIqnoThKrkYg7sXIUUJNopUdSaqmOAirKNKsFmvV4+Q
        uzN+EI5avd9cRQv3jAaLYlAInBKvtSDY2C3BSoGC5ZhSk7QgTsvR1OB8Gke6oGp69PhFQe
        EYeaQct9YW9eufYb76CXu7ccyzP6zLM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CAFE13A1B;
        Sat, 23 Apr 2022 09:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TlqKBXDCY2JqPQAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 23 Apr 2022 09:10:08 +0000
Message-ID: <8acfaa93-50ce-8dd9-49c6-cc328bb37569@suse.com>
Date:   Sat, 23 Apr 2022 11:10:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204221526221.915916@ubuntu-linux-20-04-desktop>
 <3de2852b-0a94-fd1d-2eb6-fd818f33fc88@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <3de2852b-0a94-fd1d-2eb6-fd818f33fc88@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------o0kwwZd5WhI0vqwOQJ85oWOv"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------o0kwwZd5WhI0vqwOQJ85oWOv
Content-Type: multipart/mixed; boundary="------------DtRNb3Oo0VGbLsVI53cPNLg0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr <olekstysh@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>
Message-ID: <8acfaa93-50ce-8dd9-49c6-cc328bb37569@suse.com>
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204221526221.915916@ubuntu-linux-20-04-desktop>
 <3de2852b-0a94-fd1d-2eb6-fd818f33fc88@gmail.com>
In-Reply-To: <3de2852b-0a94-fd1d-2eb6-fd818f33fc88@gmail.com>

--------------DtRNb3Oo0VGbLsVI53cPNLg0
Content-Type: multipart/mixed; boundary="------------GUEFUP6KMNbzPrgiWpDseGco"

--------------GUEFUP6KMNbzPrgiWpDseGco
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMDQuMjIgMDk6MDUsIE9sZWtzYW5kciB3cm90ZToNCj4gDQo+IE9uIDIzLjA0LjIy
IDAyOjAwLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6DQo+IA0KPiBIZWxsbyBTdGVmYW5v
DQo+IA0KPiANCj4+IE9uIEZyaSwgMjIgQXByIDIwMjIsIE9sZWtzYW5kciBUeXNoY2hlbmtv
IHdyb3RlOg0KPj4+IEZyb206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+
Pg0KPj4+IEludHJvZHVjZSBYZW4gZ3JhbnQgRE1BLW1hcHBpbmcgbGF5ZXIgd2hpY2ggY29u
dGFpbnMgc3BlY2lhbCBETUEtbWFwcGluZw0KPj4+IHJvdXRpbmVzIGZvciBwcm92aWRpbmcg
Z3JhbnQgcmVmZXJlbmNlcyBhcyBETUEgYWRkcmVzc2VzIHRvIGJlIHVzZWQgYnkNCj4+PiBm
cm9udGVuZHMgKGUuZy4gdmlydGlvKSBpbiBYZW4gZ3Vlc3RzLg0KPj4+DQo+Pj4gSW4gb3Jk
ZXIgdG8gc3VwcG9ydCB2aXJ0aW8gaW4gWGVuIGd1ZXN0cyBhZGQgYSBjb25maWcgb3B0aW9u
IFhFTl9WSVJUSU8NCj4+PiBlbmFibGluZyB0aGUgdXNlciB0byBzcGVjaWZ5IHdoZXRoZXIg
aW4gYWxsIFhlbiBndWVzdHMgdmlydGlvIHNob3VsZA0KPj4+IGJlIGFibGUgdG8gYWNjZXNz
IG1lbW9yeSB2aWEgWGVuIGdyYW50IG1hcHBpbmdzIG9ubHkgb24gdGhlIGhvc3Qgc2lkZS4N
Cj4+Pg0KPj4+IEFzIHRoaXMgYWxzbyByZXF1aXJlcyBwcm92aWRpbmcgYXJjaF9oYXNfcmVz
dHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcw0KPj4+IGltcGxlbWVudGF0aW9uLCBzd2l0
Y2ggZnJvbSBhIHB1cmUgc3R1YiB0byBhIHJlYWwgZnVuY3Rpb24gb24gQXJtDQo+Pj4gYW5k
IGNvbWJpbmUgd2l0aCBleGlzdGluZyBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIFNFViBndWVz
dHMgb24geDg2Lg0KPj4+DQo+Pj4gQWRkIHRoZSBuZWVkZWQgZnVuY3Rpb25hbGl0eSBieSBw
cm92aWRpbmcgYSBzcGVjaWFsIHNldCBvZiBETUEgb3BzDQo+Pj4gaGFuZGxpbmcgdGhlIG5l
ZWRlZCBncmFudCBvcGVyYXRpb25zIGZvciB0aGUgSS9PIHBhZ2VzLg0KPj4+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IE9sZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0Bl
cGFtLmNvbT4NCj4+IFRoZXJlIGFyZSBhIGNvdXBsZSBvZiBtaW5vciB0aGluZ3MgdGhhdCBj
aGVja3BhdGNoLnBsIHJlcG9ydHMsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRo
aXMgb3V0LCBteSBmYXVsdC4NCj4gDQo+IA0KPj4gwqAgYnV0IGFzaWRlDQo+PiBmcm9tIHRo
b3NlIHRoZSBwYXRjaCBsb29rcyBmaW5lIHRvIG1lLg0KPiANCj4gZ29vZA0KPiANCj4gDQo+
IFRoZSBhdHRhY2hlZCBkaWZmIHRvIGJlIHNxdWFzaGVkIGZvciB0aGUgbmV3IHZlcnNpb24u
IE9uZSB0aGluZyByZW1haW5zOg0KPiANCj4gY2hlY2twYXRjaC5wbCBzYXlzIHJlZ2FyZGlu
ZyBkcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmM6DQo+IA0KPiBXQVJOSU5HOiBhZGRlZCwg
bW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRp
bmc/DQo+ICMxNTE6DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IA0KPiANCj4gV2hpY2gs
IEkgYXNzdW1lLCB0aGlzIGlzIG5vdCBhbiBpc3N1ZSBhcyBuZXcgZmlsZSBmYWxscyB1bmRl
ciBYRU4gSFlQRVJWSVNPUiANCj4gSU5URVJGQUNFIG1haW50YWluZXJzaGlwPw0KDQpZZXMu
DQoNCg0KSnVlcmdlbg0K
--------------GUEFUP6KMNbzPrgiWpDseGco
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------GUEFUP6KMNbzPrgiWpDseGco--

--------------DtRNb3Oo0VGbLsVI53cPNLg0--

--------------o0kwwZd5WhI0vqwOQJ85oWOv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJjwm8FAwAAAAAACgkQsN6d1ii/Ey+H
1wf/RIPBtwhsuLI224stYcbzkJ08tRoayokmGlxy4V+7w0pS3B8Hn8UfcC1c91lB9xMQc3SSA8CB
G3FFo9EekVBD/eHx0OkGyBzDYr6zR0xCjiUWXgyzse0uFO0kNKlUT0tC9uCO8PqR83Nejpo9mN09
UbZS4fUctvMyUgdrDXzqqitob/tRVjd6qjWXUthBgHhmGyuX5ET3kXMeAwx+UsvjQAlAS3ZVu8q0
PmEI3ZbtnWcdkiKI5r4tn7Io8wuQs1xz7gG3RD9STIgu+AiL7nK4WLWRgFcKzGsj9AWaOC/PCeiN
ZsBan4mYBQczyADAMHkjnQByzi22RN/27cKp1uROUw==
=RYNS
-----END PGP SIGNATURE-----

--------------o0kwwZd5WhI0vqwOQJ85oWOv--
