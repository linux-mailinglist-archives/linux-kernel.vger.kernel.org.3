Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17783571B59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiGLNcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiGLNco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:32:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6CEB7D4E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:32:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8511022DC3;
        Tue, 12 Jul 2022 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657632758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2XsGBbxyNSX2WkHwSgKDNm6sf7LFWFkHBdhoK1F0MUA=;
        b=h5nunqLhBHNkBuPLaV17VUp9LNZu/ZN4qDoZYhP5RMyC/tkQ2Kc5ZcCqIKAAGM1o3r5GuN
        D7uRttJT0pKS8G6zDda5ABZqtUJiqTAlg76BCTKi38Q4jSMzS0Lmlq8uCRvQQBhg65MEsp
        R80DjI3i83ESStjmq6ncdQPg7Du5HBU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43D2513A94;
        Tue, 12 Jul 2022 13:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9yavDvZ3zWI9RgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 12 Jul 2022 13:32:38 +0000
Message-ID: <45fd7ade-61fe-18fa-aacc-ed80fdf3fb8d@suse.com>
Date:   Tue, 12 Jul 2022 15:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Chuck Zmudzinski <brchuckz@netscape.net>,
        Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Borislav Petkov <bp@alien8.de>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic> <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
 <4e099e2d-e429-252b-ceeb-678066d85e61@netscape.net>
 <aa8f99dc-e622-398e-1a68-6b060497e4b3@suse.com>
 <d49e87a0-417d-194d-daa1-952f707f096c@netscape.net>
 <6afa42fd-469d-5b08-1688-5af8a3c9d8fa@suse.com>
 <8011dff1-6551-898f-7e37-38ede106e2f4@netscape.net>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
In-Reply-To: <8011dff1-6551-898f-7e37-38ede106e2f4@netscape.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BMygs5DS03pxlw5GpFihyWpe"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BMygs5DS03pxlw5GpFihyWpe
Content-Type: multipart/mixed; boundary="------------qUq0m33xBxWW0oopzVEN4rd5";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Chuck Zmudzinski <brchuckz@netscape.net>, Jan Beulich <jbeulich@suse.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Borislav Petkov <bp@alien8.de>
Message-ID: <45fd7ade-61fe-18fa-aacc-ed80fdf3fb8d@suse.com>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <YsRTAGI2PhfZ5V7M@zn.tnic> <016d281b-7e40-f1bd-66ee-c19c3cc56efe@suse.com>
 <YsRjX/U1XN8rq+8u@zn.tnic>
 <4e099e2d-e429-252b-ceeb-678066d85e61@netscape.net>
 <aa8f99dc-e622-398e-1a68-6b060497e4b3@suse.com>
 <d49e87a0-417d-194d-daa1-952f707f096c@netscape.net>
 <6afa42fd-469d-5b08-1688-5af8a3c9d8fa@suse.com>
 <8011dff1-6551-898f-7e37-38ede106e2f4@netscape.net>
In-Reply-To: <8011dff1-6551-898f-7e37-38ede106e2f4@netscape.net>

--------------qUq0m33xBxWW0oopzVEN4rd5
Content-Type: multipart/mixed; boundary="------------VgW9HN3nCc3re0erqMuhpFcc"

--------------VgW9HN3nCc3re0erqMuhpFcc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDcuMjIgMTU6MjIsIENodWNrIFptdWR6aW5za2kgd3JvdGU6DQo+IE9uIDcvMTIv
MjAyMiAyOjA0IEFNLCBKYW4gQmV1bGljaCB3cm90ZToNCj4+IE9uIDExLjA3LjIwMjIgMTk6
NDEsIENodWNrIFptdWR6aW5za2kgd3JvdGU6DQo+Pj4gTW9yZW92ZXIuLi4gKHBsZWFzZSBt
b3ZlIHRvIHRoZSBib3R0b20gb2YgdGhlIGNvZGUgc25pcHBldA0KPj4+IGZvciBtb3JlIGlu
Zm9ybWF0aW9uIGFib3V0IG15IHRlc3RzIGluIHRoZSBYZW4gUFYgZW52aXJvbm1lbnQuLi4p
DQo+Pj4NCj4+PiB2b2lkIGluaXRfY2FjaGVfbW9kZXModm9pZCkNCj4+PiB7DQo+Pj4gIMKg
wqAgwqB1NjQgcGF0ID0gMDsNCj4+Pg0KPj4+ICDCoMKgIMKgaWYgKHBhdF9jbV9pbml0aWFs
aXplZCkNCj4+PiAgwqDCoCDCoMKgwqDCoCByZXR1cm47DQo+Pj4NCj4+PiAgwqDCoCDCoGlm
IChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfUEFUKSkgew0KPj4+ICDCoMKgIMKgwqDCoMKg
IC8qDQo+Pj4gIMKgwqAgwqDCoMKgwqAgwqAqIENQVSBzdXBwb3J0cyBQQVQuIFNldCBQQVQg
dGFibGUgdG8gYmUgY29uc2lzdGVudCB3aXRoDQo+Pj4gIMKgwqAgwqDCoMKgwqAgwqAqIFBB
VCBNU1IuIFRoaXMgY2FzZSBzdXBwb3J0cyAibm9wYXQiIGJvb3Qgb3B0aW9uLCBhbmQNCj4+
PiAgwqDCoCDCoMKgwqDCoCDCoCogdmlydHVhbCBtYWNoaW5lIGVudmlyb25tZW50cyB3aGlj
aCBzdXBwb3J0IFBBVCB3aXRob3V0DQo+Pj4gIMKgwqAgwqDCoMKgwqAgwqAqIE1UUlJzLiBJ
biBzcGVjaWZpYywgWGVuIGhhcyB1bmlxdWUgc2V0dXAgdG8gUEFUIE1TUi4NCj4+PiAgwqDC
oCDCoMKgwqDCoCDCoCoNCj4+PiAgwqDCoCDCoMKgwqDCoCDCoCogSWYgUEFUIE1TUiByZXR1
cm5zIDAsIGl0IGlzIGNvbnNpZGVyZWQgaW52YWxpZCBhbmQgZW11bGF0ZXMNCj4+PiAgwqDC
oCDCoMKgwqDCoCDCoCogYXMgTm8gUEFULg0KPj4+ICDCoMKgIMKgwqDCoMKgIMKgKi8NCj4+
PiAgwqDCoCDCoMKgwqDCoCByZG1zcmwoTVNSX0lBMzJfQ1JfUEFULCBwYXQpOw0KPj4+ICDC
oMKgIMKgfQ0KPj4+DQo+Pj4gIMKgwqAgwqBpZiAoIXBhdCkgew0KPj4+ICDCoMKgIMKgwqDC
oMKgIC8qDQo+Pj4gIMKgwqAgwqDCoMKgwqAgwqAqIE5vIFBBVC4gRW11bGF0ZSB0aGUgUEFU
IHRhYmxlIHRoYXQgY29ycmVzcG9uZHMgdG8gdGhlIHR3bw0KPj4+ICDCoMKgIMKgwqDCoMKg
IMKgKiBjYWNoZSBiaXRzLCBQV1QgKFdyaXRlIFRocm91Z2gpIGFuZCBQQ0QgKENhY2hlIERp
c2FibGUpLg0KPj4+ICDCoMKgIMKgwqDCoMKgIMKgKiBUaGlzIHNldHVwIGlzIGFsc28gdGhl
IHNhbWUgYXMgdGhlIEJJT1MgZGVmYXVsdCBzZXR1cC4NCj4+PiAgwqDCoCDCoMKgwqDCoCDC
oCoNCj4+PiAgwqDCoCDCoMKgwqDCoCDCoCogUFRFIGVuY29kaW5nOg0KPj4+ICDCoMKgIMKg
wqDCoMKgIMKgKg0KPj4+ICDCoMKgIMKgwqDCoMKgIMKgKsKgwqDCoMKgwqDCoCBQQ0QNCj4+
PiAgwqDCoCDCoMKgwqDCoCDCoCrCoMKgwqDCoMKgwqAgfFBXVMKgIFBBVA0KPj4+ICDCoMKg
IMKgwqDCoMKgIMKgKsKgwqDCoMKgwqDCoCB8fMKgwqDCoCBzbG90DQo+Pj4gIMKgwqAgwqDC
oMKgwqAgwqAqwqDCoMKgwqDCoMKgIDAwwqDCoMKgIDDCoMKgwqAgV0IgOiBfUEFHRV9DQUNI
RV9NT0RFX1dCDQo+Pj4gIMKgwqAgwqDCoMKgwqAgwqAqwqDCoMKgwqDCoMKgIDAxwqDCoMKg
IDHCoMKgwqAgV1QgOiBfUEFHRV9DQUNIRV9NT0RFX1dUDQo+Pj4gIMKgwqAgwqDCoMKgwqAg
wqAqwqDCoMKgwqDCoMKgIDEwwqDCoMKgIDLCoMKgwqAgVUMtOiBfUEFHRV9DQUNIRV9NT0RF
X1VDX01JTlVTDQo+Pj4gIMKgwqAgwqDCoMKgwqAgwqAqwqDCoMKgwqDCoMKgIDExwqDCoMKg
IDPCoMKgwqAgVUMgOiBfUEFHRV9DQUNIRV9NT0RFX1VDDQo+Pj4gIMKgwqAgwqDCoMKgwqAg
wqAqDQo+Pj4gIMKgwqAgwqDCoMKgwqAgwqAqIE5PVEU6IFdoZW4gV0Mgb3IgV1AgaXMgdXNl
ZCwgaXQgaXMgcmVkaXJlY3RlZCB0byBVQy0gcGVyDQo+Pj4gIMKgwqAgwqDCoMKgwqAgwqAq
IHRoZSBkZWZhdWx0IHNldHVwIGluIF9fY2FjaGVtb2RlMnB0ZV90YmxbXS4NCj4+PiAgwqDC
oCDCoMKgwqDCoCDCoCovDQo+Pj4gIMKgwqAgwqDCoMKgwqAgcGF0ID0gUEFUKDAsIFdCKSB8
IFBBVCgxLCBXVCkgfCBQQVQoMiwgVUNfTUlOVVMpIHwgUEFUKDMsIFVDKSB8DQo+Pj4gIMKg
wqAgwqDCoMKgwqAgwqDCoMKgwqDCoCBQQVQoNCwgV0IpIHwgUEFUKDUsIFdUKSB8IFBBVCg2
LCBVQ19NSU5VUykgfCBQQVQoNywgVUMpOw0KPj4+ICDCoMKgIMKgfQ0KPj4+DQo+Pj4gIMKg
wqAgwqBlbHNlIGlmICghcGF0X2JwX2VuYWJsZWQpIHsNCj4+PiAgwqDCoCDCoMKgwqDCoCAv
Kg0KPj4+ICDCoMKgIMKgwqDCoMKgIMKgKiBJbiBzb21lIGVudmlyb25tZW50cywgc3BlY2lm
aWNhbGx5IFhlbiBQViwgUEFUDQo+Pj4gIMKgwqAgwqDCoMKgwqAgwqAqIGluaXRpYWxpemF0
aW9uIGlzIHNraXBwZWQgYmVjYXVzZSBNVFJScyBhcmUNCj4+PiAgwqDCoCDCoMKgwqDCoCDC
oCogZGlzYWJsZWQgZXZlbiB0aG91Z2ggUEFUIGlzIGF2YWlsYWJsZS4gSW4gc3VjaA0KPj4+
ICDCoMKgIMKgwqDCoMKgIMKgKiBlbnZpcm9ubWVudHMsIHNldCBQQVQgdG8gaW5pdGlhbGl6
ZWQgYW5kIGVuYWJsZWQgdG8NCj4+PiAgwqDCoCDCoMKgwqDCoCDCoCogY29ycmVjdGx5IGlu
ZGljYXRlIHRvIGNhbGxlcnMgb2YgcGF0X2VuYWJsZWQoKSB0aGF0DQo+Pj4gIMKgwqAgwqDC
oMKgwqAgwqAqIFBBVCBpcyBhdmFpbGFibGUgYW5kIHByZXZlbnQgUEFUIGZyb20gYmVpbmcg
ZGlzYWJsZWQuDQo+Pj4gIMKgwqAgwqDCoMKgwqAgwqAqLw0KPj4+ICDCoMKgIMKgwqDCoMKg
IHBhdF9icF9lbmFibGVkID0gdHJ1ZTsNCj4+PiAgwqDCoCDCoMKgwqDCoCBwcl9pbmZvKCJ4
ODYvUEFUOiBQQVQgZW5hYmxlZCBieSBpbml0X2NhY2hlX21vZGVzXG4iKTsNCj4+PiAgwqDC
oCDCoH0NCj4+Pg0KPj4+ICDCoMKgIMKgX19pbml0X2NhY2hlX21vZGVzKHBhdCk7DQo+Pj4g
fQ0KPj4+DQo+Pj4gVGhpcyBmdW5jdGlvbiwgcGF0Y2hlZCB3aXRoIHRoZSBleHRyYSAnZWxz
ZSBpZicgYmxvY2ssIGZpeGVzIHRoZQ0KPj4+IHJlZ3Jlc3Npb24gb24gbXkgWGVuIHdvcmtz
YXRhdGlvbiwgYW5kIHRoZSBwcl9pbmZvIG1lc3NhZ2UNCj4+PiAieDg2L1BBVDogUEFUIGVu
YWJsZWQgYnkgaW5pdF9jYWNoZV9tb2RlcyIgYXBwZWFycyBpbiB0aGUgbG9ncw0KPj4+IHdo
ZW4gcnVubmluZyB0aGlzIHBhdGNoZWQga2VybmVsIGluIG15IFhlbiBEb20wLiBUaGlzIG1l
YW5zDQo+Pj4gdGhhdCBpbiB0aGUgWGVuIFBWIGVudmlyb25tZW50IG9uIG15IFhlbiBEb20w
IHdvcmtzdGF0aW9uLA0KPj4+IHJkbXNybChNU1JfSUEzMl9DUl9QQVQsIHBhdCkgc3VjY2Vz
c2Z1bGx5IHRlc3RlZCBmb3IgdGhlIHByZXNlbmNlDQo+Pj4gb2YgUEFUIG9uIHRoZSB2aXJ0
dWFsIENQVSB0aGF0IFhlbiBleHBvc2VkIHRvIHRoZSBMaW51eCBrZXJuZWwgb24gbXkNCj4+
PiBYZW4gRG9tMCB3b3Jrc3RhdGlvbi4gQXQgbGVhc3QgdGhhdCBpcyB3aGF0IEkgdGhpbmsg
bXkgdGVzdHMgcHJvdmUuDQo+Pj4NCj4+PiBTbyB3aHkgaXMgdGhpcyBub3QgYSB2YWxpZCB3
YXkgdG8gdGVzdCBmb3IgdGhlIGV4aXN0ZW5jZSBvZg0KPj4+IFBBVCBpbiB0aGUgWGVuIFBW
IGVudmlyb25tZW50PyBBcmUgdGhlIGV4aXN0aW5nIGNvbW1lbnRzDQo+Pj4gaW4gaW5pdF9j
YWNoZV9tb2RlcygpIGFib3V0IHN1cHBvcnRpbmcgYm90aCB0aGUgY2FzZSB3aGVuDQo+Pj4g
dGhlICJub3BhdCIgYm9vdCBvcHRpb24gaXMgc2V0IGFuZCB0aGUgc3BlY2lmaWMgY2FzZSBv
ZiBYZW4gYW5kDQo+Pj4gTVRSUiBkaXNhYmxlZCB3cm9uZz8gTXkgdGVzdGluZyBjb25maXJt
cyB0aG9zZSBjb21tZW50cyBhcmUNCj4+PiBjb3JyZWN0Lg0KPj4NCj4+IEF0IHRoZSB2ZXJ5
IGxlYXN0IHRoaXMgaWdub3JlcyB0aGUgcG9zc2libGUgIm5vcGF0IiBhbiBhZG1pbiBtYXkN
Cj4+IGhhdmUgcGFzc2VkIHRvIHRoZSBrZXJuZWwuDQo+IA0KPiBJIHJlYWxpemUgdGhhdC4g
VGhlIHBhdGNoIEkgcHJvcG9zZWQgaGVyZSBvbmx5IGZpeGVzIHRoZSByZWdyZXNzaW9uLiBJ
dA0KPiB3b3VsZCBiZSBlYXN5IHRvIGFsc28gbW9kaWZ5IHRoZSBwYXRjaCB0byBhbHNvIG9i
c2VydmUgdGhlICdub3BhdCINCj4gc2V0dGluZy4gSSB0aGluayB5b3VyIHBhdGNoIGhhZCBh
IGZvcmNlX3BhdF9kaXNhYmxlIGxvY2FsIHZhcmlhYmxlIHRoYXQNCj4gaXMgc2V0IGlmIHBh
dCBpcyBkaXNhYmxlZCBieSB0aGUgYWRtaW5pc3RyYXRvciB3aXRoICJub3BhdC4iIFdpdGgg
dGhhdA0KPiB2YXJpYWJsZSBhdmFpbGFibGUsIG1vZGlmeWluZyB0aGUgcGF0Y2ggc28gaW4g
aW5pdF9jYWNoZV9tb2RlcyB3ZSBoYXZlOg0KPiANCj4gIMKgwqDCoMKgIGlmICghcGF0IHx8
IGZvcmNlX3BhdF9kaXNhYmxlKSB7DQo+ICDCoMKgwqDCoMKgwqDCoMKgIC8qDQo+ICDCoMKg
wqDCoMKgwqDCoMKgwqAgKiBObyBQQVQuIEVtdWxhdGUgdGhlIFBBVCB0YWJsZSB0aGF0IGNv
cnJlc3BvbmRzIHRvIHRoZSB0d28NCj4gDQo+IEluc3RlYWQgb2Y6DQo+IA0KPiAgwqDCoMKg
wqAgaWYgKCFwYXQpIHsNCj4gIMKgwqDCoMKgwqDCoMKgwqAgLyoNCj4gIMKgwqDCoMKgwqDC
oMKgwqDCoCAqIE5vIFBBVC4gRW11bGF0ZSB0aGUgUEFUIHRhYmxlIHRoYXQgY29ycmVzcG9u
ZHMgdG8gdGhlIHR3bw0KPiANCj4gd291bGQgY2F1c2UgdGhlIGtlcm5lbCB0byByZXNwZWN0
IHRoZSAibm9wYXQiIHNldHRpbmcgYnkgdGhlIGFkbWluaXN0cmF0b3INCj4gaW4gdGhlIFhl
biBQViBEb20wIGVudmlyb25tZW50Lg0KDQpDaHVjaywgY291bGQgeW91IHBsZWFzZSBzZW5k
IG91dCBhIHByb3BlciBwYXRjaCB3aXRoIHlvdXIgaW5pdGlhbCBmaXgNCihzZXR0aW5nIHBh
dF9icF9lbmFibGVkKSBhbmQgdGhlIGZpeCBhYm92ZT8NCg0KSSd2ZSBjaGF0dGVkIHdpdGgg
Qm9yaXMgUGV0a292IG9uIElSQyBhbmQgaGUgaXMgZmluZSB3aXRoIHRoYXQuDQoNCj4gSSBh
Z3JlZSB0aGlzIG5lZWRzIHRvIGJlIGZpeGVkIHVwLCBiZWNhdXNlIGN1cnJlbnRseSB0aGUg
Y29kZSBpcyB2ZXJ5DQo+IGNvbmZ1c2luZyBhbmQgdGhlIGN1cnJlbnQgdmFyaWFibGUgbmFt
ZXMgYW5kIGZ1bmN0aW9uIG5hbWVzIGRvIG5vdA0KPiBhbHdheXMgYWNjdXJhdGVseSBkZXNj
cmliZSB3aGF0IHRoZXkgYWN0dWFsbHkgZG8gaW4gdGhlIGNvZGUuIFRoYXQgaXMNCj4gd2h5
IEkgYW0gd29ya2luZyBvbiBhIHBhdGNoIHRvIGRvIHNvbWUgcmUtZmFjdG9yaW5nLCB3aGlj
aCBvbmx5IGNvbnNpc3RzDQo+IG9mIGZ1bmN0aW9uIGFuZCB2YXJpYWJsZSBuYW1lIGNoYW5n
ZXMgYW5kIGNvbW1lbnQgY2hhbmdlcyB0byBmaXgNCj4gdGhlIHBsYWNlcyB3aGVyZSB0aGUg
Y29tbWVudHMgaW4gdGhlIGNvZGUgYXJlIG1pc2xlYWRpbmcgb3IgaW5jb21wbGV0ZS4NCg0K
Qm9yaXMgYW5kIEkgYWdyZWVkIHRvIHB1cnN1ZSBteSBhcHByb2FjaCBmdXJ0aGVyIGJ5IHJl
bW92aW5nIHRoZQ0KZGVwZW5kZW5jeSBiZXR3ZWVuIFBBVCBhbmQgTVRSUiBhbmQgdG8gbWFr
ZSB0aGlzIHdob2xlIG1lc3MgbW9yZQ0KY2xlYXIuDQoNCkkgd2lsbCBzdGFydCB0byB3b3Jr
IG9uIHRoaXMgYXMgc29vbiBhcyBwb3NzaWJsZSwgd2hpY2ggd2lsbA0KcHJvYmFibHkgYmUg
c29tZSB0aW1lIGluIFNlcHRlbWJlci4NCg0KPiBJIHRoaW5rIHBlcmhhcHMgdGhlIG1vc3Qg
bWlzbmFtZWQgdmFyaWFibGUgaGVyZSBpcyB0aGXCoCBsb2NhbA0KPiB2YXJpYWJsZSBwYXRf
ZGlzYWJsZWQgaW4gbWVtdHlwZXMuYyBhbmQgdGhlIG1vc3QgbWlzbmFtZWQgZnVuY3Rpb24g
aXMgdGhlDQo+IHBhdF9kaXNhYmxlIGZ1bmN0aW9uIGluIG1lbXR5cGVzLmMuIFRoZXkgc2hv
dWxkIGJlIG5hbWVkIHBhdF9pbml0X2Rpc2FibGVkDQo+IGFuZCBwYXRfaW5pdF9kaXNhYmxl
LCByZXNwZWN0aXZlbHksIGJlY2F1c2UgdGhleSBkbyBub3QgcmVhbGx5IGRpc2FibGUNCj4g
UEFUIGluDQo+IHRoZSBjb2RlIGJ1dCBvbmx5IHByZXZlbnQgZXhlY3V0aW9uIG9mIHRoZSBw
YXRfaW5pdCBmdW5jdGlvbi4gVGhhdA0KPiBsZWF2ZXMgb3Blbg0KPiB0aGUgcG9zc2liaWxp
dHkgZm9yIFBBVCB0byBiZSBlbmFibGVkIGJ5IGluaXRfY2FjaGVfbW9kZXMsIHdoaWNoIGFj
dHVhbGx5DQo+IG9jY3VycyBpbiB0aGUgY3VycmVudCBjb2RlIGluIHRoZSBYZW4gUFYgRG9t
MCBlbnZpcm9ubWVudCwgYnV0IHRoZSBjdXJyZW50DQo+IGNvZGUgbmVnbGVjdHMgdG8gc2V0
IHBhdF9icF9lbmFibGVkIHRvIHRydWUgaW4gdGhhdCBjYXNlLiBTbyB3ZSBuZWVkIGEgcGF0
Y2gNCj4gdG8gZml4IHRoYXQgaW4gb3JkZXIgdG8gZml4IHRoZSByZWdyZXNzaW9uLg0KDQpJ
biBwcmluY2lwbGUgSSBhZ3JlZSwgYnV0IHlvdSBzaG91bGQgYmUgYXdhcmUgb2YgbXkgcmVm
YWN0b3JpbmcgcGxhbnMuDQoNCg0KSnVlcmdlbg0KDQo=
--------------VgW9HN3nCc3re0erqMuhpFcc
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------VgW9HN3nCc3re0erqMuhpFcc--

--------------qUq0m33xBxWW0oopzVEN4rd5--

--------------BMygs5DS03pxlw5GpFihyWpe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmLNd/UFAwAAAAAACgkQsN6d1ii/Ey/X
Jgf+LjLb8OGQorltvt/l2MrjmUzcCLfgjzsdlE4OfYFdyw3PKQ+Fyvfr1W4G9qLFInX8AZGgoaor
YaewHZgAfAlE6eGZw+6Fpavo6jBopOgA+RFAi2HIFXlFETxaKgRe2G7AAbVa71ztnlfXv0BOCLgi
I/+gLKoT7mWes9f+BRkfhUOfQrvdOdh/ia4paZn5iqK9YpuUoz6BmuNA3NWYktXEmctpL/x6CkPE
F449pjVw5sFAKmpRbrRc7B0I5gw+n0uzlqtjcoXYA1szzMCZHFTVSD+9DjFO0VQynNMfRx9sbcdM
4kfxRv4d7kP1I+uIlwBEIb26truy6KIp3rCamq79UA==
=VZLZ
-----END PGP SIGNATURE-----

--------------BMygs5DS03pxlw5GpFihyWpe--
