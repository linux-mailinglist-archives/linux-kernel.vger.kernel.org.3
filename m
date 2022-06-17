Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E098154F0A7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380137AbiFQFjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFQFjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:39:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59F666C88
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:39:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 471AF21DDA;
        Fri, 17 Jun 2022 05:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655444335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icVLYw40BJWzaywvjlhESg++OAa7jHW/XMj9qHWHaa0=;
        b=Kd1e4aqc1FMKRpEPJtPjq6oWTH6Q1wejSv5j+q0pmeplu6xVDMid+gv2dwXMnEnFCwoX7e
        m6NymwMG+YMRKI8MAmV1ExLuQ7zM9QaolW6Dxveio+uOJB/BuMkwAzmEnV9UNmQbwyczK4
        hI/Ul0mn7DKXJa9Efo9fuSwTGBj5FOk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1227B1330D;
        Fri, 17 Jun 2022 05:38:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4TOeAm8TrGL5UQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 17 Jun 2022 05:38:55 +0000
Message-ID: <9c7aaca1-d23e-aeec-bc3a-a0bd7dc7de77@suse.com>
Date:   Fri, 17 Jun 2022 07:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, hch@infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20220616053715.3166-1-jgross@suse.com>
 <alpine.DEB.2.22.394.2206161106020.10483@ubuntu-linux-20-04-desktop>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2] xen: don't require virtio with grants for non-PV
 guests
In-Reply-To: <alpine.DEB.2.22.394.2206161106020.10483@ubuntu-linux-20-04-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UHqUBWRx2KomWqMzCZqExmX0"
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
--------------UHqUBWRx2KomWqMzCZqExmX0
Content-Type: multipart/mixed; boundary="------------67hurPYhWVJPZ7nzlPPw0cJo";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 viresh.kumar@linaro.org, hch@infradead.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-ID: <9c7aaca1-d23e-aeec-bc3a-a0bd7dc7de77@suse.com>
Subject: Re: [PATCH v2] xen: don't require virtio with grants for non-PV
 guests
References: <20220616053715.3166-1-jgross@suse.com>
 <alpine.DEB.2.22.394.2206161106020.10483@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2206161106020.10483@ubuntu-linux-20-04-desktop>

--------------67hurPYhWVJPZ7nzlPPw0cJo
Content-Type: multipart/mixed; boundary="------------Ev1Ocmj2cMoOvmWy9UDaAU0c"

--------------Ev1Ocmj2cMoOvmWy9UDaAU0c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDYuMjIgMjA6MjAsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gVGh1
LCAxNiBKdW4gMjAyMiwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IENvbW1pdCBmYTFmNTc0
MjFlMGIgKCJ4ZW4vdmlydGlvOiBFbmFibGUgcmVzdHJpY3RlZCBtZW1vcnkgYWNjZXNzIHVz
aW5nDQo+PiBYZW4gZ3JhbnQgbWFwcGluZ3MiKSBpbnRyb2R1Y2VkIGEgbmV3IHJlcXVpcmVt
ZW50IGZvciB1c2luZyB2aXJ0aW8NCj4+IGRldmljZXM6IHRoZSBiYWNrZW5kIG5vdyBuZWVk
cyB0byBzdXBwb3J0IHRoZSBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0NCj4+IGZlYXR1cmUu
DQo+Pg0KPj4gVGhpcyBpcyBhbiB1bmR1ZSByZXF1aXJlbWVudCBmb3Igbm9uLVBWIGd1ZXN0
cywgYXMgdGhvc2UgY2FuIGJlIG9wZXJhdGVkDQo+PiB3aXRoIGV4aXN0aW5nIGJhY2tlbmRz
IHdpdGhvdXQgYW55IHByb2JsZW0sIGFzIGxvbmcgYXMgdGhvc2UgYmFja2VuZHMNCj4+IGFy
ZSBydW5uaW5nIGluIGRvbTAuDQo+Pg0KPj4gUGVyIGRlZmF1bHQgYWxsb3cgdmlydGlvIGRl
dmljZXMgd2l0aG91dCBncmFudCBzdXBwb3J0IGZvciBub24tUFYNCj4+IGd1ZXN0cy4NCj4+
DQo+PiBBZGQgYSBuZXcgY29uZmlnIGl0ZW0gdG8gYWx3YXlzIGZvcmNlIHVzZSBvZiBncmFu
dHMgZm9yIHZpcnRpby4NCj4+DQo+PiBGaXhlczogZmExZjU3NDIxZTBiICgieGVuL3ZpcnRp
bzogRW5hYmxlIHJlc3RyaWN0ZWQgbWVtb3J5IGFjY2VzcyB1c2luZyBYZW4gZ3JhbnQgbWFw
cGluZ3MiKQ0KPj4gUmVwb3J0ZWQtYnk6IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxp
bmFyby5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3Vz
ZS5jb20+DQo+PiAtLS0NCj4+IFYyOg0KPj4gLSByZW1vdmUgY29tbWFuZCBsaW5lIHBhcmFt
ZXRlciAoQ2hyaXN0b3BoIEhlbGx3aWcpDQo+PiAtLS0NCj4+ICAgZHJpdmVycy94ZW4vS2Nv
bmZpZyB8IDkgKysrKysrKysrDQo+PiAgIGluY2x1ZGUveGVuL3hlbi5oICAgfCAyICstDQo+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9LY29uZmlnIGIvZHJpdmVycy94ZW4v
S2NvbmZpZw0KPj4gaW5kZXggYmZkNWY0ZjcwNmJjLi5hNjViZDkyMTIxYTUgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL3hlbi9LY29uZmlnDQo+PiArKysgYi9kcml2ZXJzL3hlbi9LY29u
ZmlnDQo+PiBAQCAtMzU1LDQgKzM1NSwxMyBAQCBjb25maWcgWEVOX1ZJUlRJTw0KPj4gICAN
Cj4+ICAgCSAgSWYgaW4gZG91YnQsIHNheSBuLg0KPj4gICANCj4+ICtjb25maWcgWEVOX1ZJ
UlRJT19GT1JDRV9HUkFOVA0KPj4gKwlib29sICJSZXF1aXJlIFhlbiB2aXJ0aW8gc3VwcG9y
dCB0byB1c2UgZ3JhbnRzIg0KPj4gKwlkZXBlbmRzIG9uIFhFTl9WSVJUSU8NCj4+ICsJaGVs
cA0KPj4gKwkgIFJlcXVpcmUgdmlydGlvIGZvciBYZW4gZ3Vlc3RzIHRvIHVzZSBncmFudCBt
YXBwaW5ncy4NCj4+ICsJICBUaGlzIHdpbGwgYXZvaWQgdGhlIG5lZWQgdG8gZ2l2ZSB0aGUg
YmFja2VuZCB0aGUgcmlnaHQgdG8gbWFwIGFsbA0KPj4gKwkgIG9mIHRoZSBndWVzdCBtZW1v
cnkuIFRoaXMgd2lsbCBuZWVkIHN1cHBvcnQgb24gdGhlIGJhY2tlbmQgc2lkZQ0KPj4gKwkg
IChlLmcuIHFlbXUgb3Iga2VybmVsLCBkZXBlbmRpbmcgb24gdGhlIHZpcnRpbyBkZXZpY2Ug
dHlwZXMgdXNlZCkuDQo+PiArDQo+PiAgIGVuZG1lbnUNCj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3hlbi94ZW4uaCBiL2luY2x1ZGUveGVuL3hlbi5oDQo+PiBpbmRleCAwNzgwYTgxZTE0
MGQuLjRkNDE4OGYyMDMzNyAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUveGVuL3hlbi5oDQo+
PiArKysgYi9pbmNsdWRlL3hlbi94ZW4uaA0KPj4gQEAgLTU2LDcgKzU2LDcgQEAgZXh0ZXJu
IHU2NCB4ZW5fc2F2ZWRfbWF4X21lbV9zaXplOw0KPj4gICANCj4+ICAgc3RhdGljIGlubGlu
ZSB2b2lkIHhlbl9zZXRfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcyh2b2lkKQ0K
Pj4gICB7DQo+PiAtCWlmIChJU19FTkFCTEVEKENPTkZJR19YRU5fVklSVElPKSAmJiB4ZW5f
ZG9tYWluKCkpDQo+PiArCWlmIChJU19FTkFCTEVEKENPTkZJR19YRU5fVklSVElPX0ZPUkNF
X0dSQU5UKSB8fCB4ZW5fcHZfZG9tYWluKCkpDQo+PiAgIAkJcGxhdGZvcm1fc2V0KFBMQVRG
T1JNX1ZJUlRJT19SRVNUUklDVEVEX01FTV9BQ0NFU1MpOw0KPj4gICB9DQo+IA0KPiBIaSBK
dWVyZ2VuLCB5b3UgbWlnaHQgaGF2ZSBzZWVuIG15IGVtYWlsOg0KPiBodHRwczovL21hcmMu
aW5mby8/bD1saW51eC1rZXJuZWwmbT0xNjU1MzM2MzY2MDc4MDEmdz0yDQo+IA0KPiBMaW51
eCBpcyBhbHdheXMgcnVubmluZyBhcyBIVk0gb24gQVJNLCBzbyBpZiB5b3Ugd2FudCB0byBp
bnRyb2R1Y2UNCj4gWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCwgdGhlbiBYRU5fVklSVElPX0ZP
UkNFX0dSQU5UIHNob3VsZCBiZQ0KPiBhdXRvbWF0aWNhbGx5IHNlbGVjdGVkIG9uIEFSTS4g
SSBkb24ndCB0aGluayB0aGVyZSBzaG91bGQgYmUgYSB2aXNpYmxlDQo+IG1lbnUgb3B0aW9u
IGZvciBYRU5fVklSVElPX0ZPUkNFX0dSQU5UIG9uIEFSTS4NCg0KTm8sIEkgZG9uJ3QgdGhp
bmsgc28uIEkgdGhpbmsgeW91IGFyZSBtaXhpbmcgdXAgZGlmZmVyZW50IHRoaW5ncyBoZXJl
Lg0KDQpTZXR0aW5nIFhFTl9WSVJUSU9fRk9SQ0VfR1JBTlQgcmVxdWlyZXMgdG8gc3VwcG9y
dCBncmFudHMgZm9yIGFsbA0KdmlydGlvIGRldmljZXMgb2YgdGhlIGd1ZXN0LCB3aGlsZSB0
aGVyZSBtaWdodCBiZSBwZXJmZWN0IHJlYXNvbnMgdG8NCmhhdmUgdGhhdCBmb3Igc29tZSBz
cGVjaWFsIGRldmljZXMgb25seSAob3IgdG8gYWxsb3cgdG8gdXNlIG5vIGdyYW50cw0KZm9y
IHNvbWUgc3BlY2lhbCBkZXZpY2VzKS4NCg0KWW91ciBzdWdnZXN0aW9uIHdvdWxkIHJlc3Vs
dCBpbiBhbiAiYWxsIG9yIG5vdGhpbmciIGFwcHJvYWNoLCB3aGlsZQ0KbWFueSB1c2VycyBj
b3VsZCB2ZXJ5IHdlbGwgd2FudCBhIG1peGVkIHNldHVwLg0KDQo+IEkgcmVhbGl6ZSB3ZSBo
YXZlIGEgY29uZmxpY3QgYmV0d2VlbiBIVk0gZ3Vlc3RzIG9uIEFSTSBhbmQgeDg2Og0KPiAN
Cj4gLSBvbiBBUk0sIFBMQVRGT1JNX1ZJUlRJT19SRVNUUklDVEVEX01FTV9BQ0NFU1Mgc2hv
dWxkIGJlIGVuYWJsZWQgd2hlbg0KPiAgICAieGVuLGdyYW50LWRtYSIgaXMgcHJlc2VudA0K
DQpBZ2Fpbiwgd2h5PyBXaHkgc2hvdWxkIG9uZSB2aXJ0aW8gZGV2aWNlIHdpdGggYSBiYWNr
ZW5kIHJ1bm5pbmcgaW4NCmEgZHJpdmVyIGRvbWFpbiByZXF1aXJlIF9hbGxfIHZpcnRpbyBk
ZXZpY2VzIHRvIHVzZSBncmFudHM/DQoNCj4gLSBvbiB4ODYsIGR1ZSB0byB0aGUgbGFjayBv
ZiAieGVuLGdyYW50LWRtYSIsIGl0IHNob3VsZCBiZSBvZmYgYnkNCj4gICAgZGVmYXVsdCBh
bmQgYmFzZWQgb24gYSBrY29uZmlnIG9yIGNvbW1hbmQgbGluZSBvcHRpb24NCg0KU2VlIGFi
b3ZlLiBJIGRvbid0IHNlZSBhIG1ham9yIGRpZmZlcmVuY2UgZm9yIEFybSBoZXJlLg0KDQo+
IFRvIGJlIGhvbmVzdCwgbGlrZSBDaHJpc3RvcGggc3VnZ2VzdGVkLCBJIHRoaW5rIGV2ZW4g
b24geDg2IHRoZXJlIHNob3VsZA0KPiBiZSBhIGZpcm13YXJlIHRhYmxlIHRvIHRyaWdnZXIg
c2V0dGluZw0KPiBQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTLiBXZSBo
YXZlIDIgWGVuLXNwZWNpZmljIEFDUEkNCj4gdGFibGVzLCBhbmQgd2UgY291bGQgaGF2ZSAx
IG1vcmUgdG8gZGVmaW5lIHRoaXMuIE9yIGFuIEhWTSBwYXJhbSBvcg0KPiBhIGZlYXR1cmUg
ZmxhZz8NCg0KUGxlYXNlIGRvbid0IG1peCB1cCBQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RF
RF9NRU1fQUNDRVNTICh3aGljaCB3aWxsDQplbmQgaW4gcmVxdWlyaW5nIGdyYW50cyBmb3Ig
X2FsbF8gdmlydGlvIGRldmljZXMpIGFuZCB0aGUgdXNlIGNhc2UNCnBlciBkZXZpY2UuDQoN
CkkgYWdyZWUgdGhhdCB4ODYgbmVlZHMgYSB3YXkgdG8gdHJhbnNwb3J0IHRoZSBncmFudCBz
ZXR0aW5nIHBlcg0KZGV2aWNlLCBpZiBvbmx5IGZvciBjb21tdW5pY2F0aW5nIHRoZSBiYWNr
ZW5kIGRvbWFpbiBpZC4NCg0KSSBjYW4gc2VlIHR3byBkaWZmZXJlbnQgc29sdXRpb25zIGZv
ciB0aGF0OiBlaXRoZXIgQUNQSSBvciBYZW5zdG9yZS4NCkEgSFZNIHBhcmFtIGRvZXNuJ3Qg
c2VlbSB0byBkbyB0aGUgam9iLCBhcyB0aGUgYmFja2VuZCBkb21haW4gaWQgc3RpbGwNCm5l
ZWRzIHRvIGJlIGNvbW11bmljYXRlZCBzb21laG93Lg0KDQpXaGVuIGNvbnNpZGVyaW5nIHdo
aWNoIG9uZSB0byB1c2UgKHRoZXJlIGFyZSBtYXliZSBvdGhlciBhbHRlcm5hdGl2ZXMpDQp3
ZSBzaG91bGQgaGF2ZSBpbiBtaW5kLCB0aGF0IHRoZSBzb2x1dGlvbiBzaG91bGQgc3VwcG9y
dCBQViBndWVzdHMNCih3aGljaCBpbiB0aGUgZ2VuZXJhbCBjYXNlIGRvbid0IHNlZSBhbiBB
Q1BJIHRhYmxlIHRvZGF5KSBhcyB3ZWxsIGFzDQp2aXJ0aW8gZGV2aWNlIGhvdHBsdWdnaW5n
IChpcyB0aGlzIHBvc3NpYmxlIG9uIEFybSB2aWEgZGV2aWNlIHRyZWU/IC0NCkkgZ3Vlc3Mg
aXQgc2hvdWxkIGJlLCBidXQgSSdtIG5vdCBzdXJlIGhvdyBkaWZmaWN1bHQgdGhhdCB3b3Vs
ZCBiZSkuDQoNCj4gSSB0aGluayB0aGF0IHdvdWxkIGJlIHRoZSBjbGVhbmVzdCB3YXkgdG8g
ZG8gdGhpcywgYnV0IGl0IGlzIGEgbG90IG9mDQo+IG1vcmUgd29yayBjb21wYXJlZCB0byBh
ZGRpbmcgYSBjb3VwbGUgb2YgbGluZXMgb2YgY29kZSB0byBMaW51eCwgc28gdGhpcw0KPiBp
cyB3aHkgSSBzdWdnZXN0ZWQ6DQo+IGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LWtlcm5l
bCZtPTE2NTUzMzYzNjYwNzgwMSZ3PTINCg0KSSdsbCBhbnN3ZXIgdG8gdGhpcyBvbmUgc2Vw
YXJhdGVseS4NCg0KPiANCj4gQVJNIHVzZXMgInhlbixncmFudC1kbWEiIHRvIGRldGVjdCB3
aGV0aGVyDQo+IFBMQVRGT1JNX1ZJUlRJT19SRVNUUklDVEVEX01FTV9BQ0NFU1MgbmVlZHMg
c2V0dGluZy4NCj4gDQo+IE9uZSBkYXkgeDg2IGNvdWxkIGNoZWNrIGFuIEFDUEkgcHJvcGVy
dHkgb3IgSFZNIHBhcmFtIG9yIGZlYXR1cmUgZmxhZy4NCj4gTm9uZSBvZiB0aGVtIGFyZSBh
dmFpbGFibGUgbm93LCBzbyBmb3Igbm93IHVzZSBhIGNvbW1hbmQgbGluZSBvcHRpb24gYXMN
Cj4gYSB3b3JrYXJvdW5kLiBJdCBpcyB0b3RhbGx5IGZpbmUgdG8gdXNlIGFuIHg4Ni1vbmx5
IGtjb25maWcgb3B0aW9uDQo+IGluc3RlYWQgb2YgYSBjb21tYW5kIGxpbmUgb3B0aW9uLg0K
PiANCj4gV291bGQgeW91IGJlIE9LIHdpdGggdGhhdD8NCg0KU2VlIGFib3ZlLiA6LSkNCg0K
DQpKdWVyZ2VuDQo=
--------------Ev1Ocmj2cMoOvmWy9UDaAU0c
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Ev1Ocmj2cMoOvmWy9UDaAU0c--

--------------67hurPYhWVJPZ7nzlPPw0cJo--

--------------UHqUBWRx2KomWqMzCZqExmX0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKsE24FAwAAAAAACgkQsN6d1ii/Ey/9
Jgf/VmDqJdei43pp8Gz3BIATNHL8sD3YHw6rR/78BXIOLHeWZ+gny40YVQ6R8dITiRGEgIeVmIqN
Cyvp5wcXjut5sikNqiMjZ20g+X654W15eaZGenajvIoueE4Wa2dk1Pnxb2hMP4riTklg+y+BnCO4
BKP5nGft/FyGDZnZrtsYgcs0JRhJLMqjAeqIMWXueSWXkyHGySGwH7jnErdXEj6ammtt/wWFUxk7
Q7bjaSpcxenSwo7pMD7GwRmhCQAy9KyynvBqhpkkgfo7inj75YPgXoGe5BxuRrTV49Q72A7v9Ury
21+Psrg4b4op+1ylvmnhahb5Zam03j5VSQP2qnLEtg==
=1DB4
-----END PGP SIGNATURE-----

--------------UHqUBWRx2KomWqMzCZqExmX0--
