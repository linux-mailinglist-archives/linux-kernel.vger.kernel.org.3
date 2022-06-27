Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D687055DA64
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbiF0Pmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbiF0Pmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:42:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93471A049
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:42:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3CC3521D83;
        Mon, 27 Jun 2022 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656344562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pQybKn32N48HmEhihiaHspXbcJxTi0638ZiC2Fawxw4=;
        b=O4sPJ9IsI0U9zHRnmQ3Jw+6+3mM9sWtFjV6FKGKf1VLOU6oxPkk8Yb/wynPtiv3w9dpRno
        ljegzUU5AxWUDroi5N9ZUehJhQoFgoU35jpmgu8sigensn3usuKl73+XZgF93XESzsHhN1
        sk5xXviPW1D4+AQ99R/Mtiv1jZQ8dB8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7C9213AB2;
        Mon, 27 Jun 2022 15:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3r2oJ/HPuWIdXQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 27 Jun 2022 15:42:41 +0000
Message-ID: <85b1fc01-ff9b-7802-d624-1450c9b9bae5@suse.com>
Date:   Mon, 27 Jun 2022 17:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4] x86/paravirt: useless assignment instructions cause
 Unixbench full core performance degradation
Content-Language: en-US
To:     Guo Hui <guohui@uniontech.com>, peterz@infradead.org
Cc:     longman@redhat.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        pv-drivers@vmware.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, boqun.feng@gmail.com,
        virtualization@lists.linux-foundation.org,
        wangxiaohua@uniontech.com, linux-kernel@vger.kernel.org
References: <YrlhGqqce0NCQ6hi@hirez.programming.kicks-ass.net>
 <20220627142732.31067-1-guohui@uniontech.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220627142732.31067-1-guohui@uniontech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iSCdADmpAVLIlhHV90TlIiWG"
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
--------------iSCdADmpAVLIlhHV90TlIiWG
Content-Type: multipart/mixed; boundary="------------xsQPT0vigC0MDWDdXN0Qc0gT";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Guo Hui <guohui@uniontech.com>, peterz@infradead.org
Cc: longman@redhat.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
 pv-drivers@vmware.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org,
 boqun.feng@gmail.com, virtualization@lists.linux-foundation.org,
 wangxiaohua@uniontech.com, linux-kernel@vger.kernel.org
Message-ID: <85b1fc01-ff9b-7802-d624-1450c9b9bae5@suse.com>
Subject: Re: [PATCH v4] x86/paravirt: useless assignment instructions cause
 Unixbench full core performance degradation
References: <YrlhGqqce0NCQ6hi@hirez.programming.kicks-ass.net>
 <20220627142732.31067-1-guohui@uniontech.com>
In-Reply-To: <20220627142732.31067-1-guohui@uniontech.com>

--------------xsQPT0vigC0MDWDdXN0Qc0gT
Content-Type: multipart/mixed; boundary="------------1MO0WdrZO2ScBFqWZ9ToNh1A"

--------------1MO0WdrZO2ScBFqWZ9ToNh1A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDYuMjIgMTY6MjcsIEd1byBIdWkgd3JvdGU6DQo+IFRoZSBpbnN0cnVjdGlvbnMg
YXNzaWduZWQgdG8gdGhlIHZjcHVfaXNfcHJlZW1wdGVkIGZ1bmN0aW9uIHBhcmFtZXRlcg0K
PiBpbiB0aGUgWDg2IGFyY2hpdGVjdHVyZSBwaHlzaWNhbCBtYWNoaW5lIGFyZSByZWR1bmRh
bnQgaW5zdHJ1Y3Rpb25zLA0KPiBjYXVzaW5nIHRoZSBtdWx0aS1jb3JlIHBlcmZvcm1hbmNl
IG9mIFVuaXhiZW5jaCB0byBkcm9wIGJ5IGFib3V0IDQlIHRvIDUlLg0KPiBUaGUgQyBmdW5j
dGlvbiBpcyBhcyBmb2xsb3dzOg0KPiBzdGF0aWMgYm9vbCB2Y3B1X2lzX3ByZWVtcHRlZChs
b25nIHZjcHUpOw0KPiANCj4gVGhlIHBhcmFtZXRlciAndmNwdScgaW4gdGhlIGZ1bmN0aW9u
IG9zcV9sb2NrDQo+IHRoYXQgY2FsbHMgdGhlIGZ1bmN0aW9uIHZjcHVfaXNfcHJlZW1wdGVk
IGlzIGFzc2lnbmVkIGFzIGZvbGxvd3M6DQo+IA0KPiBUaGUgQyBjb2RlIGlzIGluIHRoZSBm
dW5jdGlvbiBub2RlX2NwdToNCj4gY3B1ID0gbm9kZS0+Y3B1IC0gMTsNCj4gDQo+IFRoZSBp
bnN0cnVjdGlvbnMgY29ycmVzcG9uZGluZyB0byB0aGUgQyBjb2RlIGFyZToNCj4gbW92IDB4
MTQoJXJheCksJWVkaQ0KPiBzdWIgJDB4MSwlZWRpDQo+IA0KPiBUaGUgYWJvdmUgaW5zdHJ1
Y3Rpb25zIGFyZSB1bm5lY2Vzc2FyeQ0KPiBpbiB0aGUgWDg2IE5hdGl2ZSBvcGVyYXRpbmcg
ZW52aXJvbm1lbnQsDQo+IGNhdXNpbmcgaGlnaCBjYWNoZS1taXNzZXMgYW5kIGRlZ3JhZGlu
ZyBwZXJmb3JtYW5jZS4NCj4gDQo+IFRoaXMgcGF0Y2ggdXNlcyBzdGF0aWNfa2V5IHRvIG5v
dCBleGVjdXRlIHRoaXMgaW5zdHJ1Y3Rpb24NCj4gaW4gdGhlIE5hdGl2ZSBydW50aW1lIGVu
dmlyb25tZW50Lg0KPiANCj4gVGhlIHBhdGNoIGVmZmVjdCBpcyBhcyBmb2xsb3dzIHR3byBt
YWNoaW5lcywNCj4gVW5peGJlbmNoIHJ1bnMgd2l0aCBmdWxsIGNvcmUgc2NvcmU6DQo+IA0K
PiAxLiBNYWNoaW5lIGNvbmZpZ3VyYXRpb246DQo+IEludGVsKFIpIFhlb24oUikgU2lsdmVy
IDQyMTAgQ1BVIEAgMi4yMEdIeg0KPiBDUFUgY29yZTogNDANCj4gTWVtb3J5OiAyNTZHDQo+
IE9TIEtlcm5lbDogNS4xOS1yYzMNCj4gDQo+IEJlZm9yZSB1c2luZyB0aGUgcGF0Y2g6DQo+
IFN5c3RlbSBCZW5jaG1hcmtzIEluZGV4IFZhbHVlcyAgICAgICAgICAgICAgIEJBU0VMSU5F
ICAgICAgIFJFU1VMVCAgICBJTkRFWA0KPiBEaHJ5c3RvbmUgMiB1c2luZyByZWdpc3RlciB2
YXJpYWJsZXMgICAgICAgICAxMTY3MDAuMCAgOTQ4MzI2NTkxLjIgIDgxMjYxLjkNCj4gRG91
YmxlLVByZWNpc2lvbiBXaGV0c3RvbmUgICAgICAgICAgICAgICAgICAgICAgIDU1LjAgICAg
IDIxMTk4Ni4zICAzODU0My4wDQo+IEV4ZWNsIFRocm91Z2hwdXQgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA0My4wICAgICAgNDM0NTMuMiAgMTAxMDUuNA0KPiBGaWxlIENv
cHkgMTAyNCBidWZzaXplIDIwMDAgbWF4YmxvY2tzICAgICAgICAgIDM5NjAuMCAgICAgNDM4
OTM2LjIgICAxMTA4LjQNCj4gRmlsZSBDb3B5IDI1NiBidWZzaXplIDUwMCBtYXhibG9ja3Mg
ICAgICAgICAgICAxNjU1LjAgICAgIDExODE5Ny40ICAgIDcxNC4yDQo+IEZpbGUgQ29weSA0
MDk2IGJ1ZnNpemUgODAwMCBtYXhibG9ja3MgICAgICAgICAgNTgwMC4wICAgIDE1MzQ2NzQu
NyAgIDI2NDYuMA0KPiBQaXBlIFRocm91Z2hwdXQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMTI0NDAuMCAgIDQ2NDgyMTA3LjYgIDM3MzY1LjANCj4gUGlwZS1iYXNlZCBDb250
ZXh0IFN3aXRjaGluZyAgICAgICAgICAgICAgICAgICA0MDAwLjAgICAgMTkxNTA5NC4yICAg
NDc4Ny43DQo+IFByb2Nlc3MgQ3JlYXRpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDEyNi4wICAgICAgODU0NDIuMiAgIDY3ODEuMQ0KPiBTaGVsbCBTY3JpcHRzICgxIGNv
bmN1cnJlbnQpICAgICAgICAgICAgICAgICAgICAgNDIuNCAgICAgIDY5NDAwLjcgIDE2MzY4
LjENCj4gU2hlbGwgU2NyaXB0cyAoOCBjb25jdXJyZW50KSAgICAgICAgICAgICAgICAgICAg
ICA2LjAgICAgICAgODg3Ny4yICAxNDc5NS4zDQo+IFN5c3RlbSBDYWxsIE92ZXJoZWFkICAg
ICAgICAgICAgICAgICAgICAgICAgICAxNTAwMC4wICAgIDQ3MTQ5MDYuMSAgIDMxNDMuMw0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgID09PT09PT09DQo+IFN5c3RlbSBCZW5jaG1hcmtzIEluZGV4IFNj
b3JlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDc5MjMuMw0KPiAN
Cj4gQWZ0ZXIgdXNpbmcgdGhlIHBhdGNoOg0KPiBTeXN0ZW0gQmVuY2htYXJrcyBJbmRleCBW
YWx1ZXMgICAgICAgICAgICAgICBCQVNFTElORSAgICAgICBSRVNVTFQgICAgSU5ERVgNCj4g
RGhyeXN0b25lIDIgdXNpbmcgcmVnaXN0ZXIgdmFyaWFibGVzICAgICAgICAgMTE2NzAwLjAg
IDk0NzAzMjkxNS41ICA4MTE1MS4xDQo+IERvdWJsZS1QcmVjaXNpb24gV2hldHN0b25lICAg
ICAgICAgICAgICAgICAgICAgICA1NS4wICAgICAyMTE5NzEuMiAgMzg1NDAuMg0KPiBFeGVj
bCBUaHJvdWdocHV0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNDMuMCAgICAg
IDQ1MDU0LjggIDEwNDc3LjkNCj4gRmlsZSBDb3B5IDEwMjQgYnVmc2l6ZSAyMDAwIG1heGJs
b2NrcyAgICAgICAgICAzOTYwLjAgICAgIDUxNTAyNC45ICAgMTMwMC42DQo+IEZpbGUgQ29w
eSAyNTYgYnVmc2l6ZSA1MDAgbWF4YmxvY2tzICAgICAgICAgICAgMTY1NS4wICAgICAxNDYz
NTQuNiAgICA4ODQuMw0KPiBGaWxlIENvcHkgNDA5NiBidWZzaXplIDgwMDAgbWF4YmxvY2tz
ICAgICAgICAgIDU4MDAuMCAgICAxNjc5OTk1LjkgICAyODk2LjUNCj4gUGlwZSBUaHJvdWdo
cHV0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEyNDQwLjAgICA0NjQ2NjM5NC4y
ICAzNzM1Mi40DQo+IFBpcGUtYmFzZWQgQ29udGV4dCBTd2l0Y2hpbmcgICAgICAgICAgICAg
ICAgICAgNDAwMC4wICAgIDE4OTgyMjEuNCAgIDQ3NDUuNg0KPiBQcm9jZXNzIENyZWF0aW9u
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxMjYuMCAgICAgIDg1NjUzLjEgICA2
Nzk3LjkNCj4gU2hlbGwgU2NyaXB0cyAoMSBjb25jdXJyZW50KSAgICAgICAgICAgICAgICAg
ICAgIDQyLjQgICAgICA2OTQzNy4zICAxNjM3Ni43DQo+IFNoZWxsIFNjcmlwdHMgKDggY29u
Y3VycmVudCkgICAgICAgICAgICAgICAgICAgICAgNi4wICAgICAgIDg4OTguOSAgMTQ4MzEu
NA0KPiBTeXN0ZW0gQ2FsbCBPdmVyaGVhZCAgICAgICAgICAgICAgICAgICAgICAgICAgMTUw
MDAuMCAgICA0NjU4NzQ2LjcgICAzMTA1LjgNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9PT09PT09PQ0K
PiBTeXN0ZW0gQmVuY2htYXJrcyBJbmRleCBTY29yZSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA4MjQ4LjgNCj4gDQo+IDIuIE1hY2hpbmUgY29uZmlndXJhdGlv
bjoNCj4gSHlnb24gQzg2IDcxODUgMzItY29yZSBQcm9jZXNzb3INCj4gQ1BVIGNvcmU6IDEy
OA0KPiBNZW1vcnk6IDI1NkcNCj4gT1MgS2VybmVsOiA1LjE5LXJjMw0KPiANCj4gQmVmb3Jl
IHVzaW5nIHRoZSBwYXRjaDoNCj4gU3lzdGVtIEJlbmNobWFya3MgSW5kZXggVmFsdWVzICAg
ICAgICAgICAgICAgQkFTRUxJTkUgICAgICAgUkVTVUxUICAgIElOREVYDQo+IERocnlzdG9u
ZSAyIHVzaW5nIHJlZ2lzdGVyIHZhcmlhYmxlcyAgICAgICAgIDExNjcwMC4wIDIyNTY2NDQw
NjguMyAxOTMzNzEuNA0KPiBEb3VibGUtUHJlY2lzaW9uIFdoZXRzdG9uZSAgICAgICAgICAg
ICAgICAgICAgICAgNTUuMCAgICAgNDM4OTY5LjkgIDc5ODEyLjcNCj4gRXhlY2wgVGhyb3Vn
aHB1dCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDQzLjAgICAgICAxMDEwOC42
ICAgMjM1MC44DQo+IEZpbGUgQ29weSAxMDI0IGJ1ZnNpemUgMjAwMCBtYXhibG9ja3MgICAg
ICAgICAgMzk2MC4wICAgICAyNzU4OTIuOCAgICA2OTYuNw0KPiBGaWxlIENvcHkgMjU2IGJ1
ZnNpemUgNTAwIG1heGJsb2NrcyAgICAgICAgICAgIDE2NTUuMCAgICAgIDcyMDgyLjcgICAg
NDM1LjUNCj4gRmlsZSBDb3B5IDQwOTYgYnVmc2l6ZSA4MDAwIG1heGJsb2NrcyAgICAgICAg
ICA1ODAwLjAgICAgIDkyNTA0My40ICAgMTU5NC45DQo+IFBpcGUgVGhyb3VnaHB1dCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAxMjQ0MC4wICAxMTg5MDU1MTIuNSAgOTU1ODMu
Mg0KPiBQaXBlLWJhc2VkIENvbnRleHQgU3dpdGNoaW5nICAgICAgICAgICAgICAgICAgIDQw
MDAuMCAgICA3ODIwOTQ1LjcgIDE5NTUyLjQNCj4gUHJvY2VzcyBDcmVhdGlvbiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMTI2LjAgICAgICAzMTIzMy4zICAgMjQ3OC44DQo+
IFNoZWxsIFNjcmlwdHMgKDEgY29uY3VycmVudCkgICAgICAgICAgICAgICAgICAgICA0Mi40
ICAgICAgNDkwNDIuOCAgMTE1NjYuNw0KPiBTaGVsbCBTY3JpcHRzICg4IGNvbmN1cnJlbnQp
ICAgICAgICAgICAgICAgICAgICAgIDYuMCAgICAgICA2NjU2LjAgIDExMDkzLjMNCj4gU3lz
dGVtIENhbGwgT3ZlcmhlYWQgICAgICAgICAgICAgICAgICAgICAgICAgIDE1MDAwLjAgICAg
NjgxNjA0Ny41ICAgNDU0NC4wDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPT09PT09PT0NCj4gU3lzdGVt
IEJlbmNobWFya3MgSW5kZXggU2NvcmUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgNzc1Ni42DQo+IA0KPiBBZnRlciB1c2luZyB0aGUgcGF0Y2g6DQo+IFN5c3Rl
bSBCZW5jaG1hcmtzIEluZGV4IFZhbHVlcyAgICAgICAgICAgICAgIEJBU0VMSU5FICAgICAg
IFJFU1VMVCAgICBJTkRFWA0KPiBEaHJ5c3RvbmUgMiB1c2luZyByZWdpc3RlciB2YXJpYWJs
ZXMgICAgICAgICAxMTY3MDAuMCAyMjUyMjcyOTI5LjQgMTkyOTk2LjgNCj4gRG91YmxlLVBy
ZWNpc2lvbiBXaGV0c3RvbmUgICAgICAgICAgICAgICAgICAgICAgIDU1LjAgICAgIDQ1MTg0
Ny4yICA4MjE1NC4wDQo+IEV4ZWNsIFRocm91Z2hwdXQgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA0My4wICAgICAgMTA1OTUuMSAgIDI0NjQuMA0KPiBGaWxlIENvcHkgMTAy
NCBidWZzaXplIDIwMDAgbWF4YmxvY2tzICAgICAgICAgIDM5NjAuMCAgICAgMzAxMjc5LjMg
ICAgNzYwLjgNCj4gRmlsZSBDb3B5IDI1NiBidWZzaXplIDUwMCBtYXhibG9ja3MgICAgICAg
ICAgICAxNjU1LjAgICAgICA3OTI5MS4zICAgIDQ3OS4xDQo+IEZpbGUgQ29weSA0MDk2IGJ1
ZnNpemUgODAwMCBtYXhibG9ja3MgICAgICAgICAgNTgwMC4wICAgIDEwMzk3NTUuMiAgIDE3
OTIuNw0KPiBQaXBlIFRocm91Z2hwdXQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MTI0NDAuMCAgMTE4NzAxNDY4LjEgIDk1NDE5LjINCj4gUGlwZS1iYXNlZCBDb250ZXh0IFN3
aXRjaGluZyAgICAgICAgICAgICAgICAgICA0MDAwLjAgICAgODA3MzQ1My4zICAyMDE4My42
DQo+IFByb2Nlc3MgQ3JlYXRpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEy
Ni4wICAgICAgMzM0NDAuOSAgIDI2NTQuMA0KPiBTaGVsbCBTY3JpcHRzICgxIGNvbmN1cnJl
bnQpICAgICAgICAgICAgICAgICAgICAgNDIuNCAgICAgIDUyNzIyLjYgIDEyNDM0LjYNCj4g
U2hlbGwgU2NyaXB0cyAoOCBjb25jdXJyZW50KSAgICAgICAgICAgICAgICAgICAgICA2LjAg
ICAgICAgNzA1MC40ICAxMTc1MC42DQo+IFN5c3RlbSBDYWxsIE92ZXJoZWFkICAgICAgICAg
ICAgICAgICAgICAgICAgICAxNTAwMC4wICAgIDY4MzQzNzEuNSAgIDQ1NTYuMg0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgID09PT09PT09DQo+IFN5c3RlbSBCZW5jaG1hcmtzIEluZGV4IFNjb3JlICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDgxNTcuOA0KPiANCj4gU2ln
bmVkLW9mZi1ieTogR3VvIEh1aSA8Z3VvaHVpQHVuaW9udGVjaC5jb20+DQoNClJldmlld2Vk
LWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------1MO0WdrZO2ScBFqWZ9ToNh1A
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------1MO0WdrZO2ScBFqWZ9ToNh1A--

--------------xsQPT0vigC0MDWDdXN0Qc0gT--

--------------iSCdADmpAVLIlhHV90TlIiWG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmK5z/EFAwAAAAAACgkQsN6d1ii/Ey/J
zwf9FZgEbdraRn5G+NoeRnlfdtIBcSciN4n5gKYGDUsmCRAG0eSCaebbCDNIJQHgXDEVjQwVlOLZ
YQuLbEWI5g2NRZZMBjEgLF9IXJOVhEo09dlrWCFlASeIkV6wTFgsuP/G8GlLbYReONAEYpUjjDuO
ldytTU3OOH3jhah+/s2LAhepgcEUgImgAFrd5SLw8mNHqYng/qwEGCAgixWFUD0Uo3lhZFvp5Hgl
ARSzag4jS/rdkQYBUaS/CwzhQ/fMPS6uAr8PGyHIjxByRRAvKG8Her9AJKtxstC2DOyaWgT/LM+m
1WroP9hGXUm3ByKpbFb0tHin2eb4J99IR/6KcCKsbQ==
=ixpK
-----END PGP SIGNATURE-----

--------------iSCdADmpAVLIlhHV90TlIiWG--
