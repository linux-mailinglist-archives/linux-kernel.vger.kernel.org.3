Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D616516B22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358521AbiEBHL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358514AbiEBHLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:11:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3633FBD8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:08:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 505271F893;
        Mon,  2 May 2022 07:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651475297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/j6Eg6YlmI7iyXEZqBuBXLr/ocf52MgeS8WAphcSYV8=;
        b=iuQgPNDaOhD81DIQbtYM+zdB4DNg6dH2M9EujdpbzYBX0o3FqmcyM+10AyehxoqhL+/4Oh
        nEUDLPrAwGfsMG5F6k0+1MY9i9lepO8Tf0kbcEfm1Vnhdbo/r4sKtkxLEAg8SN4nYDmZTF
        WJQItEcJRKEsrYToHNZK+42wAsweKeI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AA4C13491;
        Mon,  2 May 2022 07:08:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nj9DAWGDb2JObQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 02 May 2022 07:08:17 +0000
Message-ID: <36f1c727-846b-0b81-192c-d2ecfce1fbf8@suse.com>
Date:   Mon, 2 May 2022 09:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428201947.GA1912192@roeck-us.net>
 <20220429003841.cx7uenepca22qbdl@revolver>
 <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
 <20220502001358.s2azy37zcc27vgdb@revolver>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
In-Reply-To: <20220502001358.s2azy37zcc27vgdb@revolver>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TG19cOB040TsYSrWWtHms0Hp"
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TG19cOB040TsYSrWWtHms0Hp
Content-Type: multipart/mixed; boundary="------------eQFY0OLHlpcTTgDu1TS5og2K";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Liam Howlett <liam.howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yu Zhao <yuzhao@google.com>
Message-ID: <36f1c727-846b-0b81-192c-d2ecfce1fbf8@suse.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428201947.GA1912192@roeck-us.net>
 <20220429003841.cx7uenepca22qbdl@revolver>
 <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
 <20220502001358.s2azy37zcc27vgdb@revolver>
In-Reply-To: <20220502001358.s2azy37zcc27vgdb@revolver>

--------------eQFY0OLHlpcTTgDu1TS5og2K
Content-Type: multipart/mixed; boundary="------------G0AS1ttLSwQrwrirTlS2RYK0"

--------------G0AS1ttLSwQrwrirTlS2RYK0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMDUuMjIgMDI6MTQsIExpYW0gSG93bGV0dCB3cm90ZToNCj4gKiBBbmRyZXcgTW9y
dG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPiBbMjIwNDI4IDIxOjE2XToNCj4+IE9u
IEZyaSwgMjkgQXByIDIwMjIgMDA6Mzg6NTAgKzAwMDAgTGlhbSBIb3dsZXR0IDxsaWFtLmhv
d2xldHRAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pg0KPj4+PiBtbS9tbWFwLmM6IEluIGZ1bmN0
aW9uICdkb19icmtfZmxhZ3MnOg0KPj4+PiBtbS9tbWFwLmM6MjkwODoxNzogZXJyb3I6IGlt
cGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uDQo+Pj4+IAkna2h1Z2VwYWdlZF9lbnRl
cl92bWFfbWVyZ2UnOyBkaWQgeW91IG1lYW4gJ2todWdlcGFnZWRfZW50ZXJfdm1hJz8NCj4+
Pj4NCj4+Pj4gSXQgYXBwZWFycyB0aGF0IHRoaXMgaXMgbGF0ZXIgZml4ZWQsIGJ1dCBpdCBo
dXJ0cyBiaXNlY3RhYmlsaXR5DQo+Pj4+IChhbmQgcHJldmVudHMgbWUgZnJvbSBmaW5kaW5n
IHRoZSBhY3R1YWwgYnVpbGQgZmFpbHVyZSBpbiBsaW51eC1uZXh0DQo+Pj4+IHdoZW4gdHJ5
aW5nIHRvIGJ1aWxkIGNvcmVuZXQ2NF9zbXBfZGVmY29uZmlnKS4NCj4+Pg0KPj4+IFllYWgs
IHRoYXQga2h1Z2VwYWdlZF9lbnRlcl92bWFfbWVyZ2Ugd2FzIHJlbmFtZWQgaW4gYW5vdGhl
ciBwYXRjaCBzZXQuDQo+Pj4gQW5kcmV3IG1hZGUgdGhlIGNvcnJlY3Rpb24gYnV0IGtlcHQg
dGhlIHBhdGNoIGFzIGl0IHdhcy4gIEkgdGhpbmsgdGhlDQo+Pj4gc3VnZ2VzdGVkIGNoYW5n
ZSBpcyByaWdodC4uIGlmIHlvdSByZWFkIHRoZSBjb21taXQgdGhhdCBpbnRyb2R1Y2VkDQo+
Pj4ga2h1Z2VwYWdlZF9lbnRlcl92bWEoKSwgaXQgc2VlbXMgcmlnaHQgYXQgbGVhc3QuDQo+
Pg0KPj4gVGhpbmdzIGFyZSBhIGJpdCBjcmF6eSBsYXRlbHkuICBNZXJnZSBpc3N1ZXMgd2l0
aCBtYXBsZXRyZWUsIG1lcmdlDQo+PiBpc3N1ZXMgd2l0aCBtZ2xydSBvbiBtYXBsZXRyZWUs
IG1lIGRvaW5nIGEgYnVuY2ggb2YgcmV0b29saW5nIHRvIHN0YXJ0DQo+PiBwdWJsaXNoaW5n
L21lcmdpbmcgdmlhIGdpdCwgbWFwbGV0cmVlIHJ1bnRpbWUgaXNzdWVzLCBldGMuDQo+Pg0K
Pj4gSSd2ZSBkcm9wcGVkIHRoZSBtYXBsZXRyZWUgcGF0Y2hlcyBhZ2Fpbi4gIFBsZWFzZSBz
Y29vcCB1cCBhbGwga25vd24NCj4+IGZpeGVzIGFuZCByZWRvIGFnYWluc3QgdGhlIChub24t
cmViYXNpbmcpIG1tLXN0YWJsZSBicmFuY2ggYXQNCj4+IGdpdDovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9ha3BtL21tDQo+IA0KPiBPa2F5LCBzb3VuZHMg
Z29vZC4NCj4gDQo+IEkgaGF2ZSBiZWVuIHBvcnRpbmcgbXkgcGF0Y2hlcyBvdmVyIGFuZCBo
aXQgYSBiaXQgb2YgYSBzbmFnLiBJdCBsb29rZWQNCj4gbGlrZSBteSBwYXRjaGVzIHdlcmUg
bm90IGJvb3Rpbmcgb24gdGhlIHMzOTAgLSBidXQgbm90IGFsbCB0aGUgdGltZS4gU28NCj4g
SSByZXZlcnRlZCBiYWNrIHRvIG1tLXN0YWJsZSAoMDU5MzQyZDFkZDRlKSBhbmQgZm91bmQg
dGhhdCBhbHNvIGZhaWxlZA0KPiB0byBib290IHNvbWV0aW1lcyBvbiBteSBxZW11IHNldHVw
LiAgV2hlbiBpdCBmYWlscyBpdCdzIH40LTVzZWMgaW50bw0KPiBib290aW5nLiAgVGhlIGxh
c3QgdGhpbmcgSSBzZWUgaXM6DQo+IA0KPiAiWyAgICA0LjY2ODkxNl0gU3BlY3RyZSBWMiBt
aXRpZ2F0aW9uOiBleGVjdXRlIHRyYW1wb2xpbmVzIg0KPiANCj4gSSd2ZSBiaXNlY3RlZCBi
YWNrIHRvIGNvbW1pdCBlNTUzZjYyZjEwZDkgKG1tLCBwYWdlX2FsbG9jOiBmaXgNCj4gYnVp
bGRfem9uZXJlZnNfbm9kZSgpKQ0KPiANCj4gV2l0aCB0aGUgdGhpcyBjb21taXQsIEkgYW0g
dW5hYmxlIHRvIGJvb3Qgb25lIG91dCBvZiB0aHJlZSB0aW1lcy4gIFdoZW4NCj4gdXNpbmcg
dGhlIHByZXZpb3VzIGNvbW1pdCBJIHdhcyBub3QgYWJsZSB0byBnZXQgaXQgdG8gaGFuZyBh
ZnRlciB0cnlpbmcNCj4gMTArIHRpbWVzLiAgVGhpcyBpcyBhIHFlbXUgczM5MCBpbnN0YWxs
IHdpdGggS0FTQU4gb24gYW5kIEkgc2VlIG5vIGVycm9yDQo+IG1lc3NhZ2VzLiAgSSB0aGlu
ayBpdCdzIGxpa2VseSBpdCBpcyB0aGlzIHBhdGNoLCBidXQgbm8gZ3VhcmFudGVlZC4NCg0K
VGhpcyBzb3VuZHMgbGlrZSBhIHJhY2UgY29uZGl0aW9uIGR1cmluZyB0aGUgc2V0dXAgb2Yg
bWVtb3J5IHpvbmVzLg0KDQpJIGNvdWxkIGltYWdpbmUgbXkgcGF0Y2ggaXMgdHJpZ2dlcmlu
ZyB0aGlzIHByb2JsZW0sIGJ1dCBpdCBzaG91bGQNCm5vdCBiZSB0aGUgcmVhbCByb290IGNh
dXNlLg0KDQpJJ20gbm8gZXhwZXJ0IHJlZ2FyZGluZyB6b25lIHNldHVwLCBidXQgSSB0aGlu
ayBpdCBtaWdodCBoZWxwIHRvDQpwcmludCBzb21lIHpvbmUgZGF0YSBpbiBjYXNlIHRoZSBw
cm9ibGVtIGlzIGhhcHBlbmluZy4gV2hpY2ggZGF0YSBpcw0KbmVlZGVkIEkgaGF2ZSBubyBy
ZWFsIGlkZWEsIGJ1dCBtYXliZSBzb21lb25lIGVsc2UgY2FuIGhlbHAgaGVyZS4gVGhlDQpm
b2xsb3dpbmcgZGlmZiBzaG91bGQgcmVjb2duaXplIHRoZSBwcm9ibGVtYXRpYyBjYXNlIChp
dCBtaWdodCBzaG93DQpmYWxzZSBwb3NpdGl2ZXMsIHRob3VnaCk6DQoNCmRpZmYgLS1naXQg
YS9tbS9wYWdlX2FsbG9jLmMgYi9tbS9wYWdlX2FsbG9jLmMNCmluZGV4IDBlNDIwMzgzODJj
MS4uMjNmMDI5ZjM5OTg1IDEwMDY0NA0KLS0tIGEvbW0vcGFnZV9hbGxvYy5jDQorKysgYi9t
bS9wYWdlX2FsbG9jLmMNCkBAIC02MTMyLDYgKzYxMzIsOSBAQCBzdGF0aWMgaW50IGJ1aWxk
X3pvbmVyZWZzX25vZGUocGdfZGF0YV90ICpwZ2RhdCwgc3RydWN0IA0Kem9uZXJlZiAqem9u
ZXJlZnMpDQogICAgICAgICAgICAgICAgIHpvbmVfdHlwZS0tOw0KICAgICAgICAgICAgICAg
ICB6b25lID0gcGdkYXQtPm5vZGVfem9uZXMgKyB6b25lX3R5cGU7DQogICAgICAgICAgICAg
ICAgIGlmIChwb3B1bGF0ZWRfem9uZSh6b25lKSkgew0KKyAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKCFtYW5hZ2VkX3pvbmUoem9uZSkpIHsNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLyogUHJpbnQgc29tZSBkYXRhIHJlZ2FyZGluZyB0aGUgem9uZS4gKi8NCisg
ICAgICAgICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAgICAgICAgICB6b25l
cmVmX3NldF96b25lKHpvbmUsICZ6b25lcmVmc1tucl96b25lcysrXSk7DQogICAgICAgICAg
ICAgICAgICAgICAgICAgY2hlY2tfaGlnaGVzdF96b25lKHpvbmVfdHlwZSk7DQogICAgICAg
ICAgICAgICAgIH0NCg0KDQpKdWVyZ2VuDQoNCg==
--------------G0AS1ttLSwQrwrirTlS2RYK0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------G0AS1ttLSwQrwrirTlS2RYK0--

--------------eQFY0OLHlpcTTgDu1TS5og2K--

--------------TG19cOB040TsYSrWWtHms0Hp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJvg2AFAwAAAAAACgkQsN6d1ii/Ey85
ggf/UfGA2BrkwJlb0BJDUO4idQSI2yFXWYgwqqHXGfxzzvVSNGVFKYHgOyspsJ7eYp4gSaubKcQ2
8OrOMlaiP87rZDhmyyLHXvKcUA3/9wvQB+3DjhLsYzbrua6A5+UDWNI9tUiS5feX2uDFfbO7QiIn
rRWGQqwhIfHOAOfvTHmZXR6iETjlKEHMz4s/AT99SlaLGESI9EG2yz7gRXPpnx/7x+TWauQq5RJb
b+4T8hTaQJorkkQ0fcwes68IvqvvSx+jjx1jmZ5lJIWi6IJCOoASLMFhfS5+/n7k4+wCqIQdaemF
5F/oTFyY8l6wIIDE0RKOQzxGFG+L/BX4IhUkVLUNNQ==
=5eAW
-----END PGP SIGNATURE-----

--------------TG19cOB040TsYSrWWtHms0Hp--
