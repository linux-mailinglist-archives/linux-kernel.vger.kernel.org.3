Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB92519794
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbiEDGvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiEDGvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:51:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F62018B
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:48:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15430210EB;
        Wed,  4 May 2022 06:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651646896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbspsJMuVnIA/+bk1eeLyjrei0zgpOL16RxvXGaIiu4=;
        b=UYc7J1K4q2+vsfjxTSr3gzMM2izceMF4NBwrmpaTOP/OhudG8NStc8hiuHgPcM+o4IQGw9
        PyoXJ6TinybfySIlY2Duck2SvoJewirZCwp0MZfHQZ7zBNDwBPHsf8rBhU85IHM7slTPiV
        7PRxWaUr74Muve3lt9JgnxuFG7U/WzA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF40B132C4;
        Wed,  4 May 2022 06:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eGAMKa8hcmKBQgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 04 May 2022 06:48:15 +0000
Message-ID: <fa6967cf-a718-4be2-2591-b675e2095b4c@suse.com>
Date:   Wed, 4 May 2022 08:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Xorg SEGV in Xen PV dom0 after updating from 5.16.18 to 5.17.5
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     regressions@lists.linux.dev,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <YnHK1Z3o99eMXsVK@mail-itl>
 <f4b00553-4e77-84bc-e25c-01383d7e92dd@leemhuis.info>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <f4b00553-4e77-84bc-e25c-01383d7e92dd@leemhuis.info>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1E0EoqKnmcW488obHySs1mGf"
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
--------------1E0EoqKnmcW488obHySs1mGf
Content-Type: multipart/mixed; boundary="------------vlG2q2nqgzakUnYMF8t7zZ5M";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Lucas De Marchi <lucas.demarchi@intel.com>
Cc: regressions@lists.linux.dev,
 =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>, Jani Nikula
 <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-ID: <fa6967cf-a718-4be2-2591-b675e2095b4c@suse.com>
Subject: Re: Xorg SEGV in Xen PV dom0 after updating from 5.16.18 to 5.17.5
References: <YnHK1Z3o99eMXsVK@mail-itl>
 <f4b00553-4e77-84bc-e25c-01383d7e92dd@leemhuis.info>
In-Reply-To: <f4b00553-4e77-84bc-e25c-01383d7e92dd@leemhuis.info>

--------------vlG2q2nqgzakUnYMF8t7zZ5M
Content-Type: multipart/mixed; boundary="------------0W4SKOQR4zMY20VDjAOOolpL"

--------------0W4SKOQR4zMY20VDjAOOolpL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDUuMjIgMDc6NDYsIFRob3JzdGVuIExlZW1odWlzIHdyb3RlOg0KPiBIaSwgdGhp
cyBpcyB5b3VyIExpbnV4IGtlcm5lbCByZWdyZXNzaW9uIHRyYWNrZXIuIFNlbmRpbmcgdGhp
cyBqdXN0IHRvDQo+IENDIHRoZSBkZXZlbG9wZXJzIG9mIHRoZSBjdWxwcml0IG1lbnRpb25l
ZCBiZWxvdyAoYmRkOGI2Yzk4MjM5Y2FkDQo+ICgiZHJtL2k5MTU6IHJlcGxhY2UgWDg2X0ZF
QVRVUkVfUEFUIHdpdGggcGF0X2VuYWJsZWQoKSIpKSBhbmQgdGhlDQo+IG1haW50YWluZXJz
IGZvciB0aGUgc3Vic3lzdGVtLg0KPiANCj4gV2hpbGUgYXQgaXQgYSBxdWljayBub3RlOiBJ
IHdvbmRlciBpZiB0aGlzIGlzIHByb2JsZW0gYSBzaW1pbGFyIHRvIG9uZQ0KPiB0aGF0IHJl
Y2VudGx5IHR1cm5lZCB1cCB3aXRoIGFtZGdwdSBhbmQgaXMgZml4ZWQgYnkgdGhpcyBwcm9i
bGVtOg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9uZXh0L2xpbnV4LW5leHQuZ2l0L2NvbW1pdC8/aWQ9NzhiMTIwMDhmMjANCg0KTm8sIHRo
aXMgaXMgZGlmZmVyZW50Lg0KDQpJIGhhdmUgcG9zdGVkIGEgcGF0Y2ggeWVzdGVyZGF5IHdo
aWNoIHNob3VsZCBmaXggdGhlIGlzc3VlOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzIwMjIwNTAzMTMyMjA3LjE3MjM0LTMtamdyb3NzQHN1c2UuY29tL1QvI203NWVmYzY4
Yzk2ZDhmNzE2MDIyOWI1ZjMxNDcyNDIyMjFjZTBjMjhjDQoNCg0KSnVlcmdlbg0KDQo+IA0K
PiBDaWFvLCBUaG9yc3Rlbg0KPiANCj4gT24gMDQuMDUuMjIgMDI6MzcsIE1hcmVrIE1hcmN6
eWtvd3NraS1Hw7NyZWNraSB3cm90ZToNCj4+DQo+PiBBZnRlciB1cGRhdGluZyBmcm9tIDUu
MTYuMTggdG8gNS4xNy41IGluIFhlbiBQViBkb20wLCBteSBYb3JnIHN0YXJ0ZWQNCj4+IGNy
YXNoaW5nIHdoZW4gZGlzcGxheWluZyBhbnkgd2luZG93IG1hcHBlZCBmcm9tIGEgZ3Vlc3Qg
KGRvbVUpIHN5c3RlbS4NCj4+IFRoaXMgaXMgMTAwJSByZXByb2R1Y2libGUuDQo+PiBUaGUg
c3lzdGVtIGlzIFF1YmVzIE9TLCBhbmQgaXQgdXNlcyBhIHRyaWNrIHRoYXQgbWFwcyB3aW5k
b3dzIGNvbnRlbnQNCj4+IGZyb20gb3RoZXIgZ3Vlc3RzIHVzaW5nIFhlbiBncmFudCB0YWJs
ZXMsIHdyYXBwZWQgYXMgInNoYXJlZCBtZW1vcnkiDQo+PiBmcm9tIFhvcmcgcG9pbnQgb2Yg
dmlldyAoc28sIHRoZSBtZW1vcnkgdGhhdCBYb3JnIG1tYXBzIGlzIG5vdCBqdXN0IGZyb20N
Cj4+IGFub3RoZXIgcHJvY2VzcywgYnV0IGZyb20gYW5vdGhlciBWTSkuIFRoYXQncyB0aGUg
U2htUHV0SW1hZ2UgeW91IGNhbg0KPj4gc2VlIG9uIHRoZSBzdGFjayB0cmFjZSBiZWxvdy4N
Cj4+DQo+PiBTdGFjayB0cmFjZSBvZiB0aHJlYWQgMTI4NTg6DQo+PiAjMCAgMHgwMDAwN2Y4
MDAyOWUxN2Q1IHJhaXNlIChsaWJjLnNvLjYgKyAweDNjN2Q1KQ0KPj4gIzEgIDB4MDAwMDdm
ODAwMjljYTg5NSBhYm9ydCAobGliYy5zby42ICsgMHgyNTg5NSkNCj4+ICMyICAweDAwMDA1
YjM0NjlhY2UwZTAgT3NBYm9ydCAoWG9yZyArIDB4MWM2MGUwKQ0KPj4gIzMgIDB4MDAwMDVi
MzQ2OWFkMzk1OSBBYm9ydFNlcnZlciAoWG9yZyArIDB4MWNiOTU5KQ0KPj4gIzQgIDB4MDAw
MDViMzQ2OWFkNDZhYSBGYXRhbEVycm9yIChYb3JnICsgMHgxY2M2YWEpDQo+PiAjNSAgMHgw
MDAwNWIzNDY5YWNiNDUwIE9zU2lnSGFuZGxlciAoWG9yZyArIDB4MWMzNDUwKQ0KPj4gIzYg
IDB4MDAwMDdmODAwMmI4NWE5MCBfX3Jlc3RvcmVfcnQgKGxpYnB0aHJlYWQuc28uMCArIDB4
MTRhOTApDQo+PiAjNyAgMHgwMDAwN2Y4MDAyYjBhMmExIF9fbWVtbW92ZV9hdnhfdW5hbGln
bmVkX2VybXMgKGxpYmMuc28uNiArIDB4MTY1MmExKQ0KPj4gIzggIDB4MDAwMDdmODAwMTVk
ZmNjOSBsaW5lYXJfdG9feHRpbGVkX2Zhc3RlciAoaXJpc19kcmkuc28gKyAweGM5MWNjOSkN
Cj4+ICM5ICAweDAwMDA3ZjgwMDE1ZTM0NzcgX2lzbF9tZW1jcHlfbGluZWFyX3RvX3RpbGVk
IChpcmlzX2RyaS5zbyArIDB4Yzk1NDc3KQ0KPj4gIzEwIDB4MDAwMDdmODAwMTQ2ODQ0MCBp
cmlzX3RleHR1cmVfc3ViZGF0YSAoaXJpc19kcmkuc28gKyAweGIxYTQ0MCkNCj4+ICMxMSAw
eDAwMDA3ZjgwMDBhNzYxMDcgc3RfVGV4U3ViSW1hZ2UgKGlyaXNfZHJpLnNvICsgMHgxMjgx
MDcpDQo+PiAjMTIgMHgwMDAwN2Y4MDAwYmU5YTQ3IHRleHR1cmVfc3ViX2ltYWdlIChpcmlz
X2RyaS5zbyArIDB4MjliYTQ3KQ0KPj4gIzEzIDB4MDAwMDdmODAwMGJlY2QwYyB0ZXhzdWJp
bWFnZV9lcnIgKGlyaXNfZHJpLnNvICsgMHgyOWVkMGMpDQo+PiAjMTQgMHgwMDAwN2Y4MDAw
YmYyOTM5IF9tZXNhX1RleFN1YkltYWdlMkQgKGlyaXNfZHJpLnNvICsgMHgyYTQ5MzkpDQo+
PiAjMTUgMHgwMDAwN2Y4MDAyMTM4MzFmIGdsYW1vcl91cGxvYWRfYm94ZXMgKGxpYmdsYW1v
cmVnbC5zbyArIDB4MWUzMWYpDQo+PiAjMTYgMHgwMDAwN2Y4MDAyMTM4NTZmIGdsYW1vcl91
cGxvYWRfcmVnaW9uIChsaWJnbGFtb3JlZ2wuc28gKyAweDFlNTZmKQ0KPj4gIzE3IDB4MDAw
MDdmODAwMjEyYWVhNiBnbGFtb3JfcHV0X2ltYWdlIChsaWJnbGFtb3JlZ2wuc28gKyAweDEw
ZWE2KQ0KPj4gIzE4IDB4MDAwMDViMzQ2OWE0ZDc5YyBkYW1hZ2VQdXRJbWFnZSAoWG9yZyAr
IDB4MTQ1NzljKQ0KPj4gIzE5IDB4MDAwMDViMzQ2OWEwMGE3ZSBQcm9jU2htUHV0SW1hZ2Ug
KFhvcmcgKyAweGY4YTdlKQ0KPj4gIzIwIDB4MDAwMDViMzQ2OTk2NWEyYiBEaXNwYXRjaCAo
WG9yZyArIDB4NWRhMmIpDQo+PiAjMjEgMHgwMDAwNWIzNDY5OTY5YjA0IGRpeF9tYWluIChY
b3JnICsgMHg2MWIwNCkNCj4+ICMyMiAweDAwMDA3ZjgwMDI5Y2MwODIgX19saWJjX3N0YXJ0
X21haW4gKGxpYmMuc28uNiArIDB4MjcwODIpDQo+PiAjMjMgMHgwMDAwNWIzNDY5OTUyZTZl
IF9zdGFydCAoWG9yZyArIDB4NGFlNmUpDQo+Pg0KPj4gRGlzYXNzZW1ibHkgb2YgdGhlIHN1
cnJvdW5kaW5nIGNvZGU6DQo+Pg0KPj4gICAgIDB4MDAwMDc1OTZhZThjODJmYiA8KzEyMz46
CWphICAgICAweDc1OTZhZThjODMzOCA8X19tZW1tb3ZlX2F2eF91bmFsaWduZWRfZXJtcysx
ODQ+DQo+PiAgICAgMHgwMDAwNzU5NmFlOGM4MmZkIDwrMTI1PjoJamIgICAgIDB4NzU5NmFl
OGM4MzA0IDxfX21lbW1vdmVfYXZ4X3VuYWxpZ25lZF9lcm1zKzEzMj4NCj4+ICAgICAweDAw
MDA3NTk2YWU4YzgyZmYgPCsxMjc+Ogltb3Z6YmwgKCVyc2kpLCVlY3gNCj4+ICAgICAweDAw
MDA3NTk2YWU4YzgzMDIgPCsxMzA+Ogltb3YgICAgJWNsLCglcmRpKQ0KPj4gICAgIDB4MDAw
MDc1OTZhZThjODMwNCA8KzEzMj46CXJldHENCj4+ICAgICAweDAwMDA3NTk2YWU4YzgzMDUg
PCsxMzM+Ogl2bW92ZHF1ICglcnNpKSwleG1tMA0KPj4gICAgIDB4MDAwMDc1OTZhZThjODMw
OSA8KzEzNz46CXZtb3ZkcXUgLTB4MTAoJXJzaSwlcmR4LDEpLCV4bW0xDQo+PiA9PiAweDAw
MDA3NTk2YWU4YzgzMGYgPCsxNDM+Ogl2bW92ZHF1ICV4bW0wLCglcmRpKQ0KPj4gICAgIDB4
MDAwMDc1OTZhZThjODMxMyA8KzE0Nz46CXZtb3ZkcXUgJXhtbTEsLTB4MTAoJXJkaSwlcmR4
LDEpDQo+PiAgICAgMHgwMDAwNzU5NmFlOGM4MzE5IDwrMTUzPjoJcmV0cQ0KPj4NCj4+DQo+
PiBJIGRvbid0IHNlZSBhbnkgcmVsYXRlZCBrZXJuZWwgb3IgWGVuIG1lc3NhZ2VzIGF0IHRo
aXMgdGltZS4gWG9yZydzIFNFR1YNCj4+IGhhbmRsZXIgcHJpbnRzIGFsc286DQo+Pg0KPj4g
ICAgICAoRUUpIFNlZ21lbnRhdGlvbiBmYXVsdCBhdCBhZGRyZXNzIDB4M2MwMTANCj4+DQo+
PiBHaXQgYmlzZWN0IHNheXMgaXQncyBiZGQ4YjZjOTgyMzljYWQgKCJkcm0vaTkxNTogcmVw
bGFjZSBYODZfRkVBVFVSRV9QQVQNCj4+IHdpdGggcGF0X2VuYWJsZWQoKSIpLCBhbmQgaW5k
ZWVkIHdpdGggdGhpcyBjb21taXQgcmV2ZXJ0ZWQgb24gdG9wIG9mDQo+PiA1LjE3LjUgZXZl
cnl0aGluZyB3b3JrcyBmaW5lLg0KPj4NCj4+IEkgZ3Vlc3MgdGhpcyBwYXJ0IG9mIGRvbTAn
cyBib290IGRtZXNnIG1heSBiZSByZWxldmFudDoNCj4+DQo+PiBbICAgIDAuMDAwOTQ5XSB4
ODYvUEFUOiBNVFJScyBkaXNhYmxlZCwgc2tpcHBpbmcgUEFUIGluaXRpYWxpemF0aW9uIHRv
by4NCj4+IFsgICAgMC4wMDA5NTNdIHg4Ni9QQVQ6IENvbmZpZ3VyYXRpb24gWzAtN106IFdC
ICBXVCAgVUMtIFVDICBXQyAgV1AgIFVDICBVQw0KPj4NCj4+IE9yaWdpbmFsbHkgcmVwb3J0
ZWQgYXQNCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9RdWJlc09TL3F1YmVzLWlzc3Vlcy9pc3N1
ZXMvNzQ3OQ0KPj4NCj4+ICAgDQo+PiAjcmVnemJvdCBpbnRyb2R1Y2VkIGJkZDhiNmM5ODIz
OWNhZA0KPj4gI3JlZ3pib3QgbW9uaXRvcjogaHR0cHM6Ly9naXRodWIuY29tL1F1YmVzT1Mv
cXViZXMtaXNzdWVzL2lzc3Vlcy83NDc5DQo+Pg0KDQo=
--------------0W4SKOQR4zMY20VDjAOOolpL
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0W4SKOQR4zMY20VDjAOOolpL--

--------------vlG2q2nqgzakUnYMF8t7zZ5M--

--------------1E0EoqKnmcW488obHySs1mGf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJyIa8FAwAAAAAACgkQsN6d1ii/Ey8k
CAf/RxKJ2KXpbu/LOXO2asZosy4+Ptww11i6KTzS5BL7+wXwh5/GZ9NkuLgX36r21WWa0HRrNub1
3JOabQRbIinx4OVTIPof/RixFuY6gWcsrJhp6s+xF3YgM43rIl4tIzdS+WpXKjUc8gFakQF7l073
UzSKfWVdV+MfdG2Tyz2dkmCBa07IB7ijsX731CBu39ulnHEFCrVU0Vyf5vRVXivzjM+ahFNu6mb5
wCu7Y9HiCncRPD65oLyJHzW3Ra7aBPACXILfcMUWqWiip+iRfOMkazUFZK9rw+6g/Jx3YU9uEJKp
zdbQjMIvKX9+xPmCoXy58d9wd3EfwZbhv8yjyXHTLA==
=qaxW
-----END PGP SIGNATURE-----

--------------1E0EoqKnmcW488obHySs1mGf--
