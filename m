Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F857059A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiGKObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGKObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:31:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17C661D7A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:31:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C51E20367;
        Mon, 11 Jul 2022 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657549874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i+qsif4a0a2Bz2k2mGqpG6eHPsih8lkLo27Ye6x0uTs=;
        b=iTT60rhfjlwmrL0KE4s1q2tC6sdwBH63vKFPt+QHFbLQAICBTI2B189vzZ8+JDnduTaA7V
        OCvDDH3+2maqh8o23sS3LsRal0ecHM2CLU9KXytbWVO8OivVRdzL0KF5fJobT4QqSBYQFS
        zhLVgJr6f/66tO4GjRmk/wLFg0iexuQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A8DA13524;
        Mon, 11 Jul 2022 14:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HLWWDDI0zGL3SgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 11 Jul 2022 14:31:14 +0000
Message-ID: <aa8f99dc-e622-398e-1a68-6b060497e4b3@suse.com>
Date:   Mon, 11 Jul 2022 16:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Chuck Zmudzinski <brchuckz@netscape.net>,
        Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic> <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
 <4e099e2d-e429-252b-ceeb-678066d85e61@netscape.net>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
In-Reply-To: <4e099e2d-e429-252b-ceeb-678066d85e61@netscape.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cf3SVQy8ZQnR0sTTfnNEDYPc"
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
--------------cf3SVQy8ZQnR0sTTfnNEDYPc
Content-Type: multipart/mixed; boundary="------------ArVzvAwFKmBEQK8rBKibEYfU";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Chuck Zmudzinski <brchuckz@netscape.net>, Borislav Petkov <bp@alien8.de>,
 Jan Beulich <jbeulich@suse.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <aa8f99dc-e622-398e-1a68-6b060497e4b3@suse.com>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic> <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
 <4e099e2d-e429-252b-ceeb-678066d85e61@netscape.net>
In-Reply-To: <4e099e2d-e429-252b-ceeb-678066d85e61@netscape.net>

--------------ArVzvAwFKmBEQK8rBKibEYfU
Content-Type: multipart/mixed; boundary="------------JKySDGkx4Peknf3GblYXzjxN"

--------------JKySDGkx4Peknf3GblYXzjxN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDcuMjIgMTY6MTgsIENodWNrIFptdWR6aW5za2kgd3JvdGU6DQo+IE9uIDcvNS8y
MiAxMjoxNCBQTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPj4gT24gVHVlLCBKdWwgMDUs
IDIwMjIgYXQgMDU6NTY6MzZQTSArMDIwMCwgSmFuIEJldWxpY2ggd3JvdGU6DQo+Pj4gUmUt
dXNpbmcgcGF0X2Rpc2FibGVkIGxpa2UgeW91IGRvIGluIHlvdXIgc3VnZ2VzdGlvbiBiZWxv
dyB3b24ndA0KPj4+IHdvcmssIGJlY2F1c2UgbXRycl9icF9pbml0KCkgY2FsbHMgcGF0X2Rp
c2FibGUoKSB3aGVuIE1UUlJzDQo+Pj4gYXBwZWFyIHRvIGJlIGRpc2FibGVkIChmcm9tIHRo
ZSBrZXJuZWwncyB2aWV3KS4gVGhlIGdvYWwgaXMgdG8NCj4+PiBob25vciAibm9wYXQiIHdp
dGhvdXQgaG9ub3JpbmcgYW55IG90aGVyIGNhbGxzIHRvIHBhdF9kaXNhYmxlKCkuDQo+Pg0K
Pj4gQWN0dWFsbHksIHRoZSBjdXJyZW50IGdvYWwgaXMgdG8gYWRqdXN0IFhlbiBkb20wIGJl
Y2F1c2U6DQo+Pg0KPj4gMS4gaXQgdXNlcyB0aGUgUEFUIGNvZGUNCj4+DQo+PiAyLiBidXQg
dGhlbiBpdCBkb2VzIHNvbWV0aGluZyBzcGVjaWFsIGFuZCBoaWRlcyB0aGUgTVRSUnMNCj4+
DQo+PiB3aGljaCBpcyBub3Qgc29tZXRoaW5nIHJlYWwgaGFyZHdhcmUgZG9lcy4NCj4+DQo+
PiBTbyB0aGlzIG9uZS1vZmYgdGhpbmcgc2hvdWxkIGJlIHByb21pbmVudCwgdmlzaWJsZSBh
bmQgbm90IGdldCBpbiB0aGUNCj4+IHdheS4NCj4gDQo+IEhlbGxvLA0KPiANCj4gSSBoYXZl
IHNwZW50IGEgZmFpciBhbW91bnQgb2YgdGltZSB0aGlzIHBhc3Qgd2Vla2VuZA0KPiBpbnZl
c3RpZ2F0aW5nIHRoaXMgcmVncmVzc2lvbiBhbmQgd2hhdCBtaWdodCBoYXZlIGNhdXNlZA0K
PiBpdCBhbmQgSSBhbHNvIGhhdmUgZG9uZSBzZXZlcmFsIHRlc3RzIG9uIG15IFhlbiB3b3Jr
c3RhdGlvbg0KPiB0aGF0IGV4aGliaXRzIHRoZSByZWdyZXNzaW9uIHRvIHZlcmlmeSBteSB1
bmRlcnN0YW5kaW5nDQo+IG9mIHRoZSBwcm9ibGVtIGFuZCBhbHNvIHJhaXNlIG90aGVyIHBy
b2JsZW1hdGljIHBvaW50cy4NCj4gDQo+IEkgdGhpbmssIGluIGFkZGl0aW9uIHRvIGltbWVk
aWF0ZWx5IGZpeGluZyB0aGUgcmVncmVzc2lvbiBieQ0KPiBmaXhpbmcgdGhlIG5vdyBmaXZl
LXllYXItb2xkIGNvbW1pdCB0aGF0IGlzIHRoZSByb290IGNhdXNlDQo+IG9mIHRoZSByZWNl
bnRseSBleHBvc2VkIHJlZ3Jlc3Npb24sIGFzIGRpc2N1c3NlZCBpbiBteQ0KPiBlYXJsaWVy
IG1lc3NhZ2Ugd2hpY2ggcHJvcG9zZXMgYSBzaW1wbGUgcGF0Y2ggdG8gZml4IHRoYXQNCj4g
Zml2ZS15ZWFyLW9sZCBicm9rZW4gY29tbWl0LA0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC82MzU4MzQ5Ny0xNTJmLTU4ODAtNGM4Zi1kNDdlMmE4MWY1YTZAbmV0c2Nh
cGUubmV0Lw0KPiANCj4gdGhlcmUgbmVlZHMgdG8gYmUgYSBkZWNpc2lvbiBhYm91dCBob3cg
YmVzdCB0byBkZWFsIHdpdGgNCj4gdGhpcyB2ZXJ5IGFwdGx5IGRlc2NyaWJlZCAib25lLW9m
ZiBYZW4gdGhpbmciIGluIHRoZSBmdXR1cmUuDQo+IA0KPiBPbmUgcHJvYmxlbSBpbiB4ODYv
bW0vcGF0L21lbXR5cGUuYyBpcyB0aGUgZmFjdCB0aGF0IHRoZXJlDQo+IGV4aXN0IHR3byBm
dW5jdGlvbnMsIHBhdF9pbml0KCksIGFuZCBpbml0X2NhY2hlX21vZGVzKCksIHRoYXQNCj4g
ZG8gbW9yZSBvciBsZXNzIHRoZSBzYW1lIHRoaW5nLCBzbyB0aGF0IHdoZW4gb25lIG9mIHRo
b3NlDQo+IGZ1bmN0aW9ucyBuZWVkcyB0byBiZSB1cGRhdGVkLCB0aGUgb3RoZXIgYWxzbyBu
ZWVkcyB0bw0KPiBiZSB1cGRhdGVkLiBJbiB0aGUgcGFzdCwgd2hlbiBjaGFuZ2VzIHRvIHRo
ZSBwYXRfZW5hYmxlDQo+IGFuZCBwYXRfZGlzYWJsZSBmdW5jdGlvbnMgYW5kIHZhcmlhYmxl
cyB3ZXJlIG1hZGUsIGFsbA0KPiB0b28gb2Z0ZW4sIHRoZSBjaGFuZ2Ugd2FzIG9ubHkgYXBw
bGllZCB0byBwYXRfaW5pdCgpIGFuZCBub3QNCj4gdG8gaW5pdF9jYWNoZV9tb2RlcygpIGFu
ZCB0aGUgb25lLW9mZiBYZW4gY2FzZSB3YXMgc2ltcGx5DQo+IG5vdCBhZGRyZXNzZWQgYW5k
IGRlYWx0IHdpdGggcHJvcGVybHkuDQo+IA0KPiBTbyBJIHByb3Bvc2UgdGhlIGZvbGxvd2lu
ZzoNCj4gDQo+IDEpIElkZW50aWZ5IHRob3NlIHRoaW5ncyB0aGF0IGFsd2F5cyBuZWVkIHRv
IGJlIGRvbmUgaW4NCj4gZWl0aGVyIHBhdF9pbml0KCkgb3IgaW5pdF9jYWNoZV9tb2Rlcygp
IGFuZCB0cnkgdG8gY29tYmluZQ0KPiB0aG9zZSB0aGluZ3MgaW50byBhIHNpbmdsZSBmdW5j
dGlvbiBzbyB0aGF0IGNoYW5nZXMgd2lsbA0KPiBiZSBhcHBsaWVkIGZvciBib3RoIGNhc2Vz
LiBXZSBzb3J0IG9mIGhhdmUgdGhhdCBub3cgd2l0aA0KPiBfX2luaXRfY2FjaGVfbW9kZXMo
KSwgYnV0IGl0IGlzIG5vdCByZWFsbHkgZ29vZCBlbm91Z2ggdG8NCj4gcHJldmVudCB0aGUg
cmVncmVzc2lvbnMgd2Ugc29tZXRpbWVzIGdldCBpbiBYZW4gUFYNCj4gZG9tYWlucyBzdWNo
IGFzIHRoZSBjdXJyZW50IHJlZ3Jlc3Npb24gd2UgaGF2ZSB3aXRoDQo+IFhlbiBEb20wIGFu
ZCBjZXJ0YWluIHBhcnRpY3VsYXIgSW50ZWwgZ3JhcGhpY3MgZGV2aWNlcy4NCj4gDQo+IDIp
IElmIGl0IGlzIG5vdCBwb3NzaWJsZSB0byBkbyB3aGF0IGlzIHByb3Bvc2VkIGluIDEpLCBh
dCBsZWFzdA0KPiByZS1mYWN0b3IgdGhlIGNvZGUgdG8gbWFrZSBpdCB2ZXJ5IGNsZWFyIHRo
YXQgd2hlbmV2ZXINCj4gZWl0aGVyIHBhdF9pbml0KCkgbmVlZHMgdG8gYmUgYWRqdXN0ZWQg
b3IgaW5pdF9jYWNoZV9tb2RlcygpDQo+IG5lZWRzIHRvIGJlIGFkanVzdGVkLCBjYXJlIG11
c3QgYmUgdGFrZW4gdG8gZW5zdXJlIHRoYXQNCj4gYWxsIGNhc2VzIGFyZSBwcm9wZXJseSBk
ZWFsdCB3aXRoLCBpbmNsdWRpbmcgdGhlDQo+IG9uZS1vZmYgWGVuIGNhc2Ugb2YgZW5hYmxp
bmcgUEFUIHdpdGggTVRSUiBkaXNhYmxlZCwNCj4gQ3VycmVudGx5LCBBSVVJLCBhbGwgb25l
IHJlYWxseSBuZWVkcyB0byBrbm93IGlzIHRoYXQNCj4gaW5pdF9jYWNoZWRfbW9kZXMoKSBo
YW5kbGVzIHR3byBzcGVjaWFsIGNhc2VzOg0KPiBGaXJzdCwgd2hlbiBQQVQgaXMgZGlzYWJs
ZWQgZm9yIGFueSByZWFzb24sIGluY2x1ZGluZyB3aGVuDQo+IHRoZSAibm9wYXQiIGJvb3Qg
b3B0aW9uIGlzIHNldCwgYW5kIHNlY29uZCwgdGhlIG9uZS1vZmYNCj4gWGVuIGNhc2Ugb2Yg
TVRSUiBiZWluZyBkaXNhYmxlZCBidXQgUEFUIGJlaW5nIGVuYWJsZWQuDQo+IA0KPiBJIGFt
IHRyeWluZyB0byBkbyBudW1iZXIgMiB3aXRoIGEgcGF0Y2ggc2VyaWVzIEkgYW0NCj4gd29y
a2luZyBvbi4gSXQgaXMgdXAgdG8gdGhlIGV4cGVydHMgdG8gZGVjaWRlIGlmIGl0DQo+IGlz
IHBvc3NpYmxlIG9yIGV2ZW4gZGVzaXJhYmxlIHRvIGltcHJvdmUgdGhlIGNvZGUgc28NCj4g
dGhhdCBhbnkgY2hhbmdlcyB0byB0aGUgY2FjaGluZyBjb25maWd1cmF0aW9uIGFyZSBtb3Jl
DQo+IGxpa2VseSB0byBiZSBwcm9wZXJseSBpbXBsZW1lbnRlZCBmb3IgYWxsIHN1cHBvcnRl
ZCBwbGF0Zm9ybXMNCj4gYnkgc3VjY2Vzc2Z1bGx5IGNvbWJpbmluZyB0aGUgdHdvIGZ1bmN0
aW9ucyBwYXRfaW5pdCgpIGFuZA0KPiBpbml0X2NhY2hlX21vZGVzKCkgaW50byBhIHNpbmds
ZSBmdW5jdGlvbi4gVGhlIG5ldyBmdW5jdGlvbg0KPiB3b3VsZCBwcm9iYWJseSBuZWVkIHRv
IGJlIHJlbmFtZWQgYW5kIGluY2x1ZGUgYml0cyBmcm9tDQo+IG10cnJfYnBfZW5hYmxlZCwg
ZXRjLiBmb3IgaXQgdG8gZnVuY3Rpb24gcHJvcGVybHkuDQo+IA0KPiBJZiBhbnlvbmUgd2Fu
dHMgdG8gYXJndWUgdGhhdCBpdCBpcyBub3QgZGVzaXJhYmxlIHRvIHRyeQ0KPiBjb21iaW5l
IHBhdF9pbml0KCkgYW5kIGluaXRfY2FjaGVfbW9kZXMoKSBpbnRvIGEgc2luZ2xlDQo+IGZ1
bmN0aW9uLCBJIHRoaW5rIHRoZSBidXJkZW4gb2YgcHJvb2YgcmVzdHMgb24gdGhhdA0KPiBw
ZXJzb24gdG8gZGVtb25zdHJhdGUgd2h5IGl0IGlzIGdvb2QgYW5kIGNsZWFuDQo+IGNvZGlu
ZyBwcmFjdGljZSB0byBjb250aW51ZSB0byBoYXZlIHRoZW0gc2VwYXJhdGUNCj4gYW5kIGlu
ZGVwZW5kZW50IGZyb20gZWFjaCBvdGhlciBpbiB0aGUgY29kZSB3aGVuDQo+IHRoZXkgYm90
aCBlc3NlbnRpYWxseSBkbyB0aGUgc2FtZSB0aGluZyBpbiB0aGUgZW5kLCB3aGljaA0KPiBp
cyBjYWxsIF9faW5pdF9jYWNoZV9tb2RlcygpIGFuZCBkZXRlcm1pbmUgdGhlIFBBVA0KPiBz
dGF0ZSwgYW5kIGFsc28gcHJvYmFibHkgdGhlIE1UUlIgc3RhdGUuDQoNCkkgdGhpbmsgdGhl
IHByb3BlciBzb2x1dGlvbiB3b3VsZCBiZSB0byBtYWtlIFBBVCBhbmQgTVRSUiBpbmRlcGVu
ZGVudA0KZnJvbSBlYWNoIG90aGVyIHdpdGggc29tZSBhZGRpdGlvbmFsIHJlc3RydWN0dXJp
bmcgb24gdGhlIFBBVCBzaWRlOg0KDQpUb2RheSBQQVQgY2FuJ3QgYmUgdXNlZCB3aXRob3V0
IE1UUlIgYmVpbmcgYXZhaWxhYmxlLCB1bmxlc3MgTVRSUiBpcyBhdA0KbGVhc3QgY29uZmln
dXJlZCB2aWEgQ09ORklHX01UUlIgYW5kIHRoZSBzeXN0ZW0gaXMgcnVubmluZyBhcyBYZW4g
UFYNCmd1ZXN0LiBJbiB0aGlzIGNhc2UgUEFUIGlzIGF1dG9tYXRpY2FsbHkgYXZhaWxhYmxl
IHZpYSB0aGUgaHlwZXJ2aXNvciwNCmJ1dCB0aGUgUEFUIE1TUiBjYW4ndCBiZSBtb2RpZmll
ZCBieSB0aGUga2VybmVsIGFuZCBNVFJSIGlzIGRpc2FibGVkLg0KDQpBcyBhbiBhZGRpdGlv
bmFsIGNvbXBsZXhpdHkgdGhlIGF2YWlsYWJpbGl0eSBvZiBQQVQgY2FuJ3QgYmUgcXVlcmll
ZA0KdmlhIHBhdF9lbmFibGVkKCkgaW4gdGhlIFhlbiBQViBjYXNlLCBhcyB0aGUgbGFjayBv
ZiBNVFJSIHdpbGwgc2V0IFBBVA0KdG8gYmUgZGlzYWJsZWQuIFRoaXMgbGVhZHMgdG8gc29t
ZSBkcml2ZXJzIGJlbGlldmluZyB0aGF0IG5vdCBhbGwgY2FjaGUNCm1vZGVzIGFyZSBhdmFp
bGFibGUsIHJlc3VsdGluZyBpbiBmYWlsdXJlcyBvciBkZWdyYWRlZCBmdW5jdGlvbmFsaXR5
DQoodGhlIGN1cnJlbnQgcmVncmVzc2lvbikuDQoNClRoZSBzYW1lIGFwcGxpZXMgdG8gYSBr
ZXJuZWwgYnVpbHQgd2l0aCBubyBNVFJSIHN1cHBvcnQ6IGl0IHdvbid0DQphbGxvdyB0byB1
c2UgdGhlIFBBVCBNU1IsIGV2ZW4gaWYgdGhlcmUgaXMgbm8gdGVjaG5pY2FsIHJlYXNvbiBm
b3INCnRoYXQsIG90aGVyIHRoYW4gc2V0dGluZyB1cCBQQVQgb24gYWxsIGNwdXMgdGhlIHNh
bWUgd2F5ICh3aGljaCBpcyBhDQpyZXF1aXJlbWVudCBvZiB0aGUgcHJvY2Vzc29yJ3MgY2Fj
aGUgbWFuYWdlbWVudCkgaXMgcmVseWluZyBvbiBzb21lDQpNVFJSIHNwZWNpZmljIGNvZGUu
DQoNCkFsbCBvZiB0aGF0IHNob3VsZCBiZSBmaXhhYmxlIGJ5Og0KDQotIG1vdmluZyB0aGUg
ZnVuY3Rpb24gbmVlZGVkIGJ5IFBBVCBmcm9tIE1UUlIgc3BlY2lmaWMgY29kZSBvbmUgbGV2
ZWwNCiAgIHVwDQotIGFkZGluZyBhIFBBVCBpbmRpcmVjdGlvbiBsYXllciBzdXBwb3J0aW5n
IHRoZSAzIGNhc2VzICJubyBvciBkaXNhYmxlZA0KICAgUEFUIiwgIlBBVCB1bmRlciBrZXJu
ZWwgY29udHJvbCIsIGFuZCAiUEFUIHVuZGVyIFhlbiBjb250cm9sIg0KLSByZW1vdmluZyB0
aGUgZGVwZW5kZW5jeSBvZiBQQVQgb24gTVRSUg0KDQpJJ2QgYmUgdXAgZm9yIHRyeWluZyB0
aGlzLCBidXQgcmlnaHQgbm93IEkgaGF2ZW4ndCBnb3QgdGhlIHRpbWUgdG8gZG8NCml0LiBJ
IG1pZ2h0IGJlIGFibGUgdG8gc3RhcnQgd29ya2luZyBvbiB0aGF0IGluIFNlcHRlbWJlci4N
Cg0KTWVhbndoaWxlIEkgdGhpbmsgZWl0aGVyIEphbidzIHBhdGNoIG9yIHRoZSBzaW1wbGUg
b25lIG9mIENodWNrDQpzaG91bGQgYmUgYXBwbGllZC4NCg0KDQpKdWVyZ2VuDQo=
--------------JKySDGkx4Peknf3GblYXzjxN
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------JKySDGkx4Peknf3GblYXzjxN--

--------------ArVzvAwFKmBEQK8rBKibEYfU--

--------------cf3SVQy8ZQnR0sTTfnNEDYPc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmLMNDEFAwAAAAAACgkQsN6d1ii/Ey8I
rAgAgA89Z5IbV68cr1LqOpVTqysh6Ubo0tBLRolmEvKvz57b8Sdck4+z4mqP3z94GAHD61WJPKc+
hVvgrgs1EVVzO66qqNX6qVUwZAouGgu/VNy4W+iPtv7JjK6HYk2ctJllcAjE0XT+BwL82yL/DXLn
08oMWiPY6q8WC5sgvVom1Q78Wq+zTExFpGkhx9ZyNuUpDdSSCMhXg3tPMI+r/htZtMKV37q/Tg3l
5sn5tk2GUfnd69xgbOeGizsmcr+ne9i+Wp2Z3aO7bVXyFBsiMrG+Cg9FkiBTuhKWjQfeAk4v3y3O
jf6sKcZv+cmf65R7UbFudZGnXyZAlvJ/iO2Qp/pbiQ==
=iQaR
-----END PGP SIGNATURE-----

--------------cf3SVQy8ZQnR0sTTfnNEDYPc--
