Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5DA4DB8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350714AbiCPTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiCPTcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:32:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3173B3E2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:31:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31E8E1F38D;
        Wed, 16 Mar 2022 19:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647459065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oyijL7wKYvaw8yuN+KHZKQOHPhOkToksPX5D1lko3sc=;
        b=my+6mduhWv45lUofaLcRvxeKyxsqAsyruuPYZb1X3yRNtEinKwqkhY4NcjTw3sFpmT9Wv6
        /z2l2lO8vp3Ji0eHetMDXRSIXogZPSO6KRQ+1rzoGZShTaFadYpl3hSq2Z2Yr9X7umQx/x
        2dJYp8j5ruh5lM+Ac2cGZwti2HY92LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647459065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oyijL7wKYvaw8yuN+KHZKQOHPhOkToksPX5D1lko3sc=;
        b=sA/41s0RxL5JEV2NCdTHBxXTiZN8H30+Y4OCHWyVV3dtbDg0jzFuRF7yAkIQ0XGV6QdsJF
        BU5pOcw3GULkwfCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B256813A32;
        Wed, 16 Mar 2022 19:31:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C5EhKvg6MmLaBgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 16 Mar 2022 19:31:04 +0000
Message-ID: <1f6c4559-ee48-ca67-8ff1-f7f9d330bc12@suse.de>
Date:   Wed, 16 Mar 2022 20:31:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] drm/panel: add CONFIG_DRM_KMS_HELPER dependencies
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220316183708.1505846-1-arnd@kernel.org>
 <aaf204b2-e876-d271-3d4e-51cbcc70d690@suse.de>
In-Reply-To: <aaf204b2-e876-d271-3d4e-51cbcc70d690@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fo6D0fbjn00q0zS8Eq3Sj3sl"
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
--------------fo6D0fbjn00q0zS8Eq3Sj3sl
Content-Type: multipart/mixed; boundary="------------It0SmhopNWRK4Y8F8SvBLNER";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Thierry Reding <thierry.reding@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Kees Cook
 <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Jani Nikula <jani.nikula@intel.com>, Sam Ravnborg <sam@ravnborg.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>,
 Deepak Rawat <drawat.floss@gmail.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?=
 <noralf@tronnes.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Dillon Min <dillon.minfei@gmail.com>, linux-kernel@vger.kernel.org
Message-ID: <1f6c4559-ee48-ca67-8ff1-f7f9d330bc12@suse.de>
Subject: Re: [PATCH] drm/panel: add CONFIG_DRM_KMS_HELPER dependencies
References: <20220316183708.1505846-1-arnd@kernel.org>
 <aaf204b2-e876-d271-3d4e-51cbcc70d690@suse.de>
In-Reply-To: <aaf204b2-e876-d271-3d4e-51cbcc70d690@suse.de>

--------------It0SmhopNWRK4Y8F8SvBLNER
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDE2LjAzLjIyIHVtIDIwOjEyIHNjaHJpZWIgVGhvbWFzIFppbW1lcm1hbm46DQo+
IEhpDQo+IA0KPiBBbSAxNi4wMy4yMiB1bSAxOTozNiBzY2hyaWViIEFybmQgQmVyZ21hbm46
DQo+PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPj4NCj4+IFRoZSBk
cml2ZXIgZmFpbHMgdG8gYnVpbGQgd2hlbiB0aGUgS01TIGhlbHBlcnMgYXJlIGRpc2FibGVk
Og0KPj4NCj4+IGxkLmxsZDogZXJyb3I6IHVuZGVmaW5lZCBzeW1ib2w6IGRybV9nZW1fZmJf
Z2V0X29iag0KPj4+Pj4gcmVmZXJlbmNlZCBieSBkcm1fbWlwaV9kYmkuYw0KPj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBncHUvZHJtL2RybV9taXBpX2RiaS5vOihtaXBp
X2RiaV9idWZfY29weSkgaW4gDQo+Pj4+PiBhcmNoaXZlIGRyaXZlcnMvYnVpbHQtaW4uYQ0K
Pj4+Pj4gcmVmZXJlbmNlZCBieSBkcm1fbWlwaV9kYmkuYw0KPj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBncHUvZHJtL2RybV9taXBpX2RiaS5vOihtaXBpX2RiaV9mYl9k
aXJ0eSkgaW4gDQo+Pj4+PiBhcmNoaXZlIGRyaXZlcnMvYnVpbHQtaW4uYQ0KPj4NCj4+IGxk
LmxsZDogZXJyb3I6IHVuZGVmaW5lZCBzeW1ib2w6IGRybV9nZW1fZmJfYmVnaW5fY3B1X2Fj
Y2Vzcw0KPj4+Pj4gcmVmZXJlbmNlZCBieSBkcm1fbWlwaV9kYmkuYw0KPj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBncHUvZHJtL2RybV9taXBpX2RiaS5vOihtaXBpX2Ri
aV9idWZfY29weSkgaW4gDQo+Pj4+PiBhcmNoaXZlIGRyaXZlcnMvYnVpbHQtaW4uYQ0KPj4N
Cj4+IGxkLmxsZDogZXJyb3I6IHVuZGVmaW5lZCBzeW1ib2w6IGRybV9mYl9zd2FiDQo+Pj4+
PiByZWZlcmVuY2VkIGJ5IGRybV9taXBpX2RiaS5jDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdwdS9kcm0vZHJtX21pcGlfZGJpLm86KG1pcGlfZGJpX2J1Zl9jb3B5
KSBpbiANCj4+Pj4+IGFyY2hpdmUgZHJpdmVycy9idWlsdC1pbi5hDQo+Pg0KPj4gbGQubGxk
OiBlcnJvcjogdW5kZWZpbmVkIHN5bWJvbDogZHJtX2ZiX3hyZ2I4ODg4X3RvX3JnYjU2NQ0K
Pj4+Pj4gcmVmZXJlbmNlZCBieSBkcm1fbWlwaV9kYmkuYw0KPj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBncHUvZHJtL2RybV9taXBpX2RiaS5vOihtaXBpX2RiaV9idWZf
Y29weSkgaW4gDQo+Pj4+PiBhcmNoaXZlIGRyaXZlcnMvYnVpbHQtaW4uYQ0KPj4NCj4+IGxk
LmxsZDogZXJyb3I6IHVuZGVmaW5lZCBzeW1ib2w6IGRybV9mYl9tZW1jcHkNCj4+Pj4+IHJl
ZmVyZW5jZWQgYnkgZHJtX21pcGlfZGJpLmMNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZ3B1L2RybS9kcm1fbWlwaV9kYmkubzoobWlwaV9kYmlfYnVmX2NvcHkpIGlu
IA0KPj4+Pj4gYXJjaGl2ZSBkcml2ZXJzL2J1aWx0LWluLmENCj4+DQo+PiBUaGlzIGlzIGZh
aXJseSBoYXJkIHRvIGhpdCBpbiByYW5kY29uZmlnIGRyaXZlcnMsIGJ1dCBpdCBldmVudHVh
bGx5DQo+PiBkaWQgdHJpZ2dlciBmb3IgbWUgaW4gYSBjb25maWd1cmF0aW9uIHdoZXJlIGFs
bCBvdGhlciBEUk0gZHJpdmVycw0KPj4gYXJlIGxvYWRhYmxlIG1vZHVsZXMsIGJ1dCBEUk1f
UEFORUxfV0lERUNISVBTX1dTMjQwMSB3YXMgYnVpbHQtaW4uDQo+Pg0KPj4gQWRkaW5nIGEg
ZGVwZW5kZW5jeSBpbiBhbGwgZHJpdmVycyB0aGF0IHNlbGVjdCBEUk1fTUlQSV9EQkkgYXZv
aWRzDQo+PiB0aGUgcHJvYmxlbSBmb3Igbm93LCBhZGRpbmcgdGhlIGRlcGVuZGVuY3kgaW4g
RFJNX01JUElfREJJIGFzIHdlbGwNCj4+IHNob3VsZCBoZWxwIG1ha2UgaXQgZWFzaWVyIHRv
IGZpZ3VyZSBvdXQgd2h5IGl0IGJyZWFrcyBpZiBzb21lb25lDQo+PiBmb3JnZXRzIHRoZSBk
ZXBlbmRlbmN5IHRoZSBuZXh0IHRpbWUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQXJuZCBC
ZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy9ncHUvZHJt
L0tjb25maWfCoMKgwqDCoMKgwqAgfCAyICstDQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vcGFu
ZWwvS2NvbmZpZyB8IDQgKysrKw0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBJIHNlZSB0aGlzIHdhcm5pbmcgb24gNS4x
Ny1yYzgsIGJ1dCBkaWQgbm90IHRlc3QgaXQgb24gbGludXgtbmV4dCwNCj4+IHdoaWNoIG1h
eSBhbHJlYWR5IGhhdmUgYSBmaXguDQo+Pg0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vS2NvbmZpZyBiL2RyaXZlcnMvZ3B1L2RybS9LY29uZmlnDQo+PiBpbmRleCBi
MWYyMmU0NTdmZDAuLmQ1ZWMwYjc3YzAxMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9LY29uZmlnDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vS2NvbmZpZw0KPj4gQEAg
LTMwLDcgKzMwLDcgQEAgbWVudWNvbmZpZyBEUk0NCj4+IMKgIGNvbmZpZyBEUk1fTUlQSV9E
QkkNCj4+IMKgwqDCoMKgwqAgdHJpc3RhdGUNCj4+IC3CoMKgwqAgZGVwZW5kcyBvbiBEUk0N
Cj4+ICvCoMKgwqAgZGVwZW5kcyBvbiBEUk1fS01TX0hFTFBFUg0KPiANCj4gVGhpcyBzeW1i
b2wgY2Fubm90IGJlIHNlbGVjdGVkIGJ5IHVzZXJzLCBzbyBpdCdzIG1heWJlIG5vdCBhIGdv
b2QgaWRlYSANCj4gdG8gZGVwZW5kIG9uIGl0LiBJbiBmYWN0LCBJJ3ZlIGhhZCB0byByZW1v
dmUgc3VjaCBhIHN0YXRlbWVudCBiZWNhdXNlIGl0IA0KPiBjcmVhdGVkIGEgY3ljbGljIGRl
cGVuZGVuY3kuIFsxXQ0KDQpbMV0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9kcmktZGV2
ZWwvMjAyMjAzMTUwODQ1NTkuMjM1MTAtMS10emltbWVybWFubkBzdXNlLmRlLw0KDQo+IA0K
PiBNYWtpbmcgdGhlIGRyaXZlcnMgZGVwZW5kIG9uIEtNUyBoZWxwZXJzIGlzIHRoZSByaWdo
dCB0aGluZyB0aG91Z2guIElmIA0KPiB0aGVyZSdzIGEgYmV0dGVyIHNvbHV0aW9uLCBwbGVh
c2UgbGV0IG1lIGtub3cuDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVGhvbWFzDQo+IA0KPj4g
wqAgY29uZmlnIERSTV9NSVBJX0RTSQ0KPj4gwqDCoMKgwqDCoCBib29sDQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3BhbmVsL0tjb25maWcgDQo+PiBiL2RyaXZlcnMvZ3B1
L2RybS9wYW5lbC9LY29uZmlnDQo+PiBpbmRleCAwYWVjNWExMGIwNjQuLjk2ODg3ZDBlZmI5
ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9LY29uZmlnDQo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvS2NvbmZpZw0KPj4gQEAgLTQyNSw2ICs0MjUs
NyBAQCBjb25maWcgRFJNX1BBTkVMX1NBTVNVTkdfREI3NDMwDQo+PiDCoMKgwqDCoMKgIHRy
aXN0YXRlICJTYW1zdW5nIERCNzQzMC1iYXNlZCBEUEkgcGFuZWxzIg0KPj4gwqDCoMKgwqDC
oCBkZXBlbmRzIG9uIE9GICYmIFNQSSAmJiBHUElPTElCDQo+PiDCoMKgwqDCoMKgIGRlcGVu
ZHMgb24gQkFDS0xJR0hUX0NMQVNTX0RFVklDRQ0KPj4gK8KgwqDCoCBkZXBlbmRzIG9uIERS
TV9LTVNfSEVMUEVSDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBEUk1fTUlQSV9EQkkNCj4+IMKg
wqDCoMKgwqAgaGVscA0KPj4gwqDCoMKgwqDCoMKgwqAgU2F5IFkgaGVyZSBpZiB5b3Ugd2Fu
dCB0byBlbmFibGUgc3VwcG9ydCBmb3IgdGhlIFNhbXN1bmcNCj4+IEBAIC00NDAsNiArNDQx
LDcgQEAgY29uZmlnIERSTV9QQU5FTF9TQU1TVU5HX1M2RDE2RDANCj4+IMKgIGNvbmZpZyBE
Uk1fUEFORUxfU0FNU1VOR19TNkQyN0ExDQo+PiDCoMKgwqDCoMKgIHRyaXN0YXRlICJTYW1z
dW5nIFM2RDI3QTEgRFBJIHBhbmVsIGRyaXZlciINCj4+IMKgwqDCoMKgwqAgZGVwZW5kcyBv
biBPRiAmJiBTUEkgJiYgR1BJT0xJQg0KPj4gK8KgwqDCoCBkZXBlbmRzIG9uIERSTV9LTVNf
SEVMUEVSDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBEUk1fTUlQSV9EQkkNCj4+IMKgwqDCoMKg
wqAgaGVscA0KPj4gwqDCoMKgwqDCoMKgwqAgU2F5IFkgaGVyZSBpZiB5b3Ugd2FudCB0byBl
bmFibGUgc3VwcG9ydCBmb3IgdGhlIFNhbXN1bmcNCj4+IEBAIC00NzYsNiArNDc4LDcgQEAg
Y29uZmlnIERSTV9QQU5FTF9TQU1TVU5HX1M2RTYzTTBfU1BJDQo+PiDCoMKgwqDCoMKgIGRl
cGVuZHMgb24gU1BJDQo+PiDCoMKgwqDCoMKgIGRlcGVuZHMgb24gRFJNX1BBTkVMX1NBTVNV
TkdfUzZFNjNNMA0KPj4gwqDCoMKgwqDCoCBkZWZhdWx0IERSTV9QQU5FTF9TQU1TVU5HX1M2
RTYzTTANCj4+ICvCoMKgwqAgZGVwZW5kcyBvbiBEUk1fS01TX0hFTFBFUg0KPj4gwqDCoMKg
wqDCoCBzZWxlY3QgRFJNX01JUElfREJJDQo+PiDCoMKgwqDCoMKgIGhlbHANCj4+IMKgwqDC
oMKgwqDCoMKgIFNheSBZIGhlcmUgaWYgeW91IHdhbnQgdG8gYmUgYWJsZSB0byBhY2Nlc3Mg
dGhlIFNhbXN1bmcNCj4+IEBAIC02NzcsNiArNjgwLDcgQEAgY29uZmlnIERSTV9QQU5FTF9X
SURFQ0hJUFNfV1MyNDAxDQo+PiDCoMKgwqDCoMKgIHRyaXN0YXRlICJXaWRlY2hpcHMgV1My
NDAxIERQSSBwYW5lbCBkcml2ZXIiDQo+PiDCoMKgwqDCoMKgIGRlcGVuZHMgb24gU1BJICYm
IEdQSU9MSUINCj4+IMKgwqDCoMKgwqAgZGVwZW5kcyBvbiBCQUNLTElHSFRfQ0xBU1NfREVW
SUNFDQo+PiArwqDCoMKgIGRlcGVuZHMgb24gRFJNX0tNU19IRUxQRVINCj4+IMKgwqDCoMKg
wqAgc2VsZWN0IERSTV9NSVBJX0RCSQ0KPj4gwqDCoMKgwqDCoCBoZWxwDQo+PiDCoMKgwqDC
oMKgwqDCoCBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IHRvIGVuYWJsZSBzdXBwb3J0IGZvciB0
aGUgV2lkZWNoaXBzIA0KPj4gV1MyNDAxIERQSQ0KPiANCg0KLS0gDQpUaG9tYXMgWmltbWVy
bWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlv
bnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1h
bnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8g
VG90ZXYNCg==

--------------It0SmhopNWRK4Y8F8SvBLNER--

--------------fo6D0fbjn00q0zS8Eq3Sj3sl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmIyOvcFAwAAAAAACgkQlh/E3EQov+Di
cw//c67LjK07GGoG8PgUmslj3l7PcmbquCNrO+150DbCs1tDZiY2TRYTagZRhoK5wvuZHqj8Zu4N
2sclIKGBRGIKSvvHrxF41l9ScH5+tK+7aduEGVrhveoJdXVcor4SsRYp3bcMSspD1A7N6eTN/XM7
Fa5qF1+cVr/K2drUplYioe/hVHT63n4qycBVxrQs9ZmrJpymVIexHrdJiS+A74Lim7D2AMhLve/S
nj9ftlL4O6S1FRDsDk1eRqmYJTVxuJg8svje/7s1Kzsv/baAPMaeKrSioerF1M79PO9Fy/+A4gZ+
8J9rZDgtOcxqI73IteTmgvBRXhKMYYsbOrE+wTB9aaSVWPpT+K/NWtrRYqoRNk2RknpoImL2yjJM
64VaTgq7UMnR/ObbxJJ7475KW3LA31ExWVo9je1S10lxwPZpdHQPalYom6x7OEzDjlCd2feOxpl2
1xtD58e912YlNveP/ZyAZTFI1BpQ2A0kL2aPeu8hOyw6+DY2wcrfELhIeeZHvhzN5RoA7GZjAK8U
XfkuFWBJNrkooTE8WrANFs7zK83bUVPuE2gRS3jqIY3x3fPAVOwJ4t2HswROF5m4Dqexucfys2OV
mL3oKmIjehEMqg/DhtBOySkJdMgdNWkAq5dQlrZcHhJm1TRZP8lJILlNntQdQQ7vlIWsaqcZfM4I
s88=
=h/uC
-----END PGP SIGNATURE-----

--------------fo6D0fbjn00q0zS8Eq3Sj3sl--
