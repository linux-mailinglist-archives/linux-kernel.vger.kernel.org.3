Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3734C51705C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385297AbiEBNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352708AbiEBNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:35:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FABD63EC
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:31:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D657B210EE;
        Mon,  2 May 2022 13:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651498301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lIstHClwMp6kkDDvi8Ipikr4fnPgWUhfAKVg57KkngY=;
        b=U3eJn1OirQP6iZzOQ4Hq2Fz1cvq5JVjK86nEarr8+H/eoBxl7dXi0f9axXEznmH8ToG5gT
        160JkVEGTv7L8H0aFIplzk6F4UmUJY41ZST0Hg9dWJzGbXNq0CWyw3IcXkVIBZJaV94Hv+
        lXlNV8F//8ZoOdMHQVvcujKCnerDDl0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A32F6133E5;
        Mon,  2 May 2022 13:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nrh3Jj3db2KQGAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 02 May 2022 13:31:41 +0000
Message-ID: <f209285a-6fcc-27af-b8ff-7e517e9eb250@suse.com>
Date:   Mon, 2 May 2022 15:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 08/19] xen/shbuf: switch xen-front-pgdir-shbuf to use
 INVALID_GRANT_REF
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20220428082743.16593-1-jgross@suse.com>
 <20220428082743.16593-9-jgross@suse.com>
 <CAPD2p-nisRgMOzy+w2jx5ULfZTyv4MqtG0wkV9jNn3wNg415sQ@mail.gmail.com>
 <b05fe983-8f9e-da3d-1bf0-e121ba969ae3@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <b05fe983-8f9e-da3d-1bf0-e121ba969ae3@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yarkfAZB0fK3Olo9lMNtQLAG"
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
--------------yarkfAZB0fK3Olo9lMNtQLAG
Content-Type: multipart/mixed; boundary="------------ui4wYIwPULmvH8aTJTfRFH60";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr <olekstysh@gmail.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <f209285a-6fcc-27af-b8ff-7e517e9eb250@suse.com>
Subject: Re: [PATCH v2 08/19] xen/shbuf: switch xen-front-pgdir-shbuf to use
 INVALID_GRANT_REF
References: <20220428082743.16593-1-jgross@suse.com>
 <20220428082743.16593-9-jgross@suse.com>
 <CAPD2p-nisRgMOzy+w2jx5ULfZTyv4MqtG0wkV9jNn3wNg415sQ@mail.gmail.com>
 <b05fe983-8f9e-da3d-1bf0-e121ba969ae3@gmail.com>
In-Reply-To: <b05fe983-8f9e-da3d-1bf0-e121ba969ae3@gmail.com>

--------------ui4wYIwPULmvH8aTJTfRFH60
Content-Type: multipart/mixed; boundary="------------izIJvk0vw0NGS6eDqlUuEfT9"

--------------izIJvk0vw0NGS6eDqlUuEfT9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDQuMjIgMTc6MjgsIE9sZWtzYW5kciB3cm90ZToNCj4gDQo+IEhlbGxvIEp1ZXJn
ZW4NCj4gDQo+IA0KPiBPbiAyOC4wNC4yMiAyMTowMywgT2xla3NhbmRyIFR5c2hjaGVua28g
d3JvdGU6DQo+Pg0KPj4NCj4+IE9uIFRodSwgQXByIDI4LCAyMDIyIGF0IDExOjI4IEFNIEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbSANCj4+IDxtYWlsdG86amdyb3NzQHN1c2Uu
Y29tPj4gd3JvdGU6DQo+Pg0KPj4gSGVsbG/CoEp1ZXJnZW4NCj4+DQo+PiBbc29ycnkgZm9y
IHRoZSBwb3NzaWJsZSBmb3JtYXQgaXNzdWVdDQo+Pg0KPj4gwqDCoMKgIEluc3RlYWQgb2Yg
dXNpbmcgYSBwcml2YXRlIG1hY3JvIGZvciBhbiBpbnZhbGlkIGdyYW50IHJlZmVyZW5jZSB1
c2UNCj4+IMKgwqDCoCB0aGUgY29tbW9uIG9uZS4NCj4+DQo+PiDCoMKgwqAgU2lnbmVkLW9m
Zi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tDQo+PiDCoMKgwqAgPG1haWx0
bzpqZ3Jvc3NAc3VzZS5jb20+Pg0KPj4gwqDCoMKgIC0tLQ0KPj4gwqDCoMKgIMKgZHJpdmVy
cy94ZW4veGVuLWZyb250LXBnZGlyLXNoYnVmLmMgfCAxNyArKysrLS0tLS0tLS0tLS0tLQ0K
Pj4gwqDCoMKgIMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gwqDCoMKgIGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi94ZW4tZnJv
bnQtcGdkaXItc2hidWYuYw0KPj4gwqDCoMKgIGIvZHJpdmVycy94ZW4veGVuLWZyb250LXBn
ZGlyLXNoYnVmLmMNCj4+IMKgwqDCoCBpbmRleCBhOTU5ZGVlMjExMzQuLmZhMjkyMWQ0ZmJm
YyAxMDA2NDQNCj4+IMKgwqDCoCAtLS0gYS9kcml2ZXJzL3hlbi94ZW4tZnJvbnQtcGdkaXIt
c2hidWYuYw0KPj4gwqDCoMKgICsrKyBiL2RyaXZlcnMveGVuL3hlbi1mcm9udC1wZ2Rpci1z
aGJ1Zi5jDQo+PiDCoMKgwqAgQEAgLTIxLDE1ICsyMSw2IEBADQo+Pg0KPj4gwqDCoMKgIMKg
I2luY2x1ZGUgPHhlbi94ZW4tZnJvbnQtcGdkaXItc2hidWYuaD4NCj4+DQo+PiDCoMKgwqAg
LSNpZm5kZWYgR1JBTlRfSU5WQUxJRF9SRUYNCj4+IMKgwqDCoCAtLyoNCj4+IMKgwqDCoCAt
ICogRklYTUU6IHVzYWdlIG9mIGdyYW50IHJlZmVyZW5jZSAwIGFzIGludmFsaWQgZ3JhbnQg
cmVmZXJlbmNlOg0KPj4gwqDCoMKgIC0gKiBncmFudCByZWZlcmVuY2UgMCBpcyB2YWxpZCwg
YnV0IG5ldmVyIGV4cG9zZWQgdG8gYSBQViBkcml2ZXIsDQo+PiDCoMKgwqAgLSAqIGJlY2F1
c2Ugb2YgdGhlIGZhY3QgaXQgaXMgYWxyZWFkeSBpbiB1c2UvcmVzZXJ2ZWQgYnkgdGhlIFBW
DQo+PiDCoMKgwqAgY29uc29sZS4NCj4+IMKgwqDCoCAtICovDQo+PiDCoMKgwqAgLSNkZWZp
bmUgR1JBTlRfSU5WQUxJRF9SRUbCoCDCoCDCoCAwDQo+PiDCoMKgwqAgLSNlbmRpZg0KPj4g
wqDCoMKgIC0NCj4+IMKgwqDCoCDCoC8qKg0KPj4gwqDCoMKgIMKgICogVGhpcyBzdHJ1Y3R1
cmUgcmVwcmVzZW50cyB0aGUgc3RydWN0dXJlIG9mIGEgc2hhcmVkIHBhZ2UNCj4+IMKgwqDC
oCDCoCAqIHRoYXQgY29udGFpbnMgZ3JhbnQgcmVmZXJlbmNlcyB0byB0aGUgcGFnZXMgb2Yg
dGhlIHNoYXJlZA0KPj4gwqDCoMKgIEBAIC04Myw3ICs3NCw3IEBAIGdyYW50X3JlZl90DQo+
PiDCoMKgwqAgwqB4ZW5fZnJvbnRfcGdkaXJfc2hidWZfZ2V0X2Rpcl9zdGFydChzdHJ1Y3Qg
eGVuX2Zyb250X3BnZGlyX3NoYnVmDQo+PiDCoMKgwqAgKmJ1ZikNCj4+IMKgwqDCoCDCoHsN
Cj4+IMKgwqDCoCDCoCDCoCDCoCDCoCBpZiAoIWJ1Zi0+Z3JlZnMpDQo+PiDCoMKgwqAgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIEdSQU5UX0lOVkFMSURfUkVGOw0KPj4gwqDC
oMKgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBJTlZBTElEX0dSQU5UX1JFRjsN
Cj4+DQo+PiDCoMKgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIGJ1Zi0+Z3JlZnNbMF07DQo+PiDC
oMKgwqAgwqB9DQo+PiDCoMKgwqAgQEAgLTE0Miw3ICsxMzMsNyBAQCB2b2lkIHhlbl9mcm9u
dF9wZ2Rpcl9zaGJ1Zl9mcmVlKHN0cnVjdA0KPj4gwqDCoMKgIHhlbl9mcm9udF9wZ2Rpcl9z
aGJ1ZiAqYnVmKQ0KPj4gwqDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludCBpOw0K
Pj4NCj4+IMKgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmb3IgKGkgPSAwOyBpIDwg
YnVmLT5udW1fZ3JlZnM7IGkrKykNCj4+IMKgwqDCoCAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoYnVmLT5ncmVmc1tpXSAhPSBHUkFOVF9JTlZBTElEX1JFRikN
Cj4+IMKgwqDCoCArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoYnVm
LT5ncmVmc1tpXSAhPSBJTlZBTElEX0dSQU5UX1JFRikNCj4+IMKgwqDCoCBnbnR0YWJfZW5k
X2ZvcmVpZ25fYWNjZXNzKGJ1Zi0+Z3JlZnNbaV0sIDBVTCk7DQo+PiDCoMKgwqAgwqAgwqAg
wqAgwqAgfQ0KPj4gwqDCoMKgIMKgIMKgIMKgIMKgIGtmcmVlKGJ1Zi0+Z3JlZnMpOw0KPj4g
wqDCoMKgIEBAIC0zNTUsNyArMzQ2LDcgQEAgc3RhdGljIHZvaWQgYmFja2VuZF9maWxsX3Bh
Z2VfZGlyKHN0cnVjdA0KPj4gwqDCoMKgIHhlbl9mcm9udF9wZ2Rpcl9zaGJ1ZiAqYnVmKQ0K
Pj4gwqDCoMKgIMKgIMKgIMKgIMKgIH0NCj4+IMKgwqDCoCDCoCDCoCDCoCDCoCAvKiBMYXN0
IHBhZ2UgbXVzdCBzYXkgdGhlcmUgaXMgbm8gbW9yZSBwYWdlcy4gKi8NCj4+IMKgwqDCoCDC
oCDCoCDCoCDCoCBwYWdlX2RpciA9IChzdHJ1Y3QgeGVuX3BhZ2VfZGlyZWN0b3J5ICopcHRy
Ow0KPj4gwqDCoMKgIC3CoCDCoCDCoCDCoHBhZ2VfZGlyLT5ncmVmX2Rpcl9uZXh0X3BhZ2Ug
PSBHUkFOVF9JTlZBTElEX1JFRjsNCj4+IMKgwqDCoCArwqAgwqAgwqAgwqBwYWdlX2Rpci0+
Z3JlZl9kaXJfbmV4dF9wYWdlID0gSU5WQUxJRF9HUkFOVF9SRUY7DQo+PiDCoMKgwqAgwqB9
DQo+Pg0KPj4gwqDCoMKgIMKgLyoqDQo+PiDCoMKgwqAgQEAgLTM4NCw3ICszNzUsNyBAQCBz
dGF0aWMgdm9pZCBndWVzdF9maWxsX3BhZ2VfZGlyKHN0cnVjdA0KPj4gwqDCoMKgIHhlbl9m
cm9udF9wZ2Rpcl9zaGJ1ZiAqYnVmKQ0KPj4NCj4+IMKgwqDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBpZiAoZ3JlZnNfbGVmdCA8PSBYRU5fTlVNX0dSRUZTX1BFUl9QQUdFKSB7DQo+
PiDCoMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdG9fY29weSA9
IGdyZWZzX2xlZnQ7DQo+PiDCoMKgwqAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcGFnZV9kaXItPmdyZWZfZGlyX25leHRfcGFnZSA9DQo+PiDCoMKgwqAgR1JBTlRf
SU5WQUxJRF9SRUY7DQo+PiDCoMKgwqAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcGFnZV9kaXItPmdyZWZfZGlyX25leHRfcGFnZSA9DQo+PiDCoMKgwqAgSU5WQUxJ
RF9HUkFOVF9SRUY7DQo+Pg0KPj4NCj4+IEkgZmFjZWQgYW4gaXNzdWUgd2l0aCB0ZXN0aW5n
IFBWIFNvdW5kIHdpdGggdGhlIGN1cnJlbnTCoHNlcmllcy4NCj4+DQo+PiByb290QHNhbHZh
dG9yLXgtaDMtNHgyZy14dC1kb211On4jIGFwbGF5IC9tZWRpYS9Nb29keUxvb3Aud2F2DQo+
PiBQbGF5aW5nIFdBVkUgJy9tZWRpYS9Nb29keUxvb3Aud2F2JyA6IFNpZ25lZCAxNiBiaXQg
TGl0dGxlIEVuZGlhbiwgUmF0ZSA0NDEwMCANCj4+IEh6LCBTdGVyZW8NCj4+IChYRU4pIGNv
bW1vbi9ncmFudF90YWJsZS5jOjEwNTM6ZDF2MiBCYWQgcmVmIDB4ZmZmZmZmZmYgZm9yIGQ2
DQo+Pg0KPj4gSGVyZSB3ZSBoYXZlIGFuIGludGVyZXN0aW5nIHNpdHVhdGlvbi4gUFYgU291
bmQgZnJvbnRlbmTCoHVzZXMgdGhpcyANCj4+IHhlbi1mcm9udC1wZ2Rpci1zaGJ1ZiBmcmFt
ZXdvcmsuIFRlY2huaWNhbGx5LCB0aGlzIHBhdGNoIGNoYW5nZXMgDQo+PiBwYWdlX2Rpci0+
Z3JlZl9kaXJfbmV4dF9wYWdlIChyZWZlcmVuY2UgdG8gdGhlIG5leHQgcGFnZSBkZXNjcmli
aW5nIHBhZ2UgDQo+PiBkaXJlY3RvcnkpIGZyb20gMCB0b8KgMHhmZmZmZmZmZiBoZXJlLg0K
Pj4gI2RlZmluZSBJTlZBTElEX0dSQU5UX1JFRsKgICgoZ3JhbnRfcmVmX3QpLTEpDQo+Pg0K
Pj4gQnV0IGFjY29yZGluZyB0byB0aGUgcHJvdG9jb2wgKHNuZGlmLmgpLCAiMCIgbWVhbnMg
dGhhdCB0aGVyZSBhcmUgbm8gbW9yZSANCj4+IHBhZ2VzIGluIHRoZSBsaXN0IGFuZCB0aGUg
dXNlciBzcGFjZSBiYWNrZW5kIGV4cGVjdHMgb25seSB0aGF0IHZhbHVlLiBTbyANCj4+IHJl
Y2VpdmluZ8KgMHhmZmZmZmZmZiBpdCBhc3N1bWVzIHRoZXJlIGFyZSBwYWdlcyBpbiB0aGUg
bGlzdCBhbmQgdHJ5aW5nIHRvIA0KPj4gcHJvY2Vzcy4uLg0KPj4gaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjUuMTgtcmM0L3NvdXJjZS9pbmNsdWRlL3hlbi9pbnRlcmZh
Y2UvaW8vc25kaWYuaCNMNjUwIA0KPj4NCj4+DQo+Pg0KPj4gSSB0aGluaywgdGhlwqBzYW1l
IGlzIHJlbGV2YW50IHRvwqBiYWNrZW5kX2ZpbGxfcGFnZV9kaXIoKSBhcyB3ZWxsLg0KPiAN
Cj4gDQo+IEluIGFkZGl0aW9uIHRvIHdoYXQgSSBzYWlkIHllc3RlcmRheToNCj4gDQo+IFBW
IERpc3BsYXkgYWxzbyB1c2VzIHRoaXMgeGVuLWZyb250LXBnZGlyLXNoYnVmIGZyYW1ld29y
ay4gSXQncyBwcm90b2NvbCANCj4gKGRpc3BsaWYuaCkgYWxzbyBtZW50aW9ucyB0aGUgc2Ft
ZSBhcyBzbmRpZi5oIGlmIHRoZSBjb250ZXh0IG9mIGdyZWZfZGlyX25leHRfcGFnZToNCj4g
DQo+ICDCoCogZ3JlZl9kaXJfbmV4dF9wYWdlIC0gZ3JhbnRfcmVmX3QsIHJlZmVyZW5jZSB0
byB0aGUgbmV4dCBwYWdlIGRlc2NyaWJpbmcNCj4gIMKgKsKgwqAgcGFnZSBkaXJlY3Rvcnku
IE11c3QgYmUgMCBpZiB0aGVyZSBhcmUgbm8gbW9yZSBwYWdlcyBpbiB0aGUgbGlzdC4NCj4g
DQo+IA0KPiBXaXRoIHRoYXQgbG9jYWwgY2hhbmdlIGJvdGggUFYgZGV2aWNlcyB3b3JrIGlu
IG15IGVudmlyb25tZW50Lg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3hlbi1m
cm9udC1wZ2Rpci1zaGJ1Zi5jIA0KPiBiL2RyaXZlcnMveGVuL3hlbi1mcm9udC1wZ2Rpci1z
aGJ1Zi5jDQo+IGluZGV4IGZhMjkyMWQuLmFkNGE4OGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMveGVuL3hlbi1mcm9udC1wZ2Rpci1zaGJ1Zi5jDQo+ICsrKyBiL2RyaXZlcnMveGVuL3hl
bi1mcm9udC1wZ2Rpci1zaGJ1Zi5jDQo+IEBAIC0zNDYsNyArMzQ2LDcgQEAgc3RhdGljIHZv
aWQgYmFja2VuZF9maWxsX3BhZ2VfZGlyKHN0cnVjdCANCj4geGVuX2Zyb250X3BnZGlyX3No
YnVmICpidWYpDQo+ICDCoMKgwqDCoMKgwqDCoCB9DQo+ICDCoMKgwqDCoMKgwqDCoCAvKiBM
YXN0IHBhZ2UgbXVzdCBzYXkgdGhlcmUgaXMgbm8gbW9yZSBwYWdlcy4gKi8NCj4gIMKgwqDC
oMKgwqDCoMKgIHBhZ2VfZGlyID0gKHN0cnVjdCB4ZW5fcGFnZV9kaXJlY3RvcnkgKilwdHI7
DQo+IC3CoMKgwqDCoMKgwqAgcGFnZV9kaXItPmdyZWZfZGlyX25leHRfcGFnZSA9IElOVkFM
SURfR1JBTlRfUkVGOw0KPiArwqDCoMKgwqDCoMKgIHBhZ2VfZGlyLT5ncmVmX2Rpcl9uZXh0
X3BhZ2UgPSAwOw0KPiAgwqB9DQo+IA0KPiAgwqAvKioNCj4gQEAgLTM3NSw3ICszNzUsNyBA
QCBzdGF0aWMgdm9pZCBndWVzdF9maWxsX3BhZ2VfZGlyKHN0cnVjdCB4ZW5fZnJvbnRfcGdk
aXJfc2hidWYgDQo+ICpidWYpDQo+IA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChncmVmc19sZWZ0IDw9IFhFTl9OVU1fR1JFRlNfUEVSX1BBR0UpIHsNCj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG9fY29weSA9
IGdyZWZzX2xlZnQ7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwYWdlX2Rpci0+Z3JlZl9kaXJfbmV4dF9wYWdlID0gSU5WQUxJRF9HUkFOVF9S
RUY7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
YWdlX2Rpci0+Z3JlZl9kaXJfbmV4dF9wYWdlID0gMDsNCj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9IGVsc2Ugew0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0b19jb3B5ID0gWEVOX05VTV9HUkVGU19QRVJfUEFHRTsN
Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFn
ZV9kaXItPmdyZWZfZGlyX25leHRfcGFnZSA9IGJ1Zi0+Z3JlZnNbaSArIDFdOw0KDQpJIHRo
aW5rIEknbGwgaW50cm9kdWNlIGEgcHJvcGVyIGRlZmluZSBmb3IgdGhhdCBwdXJwb3NlLg0K
DQoNCkp1ZXJnZW4NCg==
--------------izIJvk0vw0NGS6eDqlUuEfT9
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------izIJvk0vw0NGS6eDqlUuEfT9--

--------------ui4wYIwPULmvH8aTJTfRFH60--

--------------yarkfAZB0fK3Olo9lMNtQLAG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJv3T0FAwAAAAAACgkQsN6d1ii/Ey8U
8wf/QwdgjJ3EjOKZeIqsy/rjKDAVHxWaYwTtloONEZ1mZuj4wBE8KTrTRGk9SP63BWqfxXZxSEhf
GyuVUuWzyiSSJ+fVczCUB2n+vd0ecYV2LbnoS4PQ0nmiDftfqNSeqxJ6ewOqw5My5GBPIHcPKCFv
jx5fub+eRQChTtacB0IZ54RDMplQBeoxbHM55vOb/1J8nhSxS6P3Rev8teB6KNhTUY57fqqt8/NT
ln4fBfvDAL7Mie51XHvecQrwJspBDU0bCVaTRDdnxhDXSk0LHz1pkyx/moqknYP8WsZh0+Ukb5QO
hIqBusDuJTUzrXQAi2ClXgfrYJcghgatUy7F5eGyaw==
=uYaa
-----END PGP SIGNATURE-----

--------------yarkfAZB0fK3Olo9lMNtQLAG--
