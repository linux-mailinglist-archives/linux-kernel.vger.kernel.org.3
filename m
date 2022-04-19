Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BFB50653D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349155AbiDSHBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349200AbiDSHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:01:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC48632042
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:58:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97BB51F383;
        Tue, 19 Apr 2022 06:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650351501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+Y693yg71upH0P/35+ersl3llCGE9Kuiod2s7Spix8=;
        b=nzzYfgPGWhUoa58qLYAjdJ4PvFpHfBtJC1InTNgVLUcbJ1zwLQKyQLY9Uz6yUoHSofG15F
        rJdRxrKzJFai9qVXG5hsnXrVSovBENLeS5QFaKG+YrItCydDjId6O4nxF+kuMDF4dTfwMx
        r5HBMz+g6jSIgX9B1BMmnS98tVu/Qmg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 439B9132E7;
        Tue, 19 Apr 2022 06:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ec8gD41dXmJXQAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 19 Apr 2022 06:58:21 +0000
Message-ID: <de61ab3a-a6e9-0209-f06a-dc04d3b14f5d@suse.com>
Date:   Tue, 19 Apr 2022 08:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-5-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151302350.915916@ubuntu-linux-20-04-desktop>
 <84f5264c-6b98-6d56-b7ca-61c19dc502ca@gmail.com>
 <alpine.DEB.2.22.394.2204181156280.915916@ubuntu-linux-20-04-desktop>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [RFC PATCH 4/6] virtio: Various updates to xen-virtio DMA ops
 layer
In-Reply-To: <alpine.DEB.2.22.394.2204181156280.915916@ubuntu-linux-20-04-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zEq0HDPLD0VYb57K7jEjRPEq"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zEq0HDPLD0VYb57K7jEjRPEq
Content-Type: multipart/mixed; boundary="------------oInpg5CSFyyPOeZGwl5wBsnf";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr <olekstysh@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Russell King <linux@armlinux.org.uk>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Julien Grall <julien@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>
Message-ID: <de61ab3a-a6e9-0209-f06a-dc04d3b14f5d@suse.com>
Subject: Re: [RFC PATCH 4/6] virtio: Various updates to xen-virtio DMA ops
 layer
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-5-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151302350.915916@ubuntu-linux-20-04-desktop>
 <84f5264c-6b98-6d56-b7ca-61c19dc502ca@gmail.com>
 <alpine.DEB.2.22.394.2204181156280.915916@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2204181156280.915916@ubuntu-linux-20-04-desktop>

--------------oInpg5CSFyyPOeZGwl5wBsnf
Content-Type: multipart/mixed; boundary="------------C00KGA3BvOs6gJrFK0A8HNCb"

--------------C00KGA3BvOs6gJrFK0A8HNCb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTguMDQuMjIgMjE6MTEsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gU3Vu
LCAxNyBBcHIgMjAyMiwgT2xla3NhbmRyIHdyb3RlOg0KPj4gT24gMTYuMDQuMjIgMDE6MDIs
IFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4+PiBPbiBUaHUsIDE0IEFwciAyMDIyLCBP
bGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90ZToNCj4+Pj4gRnJvbTogT2xla3NhbmRyIFR5c2hj
aGVua28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPg0KPj4+Pg0KPj4+PiBJbiB0
aGUgY29udGV4dCBvZiBjdXJyZW50IHBhdGNoIGRvIHRoZSBmb2xsb3dpbmc6DQo+Pj4+IDEu
IFVwZGF0ZSBjb2RlIHRvIHN1cHBvcnQgdmlydGlvLW1taW8gZGV2aWNlcw0KPj4+PiAyLiBJ
bnRyb2R1Y2Ugc3RydWN0IHhlbl92aXJ0aW9fZGF0YSBhbmQgYWNjb3VudCBwYXNzZWQgdmly
dGlvIGRldmljZXMNCj4+Pj4gICAgICAodXNpbmcgbGlzdCkgYXMgd2UgbmVlZCB0byBzdG9y
ZSBzb21lIHBlci1kZXZpY2UgZGF0YQ0KPj4+PiAzLiBBZGQgbXVsdGktcGFnZSBzdXBwb3J0
IGZvciB4ZW5fdmlydGlvX2RtYV9tYXAodW5tYXApX3BhZ2UgY2FsbGJhY2tzDQo+Pj4+IDQu
IEhhcmRlbiBjb2RlIGFnYWluc3QgbWFsaWNpb3VzIGJhY2tlbmQNCj4+Pj4gNS4gQ2hhbmdl
IHRvIHVzZSBhbGxvY19wYWdlc19leGFjdCgpIGluc3RlYWQgb2YgX19nZXRfZnJlZV9wYWdl
cygpDQo+Pj4+IDYuIEludHJvZHVjZSBsb2NraW5nIHNjaGVtZSB0byBwcm90ZWN0IG1hcHBp
bmdzIChJIGFtIG5vdCAxMDAlIHN1cmUNCj4+Pj4gICAgICB3aGV0aGVyIHBlci1kZXZpY2Ug
bG9jayBpcyByZWFsbHkgbmVlZGVkKQ0KPj4+PiA3LiBIYW5kbGUgdmlydGlvIGRldmljZSdz
IERNQSBtYXNrDQo+Pj4+IDguIFJldHJpZXZlIHRoZSBJRCBvZiBiYWNrZW5kIGRvbWFpbiBm
cm9tIERUIGZvciB2aXJ0aW8tbW1pbyBkZXZpY2UNCj4+Pj4gICAgICBpbnN0ZWFkIG9mIGhh
cmRjb2RpbmcgaXQuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE9sZWtzYW5kciBUeXNo
Y2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+
ICAgIGFyY2gvYXJtL3hlbi9lbmxpZ2h0ZW4uYyB8ICAxMSArKysNCj4+Pj4gICAgZHJpdmVy
cy94ZW4vS2NvbmZpZyAgICAgIHwgICAyICstDQo+Pj4+ICAgIGRyaXZlcnMveGVuL3hlbi12
aXJ0aW8uYyB8IDIwMA0KPj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLQ0KPj4+PiAgICBpbmNsdWRlL3hlbi94ZW4tb3BzLmggICAgfCAgIDUg
KysNCj4+Pj4gICAgNCBmaWxlcyBjaGFuZ2VkLCAxOTYgaW5zZXJ0aW9ucygrKSwgMjIgZGVs
ZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS94ZW4vZW5saWdo
dGVuLmMgYi9hcmNoL2FybS94ZW4vZW5saWdodGVuLmMNCj4+Pj4gaW5kZXggZWM1YjA4Mi4u
ODcwZDkyZiAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC9hcm0veGVuL2VubGlnaHRlbi5jDQo+
Pj4+ICsrKyBiL2FyY2gvYXJtL3hlbi9lbmxpZ2h0ZW4uYw0KPj4+PiBAQCAtNDA5LDYgKzQw
OSwxNyBAQCBpbnQgX19pbml0IGFyY2hfeGVuX3VucG9wdWxhdGVkX2luaXQoc3RydWN0IHJl
c291cmNlDQo+Pj4+ICoqcmVzKQ0KPj4+PiAgICB9DQo+Pj4+ICAgICNlbmRpZg0KPj4+PiAg
ICArI2lmZGVmIENPTkZJR19BUkNIX0hBU19SRVNUUklDVEVEX1ZJUlRJT19NRU1PUllfQUND
RVNTDQo+Pj4+ICtpbnQgYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vz
cyh2b2lkKQ0KPj4+PiArew0KPj4+PiArCWlmIChJU19FTkFCTEVEKENPTkZJR19YRU5fSFZN
X1ZJUlRJT19HUkFOVCkgJiYgeGVuX2h2bV9kb21haW4oKSkNCj4+Pj4gKwkJcmV0dXJuIDE7
DQo+Pj4gSW5zdGVhZCBvZiB4ZW5faHZtX2RvbWFpbigpLCB5b3UgY2FuIGp1c3QgdXNlIHhl
bl9kb21haW4oKS4gQWxzbyB0aGVyZQ0KPj4+IGlzIG5vIG5lZWQgZm9yIHRoZSAjaWZkZWYN
Cj4+PiBDT05GSUdfQVJDSF9IQVNfUkVTVFJJQ1RFRF9WSVJUSU9fTUVNT1JZX0FDQ0VTUywg
Z2l2ZW4gdGhhdDoNCj4+Pg0KPj4+IENPTkZJR19YRU5fSFZNX1ZJUlRJT19HUkFOVCBkZXBl
bmRzIG9uIFhFTl9WSVJUSU8gd2hpY2ggc2VsZWN0cw0KPj4+IEFSQ0hfSEFTX1JFU1RSSUNU
RURfVklSVElPX01FTU9SWV9BQ0NFU1MNCj4+DQo+Pg0KPj4gWWVzLCBidXQgcGxlYXNlIHNl
ZSBteSBjb21tZW50cyBpbiBjb21taXQgIzIgcmVnYXJkaW5nDQo+PiBDT05GSUdfWEVOX0hW
TV9WSVJUSU9fR1JBTlQgb3B0aW9uIGFuZA0KPj4gYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0
aW9fbWVtb3J5X2FjY2VzcygpIG9uIEFybS4NCj4+DQo+PiBJIHByb3Bvc2UgdG8gaGF2ZSB0
aGUgZm9sbG93aW5nIG9uIEFybToNCj4+DQo+PiBpbnQgYXJjaF9oYXNfcmVzdHJpY3RlZF92
aXJ0aW9fbWVtb3J5X2FjY2Vzcyh2b2lkKQ0KPj4gew0KPj4gIMKgwqDCoMKgIHJldHVybiB4
ZW5faGFzX3Jlc3RyaWN0ZWRfdmlydGlvX21lbW9yeV9hY2Nlc3MoKTsNCj4+IH0NCj4+DQo+
Pg0KPj4gd2hlcmUgY29tbW9uIHhlbi5oIGNvbnRhaW4gYSBoZWxwZXIgdG8gYmUgdXNlZCBi
eSBib3RoIEFybSBhbmQgeDg2Og0KPj4NCj4+IHN0YXRpYyBpbmxpbmUgaW50IHhlbl9oYXNf
cmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcyh2b2lkKQ0KPj4gew0KPj4gIMKgwqDC
oMKgIGlmIChJU19FTkFCTEVEKENPTkZJR19YRU5fVklSVElPKSAmJiAoeGVuX3B2X2RvbWFp
bigpIHx8DQo+PiB4ZW5faHZtX2RvbWFpbigpKSkNCj4+ICDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAxOw0KPj4NCj4+ICDCoMKgwqDCoCByZXR1cm4gMDsNCj4+IH0NCj4+DQo+Pg0KPj4g
QnV0IEkgd291bGQgYmUgaGFwcHkgd2l0aCB3aGF0IHlvdSBwcm9wb3NlIGFzIHdlbGwuDQo+
IA0KPiBBcyBJIHdyb3RlIGluIHRoZSBwcmV2aW91cyByZXBseSwgSSBhbHNvIHByZWZlciB0
byBzaGFyZSB0aGUgY29kZQ0KPiBiZXR3ZWVuIHg4NiBhbmQgQVJNLCBhbmQgSSB0aGluayBp
dCBjb3VsZCBsb29rIGxpa2U6DQo+IA0KPiBpbnQgYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0
aW9fbWVtb3J5X2FjY2Vzcyh2b2lkKQ0KPiB7DQo+ICDCoMKgwqDCoCByZXR1cm4geGVuX2hh
c19yZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzKCk7DQo+IH0NCj4gWy4uLl0NCj4g
c3RhdGljIGlubGluZSBpbnQgeGVuX2hhc19yZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNj
ZXNzKHZvaWQpDQo+IHsNCj4gIMKgwqDCoMKgIHJldHVybiAoSVNfRU5BQkxFRChDT05GSUdf
WEVOX1ZJUlRJTykgJiYgeGVuX2RvbWFpbigpKTsNCj4gfQ0KPiANCj4gQnV0IGxldCdzIGNo
ZWNrIHdpdGggSnVlcmdlbiBhbmQgQm9yaXMuDQo+IA0KPiANCj4+Pj4gKwlyZXR1cm4gMDsN
Cj4+Pj4gK30NCj4+Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKGFyY2hfaGFzX3Jlc3RyaWN0ZWRf
dmlydGlvX21lbW9yeV9hY2Nlc3MpOw0KPj4+PiArI2VuZGlmDQo+Pj4+ICsNCj4+Pj4gICAg
c3RhdGljIHZvaWQgX19pbml0IHhlbl9kdF9ndWVzdF9pbml0KHZvaWQpDQo+Pj4+ICAgIHsN
Cj4+Pj4gICAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqeGVuX25vZGU7DQo+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3hlbi9LY29uZmlnIGIvZHJpdmVycy94ZW4vS2NvbmZpZw0KPj4+PiBp
bmRleCBmYzYxZjdhLi41NmFmZTZhIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL3hlbi9L
Y29uZmlnDQo+Pj4+ICsrKyBiL2RyaXZlcnMveGVuL0tjb25maWcNCj4+Pj4gQEAgLTM0Nyw3
ICszNDcsNyBAQCBjb25maWcgWEVOX1ZJUlRJTw0KPj4+PiAgICAgIGNvbmZpZyBYRU5fSFZN
X1ZJUlRJT19HUkFOVA0KPj4+PiAgICAJYm9vbCAiUmVxdWlyZSB2aXJ0aW8gZm9yIGZ1bGx5
IHZpcnR1YWxpemVkIGd1ZXN0cyB0byB1c2UgZ3JhbnQNCj4+Pj4gbWFwcGluZ3MiDQo+Pj4+
IC0JZGVwZW5kcyBvbiBYRU5fVklSVElPICYmIFg4Nl82NA0KPj4+PiArCWRlcGVuZHMgb24g
WEVOX1ZJUlRJTyAmJiAoWDg2XzY0IHx8IEFSTSB8fCBBUk02NCkNCj4+PiB5b3UgY2FuIHJl
bW92ZSB0aGUgYXJjaGl0ZWN0dXJhbCBkZXBlbmRlbmNpZXMNCj4+DQo+Pg0KPj4gQWNjb3Jk
aW5nIHRvIHRoZSBjb252ZXJzYXRpb24gaW4gY29tbWl0ICMyIHdlIGFyZSBjb25zaWRlcmlu
ZyBqdXN0IGEgc2luZ2xlDQo+PiBYRU5fVklSVElPIG9wdGlvbiwgYnV0IGl0IGlzIGdvaW5n
IHRvIGhhcyB0aGUNCj4+IHNhbWUgYXJjaGl0ZWN0dXJhbCBkZXBlbmRlbmNpZXM6IChYODZf
NjQgfHwgQVJNIHx8IEFSTTY0KQ0KPj4NCj4+IEJ5IHJlbW92aW5nIHRoZSBhcmNoaXRlY3R1
cmFsIGRlcGVuZGVuY2llcyBoZXJlLCB3ZSB3aWxsIGxlYXZlIGFsc28gWDg2XzMyDQo+PiBj
b3ZlcmVkIChuZWl0aGVyIFhFTl9IVk1fVklSVElPX0dSQU5UIG5vciBYRU5fUFZfVklSVElP
IGNvdmVyZWQgaXQpLiBJIGRvbid0DQo+PiBrbm93IHdoZXRoZXIgaXQgaXMgb2sgb3Igbm90
Lg0KPj4NCj4+IFNoYWxsIEkgcmVtb3ZlIGRlcGVuZGVuY2llcyBhbnl3YXk/DQo+IA0KPiBO
bywgZ29vZCBwb2ludC4gSSBkb24ndCBrbm93IGFib3V0IFg4Nl8zMi4gVGhpcyBpcyBhbm90
aGVyIGRldGFpbCB3aGVyZQ0KPiBKdWVyZ2VuIG9yIEJvcmlzIHNob3VsZCBjb21tZW50Lg0K
DQpYODZfMzIgc2hvdWxkIGluIHRoZW9yeSB3b3JrIChpdCBpcyBIVk0vUFZIIG9ubHksIGFz
IFBWIDMyLWJpdCBndWVzdHMgYXJlIG5vDQpsb25nZXIgc3VwcG9ydGVkKS4NCg0KDQpKdWVy
Z2VuDQo=
--------------C00KGA3BvOs6gJrFK0A8HNCb
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------C00KGA3BvOs6gJrFK0A8HNCb--

--------------oInpg5CSFyyPOeZGwl5wBsnf--

--------------zEq0HDPLD0VYb57K7jEjRPEq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJeXYwFAwAAAAAACgkQsN6d1ii/Ey/3
4Af8Ct0w/A3LzGDKWGOwBkhlVk2NrF7FtszRGIW+XjZ8CMo1rc70gUBhygLV1+miHavVBqq6AMIs
RQN8fyeRdokoYxkaynj33Rparagz5pFQU5UscTdWRZefS8oo2yU5rTfV3Tr1C2isiYjg/1nWps83
jgv+1pNW/pscABoYu9fmXxD+05ZMrAwgmSS+T+dkT/6m8to0jltJG1EtA8GJrzEjJiq+NPb9/iBU
bRxp4+FZgy7QNpk5znoA6T28dSTdFG/wLaAtFPPzdrP92uH0G8nLUZXa4ekvbbUHLQY1IIk92+dz
vZkOEMetdfeVqlxsBhjJ3Mq9rGewesyrJG83tiQPTw==
=CL7E
-----END PGP SIGNATURE-----

--------------zEq0HDPLD0VYb57K7jEjRPEq--
