Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EBE517048
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385265AbiEBNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiEBNbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:31:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87BDBC98
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:28:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 87BEE1F38D;
        Mon,  2 May 2022 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651498098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zuiiUi4rmkBpc3obCjLsJI48yYJiqOqcT6jc8QEv1Po=;
        b=VHM4T8sWukaXBkuOa5aFO1MNKYsTX3RNdOW49qghwk8g2DfuAeg2khWSnll0AccNyZLnqh
        PZxqjOubZh2t/GIApR023WMrTCuuIdWejAcWdVmcUj0ol3nrlcPKO968kcZZ1rCeQgAYGY
        eDhvbNQnc3Cd/xfj5qFFeMo3k8aMLXM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C2CB133E5;
        Mon,  2 May 2022 13:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iJcbFXLcb2KvFgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 02 May 2022 13:28:18 +0000
Message-ID: <8a4d459d-e584-fc9a-4c81-180dc6bb57dc@suse.com>
Date:   Mon, 2 May 2022 15:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 08/19] xen/shbuf: switch xen-front-pgdir-shbuf to use
 INVALID_GRANT_REF
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20220428082743.16593-1-jgross@suse.com>
 <20220428082743.16593-9-jgross@suse.com>
 <CAPD2p-nisRgMOzy+w2jx5ULfZTyv4MqtG0wkV9jNn3wNg415sQ@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <CAPD2p-nisRgMOzy+w2jx5ULfZTyv4MqtG0wkV9jNn3wNg415sQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------e0jXTIe0I05zv0JtbPremHXn"
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
--------------e0jXTIe0I05zv0JtbPremHXn
Content-Type: multipart/mixed; boundary="------------OuErbI0dwjoWBwG2q9Ael6H6";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <8a4d459d-e584-fc9a-4c81-180dc6bb57dc@suse.com>
Subject: Re: [PATCH v2 08/19] xen/shbuf: switch xen-front-pgdir-shbuf to use
 INVALID_GRANT_REF
References: <20220428082743.16593-1-jgross@suse.com>
 <20220428082743.16593-9-jgross@suse.com>
 <CAPD2p-nisRgMOzy+w2jx5ULfZTyv4MqtG0wkV9jNn3wNg415sQ@mail.gmail.com>
In-Reply-To: <CAPD2p-nisRgMOzy+w2jx5ULfZTyv4MqtG0wkV9jNn3wNg415sQ@mail.gmail.com>

--------------OuErbI0dwjoWBwG2q9Ael6H6
Content-Type: multipart/mixed; boundary="------------yTVUfd2MsHX5pdXhzgL6YyNm"

--------------yTVUfd2MsHX5pdXhzgL6YyNm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDQuMjIgMjA6MDMsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
DQo+IE9uIFRodSwgQXByIDI4LCAyMDIyIGF0IDExOjI4IEFNIEp1ZXJnZW4gR3Jvc3MgPGpn
cm9zc0BzdXNlLmNvbSANCj4gPG1haWx0bzpqZ3Jvc3NAc3VzZS5jb20+PiB3cm90ZToNCj4g
DQo+IEhlbGxvwqBKdWVyZ2VuDQo+IA0KPiBbc29ycnkgZm9yIHRoZSBwb3NzaWJsZSBmb3Jt
YXQgaXNzdWVdDQo+IA0KPiAgICAgSW5zdGVhZCBvZiB1c2luZyBhIHByaXZhdGUgbWFjcm8g
Zm9yIGFuIGludmFsaWQgZ3JhbnQgcmVmZXJlbmNlIHVzZQ0KPiAgICAgdGhlIGNvbW1vbiBv
bmUuDQo+IA0KPiAgICAgU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuY29tIDxtYWlsdG86amdyb3NzQHN1c2UuY29tPj4NCj4gICAgIC0tLQ0KPiAgICAgIMKg
ZHJpdmVycy94ZW4veGVuLWZyb250LXBnZGlyLXNoYnVmLmMgfCAxNyArKysrLS0tLS0tLS0t
LS0tLQ0KPiAgICAgIMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pDQo+IA0KPiAgICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3hlbi1mcm9u
dC1wZ2Rpci1zaGJ1Zi5jDQo+ICAgICBiL2RyaXZlcnMveGVuL3hlbi1mcm9udC1wZ2Rpci1z
aGJ1Zi5jDQo+ICAgICBpbmRleCBhOTU5ZGVlMjExMzQuLmZhMjkyMWQ0ZmJmYyAxMDA2NDQN
Cj4gICAgIC0tLSBhL2RyaXZlcnMveGVuL3hlbi1mcm9udC1wZ2Rpci1zaGJ1Zi5jDQo+ICAg
ICArKysgYi9kcml2ZXJzL3hlbi94ZW4tZnJvbnQtcGdkaXItc2hidWYuYw0KPiAgICAgQEAg
LTIxLDE1ICsyMSw2IEBADQo+IA0KPiAgICAgIMKgI2luY2x1ZGUgPHhlbi94ZW4tZnJvbnQt
cGdkaXItc2hidWYuaD4NCj4gDQo+ICAgICAtI2lmbmRlZiBHUkFOVF9JTlZBTElEX1JFRg0K
PiAgICAgLS8qDQo+ICAgICAtICogRklYTUU6IHVzYWdlIG9mIGdyYW50IHJlZmVyZW5jZSAw
IGFzIGludmFsaWQgZ3JhbnQgcmVmZXJlbmNlOg0KPiAgICAgLSAqIGdyYW50IHJlZmVyZW5j
ZSAwIGlzIHZhbGlkLCBidXQgbmV2ZXIgZXhwb3NlZCB0byBhIFBWIGRyaXZlciwNCj4gICAg
IC0gKiBiZWNhdXNlIG9mIHRoZSBmYWN0IGl0IGlzIGFscmVhZHkgaW4gdXNlL3Jlc2VydmVk
IGJ5IHRoZSBQViBjb25zb2xlLg0KPiAgICAgLSAqLw0KPiAgICAgLSNkZWZpbmUgR1JBTlRf
SU5WQUxJRF9SRUbCoCDCoCDCoCAwDQo+ICAgICAtI2VuZGlmDQo+ICAgICAtDQo+ICAgICAg
wqAvKioNCj4gICAgICDCoCAqIFRoaXMgc3RydWN0dXJlIHJlcHJlc2VudHMgdGhlIHN0cnVj
dHVyZSBvZiBhIHNoYXJlZCBwYWdlDQo+ICAgICAgwqAgKiB0aGF0IGNvbnRhaW5zIGdyYW50
IHJlZmVyZW5jZXMgdG8gdGhlIHBhZ2VzIG9mIHRoZSBzaGFyZWQNCj4gICAgIEBAIC04Myw3
ICs3NCw3IEBAIGdyYW50X3JlZl90DQo+ICAgICAgwqB4ZW5fZnJvbnRfcGdkaXJfc2hidWZf
Z2V0X2Rpcl9zdGFydChzdHJ1Y3QgeGVuX2Zyb250X3BnZGlyX3NoYnVmICpidWYpDQo+ICAg
ICAgwqB7DQo+ICAgICAgwqAgwqAgwqAgwqAgaWYgKCFidWYtPmdyZWZzKQ0KPiAgICAgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIEdSQU5UX0lOVkFMSURfUkVGOw0KPiAgICAg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIElOVkFMSURfR1JBTlRfUkVGOw0KPiAN
Cj4gICAgICDCoCDCoCDCoCDCoCByZXR1cm4gYnVmLT5ncmVmc1swXTsNCj4gICAgICDCoH0N
Cj4gICAgIEBAIC0xNDIsNyArMTMzLDcgQEAgdm9pZCB4ZW5fZnJvbnRfcGdkaXJfc2hidWZf
ZnJlZShzdHJ1Y3QNCj4gICAgIHhlbl9mcm9udF9wZ2Rpcl9zaGJ1ZiAqYnVmKQ0KPiAgICAg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludCBpOw0KPiANCj4gICAgICDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBmb3IgKGkgPSAwOyBpIDwgYnVmLT5udW1fZ3JlZnM7IGkrKykNCj4g
ICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChidWYtPmdyZWZz
W2ldICE9IEdSQU5UX0lOVkFMSURfUkVGKQ0KPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKGJ1Zi0+Z3JlZnNbaV0gIT0gSU5WQUxJRF9HUkFOVF9SRUYp
DQo+ICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZ250dGFiX2VuZF9mb3JlaWduX2FjY2VzcyhidWYtPmdyZWZzW2ldLCAwVUwpOw0KPiAg
ICAgIMKgIMKgIMKgIMKgIH0NCj4gICAgICDCoCDCoCDCoCDCoCBrZnJlZShidWYtPmdyZWZz
KTsNCj4gICAgIEBAIC0zNTUsNyArMzQ2LDcgQEAgc3RhdGljIHZvaWQgYmFja2VuZF9maWxs
X3BhZ2VfZGlyKHN0cnVjdA0KPiAgICAgeGVuX2Zyb250X3BnZGlyX3NoYnVmICpidWYpDQo+
ICAgICAgwqAgwqAgwqAgwqAgfQ0KPiAgICAgIMKgIMKgIMKgIMKgIC8qIExhc3QgcGFnZSBt
dXN0IHNheSB0aGVyZSBpcyBubyBtb3JlIHBhZ2VzLiAqLw0KPiAgICAgIMKgIMKgIMKgIMKg
IHBhZ2VfZGlyID0gKHN0cnVjdCB4ZW5fcGFnZV9kaXJlY3RvcnkgKilwdHI7DQo+ICAgICAt
wqAgwqAgwqAgwqBwYWdlX2Rpci0+Z3JlZl9kaXJfbmV4dF9wYWdlID0gR1JBTlRfSU5WQUxJ
RF9SRUY7DQo+ICAgICArwqAgwqAgwqAgwqBwYWdlX2Rpci0+Z3JlZl9kaXJfbmV4dF9wYWdl
ID0gSU5WQUxJRF9HUkFOVF9SRUY7DQo+ICAgICAgwqB9DQo+IA0KPiAgICAgIMKgLyoqDQo+
ICAgICBAQCAtMzg0LDcgKzM3NSw3IEBAIHN0YXRpYyB2b2lkIGd1ZXN0X2ZpbGxfcGFnZV9k
aXIoc3RydWN0DQo+ICAgICB4ZW5fZnJvbnRfcGdkaXJfc2hidWYgKmJ1ZikNCj4gDQo+ICAg
ICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGdyZWZzX2xlZnQgPD0gWEVOX05VTV9H
UkVGU19QRVJfUEFHRSkgew0KPiAgICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHRvX2NvcHkgPSBncmVmc19sZWZ0Ow0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcGFnZV9kaXItPmdyZWZfZGlyX25leHRfcGFnZSA9IEdSQU5U
X0lOVkFMSURfUkVGOw0KPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcGFnZV9kaXItPmdyZWZfZGlyX25leHRfcGFnZSA9IElOVkFMSURfR1JBTlRfUkVGOw0K
PiANCj4gDQo+IEkgZmFjZWQgYW4gaXNzdWUgd2l0aCB0ZXN0aW5nIFBWIFNvdW5kIHdpdGgg
dGhlIGN1cnJlbnTCoHNlcmllcy4NCj4gDQo+IHJvb3RAc2FsdmF0b3IteC1oMy00eDJnLXh0
LWRvbXU6fiMgYXBsYXkgL21lZGlhL01vb2R5TG9vcC53YXYNCj4gUGxheWluZyBXQVZFICcv
bWVkaWEvTW9vZHlMb29wLndhdicgOiBTaWduZWQgMTYgYml0IExpdHRsZSBFbmRpYW4sIFJh
dGUgNDQxMDAgDQo+IEh6LCBTdGVyZW8NCj4gKFhFTikgY29tbW9uL2dyYW50X3RhYmxlLmM6
MTA1MzpkMXYyIEJhZCByZWYgMHhmZmZmZmZmZiBmb3IgZDYNCj4gDQo+IEhlcmUgd2UgaGF2
ZSBhbiBpbnRlcmVzdGluZyBzaXR1YXRpb24uIFBWIFNvdW5kIGZyb250ZW5kwqB1c2VzIHRo
aXMgDQo+IHhlbi1mcm9udC1wZ2Rpci1zaGJ1ZiBmcmFtZXdvcmsuIFRlY2huaWNhbGx5LCB0
aGlzIHBhdGNoIGNoYW5nZXMgDQo+IHBhZ2VfZGlyLT5ncmVmX2Rpcl9uZXh0X3BhZ2UgKHJl
ZmVyZW5jZSB0byB0aGUgbmV4dCBwYWdlIGRlc2NyaWJpbmcgcGFnZSANCj4gZGlyZWN0b3J5
KSBmcm9tIDAgdG/CoDB4ZmZmZmZmZmYgaGVyZS4NCj4gI2RlZmluZSBJTlZBTElEX0dSQU5U
X1JFRsKgICgoZ3JhbnRfcmVmX3QpLTEpDQo+IA0KPiBCdXQgYWNjb3JkaW5nIHRvIHRoZSBw
cm90b2NvbCAoc25kaWYuaCksICIwIiBtZWFucyB0aGF0IHRoZXJlIGFyZSBubyBtb3JlIHBh
Z2VzIA0KPiBpbiB0aGUgbGlzdCBhbmQgdGhlIHVzZXIgc3BhY2UgYmFja2VuZCBleHBlY3Rz
IG9ubHkgdGhhdCB2YWx1ZS4gU28gDQo+IHJlY2VpdmluZ8KgMHhmZmZmZmZmZiBpdCBhc3N1
bWVzIHRoZXJlIGFyZSBwYWdlcyBpbiB0aGUgbGlzdCBhbmQgdHJ5aW5nIHRvIA0KPiBwcm9j
ZXNzLi4uDQoNCkhtbSwgdGhhdCdzIHVuZm9ydHVuYXRlLg0KDQo+IGh0dHBzOi8vZWxpeGly
LmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE4LXJjNC9zb3VyY2UvaW5jbHVkZS94ZW4vaW50ZXJm
YWNlL2lvL3NuZGlmLmgjTDY1MCANCj4gPGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xp
bnV4L3Y1LjE4LXJjNC9zb3VyY2UvaW5jbHVkZS94ZW4vaW50ZXJmYWNlL2lvL3NuZGlmLmgj
TDY1MD4NCj4gDQo+IA0KPiBJIHRoaW5rLCB0aGXCoHNhbWUgaXMgcmVsZXZhbnQgdG/CoGJh
Y2tlbmRfZmlsbF9wYWdlX2RpcigpIGFzIHdlbGwuDQoNClRoYW5rcyBmb3IgZmluZGluZyB0
aGlzLg0KDQoNCkp1ZXJnZW4NCg==
--------------yTVUfd2MsHX5pdXhzgL6YyNm
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------yTVUfd2MsHX5pdXhzgL6YyNm--

--------------OuErbI0dwjoWBwG2q9Ael6H6--

--------------e0jXTIe0I05zv0JtbPremHXn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJv3HEFAwAAAAAACgkQsN6d1ii/Ey+Q
7wf+PehYviINvhAC1ekfNOs0Q6KGjE9D2H9kOMQLcKeX2gy3zubJTg3C/TufyPUzh4yJMOX7Gvuh
s+fyP7xhaxnDmuwx4Ei/vxWXrgUKlVq0r5+AICVPgV+4cKQI1iW7liePuVQlK7ziYJcX+PSukuos
hIg9AgbfeF+dFsZmYTEN3Aau3zEw1YGAs/UQjPQADTV9TaXbi5pSZ/RZCtigHCqAhv9Km9d/ke/1
y1ktc9BG1c/BDzECv/2xhpnODLlEzgQcityjMbo/1zNhgZNxsJfN2ESpDACVI3adzQTNxCba15Aa
ysMq5XZb60uBi3w8oxaRGND+tKZlqhOIqWXadBU+kQ==
=agnj
-----END PGP SIGNATURE-----

--------------e0jXTIe0I05zv0JtbPremHXn--
