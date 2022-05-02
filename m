Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F39051705D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385316AbiEBNfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385306AbiEBNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:33:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67546F45
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:30:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 24828210EB;
        Mon,  2 May 2022 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651498222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1IDdLsFoC69G84KoVxaoVdzGHm0f4vR0NdUOvV6FFQw=;
        b=tvAbg8ZU0fNyytMYkqeLJYrS0If0KQzGlPf5TdOV5MrmiL/ssY5PWbHrEN4Q2PgmuHnvpY
        fuSZvPKQIYszVZ3YaHgUWQIVvjZKfuqO6NuAayvRG5r4CFEcjjZvNe9XBH43Co3xiMrwpN
        p2L7EzUb25GqXGtzfEYz/y4pniZ/teA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6E19133E5;
        Mon,  2 May 2022 13:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0M9wNu3cb2LzFwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 02 May 2022 13:30:21 +0000
Message-ID: <b31f2358-625e-68ff-8182-8b91820ad25e@suse.com>
Date:   Mon, 2 May 2022 15:30:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 19/19] xen/xenbus: eliminate xenbus_grant_ring()
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20220428082743.16593-1-jgross@suse.com>
 <20220428082743.16593-20-jgross@suse.com>
 <bf14e3e1-fc4d-1eee-1dfb-1ba3423f0b6f@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <bf14e3e1-fc4d-1eee-1dfb-1ba3423f0b6f@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Ddprj0nYjZO3j4Cw5iWPu6pn"
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
--------------Ddprj0nYjZO3j4Cw5iWPu6pn
Content-Type: multipart/mixed; boundary="------------wKk70Jw8ZhozH8k1CfiTrShL";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr <olekstysh@gmail.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <b31f2358-625e-68ff-8182-8b91820ad25e@suse.com>
Subject: Re: [PATCH v2 19/19] xen/xenbus: eliminate xenbus_grant_ring()
References: <20220428082743.16593-1-jgross@suse.com>
 <20220428082743.16593-20-jgross@suse.com>
 <bf14e3e1-fc4d-1eee-1dfb-1ba3423f0b6f@gmail.com>
In-Reply-To: <bf14e3e1-fc4d-1eee-1dfb-1ba3423f0b6f@gmail.com>

--------------wKk70Jw8ZhozH8k1CfiTrShL
Content-Type: multipart/mixed; boundary="------------WmMLJHd3H0XnUv8azdUmUq6G"

--------------WmMLJHd3H0XnUv8azdUmUq6G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDQuMjIgMTc6MTAsIE9sZWtzYW5kciB3cm90ZToNCj4gDQo+IE9uIDI4LjA0LjIy
IDExOjI3LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4gDQo+IEhlbGxvIEp1ZXJnZW4N
Cj4gDQo+IA0KPj4gVGhlcmUgaXMgbm8gZXh0ZXJuYWwgdXNlciBvZiB4ZW5idXNfZ3JhbnRf
cmluZygpIGxlZnQsIHNvIG1lcmdlIGl0IGludG8NCj4+IHRoZSBvbmx5IGNhbGxlciB4ZW5i
dXNfc2V0dXBfcmluZygpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3Mg
PGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gVjI6DQo+PiAtIG1ha2UgZXJyb3IgbWVz
c2FnZSBtb3JlIHByZWNpc2UgKEFuZHJldyBDb29wZXIpDQo+PiAtLS0NCj4+IMKgIGRyaXZl
cnMveGVuL3hlbmJ1cy94ZW5idXNfY2xpZW50LmMgfCA2NSArKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4+IMKgIGluY2x1ZGUveGVuL3hlbmJ1cy5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgMiAtDQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2Vy
dGlvbnMoKyksIDQ4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3hlbi94ZW5idXMveGVuYnVzX2NsaWVudC5jIA0KPj4gYi9kcml2ZXJzL3hlbi94ZW5idXMv
eGVuYnVzX2NsaWVudC5jDQo+PiBpbmRleCAxYTJlMGQ5NGNjZDEuLmQ2ZmRkMmQyMDlkMyAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL3hlbmJ1cy94ZW5idXNfY2xpZW50LmMNCj4+
ICsrKyBiL2RyaXZlcnMveGVuL3hlbmJ1cy94ZW5idXNfY2xpZW50LmMNCj4+IEBAIC0zNjMs
NTAgKzM2Myw2IEBAIHN0YXRpYyB2b2lkIHhlbmJ1c19zd2l0Y2hfZmF0YWwoc3RydWN0IHhl
bmJ1c19kZXZpY2UgDQo+PiAqZGV2LCBpbnQgZGVwdGgsIGludCBlcnIsDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgX194ZW5idXNfc3dpdGNoX3N0YXRlKGRldiwgWGVuYnVzU3RhdGVDbG9z
aW5nLCAxKTsNCj4+IMKgIH0NCj4+IC0vKioNCj4+IC0gKiB4ZW5idXNfZ3JhbnRfcmluZw0K
Pj4gLSAqIEBkZXY6IHhlbmJ1cyBkZXZpY2UNCj4+IC0gKiBAdmFkZHI6IHN0YXJ0aW5nIHZp
cnR1YWwgYWRkcmVzcyBvZiB0aGUgcmluZw0KPj4gLSAqIEBucl9wYWdlczogbnVtYmVyIG9m
IHBhZ2VzIHRvIGJlIGdyYW50ZWQNCj4+IC0gKiBAZ3JlZnM6IGdyYW50IHJlZmVyZW5jZSBh
cnJheSB0byBiZSBmaWxsZWQgaW4NCj4+IC0gKg0KPj4gLSAqIEdyYW50IGFjY2VzcyB0byB0
aGUgZ2l2ZW4gQHZhZGRyIHRvIHRoZSBwZWVyIG9mIHRoZSBnaXZlbiBkZXZpY2UuDQo+PiAt
ICogVGhlbiBmaWxsIGluIEBncmVmcyB3aXRoIGdyYW50IHJlZmVyZW5jZXMuwqAgUmV0dXJu
IDAgb24gc3VjY2Vzcywgb3INCj4+IC0gKiAtZXJybm8gb24gZXJyb3IuwqAgT24gZXJyb3Is
IHRoZSBkZXZpY2Ugd2lsbCBzd2l0Y2ggdG8NCj4+IC0gKiBYZW5idXNTdGF0ZUNsb3Npbmcs
IGFuZCB0aGUgZXJyb3Igd2lsbCBiZSBzYXZlZCBpbiB0aGUgc3RvcmUuDQo+PiAtICovDQo+
PiAtaW50IHhlbmJ1c19ncmFudF9yaW5nKHN0cnVjdCB4ZW5idXNfZGV2aWNlICpkZXYsIHZv
aWQgKnZhZGRyLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGlu
dCBucl9wYWdlcywgZ3JhbnRfcmVmX3QgKmdyZWZzKQ0KPj4gLXsNCj4+IC3CoMKgwqAgaW50
IGVycjsNCj4+IC3CoMKgwqAgdW5zaWduZWQgaW50IGk7DQo+PiAtwqDCoMKgIGdyYW50X3Jl
Zl90IGdyZWZfaGVhZDsNCj4+IC0NCj4+IC3CoMKgwqAgZXJyID0gZ250dGFiX2FsbG9jX2dy
YW50X3JlZmVyZW5jZXMobnJfcGFnZXMsICZncmVmX2hlYWQpOw0KPj4gLcKgwqDCoCBpZiAo
ZXJyKSB7DQo+PiAtwqDCoMKgwqDCoMKgwqAgeGVuYnVzX2Rldl9mYXRhbChkZXYsIGVyciwg
ImdyYW50aW5nIGFjY2VzcyB0byByaW5nIHBhZ2UiKTsNCj4+IC3CoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gZXJyOw0KPj4gLcKgwqDCoCB9DQo+PiAtDQo+PiAtwqDCoMKgIGZvciAoaSA9IDA7
IGkgPCBucl9wYWdlczsgaSsrKSB7DQo+PiAtwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9u
ZyBnZm47DQo+PiAtDQo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGlzX3ZtYWxsb2NfYWRkcih2
YWRkcikpDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZm4gPSBwZm5fdG9fZ2ZuKHZt
YWxsb2NfdG9fcGZuKHZhZGRyKSk7DQo+PiAtwqDCoMKgwqDCoMKgwqAgZWxzZQ0KPj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2ZuID0gdmlydF90b19nZm4odmFkZHIpOw0KPj4gLQ0K
Pj4gLcKgwqDCoMKgwqDCoMKgIGdyZWZzW2ldID0gZ250dGFiX2NsYWltX2dyYW50X3JlZmVy
ZW5jZSgmZ3JlZl9oZWFkKTsNCj4+IC3CoMKgwqDCoMKgwqDCoCBnbnR0YWJfZ3JhbnRfZm9y
ZWlnbl9hY2Nlc3NfcmVmKGdyZWZzW2ldLCBkZXYtPm90aGVyZW5kX2lkLA0KPj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2ZuLCAwKTsNCj4+
IC0NCj4+IC3CoMKgwqDCoMKgwqDCoCB2YWRkciA9IHZhZGRyICsgWEVOX1BBR0VfU0laRTsN
Cj4+IC3CoMKgwqAgfQ0KPj4gLQ0KPj4gLcKgwqDCoCByZXR1cm4gMDsNCj4+IC19DQo+PiAt
RVhQT1JUX1NZTUJPTF9HUEwoeGVuYnVzX2dyYW50X3JpbmcpOw0KPj4gLQ0KPj4gwqAgLyoN
Cj4+IMKgwqAgKiB4ZW5idXNfc2V0dXBfcmluZw0KPj4gwqDCoCAqIEBkZXY6IHhlbmJ1cyBk
ZXZpY2UNCj4+IEBAIC00MjQsNiArMzgwLDcgQEAgaW50IHhlbmJ1c19zZXR1cF9yaW5nKHN0
cnVjdCB4ZW5idXNfZGV2aWNlICpkZXYsIGdmcF90IA0KPj4gZ2ZwLCB2b2lkICoqdmFkZHIs
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IG5yX3Bh
Z2VzLCBncmFudF9yZWZfdCAqZ3JlZnMpDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIHVuc2ln
bmVkIGxvbmcgcmluZ19zaXplID0gbnJfcGFnZXMgKiBYRU5fUEFHRV9TSVpFOw0KPj4gK8Kg
wqDCoCBncmFudF9yZWZfdCBncmVmX2hlYWQ7DQo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkIGlu
dCBpOw0KPj4gwqDCoMKgwqDCoCBpbnQgcmV0Ow0KPj4gQEAgLTQzMyw5ICszOTAsMjUgQEAg
aW50IHhlbmJ1c19zZXR1cF9yaW5nKHN0cnVjdCB4ZW5idXNfZGV2aWNlICpkZXYsIGdmcF90
IA0KPj4gZ2ZwLCB2b2lkICoqdmFkZHIsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBl
cnI7DQo+PiDCoMKgwqDCoMKgIH0NCj4+IC3CoMKgwqAgcmV0ID0geGVuYnVzX2dyYW50X3Jp
bmcoZGV2LCAqdmFkZHIsIG5yX3BhZ2VzLCBncmVmcyk7DQo+PiAtwqDCoMKgIGlmIChyZXQp
DQo+PiArwqDCoMKgIHJldCA9IGdudHRhYl9hbGxvY19ncmFudF9yZWZlcmVuY2VzKG5yX3Bh
Z2VzLCAmZ3JlZl9oZWFkKTsNCj4+ICvCoMKgwqAgaWYgKHJldCkgew0KPj4gK8KgwqDCoMKg
wqDCoMKgIHhlbmJ1c19kZXZfZmF0YWwoZGV2LCByZXQsICJncmFudGluZyBhY2Nlc3MgdG8g
JXUgcmluZyBwYWdlcyIsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bnJfcGFnZXMpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyOw0KPj4gK8KgwqDC
oCB9DQo+PiArDQo+PiArwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBucl9wYWdlczsgaSsrKSB7
DQo+PiArwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBnZm47DQo+PiArDQo+PiArwqDC
oMKgwqDCoMKgwqAgaWYgKGlzX3ZtYWxsb2NfYWRkcigqdmFkZHIpKQ0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ2ZuID0gcGZuX3RvX2dmbih2bWFsbG9jX3RvX3Bmbih2YWRkcltp
XSkpOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGdmbiA9IHZpcnRfdG9fZ2ZuKHZhZGRyW2ldKTsNCj4+ICsNCj4+ICvCoMKgwqDCoMKg
wqDCoCBncmVmc1tpXSA9IGdudHRhYl9jbGFpbV9ncmFudF9yZWZlcmVuY2UoJmdyZWZfaGVh
ZCk7DQo+IA0KPiBnbnR0YWJfY2xhaW1fZ3JhbnRfcmVmZXJlbmNlKCkgY2FuIHJldHVybiBl
cnJvciBpZiBubyBmcmVlIGdyYW50IHJlZmVyZW5jZSByZW1haW5zLg0KDQpUaGlzIGNhbiBo
YXBwZW4gb25seSBpbiBjYXNlIGdudHRhYl9hbGxvY19ncmFudF9yZWZlcmVuY2VzKCkgZGlk
bid0DQphbGxvY2F0ZSBlbm91Z2ggZ3JhbnRzIGJ1dCB0b2xkIHVzIGl0IHN1Y2NlZWRlZCBk
b2luZyBzby4NCg0KPiBJIHVuZGVyc3RhbmQgdGhpcyBwYXRjaCBvbmx5IG1vdmVzIHRoZSBj
b2RlLCBidXQgcHJvYmFibHkgaXQgd291bGQgYmUgYmV0dGVyIHRvIA0KPiBhZGQgYSBtaXNz
aW5nIGNoZWNrIGhlcmUgKGFuZCBsaWtlbHkgcm9sbGJhY2sgYWxyZWFkeSBwcm9jZXNzZWQg
Z3JhbnRzIGlmIGFueT8pLg0KDQpJIGRvbid0IHRoaW5rIHRoaXMgaXMgbmVlZGVkLCBhcyB0
aGlzIHdvdWxkIGJlIGEgY2xlYXIgYnVnIGluIHRoZSBjb2RlLg0KDQoNCkp1ZXJnZW4NCg==

--------------WmMLJHd3H0XnUv8azdUmUq6G
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------WmMLJHd3H0XnUv8azdUmUq6G--

--------------wKk70Jw8ZhozH8k1CfiTrShL--

--------------Ddprj0nYjZO3j4Cw5iWPu6pn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJv3O0FAwAAAAAACgkQsN6d1ii/Ey/U
qQf/Ze6dNlV+TT84RD8luEgVfVlIp5m6drcCPiPgLiXo70IdUtARMhSuOzxN4IvjETj23uhS8pBY
ucb5IuPOF2jWFrOjrkawlJsB6vEkwHGuaDQ+jH5E1btAVz2kQLju8/+O/6QLSylUNT4nIfugkHtI
UHzi8qlZyWW6huWIW1S/3R8UMzbu3JBTrypRJQVxUdEGIYusPKtFTr99ZuvkRqTBjRbn5aBDhl2m
DbYvtIZuvsKlA1/1kDBQne4o9s8nQGmmm7BALtJL5NPFoMHPBJBFVIjcR6922EMpBXeHWlfVgayw
oQFIJg0SSra4lwr6UL620WJYo6qQUbzzxNp9wgbonA==
=/Kr3
-----END PGP SIGNATURE-----

--------------Ddprj0nYjZO3j4Cw5iWPu6pn--
