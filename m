Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2A54DDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376472AbiFPI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376480AbiFPI4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:56:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E665E2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:56:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 098491FAE2;
        Thu, 16 Jun 2022 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655369779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ClCu1lSS1eT0mVHhicogOYfhzB0qOq3w1ezeRl7JLbI=;
        b=Ek2sYhrEQLjW95dTjLSwKVrt+HGAJ6TX0vmJWWHItRa3l9Qoxvnv3rXVZ85mJvtnLvx70w
        eFsyvJFDN+goB33pTA0D0AWI8OViFO7FGF/Cvc5iGbI8Nfz2WA1aJTArKeOQPGojHnkezA
        IpjugpHm+/v23Pu8A0ZQc90Rcps2BkY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C58BC1344E;
        Thu, 16 Jun 2022 08:56:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IQyPLjLwqmIUOwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 16 Jun 2022 08:56:18 +0000
Message-ID: <cf755bb8-4265-875f-dc20-eefc0e8740f4@suse.com>
Date:   Thu, 16 Jun 2022 10:56:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] xen: don't require virtio with grants for non-PV
 guests
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, hch@infradead.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20220616053715.3166-1-jgross@suse.com>
 <573c2d9f-8df0-0e0f-2f57-e8ea85e403b4@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <573c2d9f-8df0-0e0f-2f57-e8ea85e403b4@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1IF8fi1u5UzCv06QNZz4Ohpv"
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
--------------1IF8fi1u5UzCv06QNZz4Ohpv
Content-Type: multipart/mixed; boundary="------------xEvkx51wTbwtZ0aB08s3WO9P";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr <olekstysh@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 viresh.kumar@linaro.org, hch@infradead.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-ID: <cf755bb8-4265-875f-dc20-eefc0e8740f4@suse.com>
Subject: Re: [PATCH v2] xen: don't require virtio with grants for non-PV
 guests
References: <20220616053715.3166-1-jgross@suse.com>
 <573c2d9f-8df0-0e0f-2f57-e8ea85e403b4@gmail.com>
In-Reply-To: <573c2d9f-8df0-0e0f-2f57-e8ea85e403b4@gmail.com>

--------------xEvkx51wTbwtZ0aB08s3WO9P
Content-Type: multipart/mixed; boundary="------------tZsPIuXAi0nONCWwb0JoU0z5"

--------------tZsPIuXAi0nONCWwb0JoU0z5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDYuMjIgMDk6MzEsIE9sZWtzYW5kciB3cm90ZToNCj4gDQo+IE9uIDE2LjA2LjIy
IDA4OjM3LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4gDQo+IEhlbGxvIEp1ZXJnZW4N
Cj4gDQo+PiBDb21taXQgZmExZjU3NDIxZTBiICgieGVuL3ZpcnRpbzogRW5hYmxlIHJlc3Ry
aWN0ZWQgbWVtb3J5IGFjY2VzcyB1c2luZw0KPj4gWGVuIGdyYW50IG1hcHBpbmdzIikgaW50
cm9kdWNlZCBhIG5ldyByZXF1aXJlbWVudCBmb3IgdXNpbmcgdmlydGlvDQo+PiBkZXZpY2Vz
OiB0aGUgYmFja2VuZCBub3cgbmVlZHMgdG8gc3VwcG9ydCB0aGUgVklSVElPX0ZfQUNDRVNT
X1BMQVRGT1JNDQo+PiBmZWF0dXJlLg0KPj4NCj4+IFRoaXMgaXMgYW4gdW5kdWUgcmVxdWly
ZW1lbnQgZm9yIG5vbi1QViBndWVzdHMsIGFzIHRob3NlIGNhbiBiZSBvcGVyYXRlZA0KPj4g
d2l0aCBleGlzdGluZyBiYWNrZW5kcyB3aXRob3V0IGFueSBwcm9ibGVtLCBhcyBsb25nIGFz
IHRob3NlIGJhY2tlbmRzDQo+PiBhcmUgcnVubmluZyBpbiBkb20wLg0KPj4NCj4+IFBlciBk
ZWZhdWx0IGFsbG93IHZpcnRpbyBkZXZpY2VzIHdpdGhvdXQgZ3JhbnQgc3VwcG9ydCBmb3Ig
bm9uLVBWDQo+PiBndWVzdHMuDQo+Pg0KPj4gQWRkIGEgbmV3IGNvbmZpZyBpdGVtIHRvIGFs
d2F5cyBmb3JjZSB1c2Ugb2YgZ3JhbnRzIGZvciB2aXJ0aW8uDQo+Pg0KPj4gRml4ZXM6IGZh
MWY1NzQyMWUwYiAoInhlbi92aXJ0aW86IEVuYWJsZSByZXN0cmljdGVkIG1lbW9yeSBhY2Nl
c3MgdXNpbmcgWGVuIA0KPj4gZ3JhbnQgbWFwcGluZ3MiKQ0KPj4gUmVwb3J0ZWQtYnk6IFZp
cmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+PiAtLS0NCj4+IFYyOg0KPj4g
LSByZW1vdmUgY29tbWFuZCBsaW5lIHBhcmFtZXRlciAoQ2hyaXN0b3BoIEhlbGx3aWcpDQo+
PiAtLS0NCj4+IMKgIGRyaXZlcnMveGVuL0tjb25maWcgfCA5ICsrKysrKysrKw0KPj4gwqAg
aW5jbHVkZS94ZW4veGVuLmjCoMKgIHwgMiArLQ0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMveGVuL0tjb25maWcgYi9kcml2ZXJzL3hlbi9LY29uZmlnDQo+PiBpbmRleCBiZmQ1
ZjRmNzA2YmMuLmE2NWJkOTIxMjFhNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL0tj
b25maWcNCj4+ICsrKyBiL2RyaXZlcnMveGVuL0tjb25maWcNCj4+IEBAIC0zNTUsNCArMzU1
LDEzIEBAIGNvbmZpZyBYRU5fVklSVElPDQo+PiDCoMKgwqDCoMKgwqDCoCBJZiBpbiBkb3Vi
dCwgc2F5IG4uDQo+PiArY29uZmlnIFhFTl9WSVJUSU9fRk9SQ0VfR1JBTlQNCj4+ICvCoMKg
wqAgYm9vbCAiUmVxdWlyZSBYZW4gdmlydGlvIHN1cHBvcnQgdG8gdXNlIGdyYW50cyINCj4+
ICvCoMKgwqAgZGVwZW5kcyBvbiBYRU5fVklSVElPDQo+PiArwqDCoMKgIGhlbHANCj4+ICvC
oMKgwqDCoMKgIFJlcXVpcmUgdmlydGlvIGZvciBYZW4gZ3Vlc3RzIHRvIHVzZSBncmFudCBt
YXBwaW5ncy4NCj4+ICvCoMKgwqDCoMKgIFRoaXMgd2lsbCBhdm9pZCB0aGUgbmVlZCB0byBn
aXZlIHRoZSBiYWNrZW5kIHRoZSByaWdodCB0byBtYXAgYWxsDQo+PiArwqDCoMKgwqDCoCBv
ZiB0aGUgZ3Vlc3QgbWVtb3J5LiBUaGlzIHdpbGwgbmVlZCBzdXBwb3J0IG9uIHRoZSBiYWNr
ZW5kIHNpZGUNCj4+ICvCoMKgwqDCoMKgIChlLmcuIHFlbXUgb3Iga2VybmVsLCBkZXBlbmRp
bmcgb24gdGhlIHZpcnRpbyBkZXZpY2UgdHlwZXMgdXNlZCkuDQo+PiArDQo+PiDCoCBlbmRt
ZW51DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS94ZW4veGVuLmggYi9pbmNsdWRlL3hlbi94
ZW4uaA0KPj4gaW5kZXggMDc4MGE4MWUxNDBkLi40ZDQxODhmMjAzMzcgMTAwNjQ0DQo+PiAt
LS0gYS9pbmNsdWRlL3hlbi94ZW4uaA0KPj4gKysrIGIvaW5jbHVkZS94ZW4veGVuLmgNCj4+
IEBAIC01Niw3ICs1Niw3IEBAIGV4dGVybiB1NjQgeGVuX3NhdmVkX21heF9tZW1fc2l6ZTsN
Cj4+IMKgIHN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5fc2V0X3Jlc3RyaWN0ZWRfdmlydGlvX21l
bW9yeV9hY2Nlc3Modm9pZCkNCj4+IMKgIHsNCj4+IC3CoMKgwqAgaWYgKElTX0VOQUJMRUQo
Q09ORklHX1hFTl9WSVJUSU8pICYmIHhlbl9kb21haW4oKSkNCj4+ICvCoMKgwqAgaWYgKElT
X0VOQUJMRUQoQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQpIHx8IHhlbl9wdl9kb21h
aW4oKSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwbGF0Zm9ybV9zZXQoUExBVEZPUk1fVklS
VElPX1JFU1RSSUNURURfTUVNX0FDQ0VTUyk7DQo+IA0KPiANCj4gTG9va3MgbGlrZSwgdGhl
IGZsYWcgd2lsbCBiZSAqYWx3YXlzKiBzZXQgZm9yIHBhcmF2aXJ0dWFsaXplZCBndWVzdHMg
ZXZlbiBpZiANCj4gQ09ORklHX1hFTl9WSVJUSU8gZGlzYWJsZWQuDQo+IA0KPiBNYXliZSB3
ZSBzaG91bGQgY2xhcmlmeSB0aGUgY2hlY2s/DQo+IA0KPiANCj4gaWYgKElTX0VOQUJMRUQo
Q09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQpIHx8IElTX0VOQUJMRUQoQ09ORklHX1hF
Tl9WSVJUSU8pIA0KPiAmJiB4ZW5fcHZfZG9tYWluKCkpDQo+IA0KPiAgwqDCoMKgIHBsYXRm
b3JtX3NldChQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTKTsNCj4gDQoN
Clllcywgd2Ugc2hvdWxkLiBJIGhhZCB0aGUgZnVuY3Rpb24gaW4gZ3JhbnQtZG1hLW9wcy5j
IGluIFYxLCBhbmQgY291bGQgZHJvcCB0aGUNCkNPTkZJR19YRU5fVklSVElPIGRlcGVuZGVu
Y3kgZm9yIHRoYXQgcmVhc29uLg0KDQpJJ2xsIHdhaXQgZm9yIG1vcmUgY29tbWVudHMgYmVm
b3JlIHNlbmRpbmcgVjMsIHRob3VnaC4NCg0KDQpKdWVyZ2VuDQo=
--------------tZsPIuXAi0nONCWwb0JoU0z5
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------tZsPIuXAi0nONCWwb0JoU0z5--

--------------xEvkx51wTbwtZ0aB08s3WO9P--

--------------1IF8fi1u5UzCv06QNZz4Ohpv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKq8DIFAwAAAAAACgkQsN6d1ii/Ey9p
AQf9GsDfMN6LBQuiIGXN/DLwv9awfh62/ozPA597SR9/IAvrGkMAVaeN59Twj/Oaiy7SGtR3F2v2
CVkNoulP7MpGJDEAgnLsFHx5j2FUd+gTvgLMqlCMNT2kyaWCtGR4MAvjcU9wSijXooA0ZLgAhw0J
tpWDS/kJDHpua5Ye2VdjygaGIqgpnKvgCiQAT8L6oPmluSbLNvvlRqFLKmMXO7w2dSHf+MGYZ4GY
bILzrgWKpx7a7qM/RuL74gZFdfSZD2RjnNpZecCaYNpaeLH2Svb7OP/kK56q3J5jKj+ZiLxx3XT3
H0auoF8V1E02cD0vvMpaezrHcCjFFguMk6nnJwdx1Q==
=S6Fy
-----END PGP SIGNATURE-----

--------------1IF8fi1u5UzCv06QNZz4Ohpv--
