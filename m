Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E62A577A45
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiGRFLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiGRFLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:11:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD86EE39
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:11:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72ACC3721F;
        Mon, 18 Jul 2022 05:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658121069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ymGqN9FnsnTYATv8HeZcPZL9ZyuBB/Rpw0Vkj/2C7iw=;
        b=fpB1fRfKLfvy4PH71ohfv86aOC0R+qQXPDK6K4/A2bWVLf914rZtfj/qARwy09vY3TZRTu
        GAeiqFxAVqaTD7RHLbBTPUGbHDaOhlz5SWy9PZ5iT0y14KGE+D17H+TG/cFw6nWQoOzOzP
        BOLlFT4GM0XKnumR2taZbuIBCmsfOJU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F30D013A83;
        Mon, 18 Jul 2022 05:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LTHbOWzr1GJkRAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 18 Jul 2022 05:11:08 +0000
Message-ID: <70b03d06-6ab9-1693-f811-f784a7dced76@suse.com>
Date:   Mon, 18 Jul 2022 07:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [patch 02/38] x86/cpu: Use native_wrmsrl() in
 load_percpu_segment()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20220716230344.239749011@linutronix.de>
 <20220716230952.787452088@linutronix.de>
 <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com> <87zgh7wo91.ffs@tglx>
 <87tu7fwlhr.ffs@tglx> <87r12jwl9l.ffs@tglx> <87o7xnwgl3.ffs@tglx>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <87o7xnwgl3.ffs@tglx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wj30QoyS010CkM8fvBPLwRRu"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wj30QoyS010CkM8fvBPLwRRu
Content-Type: multipart/mixed; boundary="------------S7VwZ9SI3wA5Lsq1sbiuSHfw";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>,
 Andrew Cooper <Andrew.Cooper3@citrix.com>,
 LKML <linux-kernel@vger.kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Johannes Wikner <kwikner@ethz.ch>,
 Alyssa Milburn <alyssa.milburn@linux.intel.com>, Jann Horn
 <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
 Joao Moreira <joao.moreira@intel.com>,
 Joseph Nuzman <joseph.nuzman@intel.com>, Steven Rostedt <rostedt@goodmis.org>
Message-ID: <70b03d06-6ab9-1693-f811-f784a7dced76@suse.com>
Subject: Re: [patch 02/38] x86/cpu: Use native_wrmsrl() in
 load_percpu_segment()
References: <20220716230344.239749011@linutronix.de>
 <20220716230952.787452088@linutronix.de>
 <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com> <87zgh7wo91.ffs@tglx>
 <87tu7fwlhr.ffs@tglx> <87r12jwl9l.ffs@tglx> <87o7xnwgl3.ffs@tglx>
In-Reply-To: <87o7xnwgl3.ffs@tglx>

--------------S7VwZ9SI3wA5Lsq1sbiuSHfw
Content-Type: multipart/mixed; boundary="------------wB4kj3uwKYTsTjryxSKo0rza"

--------------wB4kj3uwKYTsTjryxSKo0rza
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDcuMjIgMjM6NTQsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gU3VuLCBK
dWwgMTcgMjAyMiBhdCAyMjoxMywgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4gT24gU3Vu
LCBKdWwgMTcgMjAyMiBhdCAyMjowOCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+IE9u
IFN1biwgSnVsIDE3IDIwMjIgYXQgMjE6MDgsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+
PiBsb2Fkc2VnbWVudF9zaW1wbGUoKSB3YXMgYSByZWQgaGVycmluZy4gVGhlIGdzIHNlZ21l
bnQgaXMgYWxyZWFkeSB6ZXJvLg0KPj4+DQo+Pj4gU28gd2hhdCBleHBsb2RlcyBoZXJlIGlz
IHRoZSBlYXJseSBib290IHdoZW4gc3dpdGNoaW5nIGZyb20gZWFybHkgcGVyDQo+Pj4gQ1BV
IHRvIHRoZSByZWFsIHBlciBDUFUgYXJlYS4NCj4+Pg0KPj4+IHN0YXJ0X2tlcm5lbCgpDQo+
Pj4gICAgICAgICAgLi4uLi4NCj4+PiAgICAgICAgICBzZXR1cF9wZXJfY3B1X2FyZWFzKCk7
DQo+Pj4gICAgICAgICAgc21wX3ByZXBhcmVfYm9vdF9jcHUoKQ0KPj4NCj4+IEJhaC4gc3dp
dGNoX3RvX25ld19nZHQoKSBpcyBhbHJlYWR5IGludm9rZWQgZnJvbSBzZXR1cF9wZXJfY3B1
X2FyZWFzKCkNCj4+IGFuZCB0aGVuIGFnYWluIGluIHNtcF9wcmVwYXJlX2Jvb3RfY3B1KCkg
YW5kIG9uY2UgbW9yZSBpbiBjcHVfaW5pdCgpLA0KPj4NCj4+IFdoYXQgYSBtZXNzLg0KPiAN
Cj4gU28gdGhlIGJlbG93IGJ1aWxkcyBhbmQgYm9vdHMgYXQgbGVhc3Qgb24gNjRiaXQuIEkn
bGwgc3RhcmUgYXQgaXQgc29tZQ0KPiBtb3JlIHRvbW9ycm93LiBJIGhhdmUgbm8gaWRlYSB3
aGV0aGVyIG5hdGl2ZV9sb2FkX2dkdCgpIHdvcmtzIHdpdGgNCj4gWEVOX1BWLiBJdCBzaG91
bGQsIGJ1dCB3aGF0IGRvIEkga25vdy4NCg0KTm8sIHNob3VsZG4ndCB3b3JrLiBCdXQgLi4u
DQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICAgIHRnbHgNCj4gLS0tDQo+IC0tLSBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2Rlc2MuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9kZXNjLmgNCj4gQEAgLTIwNSw3ICsyMDUsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
bmF0aXZlX3NldF9sZHQoY29uc3QNCj4gICAJfQ0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBp
bmxpbmUgdm9pZCBuYXRpdmVfbG9hZF9nZHQoY29uc3Qgc3RydWN0IGRlc2NfcHRyICpkdHIp
DQo+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgbmF0aXZlX2xvYWRfZ2R0KGNvbnN0
IHN0cnVjdCBkZXNjX3B0ciAqZHRyKQ0KPiAgIHsNCj4gICAJYXNtIHZvbGF0aWxlKCJsZ2R0
ICUwIjo6Im0iICgqZHRyKSk7DQo+ICAgfQ0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9wcm9jZXNzb3IuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3Iu
aA0KPiBAQCAtNjcwLDEwICs2NzAsOSBAQCBleHRlcm4gaW50IHN5c2VudGVyX3NldHVwKHZv
aWQpOw0KPiAgIC8qIERlZmluZWQgaW4gaGVhZC5TICovDQo+ICAgZXh0ZXJuIHN0cnVjdCBk
ZXNjX3B0cgkJZWFybHlfZ2R0X2Rlc2NyOw0KPiAgIA0KPiAtZXh0ZXJuIHZvaWQgc3dpdGNo
X3RvX25ld19nZHQoaW50KTsNCj4gK2V4dGVybiB2b2lkIHN3aXRjaF90b19yZWFsX2dkdChp
bnQpOw0KPiAgIGV4dGVybiB2b2lkIGxvYWRfZGlyZWN0X2dkdChpbnQpOw0KPiAgIGV4dGVy
biB2b2lkIGxvYWRfZml4bWFwX2dkdChpbnQpOw0KPiAtZXh0ZXJuIHZvaWQgbG9hZF9wZXJj
cHVfc2VnbWVudChpbnQpOw0KPiAgIGV4dGVybiB2b2lkIGNwdV9pbml0KHZvaWQpOw0KPiAg
IGV4dGVybiB2b2lkIGNwdV9pbml0X3NlY29uZGFyeSh2b2lkKTsNCj4gICBleHRlcm4gdm9p
ZCBjcHVfaW5pdF9leGNlcHRpb25faGFuZGxpbmcodm9pZCk7DQo+IC0tLSBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9NYWtl
ZmlsZQ0KPiBAQCAtNywyMCArNywyNCBAQA0KPiAgIGlmZGVmIENPTkZJR19GVU5DVElPTl9U
UkFDRVINCj4gICBDRkxBR1NfUkVNT1ZFX2NvbW1vbi5vID0gLXBnDQo+ICAgQ0ZMQUdTX1JF
TU9WRV9wZXJmX2V2ZW50Lm8gPSAtcGcNCj4gK0NGTEFHU19SRU1PVkVfc3dpdGNoX2dkdC5v
ID0gLXBnDQo+ICAgZW5kaWYNCj4gICANCj4gICAjIElmIHRoZXNlIGZpbGVzIGFyZSBpbnN0
cnVtZW50ZWQsIGJvb3QgaGFuZ3MgZHVyaW5nIHRoZSBmaXJzdCBzZWNvbmQuDQo+ICAgS0NP
Vl9JTlNUUlVNRU5UX2NvbW1vbi5vIDo9IG4NCj4gICBLQ09WX0lOU1RSVU1FTlRfcGVyZl9l
dmVudC5vIDo9IG4NCj4gK0tDT1ZfSU5TVFJVTUVOVF9zd2l0Y2hfZ2R0Lm8gOj0gbg0KPiAg
IA0KPiAgICMgQXMgYWJvdmUsIGluc3RydW1lbnRpbmcgc2Vjb25kYXJ5IENQVSBib290IGNv
ZGUgY2F1c2VzIGJvb3QgaGFuZ3MuDQo+ICAgS0NTQU5fU0FOSVRJWkVfY29tbW9uLm8gOj0g
bg0KPiArS0NTQU5fU0FOSVRJWkVfc3dpdGNoX2dkdC5vIDo9IG4NCj4gICANCj4gLSMgTWFr
ZSBzdXJlIGxvYWRfcGVyY3B1X3NlZ21lbnQgaGFzIG5vIHN0YWNrcHJvdGVjdG9yDQo+IC1D
RkxBR1NfY29tbW9uLm8JCTo9IC1mbm8tc3RhY2stcHJvdGVjdG9yDQo+ICsjIE1ha2Ugc3Vy
ZSB0aGF0IHN3aXRjaGluZyB0aGUgR0RUIGFuZCB0aGUgcGVyIENQVSBzZWdtZW50DQo+ICsj
IGRvZXMgbm90IGhhdmUgc3RhY2sgcHJvdGVjdG9yIGVuYWJsZWQuDQo+ICtDRkxBR1Nfc3dp
dGNoX2dkdC5vCTo9IC1mbm8tc3RhY2stcHJvdGVjdG9yDQo+ICAgDQo+ICAgb2JqLXkJCQk6
PSBjYWNoZWluZm8ubyBzY2F0dGVyZWQubyB0b3BvbG9neS5vDQo+IC1vYmoteQkJCSs9IGNv
bW1vbi5vDQo+ICtvYmoteQkJCSs9IGNvbW1vbi5vIHN3aXRjaF9nZHQubw0KPiAgIG9iai15
CQkJKz0gcmRyYW5kLm8NCj4gICBvYmoteQkJCSs9IG1hdGNoLm8NCj4gICBvYmoteQkJCSs9
IGJ1Z3Mubw0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4gQEAgLTcwMSwxNiArNzAxLDYgQEAg
c3RhdGljIGNvbnN0IGNoYXIgKnRhYmxlX2xvb2t1cF9tb2RlbChzdA0KPiAgIF9fdTMyIGNw
dV9jYXBzX2NsZWFyZWRbTkNBUElOVFMgKyBOQlVHSU5UU10gX19hbGlnbmVkKHNpemVvZih1
bnNpZ25lZCBsb25nKSk7DQo+ICAgX191MzIgY3B1X2NhcHNfc2V0W05DQVBJTlRTICsgTkJV
R0lOVFNdIF9fYWxpZ25lZChzaXplb2YodW5zaWduZWQgbG9uZykpOw0KPiAgIA0KPiAtdm9p
ZCBsb2FkX3BlcmNwdV9zZWdtZW50KGludCBjcHUpDQo+IC17DQo+IC0jaWZkZWYgQ09ORklH
X1g4Nl8zMg0KPiAtCWxvYWRzZWdtZW50KGZzLCBfX0tFUk5FTF9QRVJDUFUpOw0KPiAtI2Vs
c2UNCj4gLQlfX2xvYWRzZWdtZW50X3NpbXBsZShncywgMCk7DQo+IC0Jd3Jtc3JsKE1TUl9H
U19CQVNFLCBjcHVfa2VybmVsbW9kZV9nc19iYXNlKGNwdSkpOw0KPiAtI2VuZGlmDQo+IC19
DQo+IC0NCj4gICAjaWZkZWYgQ09ORklHX1g4Nl8zMg0KPiAgIC8qIFRoZSAzMi1iaXQgZW50
cnkgY29kZSBuZWVkcyB0byBmaW5kIGNwdV9lbnRyeV9hcmVhLiAqLw0KPiAgIERFRklORV9Q
RVJfQ1BVKHN0cnVjdCBjcHVfZW50cnlfYXJlYSAqLCBjcHVfZW50cnlfYXJlYSk7DQo+IEBA
IC03MzgsMTggKzcyOCw2IEBAIHZvaWQgbG9hZF9maXhtYXBfZ2R0KGludCBjcHUpDQo+ICAg
fQ0KPiAgIEVYUE9SVF9TWU1CT0xfR1BMKGxvYWRfZml4bWFwX2dkdCk7DQo+ICAgDQo+IC0v
Kg0KPiAtICogQ3VycmVudCBnZHQgcG9pbnRzICVmcyBhdCB0aGUgIm1hc3RlciIgcGVyLWNw
dSBhcmVhOiBhZnRlciB0aGlzLA0KPiAtICogaXQncyBvbiB0aGUgcmVhbCBvbmUuDQo+IC0g
Ki8NCj4gLXZvaWQgc3dpdGNoX3RvX25ld19nZHQoaW50IGNwdSkNCj4gLXsNCj4gLQkvKiBM
b2FkIHRoZSBvcmlnaW5hbCBHRFQgKi8NCj4gLQlsb2FkX2RpcmVjdF9nZHQoY3B1KTsNCj4g
LQkvKiBSZWxvYWQgdGhlIHBlci1jcHUgYmFzZSAqLw0KPiAtCWxvYWRfcGVyY3B1X3NlZ21l
bnQoY3B1KTsNCj4gLX0NCj4gLQ0KPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY3B1X2RldiAq
Y3B1X2RldnNbWDg2X1ZFTkRPUl9OVU1dID0ge307DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQg
Z2V0X21vZGVsX25hbWUoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KPiBAQCAtMjIyOCwxMiAr
MjIwNiw2IEBAIHZvaWQgY3B1X2luaXQodm9pZCkNCj4gICAJICAgIGJvb3RfY3B1X2hhcyhY
ODZfRkVBVFVSRV9UU0MpIHx8IGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9ERSkpDQo+ICAg
CQljcjRfY2xlYXJfYml0cyhYODZfQ1I0X1ZNRXxYODZfQ1I0X1BWSXxYODZfQ1I0X1RTRHxY
ODZfQ1I0X0RFKTsNCj4gICANCj4gLQkvKg0KPiAtCSAqIEluaXRpYWxpemUgdGhlIHBlci1D
UFUgR0RUIHdpdGggdGhlIGJvb3QgR0RULA0KPiAtCSAqIGFuZCBzZXQgdXAgdGhlIEdEVCBk
ZXNjcmlwdG9yOg0KPiAtCSAqLw0KPiAtCXN3aXRjaF90b19uZXdfZ2R0KGNwdSk7DQo+IC0N
Cj4gICAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1g4Nl82NCkpIHsNCj4gICAJCWxvYWRzZWdt
ZW50KGZzLCAwKTsNCj4gICAJCW1lbXNldChjdXItPnRocmVhZC50bHNfYXJyYXksIDAsIEdE
VF9FTlRSWV9UTFNfRU5UUklFUyAqIDgpOw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvc3dpdGNoX2dkdC5jDQo+IEBAIC0wLDAgKzEsMzEgQEANCj4g
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gKyNpbmNsdWRl
IDxhc20vcHJvY2Vzc29yLmg+DQo+ICsjaW5jbHVkZSA8YXNtL3NlZ21lbnQuaD4NCj4gKyNp
bmNsdWRlIDxhc20vZGVzYy5oPg0KPiArDQo+ICsvKg0KPiArICogSW52b2tlZCBkdXJpbmcg
ZWFybHkgYm9vdCB0byBzd2l0Y2ggZnJvbSBlYXJseSBHRFQgYW5kIGVhcmx5IHBlciBDUFUN
Cj4gKyAqICglZnMgb24gMzJiaXQsIEdTX0JBU0Ugb24gNjRiaXQpIHRvIHRoZSByZWFsIEdE
VCBhbmQgdGhlIHJ1bnRpbWUgcGVyIENQVQ0KPiArICogYXJlYS4NCj4gKyAqDQo+ICsgKiBU
aGlzIGhhcyB0byBiZSBkb25lIGF0b21pYyBiZWNhdXNlIGFmdGVyIHN3aXRjaGluZyBmcm9t
IGVhcmx5IEdEVCB0bw0KPiArICogdGhlIHJlYWwgb25lIGFueSBwZXIgY3B1IHZhcmlhYmxl
IGFjY2VzcyBpcyBnb2luZyB0byBmYXVsdCBiZWNhdXNlDQo+ICsgKiAlZnMgcmVzcC4gR1Nf
QkFTRSBpcyBub3QgeWV0IHBvaW50aW5nIHRvIHRoZSByZWFsIHBlciBDUFUgZGF0YS4NCj4g
KyAqDQo+ICsgKiBBcyBhIGNvbnNlcXVlbmNlIHRoaXMgdXNlcyB0aGUgbmF0aXZlIHZhcmlh
bnRzIG9mIGxvYWRfZ2R0KCkgYW5kDQo+ICsgKiB3cm1zcmwoKS4gU28gWEVOX1BWIGhhcyB0
byB0YWtlIHRoZSBmYXVsdCBhbmQgZW11bGF0ZS4NCj4gKyAqLw0KPiArdm9pZCBfX2luaXQg
c3dpdGNoX3RvX3JlYWxfZ2R0KGludCBjcHUpDQo+ICt7DQo+ICsJc3RydWN0IGRlc2NfcHRy
IGdkdF9kZXNjcjsNCj4gKw0KPiArCWdkdF9kZXNjci5hZGRyZXNzID0gKGxvbmcpZ2V0X2Nw
dV9nZHRfcncoY3B1KTsNCj4gKwlnZHRfZGVzY3Iuc2l6ZSA9IEdEVF9TSVpFIC0gMTsNCj4g
KwluYXRpdmVfbG9hZF9nZHQoJmdkdF9kZXNjcik7DQo+ICsNCj4gKyNpZmRlZiBDT05GSUdf
WDg2XzMyDQo+ICsJbG9hZHNlZ21lbnQoZnMsIF9fS0VSTkVMX1BFUkNQVSk7DQo+ICsjZWxz
ZQ0KPiArCW5hdGl2ZV93cm1zcmwoTVNSX0dTX0JBU0UsIGNwdV9rZXJuZWxtb2RlX2dzX2Jh
c2UoY3B1KSk7DQo+ICsjZW5kaWYNCj4gK30NCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3Nl
dHVwX3BlcmNwdS5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9zZXR1cF9wZXJjcHUuYw0K
PiBAQCAtMjExLDcgKzIxMSw3IEBAIHZvaWQgX19pbml0IHNldHVwX3Blcl9jcHVfYXJlYXMo
dm9pZCkNCj4gICAJCSAqIGFyZWEuICBSZWxvYWQgYW55IGNoYW5nZWQgc3RhdGUgZm9yIHRo
ZSBib290IENQVS4NCj4gICAJCSAqLw0KPiAgIAkJaWYgKCFjcHUpDQo+IC0JCQlzd2l0Y2hf
dG9fbmV3X2dkdChjcHUpOw0KPiArCQkJc3dpdGNoX3RvX3JlYWxfZ2R0KGNwdSk7DQo+ICAg
CX0NCj4gICANCj4gICAJLyogaW5kaWNhdGUgdGhlIGVhcmx5IHN0YXRpYyBhcnJheXMgd2ls
bCBzb29uIGJlIGdvbmUgKi8NCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3NtcGJvb3QuYw0K
PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvc21wYm9vdC5jDQo+IEBAIC0xNDU3LDcgKzE0NTcs
MTEgQEAgdm9pZCBhcmNoX3RoYXdfc2Vjb25kYXJ5X2NwdXNfZW5kKHZvaWQpDQo+ICAgdm9p
ZCBfX2luaXQgbmF0aXZlX3NtcF9wcmVwYXJlX2Jvb3RfY3B1KHZvaWQpDQo+ICAgew0KPiAg
IAlpbnQgbWUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+IC0Jc3dpdGNoX3RvX25ld19nZHQo
bWUpOw0KPiArDQo+ICsJLyogU01QIGludm9rZXMgdGhpcyBmcm9tIHNldHVwX3Blcl9jcHVf
YXJlYXMoKSAqLw0KPiArCWlmICghSVNfRU5BQkxFRChDT05GSUdfU01QKSkNCj4gKwkJc3dp
dGNoX3RvX3JlYWxfZ2R0KG1lKTsNCj4gKw0KPiAgIAkvKiBhbHJlYWR5IHNldCBtZSBpbiBj
cHVfb25saW5lX21hc2sgaW4gYm9vdF9jcHVfaW5pdCgpICovDQo+ICAgCWNwdW1hc2tfc2V0
X2NwdShtZSwgY3B1X2NhbGxvdXRfbWFzayk7DQo+ICAgCWNwdV9zZXRfc3RhdGVfb25saW5l
KG1lKTsNCj4gLS0tIGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jDQo+ICsrKyBiL2Fy
Y2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYw0KPiBAQCAtMTE2NCw3ICsxMTY0LDcgQEAgc3Rh
dGljIHZvaWQgX19pbml0IHhlbl9zZXR1cF9nZHQoaW50IGNwdQ0KPiAgIAlwdl9vcHMuY3B1
LndyaXRlX2dkdF9lbnRyeSA9IHhlbl93cml0ZV9nZHRfZW50cnlfYm9vdDsNCj4gICAJcHZf
b3BzLmNwdS5sb2FkX2dkdCA9IHhlbl9sb2FkX2dkdF9ib290Ow0KPiAgIA0KPiAtCXN3aXRj
aF90b19uZXdfZ2R0KGNwdSk7DQo+ICsJc3dpdGNoX3RvX3JlYWxfZ2R0KGNwdSk7DQoNCi4u
LiBjYW4ndCB5b3UgdXNlIHRoZSBwYXJhdmlydCB2YXJpYW50IG9mIGxvYWRfZ2R0IGluIHN3
aXRjaF90b19yZWFsX2dkdCgpID8NCg0KPiAgIA0KPiAgIAlwdl9vcHMuY3B1LndyaXRlX2dk
dF9lbnRyeSA9IHhlbl93cml0ZV9nZHRfZW50cnk7DQo+ICAgCXB2X29wcy5jcHUubG9hZF9n
ZHQgPSB4ZW5fbG9hZF9nZHQ7DQo+IA0KDQpKdWVyZ2VuDQo=
--------------wB4kj3uwKYTsTjryxSKo0rza
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------wB4kj3uwKYTsTjryxSKo0rza--

--------------S7VwZ9SI3wA5Lsq1sbiuSHfw--

--------------wj30QoyS010CkM8fvBPLwRRu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmLU62wFAwAAAAAACgkQsN6d1ii/Ey/x
cAf/eMTzi9A4dvCL2lcEUuxNMc9nzyNcOJj1t14Xm536yleZ1rrteM7d6M9isgHFqeXriruX+pJ1
yX2oSL+McGc+TLwAasiiZOGhZ0GSyzRd1Bb9pBNWNAN/oTSAVicOOwi1mfk4iXIobOxG/sx6tnol
vEcvMdhLViwoVYQ43Nyl7+O5WuPoLUjw0A/j5kGS+4trQTMoAP30m+J3i/RVa2e5dsjN3WN2e0/q
rcr6fElTzzIZCeLJi0TaPZJEkRMg1lKHUhBCqa3ycd1tGp2K45TuGzkI/T0g3IGWM1NrTZJQRZxI
yrfPC66xxYkZvu5NUGtcPKFFDbvMrORzCzqynBmOJg==
=6Iq4
-----END PGP SIGNATURE-----

--------------wj30QoyS010CkM8fvBPLwRRu--
