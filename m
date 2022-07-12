Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E50571F31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiGLPaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiGLPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:30:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585BD92865
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:30:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 10BEA20376;
        Tue, 12 Jul 2022 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657639803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZcOzATguMN201yo0KEpufnUqjbpa5VOh3F5suHdSu8=;
        b=UkrlMDDv5wJFt3k78mzNlxZALnxMFko2xQiHSMW2U6POuS3yj5Rafp60Pvt6iApYtBKAF7
        AjoMDq0XGz9zt7q1ZU0lUNV2JW5CbQMQnDznpAMRyTvnMmlNWd4ODvkOJdslAIFQQXGOTe
        vW60dtKI3snCfy7SFBkMQXoTh9fDjQ4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8BDC13A94;
        Tue, 12 Jul 2022 15:30:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2iUXK3qTzWKPegAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 12 Jul 2022 15:30:02 +0000
Message-ID: <7ff738f2-716f-f42a-2f92-3a7d94722d33@suse.com>
Date:   Tue, 12 Jul 2022 17:30:02 +0200
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
 <45fd7ade-61fe-18fa-aacc-ed80fdf3fb8d@suse.com>
 <3b228e55-53b6-beb8-7822-af03e65a078b@netscape.net>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
In-Reply-To: <3b228e55-53b6-beb8-7822-af03e65a078b@netscape.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0qcVuYOeBgyocpe774tTP9C3"
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
--------------0qcVuYOeBgyocpe774tTP9C3
Content-Type: multipart/mixed; boundary="------------bp5CP2emjMCpBr8uvIZiCwkL";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Chuck Zmudzinski <brchuckz@netscape.net>, Jan Beulich <jbeulich@suse.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Borislav Petkov <bp@alien8.de>
Message-ID: <7ff738f2-716f-f42a-2f92-3a7d94722d33@suse.com>
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
 <45fd7ade-61fe-18fa-aacc-ed80fdf3fb8d@suse.com>
 <3b228e55-53b6-beb8-7822-af03e65a078b@netscape.net>
In-Reply-To: <3b228e55-53b6-beb8-7822-af03e65a078b@netscape.net>

--------------bp5CP2emjMCpBr8uvIZiCwkL
Content-Type: multipart/mixed; boundary="------------hVsn0s000J25FiXUpIB0Bzg6"

--------------hVsn0s000J25FiXUpIB0Bzg6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDcuMjIgMTc6MDksIENodWNrIFptdWR6aW5za2kgd3JvdGU6DQo+IE9uIDcvMTIv
MjAyMiA5OjMyIEFNLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gT24gMTIuMDcuMjIgMTU6
MjIsIENodWNrIFptdWR6aW5za2kgd3JvdGU6DQo+Pj4gT24gNy8xMi8yMDIyIDI6MDQgQU0s
IEphbiBCZXVsaWNoIHdyb3RlOg0KPj4+PiBPbiAxMS4wNy4yMDIyIDE5OjQxLCBDaHVjayBa
bXVkemluc2tpIHdyb3RlOg0KPj4+Pj4gTW9yZW92ZXIuLi4gKHBsZWFzZSBtb3ZlIHRvIHRo
ZSBib3R0b20gb2YgdGhlIGNvZGUgc25pcHBldA0KPj4+Pj4gZm9yIG1vcmUgaW5mb3JtYXRp
b24gYWJvdXQgbXkgdGVzdHMgaW4gdGhlIFhlbiBQViBlbnZpcm9ubWVudC4uLikNCj4+Pj4+
DQo+Pj4+PiB2b2lkIGluaXRfY2FjaGVfbW9kZXModm9pZCkNCj4+Pj4+IHsNCj4+Pj4+ICAg
wqDCoCDCoHU2NCBwYXQgPSAwOw0KPj4+Pj4NCj4+Pj4+ICAgwqDCoCDCoGlmIChwYXRfY21f
aW5pdGlhbGl6ZWQpDQo+Pj4+PiAgIMKgwqAgwqDCoMKgwqAgcmV0dXJuOw0KPj4+Pj4NCj4+
Pj4+ICAgwqDCoCDCoGlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfUEFUKSkgew0KPj4+
Pj4gICDCoMKgIMKgwqDCoMKgIC8qDQo+Pj4+PiAgIMKgwqAgwqDCoMKgwqAgwqAqIENQVSBz
dXBwb3J0cyBQQVQuIFNldCBQQVQgdGFibGUgdG8gYmUgY29uc2lzdGVudCB3aXRoDQo+Pj4+
PiAgIMKgwqAgwqDCoMKgwqAgwqAqIFBBVCBNU1IuIFRoaXMgY2FzZSBzdXBwb3J0cyAibm9w
YXQiIGJvb3Qgb3B0aW9uLCBhbmQNCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCDCoCogdmlydHVh
bCBtYWNoaW5lIGVudmlyb25tZW50cyB3aGljaCBzdXBwb3J0IFBBVCB3aXRob3V0DQo+Pj4+
PiAgIMKgwqAgwqDCoMKgwqAgwqAqIE1UUlJzLiBJbiBzcGVjaWZpYywgWGVuIGhhcyB1bmlx
dWUgc2V0dXAgdG8gUEFUIE1TUi4NCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCDCoCoNCj4+Pj4+
ICAgwqDCoCDCoMKgwqDCoCDCoCogSWYgUEFUIE1TUiByZXR1cm5zIDAsIGl0IGlzIGNvbnNp
ZGVyZWQgaW52YWxpZCBhbmQgZW11bGF0ZXMNCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCDCoCog
YXMgTm8gUEFULg0KPj4+Pj4gICDCoMKgIMKgwqDCoMKgIMKgKi8NCj4+Pj4+ICAgwqDCoCDC
oMKgwqDCoCByZG1zcmwoTVNSX0lBMzJfQ1JfUEFULCBwYXQpOw0KPj4+Pj4gICDCoMKgIMKg
fQ0KPj4+Pj4NCj4+Pj4+ICAgwqDCoCDCoGlmICghcGF0KSB7DQo+Pj4+PiAgIMKgwqAgwqDC
oMKgwqAgLyoNCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCDCoCogTm8gUEFULiBFbXVsYXRlIHRo
ZSBQQVQgdGFibGUgdGhhdCBjb3JyZXNwb25kcyB0byB0aGUgdHdvDQo+Pj4+PiAgIMKgwqAg
wqDCoMKgwqAgwqAqIGNhY2hlIGJpdHMsIFBXVCAoV3JpdGUgVGhyb3VnaCkgYW5kIFBDRCAo
Q2FjaGUgRGlzYWJsZSkuDQo+Pj4+PiAgIMKgwqAgwqDCoMKgwqAgwqAqIFRoaXMgc2V0dXAg
aXMgYWxzbyB0aGUgc2FtZSBhcyB0aGUgQklPUyBkZWZhdWx0IHNldHVwLg0KPj4+Pj4gICDC
oMKgIMKgwqDCoMKgIMKgKg0KPj4+Pj4gICDCoMKgIMKgwqDCoMKgIMKgKiBQVEUgZW5jb2Rp
bmc6DQo+Pj4+PiAgIMKgwqAgwqDCoMKgwqAgwqAqDQo+Pj4+PiAgIMKgwqAgwqDCoMKgwqAg
wqAqwqDCoMKgwqDCoMKgIFBDRA0KPj4+Pj4gICDCoMKgIMKgwqDCoMKgIMKgKsKgwqDCoMKg
wqDCoCB8UFdUwqAgUEFUDQo+Pj4+PiAgIMKgwqAgwqDCoMKgwqAgwqAqwqDCoMKgwqDCoMKg
IHx8wqDCoMKgIHNsb3QNCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCDCoCrCoMKgwqDCoMKgwqAg
MDDCoMKgwqAgMMKgwqDCoCBXQiA6IF9QQUdFX0NBQ0hFX01PREVfV0INCj4+Pj4+ICAgwqDC
oCDCoMKgwqDCoCDCoCrCoMKgwqDCoMKgwqAgMDHCoMKgwqAgMcKgwqDCoCBXVCA6IF9QQUdF
X0NBQ0hFX01PREVfV1QNCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCDCoCrCoMKgwqDCoMKgwqAg
MTDCoMKgwqAgMsKgwqDCoCBVQy06IF9QQUdFX0NBQ0hFX01PREVfVUNfTUlOVVMNCj4+Pj4+
ICAgwqDCoCDCoMKgwqDCoCDCoCrCoMKgwqDCoMKgwqAgMTHCoMKgwqAgM8KgwqDCoCBVQyA6
IF9QQUdFX0NBQ0hFX01PREVfVUMNCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCDCoCoNCj4+Pj4+
ICAgwqDCoCDCoMKgwqDCoCDCoCogTk9URTogV2hlbiBXQyBvciBXUCBpcyB1c2VkLCBpdCBp
cyByZWRpcmVjdGVkIHRvIFVDLSBwZXINCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCDCoCogdGhl
IGRlZmF1bHQgc2V0dXAgaW4gX19jYWNoZW1vZGUycHRlX3RibFtdLg0KPj4+Pj4gICDCoMKg
IMKgwqDCoMKgIMKgKi8NCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCBwYXQgPSBQQVQoMCwgV0Ip
IHwgUEFUKDEsIFdUKSB8IFBBVCgyLCBVQ19NSU5VUykgfCBQQVQoMywgVUMpIHwNCj4+Pj4+
ICAgwqDCoCDCoMKgwqDCoCDCoMKgwqDCoMKgIFBBVCg0LCBXQikgfCBQQVQoNSwgV1QpIHwg
UEFUKDYsIFVDX01JTlVTKSB8IFBBVCg3LCBVQyk7DQo+Pj4+PiAgIMKgwqAgwqB9DQo+Pj4+
Pg0KPj4+Pj4gICDCoMKgIMKgZWxzZSBpZiAoIXBhdF9icF9lbmFibGVkKSB7DQo+Pj4+PiAg
IMKgwqAgwqDCoMKgwqAgLyoNCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCDCoCogSW4gc29tZSBl
bnZpcm9ubWVudHMsIHNwZWNpZmljYWxseSBYZW4gUFYsIFBBVA0KPj4+Pj4gICDCoMKgIMKg
wqDCoMKgIMKgKiBpbml0aWFsaXphdGlvbiBpcyBza2lwcGVkIGJlY2F1c2UgTVRSUnMgYXJl
DQo+Pj4+PiAgIMKgwqAgwqDCoMKgwqAgwqAqIGRpc2FibGVkIGV2ZW4gdGhvdWdoIFBBVCBp
cyBhdmFpbGFibGUuIEluIHN1Y2gNCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCDCoCogZW52aXJv
bm1lbnRzLCBzZXQgUEFUIHRvIGluaXRpYWxpemVkIGFuZCBlbmFibGVkIHRvDQo+Pj4+PiAg
IMKgwqAgwqDCoMKgwqAgwqAqIGNvcnJlY3RseSBpbmRpY2F0ZSB0byBjYWxsZXJzIG9mIHBh
dF9lbmFibGVkKCkgdGhhdA0KPj4+Pj4gICDCoMKgIMKgwqDCoMKgIMKgKiBQQVQgaXMgYXZh
aWxhYmxlIGFuZCBwcmV2ZW50IFBBVCBmcm9tIGJlaW5nIGRpc2FibGVkLg0KPj4+Pj4gICDC
oMKgIMKgwqDCoMKgIMKgKi8NCj4+Pj4+ICAgwqDCoCDCoMKgwqDCoCBwYXRfYnBfZW5hYmxl
ZCA9IHRydWU7DQo+Pj4+PiAgIMKgwqAgwqDCoMKgwqAgcHJfaW5mbygieDg2L1BBVDogUEFU
IGVuYWJsZWQgYnkgaW5pdF9jYWNoZV9tb2Rlc1xuIik7DQo+Pj4+PiAgIMKgwqAgwqB9DQo+
Pj4+Pg0KPj4+Pj4gICDCoMKgIMKgX19pbml0X2NhY2hlX21vZGVzKHBhdCk7DQo+Pj4+PiB9
DQo+Pj4+Pg0KPj4+Pj4gVGhpcyBmdW5jdGlvbiwgcGF0Y2hlZCB3aXRoIHRoZSBleHRyYSAn
ZWxzZSBpZicgYmxvY2ssIGZpeGVzIHRoZQ0KPj4+Pj4gcmVncmVzc2lvbiBvbiBteSBYZW4g
d29ya3NhdGF0aW9uLCBhbmQgdGhlIHByX2luZm8gbWVzc2FnZQ0KPj4+Pj4gIng4Ni9QQVQ6
IFBBVCBlbmFibGVkIGJ5IGluaXRfY2FjaGVfbW9kZXMiIGFwcGVhcnMgaW4gdGhlIGxvZ3MN
Cj4+Pj4+IHdoZW4gcnVubmluZyB0aGlzIHBhdGNoZWQga2VybmVsIGluIG15IFhlbiBEb20w
LiBUaGlzIG1lYW5zDQo+Pj4+PiB0aGF0IGluIHRoZSBYZW4gUFYgZW52aXJvbm1lbnQgb24g
bXkgWGVuIERvbTAgd29ya3N0YXRpb24sDQo+Pj4+PiByZG1zcmwoTVNSX0lBMzJfQ1JfUEFU
LCBwYXQpIHN1Y2Nlc3NmdWxseSB0ZXN0ZWQgZm9yIHRoZSBwcmVzZW5jZQ0KPj4+Pj4gb2Yg
UEFUIG9uIHRoZSB2aXJ0dWFsIENQVSB0aGF0IFhlbiBleHBvc2VkIHRvIHRoZSBMaW51eCBr
ZXJuZWwgb24gbXkNCj4+Pj4+IFhlbiBEb20wIHdvcmtzdGF0aW9uLiBBdCBsZWFzdCB0aGF0
IGlzIHdoYXQgSSB0aGluayBteSB0ZXN0cyBwcm92ZS4NCj4+Pj4+DQo+Pj4+PiBTbyB3aHkg
aXMgdGhpcyBub3QgYSB2YWxpZCB3YXkgdG8gdGVzdCBmb3IgdGhlIGV4aXN0ZW5jZSBvZg0K
Pj4+Pj4gUEFUIGluIHRoZSBYZW4gUFYgZW52aXJvbm1lbnQ/IEFyZSB0aGUgZXhpc3Rpbmcg
Y29tbWVudHMNCj4+Pj4+IGluIGluaXRfY2FjaGVfbW9kZXMoKSBhYm91dCBzdXBwb3J0aW5n
IGJvdGggdGhlIGNhc2Ugd2hlbg0KPj4+Pj4gdGhlICJub3BhdCIgYm9vdCBvcHRpb24gaXMg
c2V0IGFuZCB0aGUgc3BlY2lmaWMgY2FzZSBvZiBYZW4gYW5kDQo+Pj4+PiBNVFJSIGRpc2Fi
bGVkIHdyb25nPyBNeSB0ZXN0aW5nIGNvbmZpcm1zIHRob3NlIGNvbW1lbnRzIGFyZQ0KPj4+
Pj4gY29ycmVjdC4NCj4+Pj4NCj4+Pj4gQXQgdGhlIHZlcnkgbGVhc3QgdGhpcyBpZ25vcmVz
IHRoZSBwb3NzaWJsZSAibm9wYXQiIGFuIGFkbWluIG1heQ0KPj4+PiBoYXZlIHBhc3NlZCB0
byB0aGUga2VybmVsLg0KPj4+DQo+Pj4gSSByZWFsaXplIHRoYXQuIFRoZSBwYXRjaCBJIHBy
b3Bvc2VkIGhlcmUgb25seSBmaXhlcyB0aGUgcmVncmVzc2lvbi4gSXQNCj4+PiB3b3VsZCBi
ZSBlYXN5IHRvIGFsc28gbW9kaWZ5IHRoZSBwYXRjaCB0byBhbHNvIG9ic2VydmUgdGhlICdu
b3BhdCINCj4+PiBzZXR0aW5nLiBJIHRoaW5rIHlvdXIgcGF0Y2ggaGFkIGEgZm9yY2VfcGF0
X2Rpc2FibGUgbG9jYWwgdmFyaWFibGUgdGhhdA0KPj4+IGlzIHNldCBpZiBwYXQgaXMgZGlz
YWJsZWQgYnkgdGhlIGFkbWluaXN0cmF0b3Igd2l0aCAibm9wYXQuIiBXaXRoIHRoYXQNCj4+
PiB2YXJpYWJsZSBhdmFpbGFibGUsIG1vZGlmeWluZyB0aGUgcGF0Y2ggc28gaW4gaW5pdF9j
YWNoZV9tb2RlcyB3ZSBoYXZlOg0KPj4+DQo+Pj4gICDCoMKgwqDCoCBpZiAoIXBhdCB8fCBm
b3JjZV9wYXRfZGlzYWJsZSkgew0KPj4+ICAgwqDCoMKgwqDCoMKgwqDCoCAvKg0KPj4+ICAg
wqDCoMKgwqDCoMKgwqDCoMKgICogTm8gUEFULiBFbXVsYXRlIHRoZSBQQVQgdGFibGUgdGhh
dCBjb3JyZXNwb25kcyB0byB0aGUgdHdvDQo+Pj4NCj4+PiBJbnN0ZWFkIG9mOg0KPj4+DQo+
Pj4gICDCoMKgwqDCoCBpZiAoIXBhdCkgew0KPj4+ICAgwqDCoMKgwqDCoMKgwqDCoCAvKg0K
Pj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgICogTm8gUEFULiBFbXVsYXRlIHRoZSBQQVQgdGFi
bGUgdGhhdCBjb3JyZXNwb25kcyB0byB0aGUgdHdvDQo+Pj4NCj4+PiB3b3VsZCBjYXVzZSB0
aGUga2VybmVsIHRvIHJlc3BlY3QgdGhlICJub3BhdCIgc2V0dGluZyBieSB0aGUgYWRtaW5p
c3RyYXRvcg0KPj4+IGluIHRoZSBYZW4gUFYgRG9tMCBlbnZpcm9ubWVudC4NCj4+DQo+PiBD
aHVjaywgY291bGQgeW91IHBsZWFzZSBzZW5kIG91dCBhIHByb3BlciBwYXRjaCB3aXRoIHlv
dXIgaW5pdGlhbCBmaXgNCj4+IChzZXR0aW5nIHBhdF9icF9lbmFibGVkKSBhbmQgdGhlIGZp
eCBhYm92ZT8NCj4+DQo+PiBJJ3ZlIGNoYXR0ZWQgd2l0aCBCb3JpcyBQZXRrb3Ygb24gSVJD
IGFuZCBoZSBpcyBmaW5lIHdpdGggdGhhdC4NCj4gDQo+IFRoYXQncyBncmVhdCwgSSB3aWxs
IHN1Ym1pdCBhIGZvcm1hbCBwYXRjaCBsYXRlciB0b2RheS4NCj4gDQo+Pg0KPj4+IEkgYWdy
ZWUgdGhpcyBuZWVkcyB0byBiZSBmaXhlZCB1cCwgYmVjYXVzZSBjdXJyZW50bHkgdGhlIGNv
ZGUgaXMgdmVyeQ0KPj4+IGNvbmZ1c2luZyBhbmQgdGhlIGN1cnJlbnQgdmFyaWFibGUgbmFt
ZXMgYW5kIGZ1bmN0aW9uIG5hbWVzIGRvIG5vdA0KPj4+IGFsd2F5cyBhY2N1cmF0ZWx5IGRl
c2NyaWJlIHdoYXQgdGhleSBhY3R1YWxseSBkbyBpbiB0aGUgY29kZS4gVGhhdCBpcw0KPj4+
IHdoeSBJIGFtIHdvcmtpbmcgb24gYSBwYXRjaCB0byBkbyBzb21lIHJlLWZhY3RvcmluZywg
d2hpY2ggb25seSBjb25zaXN0cw0KPj4+IG9mIGZ1bmN0aW9uIGFuZCB2YXJpYWJsZSBuYW1l
IGNoYW5nZXMgYW5kIGNvbW1lbnQgY2hhbmdlcyB0byBmaXgNCj4+PiB0aGUgcGxhY2VzIHdo
ZXJlIHRoZSBjb21tZW50cyBpbiB0aGUgY29kZSBhcmUgbWlzbGVhZGluZyBvciBpbmNvbXBs
ZXRlLg0KPj4NCj4+IEJvcmlzIGFuZCBJIGFncmVlZCB0byBwdXJzdWUgbXkgYXBwcm9hY2gg
ZnVydGhlciBieSByZW1vdmluZyB0aGUNCj4+IGRlcGVuZGVuY3kgYmV0d2VlbiBQQVQgYW5k
IE1UUlIgYW5kIHRvIG1ha2UgdGhpcyB3aG9sZSBtZXNzIG1vcmUNCj4+IGNsZWFyLg0KPj4N
Cj4+IEkgd2lsbCBzdGFydCB0byB3b3JrIG9uIHRoaXMgYXMgc29vbiBhcyBwb3NzaWJsZSwg
d2hpY2ggd2lsbA0KPj4gcHJvYmFibHkgYmUgc29tZSB0aW1lIGluIFNlcHRlbWJlci4NCj4g
DQo+IEdvb2QsIEkgd2lsbCBsb29rIGZvciB5b3VyIHBhdGNoZXMgYW5kIHRyeSB0aGVtIG91
dC4NCj4gDQo+Pg0KPj4+IEkgdGhpbmsgcGVyaGFwcyB0aGUgbW9zdCBtaXNuYW1lZCB2YXJp
YWJsZSBoZXJlIGlzIHRoZcKgIGxvY2FsDQo+Pj4gdmFyaWFibGUgcGF0X2Rpc2FibGVkIGlu
IG1lbXR5cGVzLmMgYW5kIHRoZSBtb3N0IG1pc25hbWVkIGZ1bmN0aW9uIGlzIHRoZQ0KPj4+
IHBhdF9kaXNhYmxlIGZ1bmN0aW9uIGluIG1lbXR5cGVzLmMuIFRoZXkgc2hvdWxkIGJlIG5h
bWVkIHBhdF9pbml0X2Rpc2FibGVkDQo+Pj4gYW5kIHBhdF9pbml0X2Rpc2FibGUsIHJlc3Bl
Y3RpdmVseSwgYmVjYXVzZSB0aGV5IGRvIG5vdCByZWFsbHkgZGlzYWJsZQ0KPj4+IFBBVCBp
bg0KPj4+IHRoZSBjb2RlIGJ1dCBvbmx5IHByZXZlbnQgZXhlY3V0aW9uIG9mIHRoZSBwYXRf
aW5pdCBmdW5jdGlvbi4gVGhhdA0KPj4+IGxlYXZlcyBvcGVuDQo+Pj4gdGhlIHBvc3NpYmls
aXR5IGZvciBQQVQgdG8gYmUgZW5hYmxlZCBieSBpbml0X2NhY2hlX21vZGVzLCB3aGljaCBh
Y3R1YWxseQ0KPj4+IG9jY3VycyBpbiB0aGUgY3VycmVudCBjb2RlIGluIHRoZSBYZW4gUFYg
RG9tMCBlbnZpcm9ubWVudCwgYnV0IHRoZSBjdXJyZW50DQo+Pj4gY29kZSBuZWdsZWN0cyB0
byBzZXQgcGF0X2JwX2VuYWJsZWQgdG8gdHJ1ZSBpbiB0aGF0IGNhc2UuIFNvIHdlIG5lZWQg
YSBwYXRjaA0KPj4+IHRvIGZpeCB0aGF0IGluIG9yZGVyIHRvIGZpeCB0aGUgcmVncmVzc2lv
bi4NCj4+DQo+PiBJbiBwcmluY2lwbGUgSSBhZ3JlZSwgYnV0IHlvdSBzaG91bGQgYmUgYXdh
cmUgb2YgbXkgcmVmYWN0b3JpbmcgcGxhbnMuDQo+IA0KPiBJIHdpbGwgZGVmZXIgdG8geW91
IGFuZCBzdG9wIHdvcmtpbmcgb24gdGhpcyByZS1mYWN0b3JpbmcgZWZmb3J0LCBidXQgSQ0K
PiB3aWxsIHByZXBhcmUgYSBmb3JtYWwgcGF0Y2ggdG8gZml4IHRoZSByZWdyZXNzaW9uIGxh
dGVyIHRvZGF5Lg0KPiANCj4gSSBkbyB0aGluayBKYW4ncyBwb2ludCBhYm91dCByZXNwZWN0
aW5nIHRoZSBhZG1pbmlzdHJhdG9yJ3MgIm5vcGF0IiBzZXR0aW5nDQo+IHNob3VsZCBhbHNv
IGJlIGNvbnNpZGVyZWQuIEFGQUlDVCwgdGhlICJub3BhdCIgb3B0aW9uIGluIGN1cnJlbnQg
Y29kZQ0KDQpZZXMsIHBsZWFzZSBhZGQgdGhhdCwgdG9vLiBUaGlzIHdhcyB3aGF0IEkgbWVh
bnQgd2l0aCAidGhlIGZpeCBhYm92ZSIuDQoNCj4gaXMgYWxzbyBub3QgYmVpbmcgcmVzcGVj
dGVkIG9uIHRoZSBiYXJlIG1ldGFsLCBhbmQgdGhlIHBhdGNoIHRvDQo+IGluaXRfY2FjaGVf
bW9kZXMgd2l0aCBhIGZvcmNlX25vX3BhdCB2YXJpYWJsZSBpcyBhbHNvIG5lZWRlZCB0bw0K
PiBlbnN1cmUgIm5vcGF0IiBpcyByZXNwZWN0ZWQgb24gdGhlIGJhcmUgbWV0YWwsIEFGQUlD
VC4NCg0KSG1tLCBJIGRvbid0IHNlZSBob3cgdGhlIFBBVCBNU1Igd2lsbCBiZSB3cml0dGVu
IG9uIGJhcmUgbWV0YWwgd2hlbiAibm9wYXQiDQpoYXMgYmVlbiBzcGVjaWZpZWQuDQoNCkkg
anVzdCB0cmllZCBpdCB3aXRoIGEgNS4xOSBrZXJuZWwgYW5kIGl0IGJvb3RlZCB3aXRoIHRo
ZSBjb3JyZWN0IFBBVA0Kc2V0dGluZ3M6DQoNClsgICAgMC4wMDAwMDBdIHg4Ni9QQVQ6IFBB
VCBzdXBwb3J0IGRpc2FibGVkIHZpYSBib290IG9wdGlvbi4NClsgICAgMC4wMDA5ODZdIHg4
Ni9QQVQ6IENvbmZpZ3VyYXRpb24gWzAtN106IFdCICBXVCAgVUMtIFVDICBXQiAgV1QgIFVD
LSBVQw0KDQoNCkp1ZXJnZW4NCg==
--------------hVsn0s000J25FiXUpIB0Bzg6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------hVsn0s000J25FiXUpIB0Bzg6--

--------------bp5CP2emjMCpBr8uvIZiCwkL--

--------------0qcVuYOeBgyocpe774tTP9C3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmLNk3oFAwAAAAAACgkQsN6d1ii/Ey+5
3Qf/ZqJUOehzN/hZi7dtx2aMUa11580pqFAiPtLTcv8wMfAoicVI2MxOpa6Gq14qhKwvSKOLyZte
QvCTmTsUm3KPU8UGTJ196gIBJeI3EclGOkY0hoKj1eQ79mlzJ9JeXHWzx9Hux3aDfU6ngTcDLZEb
E0f0nUM4GEyTNWm+sYKAbrZO1KHQZTKuCqxEz3Sw1h0m6LoCH25XMTgYGDCZG1Mo9l5pLrSgktje
IWAdrbtcf82kzTzRjh3DUKVxQ/oOt7/LlTzUwStqFPjwZDJGdu0Tiz86AxNSeERYnkgv+dyMqYkq
1Js6SrMu3ATdm81cWVUQosxb6a6s4Rq/zjNIokuxbQ==
=2nyO
-----END PGP SIGNATURE-----

--------------0qcVuYOeBgyocpe774tTP9C3--
