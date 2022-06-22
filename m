Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D6A554D75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358736AbiFVOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358668AbiFVOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:35:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A433B3EF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:35:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0027F21BDD;
        Wed, 22 Jun 2022 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655908524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jaxA5F5o0Lr/wQVDpMMYy+3VZ5Suu++PzDieNQ2BEs=;
        b=cx2UOedFGBuKGf/JqbMR/YQdhrS1QkliWi5/wBKwfKiY0M1HSoyfpAhX91B0lU2YXc28vx
        qx2UUJeuxzpYgekWgRdgySTx40EW+jCdDhPWFZ5rLHVfL95zKjvB/mSh4C6Rc8etdbqdC6
        RgLR4+iQOjTgfeSJBacW2SYWdjc9MOw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A81F13A5D;
        Wed, 22 Jun 2022 14:35:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qz7nF6sos2LQWQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 22 Jun 2022 14:35:23 +0000
Message-ID: <0f047970-d9ea-d2fd-3208-db843305e11c@suse.com>
Date:   Wed, 22 Jun 2022 16:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 3/3] xen: don't require virtio with grants for non-PV
 guests
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20220622063838.8854-1-jgross@suse.com>
 <20220622063838.8854-4-jgross@suse.com>
 <a8ce8ad3-aa3b-ea87-34cf-6532a272e9d8@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <a8ce8ad3-aa3b-ea87-34cf-6532a272e9d8@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HpOX0tVZwVFj2LVpY0Mh7dB0"
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
--------------HpOX0tVZwVFj2LVpY0Mh7dB0
Content-Type: multipart/mixed; boundary="------------8bYfcCrngUaPIdjCRUqfu1Ha";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr <olekstysh@gmail.com>, xen-devel@lists.xenproject.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <0f047970-d9ea-d2fd-3208-db843305e11c@suse.com>
Subject: Re: [PATCH v3 3/3] xen: don't require virtio with grants for non-PV
 guests
References: <20220622063838.8854-1-jgross@suse.com>
 <20220622063838.8854-4-jgross@suse.com>
 <a8ce8ad3-aa3b-ea87-34cf-6532a272e9d8@gmail.com>
In-Reply-To: <a8ce8ad3-aa3b-ea87-34cf-6532a272e9d8@gmail.com>

--------------8bYfcCrngUaPIdjCRUqfu1Ha
Content-Type: multipart/mixed; boundary="------------PY7imNEMXQ8rcO310kVlq7S2"

--------------PY7imNEMXQ8rcO310kVlq7S2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDYuMjIgMTE6MDMsIE9sZWtzYW5kciB3cm90ZToNCj4gDQo+IE9uIDIyLjA2LjIy
IDA5OjM4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4gSGVsbG8gSnVlcmdlbg0KPiAN
Cj4+IENvbW1pdCBmYTFmNTc0MjFlMGIgKCJ4ZW4vdmlydGlvOiBFbmFibGUgcmVzdHJpY3Rl
ZCBtZW1vcnkgYWNjZXNzIHVzaW5nDQo+PiBYZW4gZ3JhbnQgbWFwcGluZ3MiKSBpbnRyb2R1
Y2VkIGEgbmV3IHJlcXVpcmVtZW50IGZvciB1c2luZyB2aXJ0aW8NCj4+IGRldmljZXM6IHRo
ZSBiYWNrZW5kIG5vdyBuZWVkcyB0byBzdXBwb3J0IHRoZSBWSVJUSU9fRl9BQ0NFU1NfUExB
VEZPUk0NCj4+IGZlYXR1cmUuDQo+Pg0KPj4gVGhpcyBpcyBhbiB1bmR1ZSByZXF1aXJlbWVu
dCBmb3Igbm9uLVBWIGd1ZXN0cywgYXMgdGhvc2UgY2FuIGJlIG9wZXJhdGVkDQo+PiB3aXRo
IGV4aXN0aW5nIGJhY2tlbmRzIHdpdGhvdXQgYW55IHByb2JsZW0sIGFzIGxvbmcgYXMgdGhv
c2UgYmFja2VuZHMNCj4+IGFyZSBydW5uaW5nIGluIGRvbTAuDQo+Pg0KPj4gUGVyIGRlZmF1
bHQgYWxsb3cgdmlydGlvIGRldmljZXMgd2l0aG91dCBncmFudCBzdXBwb3J0IGZvciBub24t
UFYNCj4+IGd1ZXN0cy4NCj4+DQo+PiBPbiBBcm0gcmVxdWlyZSBWSVJUSU9fRl9BQ0NFU1Nf
UExBVEZPUk0gZm9yIGRldmljZXMgaGF2aW5nIGJlZW4gbGlzdGVkDQo+PiBpbiB0aGUgZGV2
aWNlIHRyZWUgdG8gdXNlIGdyYW50cy4NCj4+DQo+PiBBZGQgYSBuZXcgY29uZmlnIGl0ZW0g
dG8gYWx3YXlzIGZvcmNlIHVzZSBvZiBncmFudHMgZm9yIHZpcnRpby4NCj4+DQo+PiBGaXhl
czogZmExZjU3NDIxZTBiICgieGVuL3ZpcnRpbzogRW5hYmxlIHJlc3RyaWN0ZWQgbWVtb3J5
IGFjY2VzcyB1c2luZyBYZW4gDQo+PiBncmFudCBtYXBwaW5ncyIpDQo+PiBSZXBvcnRlZC1i
eTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gVjI6
DQo+PiAtIHJlbW92ZSBjb21tYW5kIGxpbmUgcGFyYW1ldGVyIChDaHJpc3RvcGggSGVsbHdp
ZykNCj4+IFYzOg0KPj4gLSByZWJhc2UgdG8gY2FsbGJhY2sgbWV0aG9kDQo+IA0KPiANCj4g
UGF0Y2ggbG9va3MgZ29vZCwganVzdCBvbmUgTklUIC4uLg0KPiANCj4gDQo+PiAtLS0NCj4+
IMKgIGFyY2gvYXJtL3hlbi9lbmxpZ2h0ZW4uY8KgwqDCoMKgIHzCoCA0ICsrKy0NCj4+IMKg
IGFyY2gveDg2L3hlbi9lbmxpZ2h0ZW5faHZtLmMgfMKgIDQgKysrLQ0KPj4gwqAgYXJjaC94
ODYveGVuL2VubGlnaHRlbl9wdi5jwqAgfMKgIDUgKysrKy0NCj4+IMKgIGRyaXZlcnMveGVu
L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDkgKysrKysrKysrDQo+PiDCoCBkcml2
ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmPCoCB8IDEwICsrKysrKysrKysNCj4+IMKgIGluY2x1
ZGUveGVuL3hlbi1vcHMuaMKgwqDCoMKgwqDCoMKgIHzCoCA2ICsrKysrKw0KPj4gwqAgaW5j
bHVkZS94ZW4veGVuLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA4IC0tLS0tLS0tDQo+
PiDCoCA3IGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS94ZW4vZW5saWdodGVuLmMgYi9hcmNo
L2FybS94ZW4vZW5saWdodGVuLmMNCj4+IGluZGV4IDFmOWMzYmEzMjgzMy4uOTNjOGNjYmYy
OTgyIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0veGVuL2VubGlnaHRlbi5jDQo+PiArKysg
Yi9hcmNoL2FybS94ZW4vZW5saWdodGVuLmMNCj4+IEBAIC0zNCw2ICszNCw3IEBADQo+PiDC
oCAjaW5jbHVkZSA8bGludXgvdGltZWtlZXBpbmcuaD4NCj4+IMKgICNpbmNsdWRlIDxsaW51
eC90aW1la2VlcGVyX2ludGVybmFsLmg+DQo+PiDCoCAjaW5jbHVkZSA8bGludXgvYWNwaS5o
Pg0KPj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9fYW5jaG9yLmg+DQo+PiDCoCAjaW5jbHVk
ZSA8bGludXgvbW0uaD4NCj4+IEBAIC00NDMsNyArNDQ0LDggQEAgc3RhdGljIGludCBfX2lu
aXQgeGVuX2d1ZXN0X2luaXQodm9pZCkNCj4+IMKgwqDCoMKgwqAgaWYgKCF4ZW5fZG9tYWlu
KCkpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+PiAtwqDCoMKgIHhlbl9z
ZXRfcmVzdHJpY3RlZF92aXJ0aW9fbWVtb3J5X2FjY2VzcygpOw0KPj4gK8KgwqDCoCBpZiAo
SVNfRU5BQkxFRChDT05GSUdfWEVOX1ZJUlRJTykpDQo+PiArwqDCoMKgwqDCoMKgwqAgdmly
dGlvX3NldF9tZW1fYWNjX2NiKHhlbl92aXJ0aW9fbWVtX2FjYyk7DQo+PiDCoMKgwqDCoMKg
IGlmICghYWNwaV9kaXNhYmxlZCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5fYWNwaV9n
dWVzdF9pbml0KCk7DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9o
dm0uYyBiL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5faHZtLmMNCj4+IGluZGV4IDhiNzFiMWRk
NzYzOS4uMjg3NjJmODAwNTk2IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYveGVuL2VubGln
aHRlbl9odm0uYw0KPj4gKysrIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9odm0uYw0KPj4g
QEAgLTQsNiArNCw3IEBADQo+PiDCoCAjaW5jbHVkZSA8bGludXgvY3B1Lmg+DQo+PiDCoCAj
aW5jbHVkZSA8bGludXgva2V4ZWMuaD4NCj4+IMKgICNpbmNsdWRlIDxsaW51eC9tZW1ibG9j
ay5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9fYW5jaG9yLmg+DQo+PiDCoCAjaW5j
bHVkZSA8eGVuL2ZlYXR1cmVzLmg+DQo+PiDCoCAjaW5jbHVkZSA8eGVuL2V2ZW50cy5oPg0K
Pj4gQEAgLTE5NSw3ICsxOTYsOCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgeGVuX2h2bV9ndWVz
dF9pbml0KHZvaWQpDQo+PiDCoMKgwqDCoMKgIGlmICh4ZW5fcHZfZG9tYWluKCkpDQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4gLcKgwqDCoCB4ZW5fc2V0X3Jlc3RyaWN0
ZWRfdmlydGlvX21lbW9yeV9hY2Nlc3MoKTsNCj4+ICvCoMKgwqAgaWYgKElTX0VOQUJMRUQo
Q09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQpKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHZp
cnRpb19zZXRfbWVtX2FjY19jYih2aXJ0aW9fcmVxdWlyZV9yZXN0cmljdGVkX21lbV9hY2Mp
Ow0KPj4gwqDCoMKgwqDCoCBpbml0X2h2bV9wdl9pbmZvKCk7DQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9w
di5jDQo+PiBpbmRleCBlMzI5N2IxNTcwMWMuLjVhYWFlOGE3N2Y1NSAxMDA2NDQNCj4+IC0t
LSBhL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYw0KPj4gKysrIGIvYXJjaC94ODYveGVu
L2VubGlnaHRlbl9wdi5jDQo+PiBAQCAtMzEsNiArMzEsNyBAQA0KPj4gwqAgI2luY2x1ZGUg
PGxpbnV4L2dmcC5oPg0KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L2VkZC5oPg0KPj4gwqAgI2lu
Y2x1ZGUgPGxpbnV4L3JlYm9vdC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9fYW5j
aG9yLmg+DQo+PiDCoCAjaW5jbHVkZSA8eGVuL3hlbi5oPg0KPj4gwqAgI2luY2x1ZGUgPHhl
bi9ldmVudHMuaD4NCj4+IEBAIC0xMDksNyArMTEwLDkgQEAgc3RhdGljIERFRklORV9QRVJf
Q1BVKHN0cnVjdCB0bHNfZGVzY3MsIHNoYWRvd190bHNfZGVzYyk7DQo+PiDCoCBzdGF0aWMg
dm9pZCBfX2luaXQgeGVuX3B2X2luaXRfcGxhdGZvcm0odm9pZCkNCj4+IMKgIHsNCj4+IC3C
oMKgwqAgeGVuX3NldF9yZXN0cmljdGVkX3ZpcnRpb19tZW1vcnlfYWNjZXNzKCk7DQo+PiAr
wqDCoMKgIC8qIFBWIGd1ZXN0cyBjYW4ndCBvcGVyYXRlIHZpcnRpbyBkZXZpY2VzIHdpdGhv
dXQgZ3JhbnRzLiAqLw0KPj4gK8KgwqDCoCBpZiAoSVNfRU5BQkxFRChDT05GSUdfWEVOX1ZJ
UlRJTykpDQo+PiArwqDCoMKgwqDCoMKgwqAgdmlydGlvX3NldF9tZW1fYWNjX2NiKHZpcnRp
b19yZXF1aXJlX3Jlc3RyaWN0ZWRfbWVtX2FjYyk7DQo+PiDCoMKgwqDCoMKgIHBvcHVsYXRl
X2V4dHJhX3B0ZShmaXhfdG9fdmlydChGSVhfUEFSQVZJUlRfQk9PVE1BUCkpOw0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMveGVuL0tjb25maWcgYi9kcml2ZXJzL3hlbi9LY29uZmlnDQo+
PiBpbmRleCBiZmQ1ZjRmNzA2YmMuLmE2NWJkOTIxMjFhNSAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMveGVuL0tjb25maWcNCj4+ICsrKyBiL2RyaXZlcnMveGVuL0tjb25maWcNCj4+IEBA
IC0zNTUsNCArMzU1LDEzIEBAIGNvbmZpZyBYRU5fVklSVElPDQo+PiDCoMKgwqDCoMKgwqDC
oCBJZiBpbiBkb3VidCwgc2F5IG4uDQo+PiArY29uZmlnIFhFTl9WSVJUSU9fRk9SQ0VfR1JB
TlQNCj4+ICvCoMKgwqAgYm9vbCAiUmVxdWlyZSBYZW4gdmlydGlvIHN1cHBvcnQgdG8gdXNl
IGdyYW50cyINCj4+ICvCoMKgwqAgZGVwZW5kcyBvbiBYRU5fVklSVElPDQo+PiArwqDCoMKg
IGhlbHANCj4+ICvCoMKgwqDCoMKgIFJlcXVpcmUgdmlydGlvIGZvciBYZW4gZ3Vlc3RzIHRv
IHVzZSBncmFudCBtYXBwaW5ncy4NCj4+ICvCoMKgwqDCoMKgIFRoaXMgd2lsbCBhdm9pZCB0
aGUgbmVlZCB0byBnaXZlIHRoZSBiYWNrZW5kIHRoZSByaWdodCB0byBtYXAgYWxsDQo+PiAr
wqDCoMKgwqDCoCBvZiB0aGUgZ3Vlc3QgbWVtb3J5LiBUaGlzIHdpbGwgbmVlZCBzdXBwb3J0
IG9uIHRoZSBiYWNrZW5kIHNpZGUNCj4+ICvCoMKgwqDCoMKgIChlLmcuIHFlbXUgb3Iga2Vy
bmVsLCBkZXBlbmRpbmcgb24gdGhlIHZpcnRpbyBkZXZpY2UgdHlwZXMgdXNlZCkuDQo+PiAr
DQo+PiDCoCBlbmRtZW51DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vZ3JhbnQtZG1h
LW9wcy5jIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+PiBpbmRleCBmYzAxNDI0
ODQwMDEuLjg5NzNmYzFlOWNjYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL2dyYW50
LWRtYS1vcHMuYw0KPj4gKysrIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+PiBA
QCAtMTIsNiArMTIsOCBAQA0KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+PiDCoCAj
aW5jbHVkZSA8bGludXgvcGZuLmg+DQo+PiDCoCAjaW5jbHVkZSA8bGludXgveGFycmF5Lmg+
DQo+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19hbmNob3IuaD4NCj4+ICsjaW5jbHVkZSA8
bGludXgvdmlydGlvLmg+DQo+PiDCoCAjaW5jbHVkZSA8eGVuL3hlbi5oPg0KPj4gwqAgI2lu
Y2x1ZGUgPHhlbi94ZW4tb3BzLmg+DQo+PiDCoCAjaW5jbHVkZSA8eGVuL2dyYW50X3RhYmxl
Lmg+DQo+PiBAQCAtMjg3LDYgKzI4OSwxNCBAQCBib29sIHhlbl9pc19ncmFudF9kbWFfZGV2
aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIGhhc19pb21t
dTsNCj4+IMKgIH0NCj4+ICtib29sIHhlbl92aXJ0aW9fbWVtX2FjYyhzdHJ1Y3QgdmlydGlv
X2RldmljZSAqZGV2KQ0KPj4gK3sNCj4+ICvCoMKgwqAgaWYgKElTX0VOQUJMRUQoQ09ORklH
X1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQpKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiB0
cnVlOw0KPj4gKw0KPj4gK8KgwqDCoCByZXR1cm4geGVuX2lzX2dyYW50X2RtYV9kZXZpY2Uo
ZGV2LT5kZXYucGFyZW50KTsNCj4+ICt9DQo+IA0KPiANCj4gIMKgwqAgLi4uIEkgYW0gdGhp
bmtpbmcgd291bGQgaXQgYmUgYmV0dGVyIHRvIG1vdmUgdGhpcyB0byB4ZW4veGVuLW9wcy5o
IGFzIA0KPiBncmFudC1kbWEtb3BzLmMgaXMgZ2VuZXJpYyAobm90IG9ubHkgZm9yIHZpcnRp
bywgYWx0aG91Z2ggdGhlIHZpcnRpbyBpcyB0aGUgDQo+IGZpcnN0IHVzZS1jYXNlKQ0KDQpJ
IGRpc2xpa2UgdXNpbmcgYSBmdW5jdGlvbiBtYXJrZWQgYXMgaW5saW5lIGluIGEgZnVuY3Rp
b24gdmVjdG9yLg0KDQpXZSBjb3VsZCBhZGQgYW5vdGhlciBtb2R1bGUgInhlbi12aXJ0aW8i
IGZvciB0aGlzIHB1cnBvc2UsIGJ1dCB0aGlzIHNlZW1zDQp0byBiZSBvdmVya2lsbC4NCg0K
SSB0aGluayB3ZSBzaG91bGQganVzdCBsZWF2ZSBpdCBoZXJlIGFuZCBtb3ZlIGl0IGxhdGVy
IGluIGNhc2UgbW9yZSByZWFsDQp2aXJ0aW8gZGVwZW5kZW50IHN0dWZmIGlzIGJlaW5nIGFk
ZGVkLg0KDQoNCkp1ZXJnZW4NCg==
--------------PY7imNEMXQ8rcO310kVlq7S2
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------PY7imNEMXQ8rcO310kVlq7S2--

--------------8bYfcCrngUaPIdjCRUqfu1Ha--

--------------HpOX0tVZwVFj2LVpY0Mh7dB0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKzKKoFAwAAAAAACgkQsN6d1ii/Ey/E
NQf+KgQnJgl8+Rf3bpQZznWiqs8nBgnovMYNS8FRot7UII4dT9i7aCL+WJtlIcoQ54pugoxWf1G/
/N0iXjvHnhkP6zOf9zEjPmypDet8v5Gkwzj3k7utn2oPmV8ubgB0g6hVpyb0z4f2mNLzsUNBjWr6
Qc7i9bHDVxIbXtQ9pgfAvg1X4gZT4J1rW7w6rkEbRhMDn+aUZVaX/XcLVJZOwOjcta0Os21a1nBE
QevEDFQeUNt2iK5lWIt7fBZsoIFHKThFeOiSn4lVsYRDBvvqCwlRHP1qFHyolXtKQJCFP9QZSyO4
nuOn19LPKZaC/9vz8CLTZruaRKqooeFjiRYyVxC5cg==
=ABxh
-----END PGP SIGNATURE-----

--------------HpOX0tVZwVFj2LVpY0Mh7dB0--
