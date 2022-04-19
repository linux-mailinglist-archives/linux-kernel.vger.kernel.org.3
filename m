Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FCB506457
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiDSGYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiDSGYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:24:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217121253
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:21:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB7AB2112B;
        Tue, 19 Apr 2022 06:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650349289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wjvi2tJLsjMs6b52f8hYveh80VH8vOHaWkhrnEa4Lak=;
        b=FqA7IfISPnLcJsDkmG9lF4PObt/2kujk5AcdjvKzYGqSngL0r/HhRKJT6SEs4cQpTEYEy+
        pfGYZkVCmxn8JWQgoTgUoSK78P4hB3B4gdjpN+hmRl1UZ6eul6lINBX2Jj9f0UtG2dREex
        dMAjOt8tmQ5jZf5GbiuTGQRKb7096FU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54966139BE;
        Tue, 19 Apr 2022 06:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ve84E+lUXmJJMwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 19 Apr 2022 06:21:29 +0000
Message-ID: <ef637f17-0e9c-2f86-218b-918297cb9930@suse.com>
Date:   Tue, 19 Apr 2022 08:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 2/6] virtio: add option to restrict memory access
 under Xen
Content-Language: en-US
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-3-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151235440.915916@ubuntu-linux-20-04-desktop>
 <8a66ad42-a3e7-c29d-7d4e-35766dcccd15@gmail.com>
 <alpine.DEB.2.22.394.2204181151030.915916@ubuntu-linux-20-04-desktop>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <alpine.DEB.2.22.394.2204181151030.915916@ubuntu-linux-20-04-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ispkVl45x6FrSWcrxAB1CcR0"
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
--------------ispkVl45x6FrSWcrxAB1CcR0
Content-Type: multipart/mixed; boundary="------------MFzWi6q0y0Ygy4pZ20Jx5X4F";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr <olekstysh@gmail.com>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 linux-arm-kernel@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <ef637f17-0e9c-2f86-218b-918297cb9930@suse.com>
Subject: Re: [RFC PATCH 2/6] virtio: add option to restrict memory access
 under Xen
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-3-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151235440.915916@ubuntu-linux-20-04-desktop>
 <8a66ad42-a3e7-c29d-7d4e-35766dcccd15@gmail.com>
 <alpine.DEB.2.22.394.2204181151030.915916@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2204181151030.915916@ubuntu-linux-20-04-desktop>

--------------MFzWi6q0y0Ygy4pZ20Jx5X4F
Content-Type: multipart/mixed; boundary="------------9hgp6EPShCnsxphgBLzhQbzX"

--------------9hgp6EPShCnsxphgBLzhQbzX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTguMDQuMjIgMjE6MTEsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gU3Vu
LCAxNyBBcHIgMjAyMiwgT2xla3NhbmRyIHdyb3RlOg0KPj4gT24gMTYuMDQuMjIgMDE6MDEs
IFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4+PiBPbiBUaHUsIDE0IEFwciAyMDIyLCBP
bGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90ZToNCj4+Pj4gRnJvbTogSnVlcmdlbiBHcm9zcyA8
amdyb3NzQHN1c2UuY29tPg0KPj4+Pg0KPj4+PiBJbiBvcmRlciB0byBzdXBwb3J0IHZpcnRp
byBpbiBYZW4gZ3Vlc3RzIGFkZCBhIGNvbmZpZyBvcHRpb24gZW5hYmxpbmcNCj4+Pj4gdGhl
IHVzZXIgdG8gc3BlY2lmeSB3aGV0aGVyIGluIGFsbCBYZW4gZ3Vlc3RzIHZpcnRpbyBzaG91
bGQgYmUgYWJsZSB0bw0KPj4+PiBhY2Nlc3MgbWVtb3J5IHZpYSBYZW4gZ3JhbnQgbWFwcGlu
Z3Mgb25seSBvbiB0aGUgaG9zdCBzaWRlLg0KPj4+Pg0KPj4+PiBUaGlzIGFwcGxpZXMgdG8g
ZnVsbHkgdmlydHVhbGl6ZWQgZ3Vlc3RzIG9ubHksIGFzIGZvciBwYXJhdmlydHVhbGl6ZWQN
Cj4+Pj4gZ3Vlc3RzIHRoaXMgaXMgbWFuZGF0b3J5Lg0KPj4+Pg0KPj4+PiBUaGlzIHJlcXVp
cmVzIHRvIHN3aXRjaCBhcmNoX2hhc19yZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNz
KCkNCj4+Pj4gZnJvbSBhIHB1cmUgc3R1YiB0byBhIHJlYWwgZnVuY3Rpb24gb24geDg2IHN5
c3RlbXMgKEFybSBzeXN0ZW1zIGFyZQ0KPj4+PiBub3QgY292ZXJlZCBieSBub3cpLg0KPj4+
Pg0KPj4+PiBBZGQgdGhlIG5lZWRlZCBmdW5jdGlvbmFsaXR5IGJ5IHByb3ZpZGluZyBhIHNw
ZWNpYWwgc2V0IG9mIERNQSBvcHMNCj4+Pj4gaGFuZGxpbmcgdGhlIG5lZWRlZCBncmFudCBv
cGVyYXRpb25zIGZvciB0aGUgSS9PIHBhZ2VzLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBh
cmNoL3g4Ni9tbS9pbml0LmMgICAgICAgIHwgIDE1ICsrKysNCj4+Pj4gICAgYXJjaC94ODYv
bW0vbWVtX2VuY3J5cHQuYyB8ICAgNSAtLQ0KPj4+PiAgICBhcmNoL3g4Ni94ZW4vS2NvbmZp
ZyAgICAgIHwgICA5ICsrKw0KPj4+PiAgICBkcml2ZXJzL3hlbi9LY29uZmlnICAgICAgIHwg
IDIwICsrKysrKw0KPj4+PiAgICBkcml2ZXJzL3hlbi9NYWtlZmlsZSAgICAgIHwgICAxICsN
Cj4+Pj4gICAgZHJpdmVycy94ZW4veGVuLXZpcnRpby5jICB8IDE3Nw0KPj4+PiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIGluY2x1
ZGUveGVuL3hlbi1vcHMuaCAgICAgfCAgIDggKysrDQo+Pj4+ICAgIDcgZmlsZXMgY2hhbmdl
ZCwgMjMwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pj4+ICAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3hlbi94ZW4tdmlydGlvLmMNCj4+Pj4NCj4+Pj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L21tL2luaXQuYyBiL2FyY2gveDg2L21tL2luaXQuYw0KPj4+PiBp
bmRleCBkOGNmY2UyLi41MjZhM2IyIDEwMDY0NA0KPj4+PiAtLS0gYS9hcmNoL3g4Ni9tbS9p
bml0LmMNCj4+Pj4gKysrIGIvYXJjaC94ODYvbW0vaW5pdC5jDQo+Pj4+IEBAIC04LDYgKzgs
OCBAQA0KPj4+PiAgICAjaW5jbHVkZSA8bGludXgva21lbWxlYWsuaD4NCj4+Pj4gICAgI2lu
Y2x1ZGUgPGxpbnV4L3NjaGVkL3Rhc2suaD4NCj4+Pj4gICAgKyNpbmNsdWRlIDx4ZW4veGVu
Lmg+DQo+Pj4+ICsNCj4+Pj4gICAgI2luY2x1ZGUgPGFzbS9zZXRfbWVtb3J5Lmg+DQo+Pj4+
ICAgICNpbmNsdWRlIDxhc20vZTgyMC9hcGkuaD4NCj4+Pj4gICAgI2luY2x1ZGUgPGFzbS9p
bml0Lmg+DQo+Pj4+IEBAIC0xMDY1LDMgKzEwNjcsMTYgQEAgdW5zaWduZWQgbG9uZyBtYXhf
c3dhcGZpbGVfc2l6ZSh2b2lkKQ0KPj4+PiAgICAJcmV0dXJuIHBhZ2VzOw0KPj4+PiAgICB9
DQo+Pj4+ICAgICNlbmRpZg0KPj4+PiArDQo+Pj4+ICsjaWZkZWYgQ09ORklHX0FSQ0hfSEFT
X1JFU1RSSUNURURfVklSVElPX01FTU9SWV9BQ0NFU1MNCj4+Pj4gK2ludCBhcmNoX2hhc19y
ZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzKHZvaWQpDQo+Pj4+ICt7DQo+Pj4+ICsJ
aWYgKElTX0VOQUJMRUQoQ09ORklHX1hFTl9QVl9WSVJUSU8pICYmIHhlbl9wdl9kb21haW4o
KSkNCj4+Pj4gKwkJcmV0dXJuIDE7DQo+Pj4+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1hF
Tl9IVk1fVklSVElPX0dSQU5UKSAmJiB4ZW5faHZtX2RvbWFpbigpKQ0KPj4+PiArCQlyZXR1
cm4gMTsNCj4+PiBJIHRoaW5rIHRoZXNlIHR3byBjaGVja3MgY291bGQgYmUgbW92ZWQgdG8g
YSBzZXBhcmF0ZSBmdW5jdGlvbiBpbiBhIFhlbg0KPj4+IGhlYWRlciwgZS5nLiB4ZW5fcmVz
dHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2VzcywgYW5kIGhlcmUgeW91IGNvdWxkDQo+Pj4g
anVzdA0KPj4+DQo+Pj4gaWYgKHhlbl9yZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNz
KCkpDQo+Pj4gICAgICAgcmV0dXJuIDE7DQo+Pg0KPj4gQWdyZWUsIHdpbGwgZG8NCj4+DQo+
Pg0KPj4+DQo+Pj4NCj4+Pg0KPj4+PiArCXJldHVybiBjY19wbGF0Zm9ybV9oYXMoQ0NfQVRU
Ul9HVUVTVF9NRU1fRU5DUllQVCk7DQo+Pj4+ICt9DQo+Pj4+ICtFWFBPUlRfU1lNQk9MX0dQ
TChhcmNoX2hhc19yZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzKTsNCj4+Pj4gKyNl
bmRpZg0KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHQuYyBiL2Fy
Y2gveDg2L21tL21lbV9lbmNyeXB0LmMNCj4+Pj4gaW5kZXggNTBkMjA5OS4uZGRhMDIwZiAx
MDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHQuYw0KPj4+PiArKysg
Yi9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jDQo+Pj4+IEBAIC03Nyw4ICs3NywzIEBAIHZv
aWQgX19pbml0IG1lbV9lbmNyeXB0X2luaXQodm9pZCkNCj4+Pj4gICAgCXByaW50X21lbV9l
bmNyeXB0X2ZlYXR1cmVfaW5mbygpOw0KPj4+PiAgICB9DQo+Pj4+ICAgIC1pbnQgYXJjaF9o
YXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcyh2b2lkKQ0KPj4+PiAtew0KPj4+
PiAtCXJldHVybiBjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9HVUVTVF9NRU1fRU5DUllQVCk7
DQo+Pj4+IC19DQo+Pj4+IC1FWFBPUlRfU1lNQk9MX0dQTChhcmNoX2hhc19yZXN0cmljdGVk
X3ZpcnRpb19tZW1vcnlfYWNjZXNzKTsNCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hl
bi9LY29uZmlnIGIvYXJjaC94ODYveGVuL0tjb25maWcNCj4+Pj4gaW5kZXggODUyNDZkZC4u
ZGZmZGZmZCAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC94ODYveGVuL0tjb25maWcNCj4+Pj4g
KysrIGIvYXJjaC94ODYveGVuL0tjb25maWcNCj4+Pj4gQEAgLTkyLDMgKzkyLDEyIEBAIGNv
bmZpZyBYRU5fRE9NMA0KPj4+PiAgICAJc2VsZWN0IFg4Nl9YMkFQSUMgaWYgWEVOX1BWSCAm
JiBYODZfNjQNCj4+Pj4gICAgCWhlbHANCj4+Pj4gICAgCSAgU3VwcG9ydCBydW5uaW5nIGFz
IGEgWGVuIERvbTAgZ3Vlc3QuDQo+Pj4+ICsNCj4+Pj4gK2NvbmZpZyBYRU5fUFZfVklSVElP
DQo+Pj4+ICsJYm9vbCAiWGVuIHZpcnRpbyBzdXBwb3J0IGZvciBQViBndWVzdHMiDQo+Pj4+
ICsJZGVwZW5kcyBvbiBYRU5fVklSVElPICYmIFhFTl9QVg0KPj4+PiArCWRlZmF1bHQgeQ0K
Pj4+PiArCWhlbHANCj4+Pj4gKwkgIFN1cHBvcnQgdmlydGlvIGZvciBydW5uaW5nIGFzIGEg
cGFyYXZpcnR1YWxpemVkIGd1ZXN0LiBUaGlzIHdpbGwNCj4+Pj4gKwkgIG5lZWQgc3VwcG9y
dCBvbiB0aGUgYmFja2VuZCBzaWRlIChxZW11IG9yIGtlcm5lbCwgZGVwZW5kaW5nIG9uIHRo
ZQ0KPj4+PiArCSAgdmlydGlvIGRldmljZSB0eXBlcyB1c2VkKS4NCj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMveGVuL0tjb25maWcgYi9kcml2ZXJzL3hlbi9LY29uZmlnDQo+Pj4+IGlu
ZGV4IDEyMGQzMmYuLmZjNjFmN2EgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMveGVuL0tj
b25maWcNCj4+Pj4gKysrIGIvZHJpdmVycy94ZW4vS2NvbmZpZw0KPj4+PiBAQCAtMzM1LDQg
KzMzNSwyNCBAQCBjb25maWcgWEVOX1VOUE9QVUxBVEVEX0FMTE9DDQo+Pj4+ICAgIAkgIGhh
dmluZyB0byBiYWxsb29uIG91dCBSQU0gcmVnaW9ucyBpbiBvcmRlciB0byBvYnRhaW4gcGh5
c2ljYWwgbWVtb3J5DQo+Pj4+ICAgIAkgIHNwYWNlIHRvIGNyZWF0ZSBzdWNoIG1hcHBpbmdz
Lg0KPj4+PiAgICArY29uZmlnIFhFTl9WSVJUSU8NCj4+Pj4gKwlib29sICJYZW4gdmlydGlv
IHN1cHBvcnQiDQo+Pj4+ICsJZGVmYXVsdCBuDQo+Pj4+ICsJZGVwZW5kcyBvbiBWSVJUSU8g
JiYgRE1BX09QUw0KPj4+PiArCXNlbGVjdCBBUkNIX0hBU19SRVNUUklDVEVEX1ZJUlRJT19N
RU1PUllfQUNDRVNTDQo+Pj4+ICsJaGVscA0KPj4+PiArCSAgRW5hYmxlIHZpcnRpbyBzdXBw
b3J0IGZvciBydW5uaW5nIGFzIFhlbiBndWVzdC4gRGVwZW5kaW5nIG9uIHRoZQ0KPj4+PiAr
CSAgZ3Vlc3QgdHlwZSB0aGlzIHdpbGwgcmVxdWlyZSBzcGVjaWFsIHN1cHBvcnQgb24gdGhl
IGJhY2tlbmQgc2lkZQ0KPj4+PiArCSAgKHFlbXUgb3Iga2VybmVsLCBkZXBlbmRpbmcgb24g
dGhlIHZpcnRpbyBkZXZpY2UgdHlwZXMgdXNlZCkuDQo+Pj4+ICsNCj4+Pj4gK2NvbmZpZyBY
RU5fSFZNX1ZJUlRJT19HUkFOVA0KPj4+PiArCWJvb2wgIlJlcXVpcmUgdmlydGlvIGZvciBm
dWxseSB2aXJ0dWFsaXplZCBndWVzdHMgdG8gdXNlIGdyYW50DQo+Pj4+IG1hcHBpbmdzIg0K
Pj4+PiArCWRlcGVuZHMgb24gWEVOX1ZJUlRJTyAmJiBYODZfNjQNCj4+Pj4gKwlkZWZhdWx0
IHkNCj4+Pj4gKwloZWxwDQo+Pj4+ICsJICBSZXF1aXJlIHZpcnRpbyBmb3IgZnVsbHkgdmly
dHVhbGl6ZWQgZ3Vlc3RzIHRvIHVzZSBncmFudCBtYXBwaW5ncy4NCj4+Pj4gKwkgIFRoaXMg
d2lsbCBhdm9pZCB0aGUgbmVlZCB0byBnaXZlIHRoZSBiYWNrZW5kIHRoZSByaWdodCB0byBt
YXAgYWxsDQo+Pj4+ICsJICBvZiB0aGUgZ3Vlc3QgbWVtb3J5LiBUaGlzIHdpbGwgbmVlZCBz
dXBwb3J0IG9uIHRoZSBiYWNrZW5kIHNpZGUNCj4+Pj4gKwkgIChxZW11IG9yIGtlcm5lbCwg
ZGVwZW5kaW5nIG9uIHRoZSB2aXJ0aW8gZGV2aWNlIHR5cGVzIHVzZWQpLg0KPj4+IEkgZG9u
J3QgdGhpbmsgd2UgbmVlZCAzIHZpc2libGUga2NvbmZpZyBvcHRpb25zIGZvciB0aGlzLg0K
Pj4+DQo+Pj4gSW4gZmFjdCwgSSB3b3VsZCBvbmx5IGFkZCBvbmU6IFhFTl9WSVJUSU8uIFdl
IGNhbiBoYXZlIGFueSBYODYgKG9yIEFSTSkNCj4+PiBzcGVjaWZpYyBkZXBlbmRlbmNpZXMg
aW4gdGhlICJkZXBlbmRzIiBsaW5lIHVuZGVyIFhFTl9WSVJUSU8uIEFuZCBJDQo+Pj4gZG9u
J3QgdGhpbmsgd2UgbmVlZCBYRU5fSFZNX1ZJUlRJT19HUkFOVCBhcyBhIGtjb25maWcgb3B0
aW9uDQo+Pj4gbmVjZXNzYXJlbHkuIEl0IGRvZXNuJ3Qgc2VlbSBsaWtlIHNvbWUgd2Ugd2Fu
dCBhcyBidWlsZCB0aW1lIG9wdGlvbi4gQXQNCj4+PiBtb3N0LCBpdCBjb3VsZCBiZSBhIHJ1
bnRpbWUgb3B0aW9uIChsaWtlIGEgY29tbWFuZCBsaW5lKSBvciBhIGRlYnVnDQo+Pj4gb3B0
aW9uIChsaWtlIGFuICNkZWZpbmUgYXQgdGhlIHRvcCBvZiB0aGUgc291cmNlIGZpbGUuKQ0K
Pj4NCj4+DQo+PiBJIGRvbid0IGtub3cgd2hhdCB3YXMgdGhlIGluaXRpYWwgaWRlYSBvZiBo
YXZpbmcgYW5kIGV4dHJhIFhFTl9IVk1fVklSVElPIGFuZA0KPj4gWEVOX1BWX1ZJUlRJTyBv
cHRpb25zLCBidXQgdGFraW5nIGludG8gdGhlIGFjY291bnQgdGhhdA0KPj4gdGhleSBhcmUg
b25seSB1c2VkIGluIGFyY2hfaGFzX3Jlc3RyaWN0ZWRfdmlydGlvX21lbW9yeV9hY2Nlc3Mo
KSBjdXJyZW50bHksIEkNCj4+IHNoYXJlIHlvdXIgb3BpbmlvbiByZWdhcmRpbmcgYSBzaW5n
bGUgWEVOX1ZJUlRJTyBvcHRpb24uDQo+Pg0KPj4gTG9va2luZyBhaGVhZCAoaW5jbHVkaW5n
IGNoYW5nZXMgaW4gdGhlIGNvbW1pdCAjNCksIHdlIGNhbiBpbWFnaW5lIHRoZQ0KPj4gcmVz
dWx0aW5nIG9wdGlvbjoNCj4+DQo+PiBjb25maWcgWEVOX1ZJUlRJTw0KPj4gIMKgwqDCoCBi
b29sICJYZW4gdmlydGlvIHN1cHBvcnQiDQo+PiAgwqDCoMKgIGRlZmF1bHQgbg0KPj4gIMKg
wqDCoCBkZXBlbmRzIG9uIFZJUlRJTyAmJiBETUFfT1BTDQo+PiAgwqDCoMKgIGRlcGVuZHMg
b24gKFg4Nl82NCB8fCBBUk0gfHwgQVJNNjQpDQo+PiAgwqDCoMKgIHNlbGVjdCBBUkNIX0hB
U19SRVNUUklDVEVEX1ZJUlRJT19NRU1PUllfQUNDRVNTDQo+PiAgwqDCoMKgIGhlbHANCj4+
ICDCoMKgwqAgwqAgRW5hYmxlIHZpcnRpbyBzdXBwb3J0IGZvciBydW5uaW5nIGFzIFhlbiBn
dWVzdC4gRGVwZW5kaW5nIG9uIHRoZQ0KPj4gIMKgwqDCoCDCoCBndWVzdCB0eXBlIHRoaXMg
d2lsbCByZXF1aXJlIHNwZWNpYWwgc3VwcG9ydCBvbiB0aGUgYmFja2VuZCBzaWRlDQo+PiAg
wqDCoMKgIMKgIChxZW11IG9yIGtlcm5lbCwgZGVwZW5kaW5nIG9uIHRoZSB2aXJ0aW8gZGV2
aWNlIHR5cGVzIHVzZWQpLg0KPj4NCj4+DQo+PiBhbmQgdGhlbiBhcmNoX2hhc19yZXN0cmlj
dGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzKCkgcGVyIGFyY2g6DQo+Pg0KPj4NCj4+IDEuIHg4
NjoNCj4+DQo+PiBpbnQgYXJjaF9oYXNfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vz
cyh2b2lkKQ0KPj4gew0KPj4gIMKgwqDCoCByZXR1cm4gKHhlbl9oYXNfcmVzdHJpY3RlZF92
aXJ0aW9fbWVtb3J5X2FjY2VzcygpIHx8DQo+PiAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgY2Nf
cGxhdGZvcm1faGFzKENDX0FUVFJfR1VFU1RfTUVNX0VOQ1JZUFQpKTsNCj4+IH0NCj4+DQo+
Pg0KPj4gMi4gQXJtOg0KPj4NCj4+IGludCBhcmNoX2hhc19yZXN0cmljdGVkX3ZpcnRpb19t
ZW1vcnlfYWNjZXNzKHZvaWQpDQo+PiB7DQo+PiAgwqDCoMKgIHJldHVybiB4ZW5faGFzX3Jl
c3RyaWN0ZWRfdmlydGlvX21lbW9yeV9hY2Nlc3MoKTsNCj4+IH0NCj4+DQo+Pg0KPj4gMy4g
eGVuLmg6DQo+Pg0KPj4gc3RhdGljIGlubGluZSBpbnQgeGVuX2hhc19yZXN0cmljdGVkX3Zp
cnRpb19tZW1vcnlfYWNjZXNzKHZvaWQpDQo+PiB7DQo+PiAgwqDCoMKgIGlmIChJU19FTkFC
TEVEKENPTkZJR19YRU5fVklSVElPKSAmJiAoeGVuX3B2X2RvbWFpbigpIHx8DQo+PiB4ZW5f
aHZtX2RvbWFpbigpKSkNCj4+ICDCoMKgwqAgwqDCoMKgIHJldHVybiAxOw0KPj4NCj4+ICDC
oMKgwqAgcmV0dXJuIDA7DQo+PiB9DQo+Pg0KPj4NCj4+IEFjdHVhbGx5LCBhcyBkb21haW4g
dHlwZSBvbiBBcm0gaXMgYWx3YXlzIFhFTl9IVk1fRE9NQUlOLCB3ZSBjb3VsZCBwcm9iYWJs
eQ0KPj4gaGF2ZSB0aGUgZm9sbG93aW5nIG9uIEFybToNCj4+DQo+PiBpbnQgYXJjaF9oYXNf
cmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2Vzcyh2b2lkKQ0KPj4gew0KPj4gIMKgwqDC
oCByZXR1cm4gSVNfRU5BQkxFRChDT05GSUdfWEVOX1ZJUlRJTyk7DQo+PiB9DQo+Pg0KPj4g
YnV0IEkgd291bGQgcHJlZmVyIG5vdCB0byBkaXZlcmdlIGFuZCB1c2UgY29tbW9uDQo+PiB4
ZW5faGFzX3Jlc3RyaWN0ZWRfdmlydGlvX21lbW9yeV9hY2Nlc3MoKS4NCj4+DQo+PiBBbnkg
dGhvdWdodHM/DQo+IA0KPiBZZXMsIEkgd291bGQgYWxzbyBwcmVmZXIgbm90IHRvIGRpdmVy
Z2UgYmV0d2VlbiB0aGUgeDg2IGFuZCBhcm0gdmVyc2lvbnMNCj4gb2YgeGVuX2hhc19yZXN0
cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzLiBCdXQgd2hhdCBjYXNlIGFyZSB3ZSB0cnlp
bmcNCj4gdG8gY2F0Y2ggd2l0aCAoeGVuX3B2X2RvbWFpbigpIHx8IHhlbl9odm1fZG9tYWlu
KCkpID8gRXZlbiBvbiB4ODYsIGl0IGlzDQo+IG5vdCBnb2luZyB0byBsZWF2ZSBtdWNoIG91
dC4gSXMgaXQgcmVhbGx5IG1lYW50IG9ubHkgdG8gZXhjbHVkZSBwdmgNCj4gZG9tYWlucz8N
Cg0KSXQgd291bGRuJ3QgZXhjbHVkZSBwdmggZG9tYWlucy4NCg0KPiANCj4gSSBoYXZlIHRo
ZSBmZWVsaW5nIHRoYXQgd2UgY291bGQgdHVybiB0aGlzIGNoZWNrIGludG86DQo+IA0KPiBz
dGF0aWMgaW5saW5lIGludCB4ZW5faGFzX3Jlc3RyaWN0ZWRfdmlydGlvX21lbW9yeV9hY2Nl
c3Modm9pZCkNCj4gew0KPiAgICAgIHJldHVybiBJU19FTkFCTEVEKENPTkZJR19YRU5fVklS
VElPKSAmJiB4ZW5fZG9tYWluKCk7DQo+IH0NCj4gDQo+IGV2ZW4gb24geDg2LCBidXQgb25l
IG9mIHRoZSB4ZW4veDg2IG1haW50YWluZXJzIHNob3VsZCBjb25maXJtLg0KDQpJIGRvIGNv
bmZpcm0gdGhpcyBpcyBiZXR0ZXIgYW5kIGZ1bmN0aW9uYWxseSBlcXVpdmFsZW50Lg0KDQoN
Ckp1ZXJnZW4NCg==
--------------9hgp6EPShCnsxphgBLzhQbzX
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------9hgp6EPShCnsxphgBLzhQbzX--

--------------MFzWi6q0y0Ygy4pZ20Jx5X4F--

--------------ispkVl45x6FrSWcrxAB1CcR0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJeVOgFAwAAAAAACgkQsN6d1ii/Ey+i
wwf+PZN/+STHtk1BQfOx18wax94IJ9kZXW3mihzciSJ4NiH9b9ViCZjwBh62HG4WdNpCKy09JIRO
6oA87NyizTGiHfZceUwgRdXfB+PwOSSFitEwGULiVwRhccTjn1qrVtBMEJOfBBZA3FssiIjaoobp
7rpC9Nun0KskK1xLJtrbneX3u+ylalrZSiwDLiJd8hCpWhkt2He+SYkRNe3udVDwlEZfwi/iCfvf
XcQJXopNmUFaCo369IAXVRY1xy5KDt/ofvBqiS3Ojzv0GUZ53HbNtDvcSKMXMgIA+dooqbK+YLai
OMoNczJKrEGPdqkbrqoSvyzCli21gy3r5j8F/iOagw==
=L0/z
-----END PGP SIGNATURE-----

--------------ispkVl45x6FrSWcrxAB1CcR0--
