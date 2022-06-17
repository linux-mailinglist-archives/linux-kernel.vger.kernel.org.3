Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6754F0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380151AbiFQFln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFQFlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:41:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC9466C9B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:41:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9547621A7F;
        Fri, 17 Jun 2022 05:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655444500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LcZUUZdA9Bs6dRtZtYIQd7zgwuZ9YUtZN1HPMs8hGuw=;
        b=h6tsuKPj2kJHlqL5ClhRpoiNSijRgyqnv0NtcqpXKD40iKylFnrd3A6l1RMDzqcjkMw7BL
        61yRbCGK8lMV9yys1q+IJuDo98fxDXkKUWdXtQzrAfUAST0guuTVyZpWe/clK+dFng928E
        CP8kW6ASX09QNOfp0Nruf5+EFzEAT7g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58FF81330D;
        Fri, 17 Jun 2022 05:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x639ExQUrGKvUgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 17 Jun 2022 05:41:40 +0000
Message-ID: <0cb980f8-255d-4835-272e-f625e8463f11@suse.com>
Date:   Fri, 17 Jun 2022 07:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] xen: don't require virtio with grants for non-PV
 guests
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>, hch@infradead.org,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20220616053715.3166-1-jgross@suse.com>
 <573c2d9f-8df0-0e0f-2f57-e8ea85e403b4@gmail.com>
 <cf755bb8-4265-875f-dc20-eefc0e8740f4@suse.com>
 <a67a709a-78b1-c3b1-009e-2d9c834bdd67@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <a67a709a-78b1-c3b1-009e-2d9c834bdd67@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PlTpeNGGUZ6fVQJy38WwWM7y"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PlTpeNGGUZ6fVQJy38WwWM7y
Content-Type: multipart/mixed; boundary="------------KAzbyXDfafTqoOmE5eSwOQrI";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr <olekstysh@gmail.com>, hch@infradead.org,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 viresh.kumar@linaro.org, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-ID: <0cb980f8-255d-4835-272e-f625e8463f11@suse.com>
Subject: Re: [PATCH v2] xen: don't require virtio with grants for non-PV
 guests
References: <20220616053715.3166-1-jgross@suse.com>
 <573c2d9f-8df0-0e0f-2f57-e8ea85e403b4@gmail.com>
 <cf755bb8-4265-875f-dc20-eefc0e8740f4@suse.com>
 <a67a709a-78b1-c3b1-009e-2d9c834bdd67@gmail.com>
In-Reply-To: <a67a709a-78b1-c3b1-009e-2d9c834bdd67@gmail.com>

--------------KAzbyXDfafTqoOmE5eSwOQrI
Content-Type: multipart/mixed; boundary="------------RmLAwTcj00wZFtYIY8DWZy9f"

--------------RmLAwTcj00wZFtYIY8DWZy9f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDYuMjIgMjI6MzMsIE9sZWtzYW5kciB3cm90ZToNCj4gDQo+IE9uIDE2LjA2LjIy
IDExOjU2LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4gSGVsbG8gSnVlcmdlbiwgYWxs
DQo+IA0KPiANCj4+IE9uIDE2LjA2LjIyIDA5OjMxLCBPbGVrc2FuZHIgd3JvdGU6DQo+Pj4N
Cj4+PiBPbiAxNi4wNi4yMiAwODozNywgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+Pg0KPj4+
DQo+Pj4gSGVsbG8gSnVlcmdlbg0KPj4+DQo+Pj4+IENvbW1pdCBmYTFmNTc0MjFlMGIgKCJ4
ZW4vdmlydGlvOiBFbmFibGUgcmVzdHJpY3RlZCBtZW1vcnkgYWNjZXNzIHVzaW5nDQo+Pj4+
IFhlbiBncmFudCBtYXBwaW5ncyIpIGludHJvZHVjZWQgYSBuZXcgcmVxdWlyZW1lbnQgZm9y
IHVzaW5nIHZpcnRpbw0KPj4+PiBkZXZpY2VzOiB0aGUgYmFja2VuZCBub3cgbmVlZHMgdG8g
c3VwcG9ydCB0aGUgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNDQo+Pj4+IGZlYXR1cmUuDQo+
Pj4+DQo+Pj4+IFRoaXMgaXMgYW4gdW5kdWUgcmVxdWlyZW1lbnQgZm9yIG5vbi1QViBndWVz
dHMsIGFzIHRob3NlIGNhbiBiZSBvcGVyYXRlZA0KPj4+PiB3aXRoIGV4aXN0aW5nIGJhY2tl
bmRzIHdpdGhvdXQgYW55IHByb2JsZW0sIGFzIGxvbmcgYXMgdGhvc2UgYmFja2VuZHMNCj4+
Pj4gYXJlIHJ1bm5pbmcgaW4gZG9tMC4NCj4+Pj4NCj4+Pj4gUGVyIGRlZmF1bHQgYWxsb3cg
dmlydGlvIGRldmljZXMgd2l0aG91dCBncmFudCBzdXBwb3J0IGZvciBub24tUFYNCj4+Pj4g
Z3Vlc3RzLg0KPj4+Pg0KPj4+PiBBZGQgYSBuZXcgY29uZmlnIGl0ZW0gdG8gYWx3YXlzIGZv
cmNlIHVzZSBvZiBncmFudHMgZm9yIHZpcnRpby4NCj4+Pj4NCj4+Pj4gRml4ZXM6IGZhMWY1
NzQyMWUwYiAoInhlbi92aXJ0aW86IEVuYWJsZSByZXN0cmljdGVkIG1lbW9yeSBhY2Nlc3Mg
dXNpbmcgWGVuIA0KPj4+PiBncmFudCBtYXBwaW5ncyIpDQo+Pj4+IFJlcG9ydGVkLWJ5OiBW
aXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBW
MjoNCj4+Pj4gLSByZW1vdmUgY29tbWFuZCBsaW5lIHBhcmFtZXRlciAoQ2hyaXN0b3BoIEhl
bGx3aWcpDQo+Pj4+IC0tLQ0KPj4+PiDCoCBkcml2ZXJzL3hlbi9LY29uZmlnIHwgOSArKysr
KysrKysNCj4+Pj4gwqAgaW5jbHVkZS94ZW4veGVuLmjCoMKgIHwgMiArLQ0KPj4+PiDCoCAy
IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4N
Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL0tjb25maWcgYi9kcml2ZXJzL3hlbi9L
Y29uZmlnDQo+Pj4+IGluZGV4IGJmZDVmNGY3MDZiYy4uYTY1YmQ5MjEyMWE1IDEwMDY0NA0K
Pj4+PiAtLS0gYS9kcml2ZXJzL3hlbi9LY29uZmlnDQo+Pj4+ICsrKyBiL2RyaXZlcnMveGVu
L0tjb25maWcNCj4+Pj4gQEAgLTM1NSw0ICszNTUsMTMgQEAgY29uZmlnIFhFTl9WSVJUSU8N
Cj4+Pj4gwqDCoMKgwqDCoMKgwqAgSWYgaW4gZG91YnQsIHNheSBuLg0KPj4+PiArY29uZmln
IFhFTl9WSVJUSU9fRk9SQ0VfR1JBTlQNCj4+Pj4gK8KgwqDCoCBib29sICJSZXF1aXJlIFhl
biB2aXJ0aW8gc3VwcG9ydCB0byB1c2UgZ3JhbnRzIg0KPj4+PiArwqDCoMKgIGRlcGVuZHMg
b24gWEVOX1ZJUlRJTw0KPj4+PiArwqDCoMKgIGhlbHANCj4+Pj4gK8KgwqDCoMKgwqAgUmVx
dWlyZSB2aXJ0aW8gZm9yIFhlbiBndWVzdHMgdG8gdXNlIGdyYW50IG1hcHBpbmdzLg0KPj4+
PiArwqDCoMKgwqDCoCBUaGlzIHdpbGwgYXZvaWQgdGhlIG5lZWQgdG8gZ2l2ZSB0aGUgYmFj
a2VuZCB0aGUgcmlnaHQgdG8gbWFwIGFsbA0KPj4+PiArwqDCoMKgwqDCoCBvZiB0aGUgZ3Vl
c3QgbWVtb3J5LiBUaGlzIHdpbGwgbmVlZCBzdXBwb3J0IG9uIHRoZSBiYWNrZW5kIHNpZGUN
Cj4+Pj4gK8KgwqDCoMKgwqAgKGUuZy4gcWVtdSBvciBrZXJuZWwsIGRlcGVuZGluZyBvbiB0
aGUgdmlydGlvIGRldmljZSB0eXBlcyB1c2VkKS4NCj4+Pj4gKw0KPj4+PiDCoCBlbmRtZW51
DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3hlbi94ZW4uaCBiL2luY2x1ZGUveGVuL3hl
bi5oDQo+Pj4+IGluZGV4IDA3ODBhODFlMTQwZC4uNGQ0MTg4ZjIwMzM3IDEwMDY0NA0KPj4+
PiAtLS0gYS9pbmNsdWRlL3hlbi94ZW4uaA0KPj4+PiArKysgYi9pbmNsdWRlL3hlbi94ZW4u
aA0KPj4+PiBAQCAtNTYsNyArNTYsNyBAQCBleHRlcm4gdTY0IHhlbl9zYXZlZF9tYXhfbWVt
X3NpemU7DQo+Pj4+IMKgIHN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5fc2V0X3Jlc3RyaWN0ZWRf
dmlydGlvX21lbW9yeV9hY2Nlc3Modm9pZCkNCj4+Pj4gwqAgew0KPj4+PiAtwqDCoMKgIGlm
IChJU19FTkFCTEVEKENPTkZJR19YRU5fVklSVElPKSAmJiB4ZW5fZG9tYWluKCkpDQo+Pj4+
ICvCoMKgwqAgaWYgKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQp
IHx8IHhlbl9wdl9kb21haW4oKSkNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBsYXRmb3Jt
X3NldChQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTKTsNCj4+Pg0KPj4+
DQo+Pj4gTG9va3MgbGlrZSwgdGhlIGZsYWcgd2lsbCBiZSAqYWx3YXlzKiBzZXQgZm9yIHBh
cmF2aXJ0dWFsaXplZCBndWVzdHMgZXZlbiBpZiANCj4+PiBDT05GSUdfWEVOX1ZJUlRJTyBk
aXNhYmxlZC4NCj4+Pg0KPj4+IE1heWJlIHdlIHNob3VsZCBjbGFyaWZ5IHRoZSBjaGVjaz8N
Cj4+Pg0KPj4+DQo+Pj4gaWYgKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0Vf
R1JBTlQpIHx8IA0KPj4+IElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJUSU8pICYmIHhlbl9w
dl9kb21haW4oKSkNCj4+Pg0KPj4+IMKgwqDCoMKgIHBsYXRmb3JtX3NldChQTEFURk9STV9W
SVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTKTsNCj4+Pg0KPj4NCj4+IFllcywgd2Ugc2hv
dWxkLiBJIGhhZCB0aGUgZnVuY3Rpb24gaW4gZ3JhbnQtZG1hLW9wcy5jIGluIFYxLCBhbmQg
Y291bGQgZHJvcCB0aGUNCj4+IENPTkZJR19YRU5fVklSVElPIGRlcGVuZGVuY3kgZm9yIHRo
YXQgcmVhc29uLg0KPj4NCj4+IEknbGwgd2FpdCBmb3IgbW9yZSBjb21tZW50cyBiZWZvcmUg
c2VuZGluZyBWMywgdGhvdWdoLg0KPiANCj4gb2sNCj4gDQo+IA0KPiANCj4gUGxlYXNlIG5v
dGUsIEkgYW0gaGFwcHkgd2l0aCBjdXJyZW50IHBhdGNoIGFuZCBpdCB3b3JrcyBpbiBteSBB
cm02NCBiYXNlZCANCj4gZW52aXJvbm1lbnQuDQo+IA0KPiBKdXN0IG9uZSBtb21lbnQgdG8g
Y29uc2lkZXIuDQo+IA0KPiANCj4gQXMgaXQgd2FzIGFscmVhZHkgbWVudGlvbmVkIGVhcmxp
ZXIgaW4gY3VycmVudCB0aHJlYWQgdGhlIA0KPiBQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RF
RF9NRU1fQUNDRVNTIChmb3JtZXIgDQo+IGFyY2hfaGFzX3Jlc3RyaWN0ZWRfdmlydGlvX21l
bW9yeV9hY2Nlc3MoKSkgaXMgbm90IHBlciBkZXZpY2UgYnV0IGFib3V0IHRoZSANCj4gd2hv
bGUgZ3Vlc3QuIEJlaW5nIHNldCBpdCBtYWtlcyBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0g
YW5kIFZJUlRJT19GX1ZFUlNJT05fMSANCj4gZmVhdHVyZXMgbWFuZGF0b3J5IGZvciAqYWxs
KiB2aXJ0aW8gZGV2aWNlcyBpbiB0aGUgZ3Vlc3QuDQo+IA0KPiBUaGUgcXVlc3Rpb24gaXMg
4oCcRG8gd2Ugd2FudC9uZWVkIHRvIGxpZnQgdGhpcyByZXN0cmljdGlvbiBmb3Igc29tZSBk
ZXZpY2VzIA0KPiAod2hpY2ggYmFja2VuZHMgYXJlIHRydXN0ZWQgc28gY2FuIGFjY2VzcyBh
bGwgZ3Vlc3QgbWVtb3J5KSBhdCB0aGUgc2FtZSB0aW1l4oCdPyANCg0KTm8sIGlmIHlvdSBu
ZWVkIHNvbWUgdmlydGlvIGRldmljZXMgdG8gbm90IHVzZSBncmFudHMsIHRoZW4gZG9uJ3Qg
c2V0DQpQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTLg0KDQpQbGVhc2Ug
c2VlIG15IGFuc3dlciB0byBTdGVmYW5vJ3MgYWx0ZXJuYXRpdmUgc29sdXRpb24gZm9yIG15
IGlkZWEgaG93IHRvDQpyZXNvbHZlIHRoaXMgdmlhIGEgcGVyLWRldmljZSBzZXR0aW5nLg0K
DQoNCkp1ZXJnZW4NCg==
--------------RmLAwTcj00wZFtYIY8DWZy9f
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------RmLAwTcj00wZFtYIY8DWZy9f--

--------------KAzbyXDfafTqoOmE5eSwOQrI--

--------------PlTpeNGGUZ6fVQJy38WwWM7y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKsFBMFAwAAAAAACgkQsN6d1ii/Ey8x
Vgf/YeKLCESBxoZ/u7ukv1Dlu1I1ZmIngpAmEbzpls1a44298LwvsXFBO1dl244X/ovg2Ioq5lst
SW1WrcREt+0MILShyPs34+tY/YpnYnqEX9XC48I6cFhpWfewPgGi7UUrAmqcBK1fcZP1D8k3endn
XzeLxu6z2VvGF87kHAHVx+FpjlUPg369UCYIDqMPfIIerUu80XMf0UaZJq8rW1zaZxEYYcyPjPbb
9bNZmfUBMsxgEp53qGIqkifo1l8TB8lfzZkc5c69BFU3EC3ZOQrTTuey5M3ZAYWRb5JxkpKwF8GI
ApfNuLXbwHuQ4LIPOKeGJMrHuz4Ma22N8LN3wgLrOQ==
=gADQ
-----END PGP SIGNATURE-----

--------------PlTpeNGGUZ6fVQJy38WwWM7y--
