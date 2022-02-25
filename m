Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2DE4C4649
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbiBYN20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241284AbiBYN2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:28:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7E5197B41
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:27:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 002D91F380;
        Fri, 25 Feb 2022 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645795665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L7Lchxug1wh4lmXVF3m87PVXxFgIAJYCSrECSMUN5os=;
        b=UUUKpeHWOabAXEjbzHQMbygmNE24m0KGF/ddc6HvfQ0vbyK1SdAI0STwOZ2UZzB85gGqdU
        zwQvoGd7ElPo8pFsLuo5+xcF+vcqXtCitFtesLG8OCKjaJZNsfwNFX3Jdrk6fGBZ+vrmBV
        uft8Jx7rmUSKfYf3zY+ygvcwelHbox8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5A1813BD1;
        Fri, 25 Feb 2022 13:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1b4QJ1DZGGJpSgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 25 Feb 2022 13:27:44 +0000
Message-ID: <919a30bd-be6c-f773-5b90-700966099d19@suse.com>
Date:   Fri, 25 Feb 2022 14:27:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <20220225081121.18803-1-baijiaju1990@gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] arch: x86: xen: check the return value of kasprintf()
In-Reply-To: <20220225081121.18803-1-baijiaju1990@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oMzV5If1mgGqJO1WZ6RTVtpg"
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
--------------oMzV5If1mgGqJO1WZ6RTVtpg
Content-Type: multipart/mixed; boundary="------------DoFSGUDUMXcD7gEdWjdcecyu";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, boris.ostrovsky@oracle.com,
 sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Message-ID: <919a30bd-be6c-f773-5b90-700966099d19@suse.com>
Subject: Re: [PATCH] arch: x86: xen: check the return value of kasprintf()
References: <20220225081121.18803-1-baijiaju1990@gmail.com>
In-Reply-To: <20220225081121.18803-1-baijiaju1990@gmail.com>

--------------DoFSGUDUMXcD7gEdWjdcecyu
Content-Type: multipart/mixed; boundary="------------IncJ9dP6aG1DUn6PWvIIt03m"

--------------IncJ9dP6aG1DUn6PWvIIt03m
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUuMDIuMjIgMDk6MTEsIEppYS1KdSBCYWkgd3JvdGU6DQo+IFRoZSBmdW5jdGlvbiBr
YXNwcmludGYoKSBjYW4gZmFpbCwgYnV0IHRoZXJlIGlzIG5vIGNoZWNrIG9mIGl0cyByZXR1
cm4NCj4gdmFsdWUuIFRvIGZpeCB0aGlzIGJ1ZywgaXRzIHJldHVybiB2YWx1ZSBzaG91bGQg
YmUgY2hlY2tlZCB3aXRoIG5ldw0KPiBlcnJvciBoYW5kbGluZyBjb2RlLg0KPiANCj4gRml4
ZXM6IGY4N2U0Y2FjNGY0ZSAoInhlbjogU01QIGd1ZXN0IHN1cHBvcnQiKQ0KPiBGaXhlczog
ODNiOTY3OTRlMGVhICgieDg2L3hlbjogc3BsaXQgb2ZmIHNtcF9wdi5jIikNCj4gRml4ZXM6
IGQ1ZGU4ODQxMzU1YSAoIng4Njogc3BsaXQgc3BpbmxvY2sgaW1wbGVtZW50YXRpb25zIG91
dCBpbnRvIHRoZWlyIG93biBmaWxlcyIpDQo+IFJlcG9ydGVkLWJ5OiBUT1RFIFJvYm90IDxv
c2xhYkB0c2luZ2h1YS5lZHUuY24+DQo+IFNpZ25lZC1vZmYtYnk6IEppYS1KdSBCYWkgPGJh
aWppYWp1MTk5MEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGFyY2gveDg2L3hlbi9zbXAuYyAg
ICAgIHwgMiArKw0KPiAgIGFyY2gveDg2L3hlbi9zbXBfcHYuYyAgIHwgMiArKw0KPiAgIGFy
Y2gveDg2L3hlbi9zcGlubG9jay5jIHwgMiArKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL3NtcC5jIGIv
YXJjaC94ODYveGVuL3NtcC5jDQo+IGluZGV4IGMzZTFmOWE3ZDQzYS4uOTEyNjEzOTBmOGMw
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni94ZW4vc21wLmMNCj4gKysrIGIvYXJjaC94ODYv
eGVuL3NtcC5jDQo+IEBAIC02NSw2ICs2NSw4IEBAIGludCB4ZW5fc21wX2ludHJfaW5pdCh1
bnNpZ25lZCBpbnQgY3B1KQ0KPiAgIAljaGFyICpyZXNjaGVkX25hbWUsICpjYWxsZnVuY19u
YW1lLCAqZGVidWdfbmFtZTsNCj4gICANCj4gICAJcmVzY2hlZF9uYW1lID0ga2FzcHJpbnRm
KEdGUF9LRVJORUwsICJyZXNjaGVkJWQiLCBjcHUpOw0KPiArCWlmICghcmVzY2hlZF9uYW1l
KQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCg0KVGhlcmUgYXJlIDMgbW9yZSBpbnN0YW5jZXMg
b2Yga2FzcHJpbnRmKCkgaW4gdGhpcyBmdW5jdGlvbi4NCg0KPiAgIAlyYyA9IGJpbmRfaXBp
X3RvX2lycWhhbmRsZXIoWEVOX1JFU0NIRURVTEVfVkVDVE9SLA0KPiAgIAkJCQkgICAgY3B1
LA0KPiAgIAkJCQkgICAgeGVuX3Jlc2NoZWR1bGVfaW50ZXJydXB0LA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYveGVuL3NtcF9wdi5jIGIvYXJjaC94ODYveGVuL3NtcF9wdi5jDQo+IGlu
ZGV4IDRhNjAxOTIzOGVlNy4uN2QxNDcxZmQxMjY3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4
Ni94ZW4vc21wX3B2LmMNCj4gKysrIGIvYXJjaC94ODYveGVuL3NtcF9wdi5jDQo+IEBAIC0x
MTgsNiArMTE4LDggQEAgaW50IHhlbl9zbXBfaW50cl9pbml0X3B2KHVuc2lnbmVkIGludCBj
cHUpDQo+ICAgCWNoYXIgKmNhbGxmdW5jX25hbWUsICpwbXVfbmFtZTsNCj4gICANCj4gICAJ
Y2FsbGZ1bmNfbmFtZSA9IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiaXJxd29yayVkIiwgY3B1
KTsNCj4gKwlpZiAoIWNhbGxmdW5jX25hbWUpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KDQpB
bmQgaW4gaGVyZSBpcyBhbm90aGVyIG9uZSwgdG9vLg0KDQo+ICAgCXJjID0gYmluZF9pcGlf
dG9faXJxaGFuZGxlcihYRU5fSVJRX1dPUktfVkVDVE9SLA0KPiAgIAkJCQkgICAgY3B1LA0K
PiAgIAkJCQkgICAgeGVuX2lycV93b3JrX2ludGVycnVwdCwNCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L3hlbi9zcGlubG9jay5jIGIvYXJjaC94ODYveGVuL3NwaW5sb2NrLmMNCj4gaW5k
ZXggMDQzYzczZGZkMmM5Li5jY2RiOWVkZGQ5M2IgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2
L3hlbi9zcGlubG9jay5jDQo+ICsrKyBiL2FyY2gveDg2L3hlbi9zcGlubG9jay5jDQo+IEBA
IC03NSw2ICs3NSw4IEBAIHZvaWQgeGVuX2luaXRfbG9ja19jcHUoaW50IGNwdSkNCj4gICAJ
ICAgICBjcHUsIHBlcl9jcHUobG9ja19raWNrZXJfaXJxLCBjcHUpKTsNCj4gICANCj4gICAJ
bmFtZSA9IGthc3ByaW50ZihHRlBfS0VSTkVMLCAic3BpbmxvY2slZCIsIGNwdSk7DQo+ICsJ
aWYgKCFuYW1lKQ0KPiArCQlyZXR1cm47DQoNCkp1c3QgZmFpbGluZyBzaWxlbnRseSBpcyBu
b3QgbmljZS4NCg0KPiAgIAlpcnEgPSBiaW5kX2lwaV90b19pcnFoYW5kbGVyKFhFTl9TUElO
X1VOTE9DS19WRUNUT1IsDQo+ICAgCQkJCSAgICAgY3B1LA0KPiAgIAkJCQkgICAgIGR1bW15
X2hhbmRsZXIsDQoNCg0KSnVlcmdlbg0K
--------------IncJ9dP6aG1DUn6PWvIIt03m
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------IncJ9dP6aG1DUn6PWvIIt03m--

--------------DoFSGUDUMXcD7gEdWjdcecyu--

--------------oMzV5If1mgGqJO1WZ6RTVtpg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmIY2VAFAwAAAAAACgkQsN6d1ii/Ey+L
tQgAiS8darJWTHfNev/ftsWvgYnsIh6/d3XQKL12qjTv3w7t/SDgCn7dUVehgkjnkaX+fF4JPL8t
oX+sA2PbWaVbJ824FUynH8gUA103TCoWIn/YYxyxhXy60FDdO66Dc0TtY7iNVEoqP1Ob9jiM8AmW
J7FYQiv5QUKhXnRhq4NzEgKrueeawiUqz/wIyuZNSPBcWC5meXNfA1GML0SQOHscaCLXjdqKoBWX
rqpXayiTL2ZJiay/vxdRny1gXtYzFgp1OEENeozGfGQJHFWsT4hDjfYWiMnM9TTmHtdDVr08hna3
P6Ygcdg4aawTZafc4VxW0/6JiPEGjI6BXnAirtj3bw==
=w7n2
-----END PGP SIGNATURE-----

--------------oMzV5If1mgGqJO1WZ6RTVtpg--
