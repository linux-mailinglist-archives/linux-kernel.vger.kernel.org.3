Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFB35ACE15
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiIEImL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiIEImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:42:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A313D12
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:42:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 33D885FCEA;
        Mon,  5 Sep 2022 08:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662367326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9cc8jXMXq+VJC2r3/qujYRpXcnXfJqIxBUW+wzkamH4=;
        b=qf/ZGiG4gMPlQj0AV4Xc7iRzlifaGgIelGPhY240Nhv/BE4Z2H/UnTZfFiGieAHFRrXLa2
        5CpNc66fXnoP5GRDnQazM1QnVEF0/g6kPQm08fAQN6+kiG+W5IqxQU+ZqOBTmj3HKHPO/j
        GNDCxX90QLHWkAG2SneLqM//GlA2o1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662367326;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9cc8jXMXq+VJC2r3/qujYRpXcnXfJqIxBUW+wzkamH4=;
        b=5A2UkiOXsyB+LpFSG7lgJSeayBGtMBU9SgpITbyv7h8BSB3dpS8d7ELJAV6f+jysgoUemq
        B5CpncrwMUAmv6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D61D139C7;
        Mon,  5 Sep 2022 08:42:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eeM6Bl62FWNvEwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 05 Sep 2022 08:42:06 +0000
Message-ID: <293a35ea-332f-3ed6-8060-bbde3ac53fa6@suse.de>
Date:   Mon, 5 Sep 2022 10:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 11/12] drm/udl: Don't re-initialize stuff at retrying the
 URB list allocation
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220816153655.27526-1-tiwai@suse.de>
 <20220816153655.27526-12-tiwai@suse.de>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20220816153655.27526-12-tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------uUZ8zSrEp9CNOJe2a8igipW0"
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------uUZ8zSrEp9CNOJe2a8igipW0
Content-Type: multipart/mixed; boundary="------------rpmQu0OUpKS0BH0rKyEHbUUr";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <293a35ea-332f-3ed6-8060-bbde3ac53fa6@suse.de>
Subject: Re: [PATCH 11/12] drm/udl: Don't re-initialize stuff at retrying the
 URB list allocation
References: <20220816153655.27526-1-tiwai@suse.de>
 <20220816153655.27526-12-tiwai@suse.de>
In-Reply-To: <20220816153655.27526-12-tiwai@suse.de>

--------------rpmQu0OUpKS0BH0rKyEHbUUr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDE2LjA4LjIyIHVtIDE3OjM2IHNjaHJpZWIgVGFrYXNoaSBJd2FpOg0KPiB1ZGxf
YWxsb2NfdXJiX2xpc3QoKSByZXRpcmVzIHRoZSBhbGxvY2F0aW9uIGlmIHRoZXJlIGlzIG5v
IGVub3VnaCByb29tDQo+IGxlZnQsIGFuZCBpdCByZWluaXRpYWxpemVzIHRoZSBzdHVmZiB1
bm5lY2Vzc2FyaWx5IHN1Y2ggYXMgdGhlIGxpbmtlZA0KPiBsaXN0IGhlYWQgYW5kIHRoZSB3
YWl0cXVldWUsIHdoaWNoIGNvdWxkIGJlIGhhcm1mdWwuICBUaG9zZSBzaG91bGQgYmUNCj4g
b3V0c2lkZSB0aGUgcmV0cnkgbG9vcC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRha2FzaGkg
SXdhaSA8dGl3YWlAc3VzZS5kZT4NCg0KQWNrZWQtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0
emltbWVybWFubkBzdXNlLmRlPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS91ZGwv
dWRsX21haW4uYyB8IDcgKysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3VkbC91ZGxfbWFpbi5jIGIvZHJpdmVycy9ncHUvZHJtL3VkbC91ZGxfbWFpbi5jDQo+
IGluZGV4IDE5ZGM4MzE3ZTg0My4uYzFmNGI2MTk5OTQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vdWRsL3VkbF9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3Vk
bC91ZGxfbWFpbi5jDQo+IEBAIC0xODcsMTUgKzE4NywxNCBAQCBzdGF0aWMgaW50IHVkbF9h
bGxvY191cmJfbGlzdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBpbnQgY291bnQsIHNpemVf
dCBzaXplKQ0KPiAgIAlzdHJ1Y3QgdXNiX2RldmljZSAqdWRldiA9IHVkbF90b191c2JfZGV2
aWNlKHVkbCk7DQo+ICAgDQo+ICAgCXNwaW5fbG9ja19pbml0KCZ1ZGwtPnVyYnMubG9jayk7
DQo+IC0NCj4gLXJldHJ5Og0KPiAtCXVkbC0+dXJicy5zaXplID0gc2l6ZTsNCj4gICAJSU5J
VF9MSVNUX0hFQUQoJnVkbC0+dXJicy5saXN0KTsNCj4gLQ0KPiAgIAlpbml0X3dhaXRxdWV1
ZV9oZWFkKCZ1ZGwtPnVyYnMuc2xlZXApOw0KPiAgIAl1ZGwtPnVyYnMuY291bnQgPSAwOw0K
PiAgIAl1ZGwtPnVyYnMuYXZhaWxhYmxlID0gMDsNCj4gICANCj4gK3JldHJ5Og0KPiArCXVk
bC0+dXJicy5zaXplID0gc2l6ZTsNCj4gKw0KPiAgIAl3aGlsZSAodWRsLT51cmJzLmNvdW50
ICogc2l6ZSA8IHdhbnRlZF9zaXplKSB7DQo+ICAgCQl1bm9kZSA9IGt6YWxsb2Moc2l6ZW9m
KHN0cnVjdCB1cmJfbm9kZSksIEdGUF9LRVJORUwpOw0KPiAgIAkJaWYgKCF1bm9kZSkNCg0K
LS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VT
RSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQw
OSBOw7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2No
w6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------rpmQu0OUpKS0BH0rKyEHbUUr--

--------------uUZ8zSrEp9CNOJe2a8igipW0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmMVtl0FAwAAAAAACgkQlh/E3EQov+B/
MxAAumV6LAPveYKLPGYTpSNj8WJkx1LX+3MdQ3RSTsSmR69A8V/MnyZ7h5fHc1flu/FvD9fqfpE8
vl8l2oGH4FCqex+QoUHJTmg+8ddDCyF4xdtmfpz1ocl9Yjqv5y+0b5U50uUtS4lYZvewBLESpXCU
MXML+tnzDwtP3u2r3AOUqs1pAlDaDLX4q3cgEgG3s903FbG7aGj/13RsVolauVFZ/Ib+JcVxVAY3
wAP434yGArPYQrihWSOgSFRSql3zdQksi90jrkXmZ9YjtaHTk2LgDjL7rttDTEuc74DjEJzQKd9a
W8hsABhJFBvW8ZFa9qrHJV9i9S7efJP2fWzHechEHmDkQO4s2Wff261ywjbbx0v57IAY2Oef2Vah
yvTcMYQDuK3lw7QhQo0n0ROV9JP3bMB/QFGDfcIuC32QAhh/+XxHoB9ufrQ9NvDkjgkC6GgLGKqZ
tjaaXlX2SfQcL/OU9sgUxLzRiOtc1luIz3qRuWaTHCJjk3URUnqR6rGgsdScatmY1VcuuG/yeWd1
B8O26WI9zzReoI/qcsvbz5/YO3eWC6tiGHZsbH471VcDtKOifOOfTKIc7QU4sEtck9JZTfZ7grRz
2YJ3CbT4WYZgTN03X/qoMsTxdJ0NCayHxmo9KaV3AVQiM734DHmUgC/GVrLCy/uYb5kjFOEx4uxA
/nw=
=duDI
-----END PGP SIGNATURE-----

--------------uUZ8zSrEp9CNOJe2a8igipW0--
