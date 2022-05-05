Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D151BE6E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358316AbiEELzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiEELzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:55:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED9F532F9;
        Thu,  5 May 2022 04:51:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 846C31F8D4;
        Thu,  5 May 2022 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651751502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mVkZP16seFI7V6Y2j5g4tx9yd6zUju4tMIUwikRtuZM=;
        b=n529iRyin8u2q3PFxoHpdH81Ajn0A11USwjflG9sxDot4D5AyXnjJ0cwcFAdPS0rE/jryu
        Za1i9xB96fbi28GNovCBvvb/1TFa4BGnC8/dYCrUUi2DJabyle1EoMkBP58Tn/6oUYpBoM
        A9IHVRGssfxSjwdLJJnYpgiOFRMkaxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651751502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mVkZP16seFI7V6Y2j5g4tx9yd6zUju4tMIUwikRtuZM=;
        b=yvw98h3Q7Emlhc2YpJFEzS3823zRCZwrweAPGR28eCy+o5S0wtN3FrE1XuQgFET6Jkia63
        9yxmFPn8xbcUsTBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FE8613A65;
        Thu,  5 May 2022 11:51:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D+71FU66c2KcbwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 05 May 2022 11:51:42 +0000
Message-ID: <d5348b86-f455-b28e-14ef-972dfdb75585@suse.de>
Date:   Thu, 5 May 2022 13:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] fbdev: vesafb: Cleanup fb_info in .fb_destroy
 rather than .remove
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220505113128.264963-1-javierm@redhat.com>
 <20220505113128.264963-5-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20220505113128.264963-5-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3qb0jJDsfMwthAxMyida0Ig6"
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3qb0jJDsfMwthAxMyida0Ig6
Content-Type: multipart/mixed; boundary="------------qjaYkn7iDSY9Mbq55tpCXTw7";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Message-ID: <d5348b86-f455-b28e-14ef-972dfdb75585@suse.de>
Subject: Re: [PATCH v2 4/4] fbdev: vesafb: Cleanup fb_info in .fb_destroy
 rather than .remove
References: <20220505113128.264963-1-javierm@redhat.com>
 <20220505113128.264963-5-javierm@redhat.com>
In-Reply-To: <20220505113128.264963-5-javierm@redhat.com>

--------------qjaYkn7iDSY9Mbq55tpCXTw7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDA1LjA1LjIyIHVtIDEzOjMxIHNjaHJpZWIgSmF2aWVyIE1hcnRpbmV6IENhbmls
bGFzOg0KPiBUaGUgZHJpdmVyIGlzIGNhbGxpbmcgZnJhbWVidWZmZXJfcmVsZWFzZSgpIGlu
IGl0cyAucmVtb3ZlIGNhbGxiYWNrLCBidXQNCj4gdGhpcyB3aWxsIGNhdXNlIHRoZSBzdHJ1
Y3QgZmJfaW5mbyB0byBiZSBmcmVlZCB0b28gZWFybHkuIFNpbmNlIGl0IGNvdWxkDQo+IGJl
IHRoYXQgYSByZWZlcmVuY2UgaXMgc3RpbGwgaG9sZCB0byBpdCBpZiB1c2VyLXNwYWNlIG9w
ZW5lZCB0aGUgZmJkZXYuDQo+IA0KPiBUaGlzIHdvdWxkIGxlYWQgdG8gYSB1c2UtYWZ0ZXIt
ZnJlZSBlcnJvciBpZiB0aGUgZnJhbWVidWZmZXIgZGV2aWNlIHdhcw0KPiB1bnJlZ2lzdGVy
ZWQgYnV0IGxhdGVyIGEgdXNlci1zcGFjZSBwcm9jZXNzIHRyaWVzIHRvIGNsb3NlIHRoZSBm
YmRldiBmZC4NCj4gDQo+IFRoZSBjb3JyZWN0IHRoaW5nIHRvIGRvIGlzIHRvIG9ubHkgdW5y
ZWdpc3RlciB0aGUgZnJhbWVidWZmZXIgaW4gdGhlDQo+IGRyaXZlcidzIC5yZW1vdmUgY2Fs
bGJhY2ssIGJ1dCBkbyBhbnkgY2xlYW51cCBpbiB0aGUgZmJfb3BzLmZiX2Rlc3Ryb3kuDQo+
IA0KPiBTdWdnZXN0ZWQtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwu
Y2g+DQo+IFNpZ25lZC1vZmYtYnk6IEphdmllciBNYXJ0aW5leiBDYW5pbGxhcyA8amF2aWVy
bUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1t
ZXJtYW5uQHN1c2UuZGU+DQoNCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEFs
c28gZG8gdGhlIGNoYW5nZSBmb3IgdmVzYWZiIChUaG9tYXMgWmltbWVybWFubikuDQo+IA0K
PiAgIGRyaXZlcnMvdmlkZW8vZmJkZXYvdmVzYWZiLmMgfCAxNCArKysrKysrKysrKy0tLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvdmVzYWZiLmMgYi9kcml2
ZXJzL3ZpZGVvL2ZiZGV2L3Zlc2FmYi5jDQo+IGluZGV4IGRmNmRlNWE5ZGQ0Yy4uMWYwM2E0
NDllNTA1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3Zlc2FmYi5jDQo+
ICsrKyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvdmVzYWZiLmMNCj4gQEAgLTE3OSw2ICsxNzks
MTAgQEAgc3RhdGljIGludCB2ZXNhZmJfc2V0Y29scmVnKHVuc2lnbmVkIHJlZ25vLCB1bnNp
Z25lZCByZWQsIHVuc2lnbmVkIGdyZWVuLA0KPiAgIAlyZXR1cm4gZXJyOw0KPiAgIH0NCj4g
ICANCj4gKy8qDQo+ICsgKiBmYl9vcHMuZmJfZGVzdHJveSBpcyBjYWxsZWQgYnkgdGhlIGxh
c3QgcHV0X2ZiX2luZm8oKSBjYWxsIGF0IHRoZSBlbmQNCj4gKyAqIG9mIHVucmVnaXN0ZXJf
ZnJhbWVidWZmZXIoKSBvciBmYl9yZWxlYXNlKCkuIERvIGFueSBjbGVhbnVwIGhlcmUuDQo+
ICsgKi8NCj4gICBzdGF0aWMgdm9pZCB2ZXNhZmJfZGVzdHJveShzdHJ1Y3QgZmJfaW5mbyAq
aW5mbykNCj4gICB7DQo+ICAgCXN0cnVjdCB2ZXNhZmJfcGFyICpwYXIgPSBpbmZvLT5wYXI7
DQo+IEBAIC0xODcsNyArMTkxLDEzIEBAIHN0YXRpYyB2b2lkIHZlc2FmYl9kZXN0cm95KHN0
cnVjdCBmYl9pbmZvICppbmZvKQ0KPiAgIAlhcmNoX3BoeXNfd2NfZGVsKHBhci0+d2NfY29v
a2llKTsNCj4gICAJaWYgKGluZm8tPnNjcmVlbl9iYXNlKQ0KPiAgIAkJaW91bm1hcChpbmZv
LT5zY3JlZW5fYmFzZSk7DQo+ICsNCj4gKwlpZiAoKChzdHJ1Y3QgdmVzYWZiX3BhciAqKShp
bmZvLT5wYXIpKS0+cmVnaW9uKQ0KPiArCQlyZWxlYXNlX3JlZ2lvbigweDNjMCwgMzIpOw0K
PiArDQo+ICAgCXJlbGVhc2VfbWVtX3JlZ2lvbihpbmZvLT5hcGVydHVyZXMtPnJhbmdlc1sw
XS5iYXNlLCBpbmZvLT5hcGVydHVyZXMtPnJhbmdlc1swXS5zaXplKTsNCj4gKw0KPiArCWZy
YW1lYnVmZmVyX3JlbGVhc2UoaW5mbyk7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBzdHJ1
Y3QgZmJfb3BzIHZlc2FmYl9vcHMgPSB7DQo+IEBAIC00ODQsMTAgKzQ5NCw4IEBAIHN0YXRp
YyBpbnQgdmVzYWZiX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
IHsNCj4gICAJc3RydWN0IGZiX2luZm8gKmluZm8gPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShw
ZGV2KTsNCj4gICANCj4gKwkvKiB2ZXNhZmJfZGVzdHJveSB0YWtlcyBjYXJlIG9mIGluZm8g
Y2xlYW51cCAqLw0KPiAgIAl1bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyKGluZm8pOw0KPiAtCWlm
ICgoKHN0cnVjdCB2ZXNhZmJfcGFyICopKGluZm8tPnBhcikpLT5yZWdpb24pDQo+IC0JCXJl
bGVhc2VfcmVnaW9uKDB4M2MwLCAzMik7DQo+IC0JZnJhbWVidWZmZXJfcmVsZWFzZShpbmZv
KTsNCj4gICANCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KDQotLSANClRob21hcyBaaW1tZXJt
YW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFu
eQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBU
b3Rldg0K

--------------qjaYkn7iDSY9Mbq55tpCXTw7--

--------------3qb0jJDsfMwthAxMyida0Ig6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmJzuk0FAwAAAAAACgkQlh/E3EQov+C9
CBAAkIiJUw3OnjFE97PswhZpdccKT8EMFa/zzkjh+SS+nCzOHUimt0Nf7kvtOYUB5EVmYS6DV+n6
Kz395oq40et5kks17UL/yTqxryNr4BlIrkgqQwy0f35clZw8iM5QOolgnlXE10gP5oYGrd9W7Tpi
U+ynq3kYOT2AO+J2GvNxMTEK3pq9pcUiha7HIEG1N52VGrDPDlPaV7Qamx95C5oXvRhkg8yDaW0i
x1tLe7dY3n7mrPDuG6LqqS6efPUARDcquRvCKr6m7AZpN1amT7ceyW3K93HpBRqDZM25Tq/Vv6Nx
IH2h3b/J4Oz09a6Z8jjJk/WPdh2IPTr63o2miJx7mWe9OPeepT53WZJRO0R3zDNWOieXNObFXhbY
I7b0CsBRGU0jdzQCesDf2jlhFQBahxUZxgJvlB35N292k2PMFRgDBxeLkoun5VKVr2kb+iuD6y+D
iZKrbKWC33D7wOeJeVgEx7CLkmzyxQX5jwytFSZKnU3bZWWjLBVVMjJ5Uwgo0W9PgNi4HRlaQ0Ft
As9uD7HCg3IWkKjuP51Prw4cuyR2e6XMPhvQa2yeJp2AMXiIVvnUMGvqtb/cg41K7QVD+/7DlBUy
vdcVGIO0TMbPnGjQmvwm+sCJG2lni9Y9aGrFm2AZXpCX/KVHDGws+mo6hhTxI0CuzyiUv2PVQCs2
IQs=
=M+WV
-----END PGP SIGNATURE-----

--------------3qb0jJDsfMwthAxMyida0Ig6--
