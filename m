Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4108F591F0B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 10:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiHNIIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiHNIIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 04:08:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EFA6068B;
        Sun, 14 Aug 2022 01:08:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2C3551F936;
        Sun, 14 Aug 2022 08:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660464528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRzV4ig7EK+1L8wTuiL20CPWwFEOF4VmNbkE1XFK75c=;
        b=aE7TgSsthSy5gPijSuCR0ilqEFz4Hz+gj3cF606H94WJkb6MWzaxjyIiafT/5383G22qIV
        Q0Zw29eDcjaxtaWVh3qQocEjOc341728N9qfW8DmGCv69oSpHA8594gaCIPi5MMh6fJFZj
        Bm0WTuEwC1v5X6znmormF+xPNyGwfQw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97B4513754;
        Sun, 14 Aug 2022 08:08:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HiyKI4+t+GLULwAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 14 Aug 2022 08:08:47 +0000
Message-ID: <c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com>
Date:   Sun, 14 Aug 2022 10:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Chuck Zmudzinski <brchuckz@netscape.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     jbeulich@suse.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
In-Reply-To: <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------b65gjEspzMDwS5OlTrjvWA1i"
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
--------------b65gjEspzMDwS5OlTrjvWA1i
Content-Type: multipart/mixed; boundary="------------o4Xr3ZvfBsIM8AotFyz0L5Dl";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Chuck Zmudzinski <brchuckz@netscape.net>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: jbeulich@suse.com, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, regressions@lists.linux.dev,
 xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Message-ID: <c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com>
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
In-Reply-To: <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>

--------------o4Xr3ZvfBsIM8AotFyz0L5Dl
Content-Type: multipart/mixed; boundary="------------xWoWbx6Tg6KmC2ytD0eUvvQd"

--------------xWoWbx6Tg6KmC2ytD0eUvvQd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMDguMjIgMDk6NDIsIENodWNrIFptdWR6aW5za2kgd3JvdGU6DQo+IE9uIDgvMTMv
MjAyMiAxMjo1NiBQTSwgQ2h1Y2sgWm11ZHppbnNraSB3cm90ZToNCj4+IE9uIDcvMTcvMjIg
Mzo1NSBBTSwgVGhvcnN0ZW4gTGVlbWh1aXMgd3JvdGU6DQo+Pj4gSGkgSnVlcmdlbiENCj4+
Pg0KPj4+IE9uIDE1LjA3LjIyIDE2OjI1LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOiAuLi4NCj4+
DQo+PiBIaSBUaG9yc3RlbiwNCj4+DQo+PiBUaGlzIGFwcGVhcnMgc3RhbGxlZCBhZ2FpbiBh
bmQgd2UgYXJlIG5vdyBvdmVyIHRocmVlIG1vbnRocw0KPj4gZnJvbSB0aGUgZmlyc3QgcmVw
b3J0IG9mIHRoZSByZWdyZXNzaW9uLCBUaGUgb25seSBleGN1c2UgZm9yDQo+PiBpZ25vcmlu
ZyB5b3VyIGNvbW1lbnRzLCBhbmQgb3RoZXIgY29tbWVudHMgb24gdGhlIHBhdGNoZXMNCj4+
IGluIHRoaXMgcGF0Y2ggc2VyaWVzIGZvciB0aGlzIGxvbmcgYSB0aW1lIGlzIHRoYXQgdGhl
IHBhdGNoIHNlcmllcw0KPj4gZm9yIHNvbWUgcmVhc29uIGNhbm5vdCBiZSBjb25zaWRlcmVk
IGEgdHJ1ZSByZWdyZXNzaW9uLiBJZiB0aGlzIGlzIGENCj4+IHJlZ3Jlc3Npb24sIHRoZW4s
IElNSE8sIHRoaXMgbmVlZHMgdG8gaGF2ZSBhIGhpZ2hlciBwcmlvcml0eSBieSB0aGUNCj4+
IG1haW50YWluZXJzLCBvciB0aGUgbWFpbnRhaW5lcnMgbmVlZCB0byBleHBsYWluIHdoeSB0
aGlzIHJlZ3Jlc3Npb24NCj4+IGNhbm5vdCBiZSBmaXhlZCBpbiBhIG1vcmUgdGltZWx5IG1h
bm5lci4gQnV0IGNvbnRpbnVlZCBzaWxlbmNlDQo+PiBieSB0aGUgbWFpbnRhaW5lcnMgaXMg
dW5hY2NlcHRhYmxlLCBJTUhPLiBUaGlzIGlzIGVzcGVjaWFsbHkgdHJ1ZQ0KPj4gaW4gdGhp
cyBjYXNlIHdoZW4gbXVsdGlwbGUgZml4ZXMgZm9yIHRoZSByZWdyZXNzaW9uIGhhdmUgYmVl
bg0KPj4gaWRlbnRpZmllZCBhbmQgdGhlIG1haW50YWluZXJzIGhhdmUgbm90IHlldCBjbGVh
cmx5IGV4cGxhaW5lZCB3aHkNCj4+IGF0IGxlYXN0IGEgZml4LCBldmVuIGlmIHRlbXBvcmFy
eSwgY2Fubm90IGJlIGFwcGxpZWQgaW1tZWRpYXRlbHkNCj4+IHdoaWxlIHdlIHdhaXQgZm9y
IGEgbW9yZSBjb21wcmVoZW5zaXZlIGZpeC4NCj4+DQo+PiBBdCB0aGUgdmVyeSBsZWFzdCwg
SSB3b3VsZCBleHBlY3QgSnVlcmdlbiB0byByZXBseSBoZXJlIGFuZCBzYXkgdGhhdA0KPj4g
aGUgaXMgZGVsYXllZCBidXQgZG9lcyBwbGFuIHRvIHNwaW4gdXAgYW4gdXBkYXRlZCB2ZXJz
aW9uIGFuZCBpbmNsdWRlDQo+PiB0aGUgbmVjZXNzYXJ5IGxpbmtzIGluIHRoZSBuZXcgdmVy
c2lvbiB0byBmYWNpbGl0YXRlIHlvdXIgdHJhY2tpbmcgb2YNCj4+IHRoZSByZWdyZXNzaW9u
LiBXaHkgdGhlIHNpbGVuY2UgZnJvbSBKdWVyZ2VuIGhlcmU/DQo+IA0KPiBUaGlzIGlzIGEg
ZmFpcmx5IGxvbmcgbWVzc2FnZSBidXQgSSB0aGluayB3aGF0IEkgbmVlZCB0byBzYXkNCj4g
aGVyZSBpcyBpbXBvcnRhbnQgZm9yIHRoZSBmdXR1cmUgc3VjY2VzcyBvZiBMaW51eCBhbmQg
b3Blbg0KPiBzb3VyY2Ugc29mdHdhcmUsIHNvIGhlcmUgZ29lcy4uLi4NCj4gDQo+IFVwZGF0
ZTogSSBhY2NlcHQgQm9yaXMgUGV0a292J3MgcmVzcG9uc2UgdG8gbWUgeWVzdGVyZGF5IGFz
IHJlYXNvbmFibGUNCj4gYW5kIGFjY2VwdGFibGUgaWYgd2l0aGluIHR3byB3ZWVrcyBoZSBh
dCBsZWFzdCBleHBsYWlucyBvbiB0aGUgcHVibGljDQo+IG1haWxpbmcgbGlzdHMgaG93IGhl
IGFuZCBKdWVyZ2VuIGhhdmUgcHJpdmF0ZWx5IGFncmVlZCB0byBmaXggdGhpcyByZWdyZXNz
aW9uDQo+ICJzb29uIiBpZiBoZSBkb2VzIG5vdCBhY3R1YWxseSBmaXggdGhlIHJlZ3Jlc3Np
b24gYnkgdGhlbiB3aXRoIGEgY29tbWl0LA0KPiBwYXRjaCBzZXQsIG9yIG1lcmdlLiBUaGUg
dHdvLXdlZWsgdGltZSBmcmFtZSBpcyBmcm9tIGhlcmU6DQo+IA0KPiBodHRwczovL3d3dy5r
ZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL2hhbmRsaW5nLXJlZ3Jlc3Npb25z
Lmh0bWwNCj4gDQo+IHdoZXJlIGRldmVsb3BlcnMgYW5kIG1haW50YWluZXJzIGFyZSBleGhv
cnRlZCBhcyBmb2xsb3dzOiAiVHJ5IHRvIGZpeA0KPiByZWdyZXNzaW9ucyBxdWlja2x5IG9u
Y2UgdGhlIGN1bHByaXQgaGFzIGJlZW4gaWRlbnRpZmllZDsgZml4ZXMgZm9yIG1vc3QNCj4g
cmVncmVzc2lvbnMgc2hvdWxkIGJlIG1lcmdlZCB3aXRoaW4gdHdvIHdlZWtzLCBidXQgc29t
ZSBuZWVkIHRvIGJlDQo+IHJlc29sdmVkIHdpdGhpbiB0d28gb3IgdGhyZWUgZGF5cy4iDQoN
CkFuZCBzb21lIG1vcmUgY2l0YXRpb25zIGZyb20gdGhlIHNhbWUgZG9jdW1lbnQ6DQoNCiJQ
cmlvcml0aXplIHdvcmsgb24gaGFuZGxpbmcgcmVncmVzc2lvbiByZXBvcnRzIGFuZCBmaXhp
bmcgcmVncmVzc2lvbiBvdmVyIGFsbA0Kb3RoZXIgTGludXgga2VybmVsIHdvcmssIHVubGVz
cyB0aGUgbGF0dGVyIGNvbmNlcm5zIGFjdXRlIHNlY3VyaXR5IGlzc3VlcyBvcg0KYnVncyBj
YXVzaW5nIGRhdGEgbG9zcyBvciBkYW1hZ2UuIg0KDQpGaXJzdCB0aGluZyB0byBub3RlIGhl
cmU6ICJvdmVyIGFsbCBMaW51eCBrZXJuZWwgd29yayIuIEknIG5vdCBvbmx5IHdvcmtpbmcN
Cm9uIHRoZSBrZXJuZWwsIGJ1dCBJIGhhdmUgb3RoZXIgcmVzcG9uc2liaWxpdGllcyBlLmcu
IGluIHRoZSBYZW4gY29tbXVuaXR5LA0Kd2hlcmUgSSB3YXMgc2VuZGluZyBwYXRjaGVzIGZv
ciBmaXhpbmcgYSByZWdyZXNzaW9uIGFuZCB3aGVyZSBJJ20gcXVpdGUgYnVzeQ0KZG9pbmcg
c2VjdXJpdHkgcmVsYXRlZCB3b3JrLiBBcGFydCBmcm9tIHRoYXQgSSdtIG9mIGNvdXJzZSBy
ZXNwb25zaWJsZSB0bw0KaGFuZGxlIFNVU0UgY3VzdG9tZXJzJyBidWcgcmVwb3J0cyBhdCBh
IHJhdGhlciBoaWdoIHByaW9yaXR5LiBTbyBwbGVhc2Ugc3RvcA0KYWNjdXNpbmcgbWUgdG8g
aWdub3JlIHRoZSByZXNwb25zZXMgdG8gdGhlc2UgcGF0Y2hlcy4gVGhpcyBpcyBqdXN0IG5v
dCByZWFsbHkNCm1vdGl2YXRpbmcgbWUgdG8gY29udGludWUgaW50ZXJhY3Rpbmcgd2l0aCB5
b3UuDQoNCiJBbHdheXMgY29uc2lkZXIgcmV2ZXJ0aW5nIHRoZSBjdWxwcml0IGNvbW1pdHMg
YW5kIHJlYXBwbHlpbmcgdGhlbSBsYXRlcg0KdG9nZXRoZXIgd2l0aCBuZWNlc3NhcnkgZml4
ZXMsIGFzIHRoaXMgbWlnaHQgYmUgdGhlIGxlYXN0IGRhbmdlcm91cyBhbmQgcXVpY2tlc3QN
CndheSB0byBmaXggYSByZWdyZXNzaW9uLiINCg0KSSBkaWRuJ3QgaW50cm9kdWNlIHRoZSBy
ZWdyZXNzaW9uLCBub3Igd2FzIGl0IGludHJvZHVjZWQgaW4gbXkgYXJlYSBvZg0KbWFpbnRh
aW5lcnNoaXAuIEl0IGp1c3QgaGFwcGVuZWQgdG8gaGl0IFhlbi4gU28gSSBzdGVwcGVkIHVw
IGFmdGVyIEphbidzIHBhdGNoZXMNCndlcmUgbm90IGRlZW1lZCB0byBiZSB0aGUgd2F5IHRv
IGdvLCBhbmQgSSB3cm90ZSB0aGUgcGF0Y2hlcyBpbiBzcGl0ZSBvZiBtZQ0KaGF2aW5nIG90
aGVyIHVyZ2VudCB3b3JrIHRvIGRvLiBJbiBjYXNlIHlvdSBhcmUgZmVlbGluZyBzbyBzdHJv
bmcgYWJvdXQgdGhlIGZpeA0Kb2YgdGhlIHJlZ3Jlc3Npb24sIHdoeSBkb24ndCB5b3UgYXNr
IGZvciB0aGUgcGF0Y2ggaW50cm9kdWNpbmcgaXQgdG8gYmUgcmV2ZXJ0ZWQNCmluc3RlYWQ/
IEFjY3VzaW5nIG1lIGFuZCBCb3JpcyBpcyBub3QgYWNjZXB0YWJsZSBhdCBhbGwhDQoNCj4g
SSBhbHNvIHRoaW5rIHRoZXJlIGlzIGEgcHJpdmF0ZSBhZ3JlZW1lbnQgYmV0d2VlbiBKdWVy
Z2VuIGFuZCBCb3JpcyB0bw0KPiBmaXggdGhpcyByZWdyZXNzaW9uIGJlY2F1c2UgQUZBSUNU
IHRoZXJlIGlzIG5vIGV2aWRlbmNlIGluIHRoZSBwdWJsaWMNCj4gbWFpbGluZyBsaXN0cyB0
aGF0IHN1Y2ggYW4gYWdyZWVtZW50IGhhcyBiZWVuIHJlYWNoZWQsIHlldCBCb3JpcyB5ZXN0
ZXJkYXkNCj4gdG9sZCBtZSBvbiB0aGUgcHVibGljIG1haWxpbmcgbGlzdHMgaW4gdGhpcyB0
aHJlYWQgdG8gYmUgInBhdGllbnQiIGFuZCB0aGF0DQo+ICJ3ZSB3aWxsIGZpeCB0aGlzIHNv
b24uIiBVbmxlc3MgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywgYW5kIEkgaG9wZSBJIGFtLA0K
PiB0aGUgb25seSB3YXkgdGhhdCBhIGZpeCBjb3VsZCBiZSBjb21pbmcgInNvb24iIHdvdWxk
IGJlIHRvIHByZXN1bWUNCj4gdGhhdCBKdWVyZ2VuIGFuZCBCb3JpcyBoYXZlIGFncmVlZCB0
byBhIGZpeCBmb3IgdGhlIHJlZ3Jlc3Npb24gaW4gcHJpdmF0ZS4NCj4gDQo+IEhvd2V2ZXIs
IEFGQUlDVCwga2VlcGluZyB0aGVpciBzb2x1dGlvbiBwcml2YXRlIHdvdWxkIGJlIGEgdmlv
bGF0aW9uIG9mDQo+IG5ldGlxdWV0dGUgYXMgZGVzY3JpYmVkIGhlcmU6DQo+IA0KPiBodHRw
czovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KPiAN
Cj4gd2hlcmUgYSB3aG9sZSBzZWN0aW9uIGlzIGRldm90ZWQgdG8gdGhlIGltcG9ydGFuY2Ug
b2Yga2VlcGluZyB0aGUNCj4gZGlzY3Vzc2lvbiBvZiBjaGFuZ2VzIHRvIHRoZSBrZXJuZWwg
aW4gcHVibGljLCB3aXRoIHByaXZhdGUgZGlzY3Vzc2lvbnMNCj4gYmVpbmcgYSB2aW9sYXRp
b24gb2YgdGhlIG5ldGlxdWV0dGUgdGhhdCBnb3Zlcm5zIHRoZSBkaXNjdXNzaW9ucyB0aGF0
DQo+IHRha2UgcGxhY2UgYmV0d2VlbiBwZXJzb25zIGludGVyZXN0ZWQgaW4gdGhlIExpbnV4
IGtlcm5lbCBwcm9qZWN0IGFuZA0KPiBvdGhlciBvcGVuIHNvdXJjZSBwcm9qZWN0cy4NCg0K
QW5vdGhlciB1bmNhbGxlZCBmb3IgYXR0YWNrLg0KDQpBZnRlciBzZW5kaW5nIHRoZSBwYXRj
aGVzIEkganVzdCB0b2xkIEJvcmlzIHZpYSBJUkMgdGhhdCBJIHdvdWxkbid0IHJlYWN0DQp0
byBhbnkgcmVzcG9uc2VzIHNvb24sIGFzIEkgd2FzIGFib3V0IHRvIHN0YXJ0IG15IHZhY2F0
aW9uLiBUaGlzIHdhcyBqdXN0IGENCmhpbnQgZm9yIGhpbSwgYXMgaGUgd2FzIHJhdGhlciBi
dXN5IGF0IHRoYXQgdGltZSBoYW5kbGluZyBrZXJuZWwgc2VjdXJpdHkNCmlzc3Vlcy4NCg0K
SSB3b24ndCBjb21tZW50IG9uIHRoZSByZXN0IG9mIHlvdXIgYWJzb2x1dGUgdW5hY2NlcHRh
YmxlIGFjY3VzYXRpb25zLg0KDQpJIHdpbGwgY29udGludWUgd2l0aCB0aGUgcGF0Y2hlcyBh
cyBzb29uIGFzIEkgZmluZCB0aW1lIHRvIGRvIHNvLg0KDQoNCkp1ZXJnZW4NCg==
--------------xWoWbx6Tg6KmC2ytD0eUvvQd
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------xWoWbx6Tg6KmC2ytD0eUvvQd--

--------------o4Xr3ZvfBsIM8AotFyz0L5Dl--

--------------b65gjEspzMDwS5OlTrjvWA1i
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmL4rY8FAwAAAAAACgkQsN6d1ii/Ey9Z
JQf9FBOfp/A4bpRaFYQWcVBwDCqh3H7ca4rz6teu8nJQKx/6NUre0TsqzZOttf4P30oPjKA0qNol
9buUv2g5efOZVujITYiX+RErMxTno2vPiTZgpKITNka1lOKcKMV1gGiTcrHzyBBHYAhxzRY5oSrn
ZJiR3ccs920xJMMNewF5i89wlYgI4LTm977QwArcliCdxY9aOWvAYTVQ2U2W6p6P8061OPL0u2Gw
WkTbDSYAdoue9VIlAxQR3wizhcCrvzt7vvYq04ZHKgHWBuShD+VIn++ENvNwSilMqL+cDEjWZFMN
Uet9EeL3Qzf1AnHSspsvz1I+2od1GVFajeRkyH6f6Q==
=j0hR
-----END PGP SIGNATURE-----

--------------b65gjEspzMDwS5OlTrjvWA1i--
