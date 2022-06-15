Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC07E54C4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbiFOJcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiFOJcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:32:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6395713F67;
        Wed, 15 Jun 2022 02:32:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E6AB21B61;
        Wed, 15 Jun 2022 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655285561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GdiDvCAg9O1/d1vITE2FLYA4kxpmVbO5wBq5nI2zzws=;
        b=rDnf0s4wqN2vFvjXd+otZTvw7/+5+9Bkl3WtioPxpmigme3C2DIjBJ8sJTBlIDoZBInaLd
        b3n/XqvL+WSEE3Su6AQ29x2/qaSvqtPjKigIncjwiwBlc964HFcuZGoLSei1LmU4dc2HGb
        3oIs5sYCrQFz5NB9fR8s06K/hsivbco=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA5A1139F3;
        Wed, 15 Jun 2022 09:32:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ikr3MzinqWJSQQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 15 Jun 2022 09:32:40 +0000
Message-ID: <a063368a-022a-c294-5a19-da1b80c45461@suse.com>
Date:   Wed, 15 Jun 2022 11:32:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] xen: don't require virtio with grants for non-PV guests
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20220615084835.27113-1-jgross@suse.com>
 <20220615092519.5677clabobheziet@vireshk-i7>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220615092519.5677clabobheziet@vireshk-i7>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WbFtDx5jTtNkqzBb0mqgblYE"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WbFtDx5jTtNkqzBb0mqgblYE
Content-Type: multipart/mixed; boundary="------------nKGSwd00yM0V3lyWpANyvyUW";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: xen-devel@lists.xenproject.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-ID: <a063368a-022a-c294-5a19-da1b80c45461@suse.com>
Subject: Re: [PATCH] xen: don't require virtio with grants for non-PV guests
References: <20220615084835.27113-1-jgross@suse.com>
 <20220615092519.5677clabobheziet@vireshk-i7>
In-Reply-To: <20220615092519.5677clabobheziet@vireshk-i7>

--------------nKGSwd00yM0V3lyWpANyvyUW
Content-Type: multipart/mixed; boundary="------------gQNSt1Ojv9sx01gPYMoid8mJ"

--------------gQNSt1Ojv9sx01gPYMoid8mJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMDYuMjIgMTE6MjUsIFZpcmVzaCBLdW1hciB3cm90ZToNCj4gT24gMTUtMDYtMjIs
IDEwOjQ4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gQ29tbWl0IGZhMWY1NzQyMWUwYiAo
Inhlbi92aXJ0aW86IEVuYWJsZSByZXN0cmljdGVkIG1lbW9yeSBhY2Nlc3MgdXNpbmcNCj4+
IFhlbiBncmFudCBtYXBwaW5ncyIpIGludHJvZHVjZWQgYSBuZXcgcmVxdWlyZW1lbnQgZm9y
IHVzaW5nIHZpcnRpbw0KPj4gZGV2aWNlczogdGhlIGJhY2tlbmQgbm93IG5lZWRzIHRvIHN1
cHBvcnQgdGhlIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STQ0KPj4gZmVhdHVyZS4NCj4+DQo+
PiBUaGlzIGlzIGFuIHVuZHVlIHJlcXVpcmVtZW50IGZvciBub24tUFYgZ3Vlc3RzLCBhcyB0
aG9zZSBjYW4gYmUgb3BlcmF0ZWQNCj4+IHdpdGggZXhpc3RpbmcgYmFja2VuZHMgd2l0aG91
dCBhbnkgcHJvYmxlbSwgYXMgbG9uZyBhcyB0aG9zZSBiYWNrZW5kcw0KPj4gYXJlIHJ1bm5p
bmcgaW4gZG9tMC4NCj4+DQo+PiBQZXIgZGVmYXVsdCBhbGxvdyB2aXJ0aW8gZGV2aWNlcyB3
aXRob3V0IGdyYW50IHN1cHBvcnQgZm9yIG5vbi1QVg0KPj4gZ3Vlc3RzLg0KPj4NCj4+IFRo
ZSBzZXR0aW5nIGNhbiBiZSBvdmVycmlkZGVuIGJ5IHVzaW5nIHRoZSBuZXcgInhlbl92aXJ0
aW9fZ3JhbnQiDQo+PiBjb21tYW5kIGxpbmUgcGFyYW1ldGVyLg0KPj4NCj4+IEFkZCBhIG5l
dyBjb25maWcgaXRlbSB0byBhbHdheXMgZm9yY2UgdXNlIG9mIGdyYW50cyBmb3IgdmlydGlv
Lg0KPj4NCj4+IEZpeGVzOiBmYTFmNTc0MjFlMGIgKCJ4ZW4vdmlydGlvOiBFbmFibGUgcmVz
dHJpY3RlZCBtZW1vcnkgYWNjZXNzIHVzaW5nIFhlbiBncmFudCBtYXBwaW5ncyIpDQo+PiBT
aWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+PiAtLS0N
Cj4+ICAgLi4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCAgICAgICAgIHwg
IDYgKysrKysNCj4+ICAgZHJpdmVycy94ZW4vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDkgKysrKysrKysNCj4+ICAgZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5j
ICAgICAgICAgICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKw0KPj4gICBpbmNs
dWRlL3hlbi94ZW4uaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMiArKysrKy0t
LS0tDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHF1aWNrIGZpeC4NCj4gDQo+IFdpdGggQ09O
RklHX0RFQlVHX1NFQ1RJT05fTUlTTUFUQ0g9eSwgdGhpcyBnZW5lcmF0ZXMgYSB3YXJuaW5n
Lg0KPiANCj4gV0FSTklORzogbW9kcG9zdDogdm1saW51eC5vKC50ZXh0KzB4N2E4MjcwKTog
U2VjdGlvbiBtaXNtYXRjaCBpbiByZWZlcmVuY2UgZnJvbSB0aGUgZnVuY3Rpb24geGVuX3Nl
dF9yZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzKCkgdG8gdGhlIHZhcmlhYmxlIC5p
bml0LmRhdGE6eGVuX3ZpcnRpb19ncmFudHMNCj4gVGhlIGZ1bmN0aW9uIHhlbl9zZXRfcmVz
dHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2VzcygpIHJlZmVyZW5jZXMNCj4gdGhlIHZhcmlh
YmxlIF9faW5pdGRhdGEgeGVuX3ZpcnRpb19ncmFudHMuDQo+IFRoaXMgaXMgb2Z0ZW4gYmVj
YXVzZSB4ZW5fc2V0X3Jlc3RyaWN0ZWRfdmlydGlvX21lbW9yeV9hY2Nlc3MgbGFja3MgYSBf
X2luaXRkYXRhDQo+IGFubm90YXRpb24gb3IgdGhlIGFubm90YXRpb24gb2YgeGVuX3ZpcnRp
b19ncmFudHMgaXMgd3JvbmcuDQoNClNpbGx5IG1lLiBUaGFua3MgZm9yIHRoZSBub3RpY2Uu
DQoNCj4gDQo+IFRoaXMgY2FuIGJlIGZpeGVkIGJ5Og0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYyBiL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMu
Yw0KPiBpbmRleCBkMWZhZTc4OWRmYWQuLjEwOTkwOTdiNDUxNSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+ICsrKyBiL2RyaXZlcnMveGVuL2dyYW50
LWRtYS1vcHMuYw0KPiBAQCAtNDIsNyArNDIsNyBAQCBzdGF0aWMgX19pbml0IGludCBwYXJz
ZV91c2VfZ3JhbnRzKGNoYXIgKmFyZykNCj4gICB9DQo+ICAgZWFybHlfcGFyYW0oInhlbl92
aXJ0aW9fZ3JhbnQiLCBwYXJzZV91c2VfZ3JhbnRzKTsNCj4gDQo+IC12b2lkIHhlbl9zZXRf
cmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcyh2b2lkKQ0KPiArdm9pZCBfX2luaXQg
eGVuX3NldF9yZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzKHZvaWQpDQo+ICAgew0K
PiAgICAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFO
VCkgfHwgeGVuX3ZpcnRpb19ncmFudHMgfHwNCj4gICAgICAgICAgICAgICgheGVuX3ZpcnRp
b19ncmFudHNfc2V0ICYmIHhlbl9wdl9kb21haW4oKSkpDQo+IA0KPiBXaXRoIHRoYXQ6DQo+
IA0KPiBUZXN0ZWQtYnk6IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+
DQo+IA0KDQpUaGFua3MsDQoNCg0KSnVlcmdlbg0K
--------------gQNSt1Ojv9sx01gPYMoid8mJ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------gQNSt1Ojv9sx01gPYMoid8mJ--

--------------nKGSwd00yM0V3lyWpANyvyUW--

--------------WbFtDx5jTtNkqzBb0mqgblYE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKppzgFAwAAAAAACgkQsN6d1ii/Ey/V
YAf/Q8X92e3qwlE8Q4ITny2XI7T0CiFWcAdKwHkIjBHIHtMszxV/RdVnjVkEHOgh1c1rLwzvf9nC
DODMe4T3YbDZAjCkztASdGuCPn++tuBeBrlTWOvtsbn4W1DzKfQvSptJAjSrZU6tiiwopunvtvtW
4ImAUhCCyxYTJwAaGs1/XgT5RQTt8kAq5GjFb77difPu87aJLVX7evdDbGkdD5qEvReKKVChZVyu
BkQSv4wYWQcVRZBeT7y0EAzNE/erpi3GFrP5rKMbqPtgBRbRFwKmBRxhiZDr4AAcDWi90NAHnnn9
hmwzoDCBPA5BeHeLCtPMtMwnmPI41V/12bkZFGtWUA==
=e5f6
-----END PGP SIGNATURE-----

--------------WbFtDx5jTtNkqzBb0mqgblYE--
