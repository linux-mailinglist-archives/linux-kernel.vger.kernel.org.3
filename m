Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9AA577498
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 07:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiGQFUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 01:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQFU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 01:20:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F1C15A05
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 22:20:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E575634866;
        Sun, 17 Jul 2022 05:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658035223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nBxnxsBvQk92FZoXjukF0aK9XCteCOTDK2DUR1P5eu4=;
        b=S6ylxJaN+tzXZ8g1AJ9zt2Ry9UHYc06k2NE1bR7yxhtX0g8kpW1TZOteKs/3Smf+/0+9jt
        s28OuHCpUGhAL1BBKAM0cpk/zr2Rt4Y5w5eH8kFinPxfwuiOwmcsM9IQXAFgEicNyORDnj
        MUVif9Qu598k1KWa6DBgzS+cUgpsvAI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DDC113A89;
        Sun, 17 Jul 2022 05:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jyb/HBec02KCUAAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 17 Jul 2022 05:20:23 +0000
Message-ID: <6eea38ab-17d2-7bdc-1277-9964a3828a9e@suse.com>
Date:   Sun, 17 Jul 2022 07:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Build warnings in Xen 5.15.y and 5.10.y with retbleed backports
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Nicolai Stange <nstange@suse.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        Ben Hutchings <ben@decadent.org.uk>
References: <Ys2jlGMqAe6+h1SX@kroah.com>
 <ddcdd531-fc33-39df-a69f-5352d7a1c8af@oracle.com>
 <Ys3MI7cv2yKj9RFc@kroah.com>
 <1b8fee7f-5af2-332e-d2c9-ceecd6ff487b@oracle.com>
 <875yjxrp66.fsf@linux.fritz.box>
 <ed82e54e-ccc4-f514-7018-8410d0f5bb82@oracle.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <ed82e54e-ccc4-f514-7018-8410d0f5bb82@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7zGKpLsubE0ZasDYHbv93z3k"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7zGKpLsubE0ZasDYHbv93z3k
Content-Type: multipart/mixed; boundary="------------8epbhHZboIDosp92OlpVYKs5";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Nicolai Stange <nstange@suse.de>, Greg KH <gregkh@linuxfoundation.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 jpoimboe@redhat.com, Ben Hutchings <ben@decadent.org.uk>
Message-ID: <6eea38ab-17d2-7bdc-1277-9964a3828a9e@suse.com>
Subject: Re: Build warnings in Xen 5.15.y and 5.10.y with retbleed backports
References: <Ys2jlGMqAe6+h1SX@kroah.com>
 <ddcdd531-fc33-39df-a69f-5352d7a1c8af@oracle.com>
 <Ys3MI7cv2yKj9RFc@kroah.com>
 <1b8fee7f-5af2-332e-d2c9-ceecd6ff487b@oracle.com>
 <875yjxrp66.fsf@linux.fritz.box>
 <ed82e54e-ccc4-f514-7018-8410d0f5bb82@oracle.com>
In-Reply-To: <ed82e54e-ccc4-f514-7018-8410d0f5bb82@oracle.com>

--------------8epbhHZboIDosp92OlpVYKs5
Content-Type: multipart/mixed; boundary="------------An3p6WjSIkMGZfJvD7k73r3z"

--------------An3p6WjSIkMGZfJvD7k73r3z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDcuMjIgMDA6NDcsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToNCj4gDQo+IA0KPiBP
biA3LzE2LzIyIDEyOjM1IFBNLCBOaWNvbGFpIFN0YW5nZSB3cm90ZToNCj4+IEhpLA0KPj4N
Cj4+IEkgc2VlIGEgcGF0Y2ggZm9yIHRoaXMgaGFzIGJlZW4gcXVldWVkIHVwIGZvciA1LjEw
IGFscmVhZHkgKFsxXSksIEknbQ0KPj4ganVzdCBzaGFyaW5nIG15IGZpbmRpbmdzIGluIHN1
cHBvcnQgb2YgdGhpcyBwYXRjaCBoZXJlIC0tIGl0IGRvZXNuJ3QNCj4+IG1lcmVseSBleGNo
YW5nZSBvbmUgd2FybmluZyBmb3IgYW5vdGhlciwgYnV0IGZpeGVzIGEgcmVhbCBpc3N1ZSBh
bmQNCj4+IHNob3VsZCBwZXJoYXBzIGdldCBhcHBsaWVkIHRvIG90aGVyIHN0YWJsZSBicmFu
Y2hlcyBhcyB3ZWxsLg0KPj4NCj4+IFRMO0RSOiBmb3IgdGhpcyBwYXJ0aWN1bGFyIHdhcm5p
bmcsIG9ianRvb2wgd291bGQgZXhpdCBlYXJseSBhbmQgZmFpbCB0bw0KPj4gY3JlYXRlIGFu
eSAub3JjX3Vud2luZCogRUxGIHNlY3Rpb25zIGZvciBoZWFkXzY0Lm8sIHdoaWNoIGFyZSBj
b25zdW1lZA0KPj4gYnkgdGhlIE9SQyB1bndpbmRlciBhdCBydW50aW1lLg0KPj4NCj4+DQo+
PiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPiB3cml0ZXM6
DQo+Pg0KPj4+IE9uIDcvMTIvMjIgMzozMSBQTSwgR3JlZyBLSCB3cm90ZToNCj4+Pj4gT24g
VHVlLCBKdWwgMTIsIDIwMjIgYXQgMDM6MTk6MzlQTSAtMDQwMCwgQm9yaXMgT3N0cm92c2t5
IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IE9uIDcvMTIvMjIgMTI6MzggUE0sIEdyZWcgS0ggd3Jv
dGU6DQo+Pj4+Pj4gSGkgYWxsLA0KPj4+Pj4+DQo+Pj4+Pj4gSSdtIHNlZWluZyB0aGUgZm9s
bG93aW5nIGJ1aWxkIHdhcm5pbmc6DQo+Pj4+Pj4gwqDCoMKgwqBhcmNoL3g4Ni9rZXJuZWwv
aGVhZF82NC5vOiB3YXJuaW5nOiBvYmp0b29sOiANCj4+Pj4+PiB4ZW5faHlwZXJjYWxsX21t
dV91cGRhdGUoKTogY2FuJ3QgZmluZCBzdGFydGluZyBpbnN0cnVjdGlvbg0KPj4+Pj4+IGlu
IHRoZSA1LjE1LnkgYW5kIDUuMTAueSByZXRibGVlZCBiYWNrcG9ydHMuDQo+Pg0KPj4gVGhl
IHJlYXNvbiBmb3IgdGhpcyBpcyB0aGF0IHdpdGggUkVUIGJlaW5nIG11bHRpYnl0ZSwgaXQg
Y2FuIGNyb3NzIHRob3NlDQo+PiAieGVuX2h5cGVjYWxsXyoiIHN5bWJvbCBib3VuZGFyaWVz
LCBiZWNhdXNlIC4uLg0KPj4NCj4+Pj4+Pg0KPj4+Pj4+IEkgZG9uJ3Qga25vdyB3aHkganVz
dCB0aGlzIG9uZSBoeXBlcmNhbGwgaXMgYmVpbmcgY2FsbGVkIG91dCBieSBvYmp0b29sLA0K
Pj4+Pj4+IGFuZCB0aGlzIHdhcm5pbmcgaXNuJ3QgaW4gNS4xOCBhbmQgTGludXMncyB0cmVl
IGR1ZSB0byBJIHRoaW5rIGNvbW1pdA0KPj4+Pj4+IDViMmZjNTE1NzZlZiAoIng4Ni9pYnQs
eGVuOiBTcHJpbmtsZSB0aGUgRU5EQlIiKSBiZWluZyB0aGVyZS4NCj4+Pj4+Pg0KPj4+Pj4+
IEJ1dCwgaXMgdGhpcyBhIHJldCBjYWxsIHRoYXQgd2UgImZvcmdvdCIgaGVyZT/CoCBJdCdz
IGEgInJlYWwiIHJldCBpbg0KPj4+Pj4+IExpbnVzJ3MgYnJhbmNoOg0KPj4+Pj4+DQo+Pj4+
Pj4gLnB1c2hzZWN0aW9uIC5ub2luc3RyLnRleHQsICJheCINCj4+Pj4+PiDCoMKgwqDCoC5i
YWxpZ24gUEFHRV9TSVpFDQo+Pj4+Pj4gU1lNX0NPREVfU1RBUlQoaHlwZXJjYWxsX3BhZ2Up
DQo+Pj4+Pj4gwqDCoMKgwqAucmVwdCAoUEFHRV9TSVpFIC8gMzIpDQo+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqAgVU5XSU5EX0hJTlRfRlVOQw0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgIEFOTk9U
QVRFX05PRU5EQlINCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoCBBTk5PVEFURV9VTlJFVF9TQUZF
DQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgcmV0DQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgLyoN
Cj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgICogWGVuIHdpbGwgd3JpdGUgdGhlIGh5cGVyY2Fs
bCBwYWdlLCBhbmQgc29ydCBvdXQgRU5EQlIuDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCAq
Lw0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgIC5za2lwIDMxLCAweGNjDQo+Pj4+Pj4gwqDCoMKg
wqAuZW5kcg0KPj4+Pj4+DQo+Pj4+Pj4gd2hpbGUgNS4xNS55IGFuZCBvbGRlciBoYXM6DQo+
Pj4+Pj4gLnB1c2hzZWN0aW9uIC50ZXh0DQo+Pj4+Pj4gwqDCoMKgwqAuYmFsaWduIFBBR0Vf
U0laRQ0KPj4+Pj4+IFNZTV9DT0RFX1NUQVJUKGh5cGVyY2FsbF9wYWdlKQ0KPj4+Pj4+IMKg
wqDCoMKgLnJlcHQgKFBBR0VfU0laRSAvIDMyKQ0KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgIFVO
V0lORF9ISU5UX0ZVTkMNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoCAuc2tpcCAzMSwgMHg5MA0K
Pj4NCj4+IC4uLiB0aGUgIjMxIiBpcyBubyBsb25nZXIgY29ycmVjdCwgLi4uDQo+Pg0KPj4+
Pj4+IMKgwqDCoMKgwqDCoMKgIEFOTk9UQVRFX1VOUkVUX1NBRkUNCj4+Pj4+PiDCoMKgwqDC
oMKgwqDCoCBSRVQNCj4+DQo+PiAuLi4gYXMgd2l0aCBSRVQgb2NjdXB5aW5nIG1vcmUgdGhh
biBvbmUgYnl0ZSwgdGhlIHJlc3VsdGluZyBoeXBlcmNhbGwNCj4+IGVudHJ5J3MgdG90YWwg
c2l6ZSB3b24ndCBhZGQgdXAgdG8gMzIgYW55bW9yZS4NCj4gDQo+IA0KPiBSaWdodCEgSSBo
YXZlbid0IHRob3VnaHQgYWJvdXQgdGhhdCBwYXJ0LiBJIHRoaW5rIHRoaXMgaGFzIGJlZW4g
YnJva2VuIHNpbmNlIA0KPiAxNGI0NzZlMDdmYWIgKCJ4ODY6IFByZXBhcmUgYXNtIGZpbGVz
IGZvciBzdHJhaWdodC1saW5lLXNwZWN1bGF0aW9uIikuDQo+IA0KPiBJdCBzdGlsbCBzaG91
bGRuJ3QgbWF0dGVyIGFzIGZhciBhcyBjb3JyZWN0IGV4ZWN1dGlvbiBpcyBjb25jZXJuZWQg
d2hpY2ggaXMgDQo+IHByb2JhYmx5IHdoeSBub29uZSBjb21wbGFpbmVkLg0KPiANCj4gDQo+
Pg0KPj4gTm90ZSB0aGF0IHRob3NlIHhlbl9oeXBlcmNhbGxfKiBzeW1ib2xzJyB2YWx1ZXMg
YXJlIGdldHRpbmcgc3RhdGljYWxseQ0KPj4gY2FsY3VsYXRlZCBhcyAnaHlwZXJjYWxsIHBh
Z2UgKyBuICogMzInIGluIHRoZSBIWVBFUkNBTEwoKSAjZGVmaW5lIGZyb20NCj4+IHhlbi1o
ZWFkLlMuIFNvIHRoZXJlJ3MgYSBtaXNtYXRjaCBhbmQgd2l0aCBSRVQgPT0gJ3JldDsgaW50
MycsIHRoZQ0KPj4gcmVzdWx0aW5nIC50ZXh0IGVmZmVjdGl2ZWx5IGJlY29tZXMNCj4+DQo+
PiDCoMKgwqDCoCAxMDFlOsKgwqDCoMKgwqDCoCA5MMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBub3ANCj4+IMKgwqDCoMKgIDEwMWY6wqDCoMKgwqDCoMKg
IGMzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldA0KPj4N
Cj4+IDAwMDAwMDAwMDAwMDEwMjAgPHhlbl9oeXBlcmNhbGxfbW11X3VwZGF0ZT46DQo+PiDC
oMKgwqDCoCAxMDIwOsKgwqDCoMKgwqDCoCBjY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpbnQzDQo+PiDCoMKgwqDCoCAxMDIxOsKgwqDCoMKgwqDCoCA5
MMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBub3ANCj4+IMKg
wqDCoMKgIDEwMjI6wqDCoMKgwqDCoMKgIDkwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG5vcA0KPj4NCj4+DQo+PiBUaGlzIGlzIHByb2JhYmx5IGFscmVh
ZHkgbm90IHdoYXQgaGFzIGJlZW4gaW50ZW5kZWQsIGJ1dCBiZWNhdXNlICdyZXQnDQo+PiBh
bmQgJ2ludDMnIGJvdGggYXJlIHNpbmdsZS1ieXRlIGVuY29kZWQsIG9ianRvb2wgd291bGQg
c3RpbGwgYmUgYWJsZSB0bw0KPj4gZmluZCBhdCBsZWFzdCBzb21lICJzdGFydGluZyBpbnN0
cnVjdGlvbiIgYXQgdGhpcyBwb2ludC4NCj4+DQo+PiBCdXQgd2l0aCBSRVQgPT0gJ2ptcCBf
X3g4Nl9yZXR1cm5fdGh1bmsnLCBpdCBiZWNvbWVzDQo+Pg0KPj4gwqDCoMKgwqAgMTAxZTrC
oMKgwqDCoMKgwqAgOTDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbm9wDQo+PiDCoMKgwqDCoCAxMDFmOsKgwqDCoMKgwqDCoCBlOcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuYnl0ZSAweGU5DQo+Pg0KPj4gMDAwMDAw
MDAwMDAwMTAyMCA8eGVuX2h5cGVyY2FsbF9tbXVfdXBkYXRlPjoNCj4+IMKgwqDCoMKgIDEw
MjA6wqDCoMKgwqDCoMKgIDAwIDAwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGFkZMKgwqDCoCAlYWwsKCVyYXgpDQo+PiDCoMKgwqDCoCAxMDIyOsKgwqDCoMKgwqDC
oCAwMCAwMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGTCoMKgwqAg
JWFsLCglcmF4KQ0KPj4gwqDCoMKgwqAgMTAyNDrCoMKgwqDCoMKgwqAgOTDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbm9wDQo+Pg0KPj4gSGVyZSB0aGUg
J2U5IDAwIDAwIDAwIDAwJyBqbXAgY3Jvc3NlcyB0aGUgc3ltYm9sIGJvdW5kYXJ5IGFuZCBv
Ymp0b29sDQo+PiBlcnJvcnMgb3V0Lg0KPj4NCj4gDQo+IA0KPiBBaCwgdGhhbmtzIGZvciBl
eHBsYW5hdGlvbi4NCj4gDQo+IA0KPiBUaGVuIEkgdGhpbmsgd2UgbmVlZCB0byByZXBsYWNl
DQo+IA0KPiAgwqDCoMKgwqAuc2tpcCAzMSwgMHg5MA0KPiANCj4gd2l0aCBzb21ldGhpbmcg
bGlrZQ0KPiANCj4gI2lmIGRlZmluZWQoQ09ORklHX1JFVEhVTkspICYmICFkZWZpbmVkKF9f
RElTQUJMRV9FWFBPUlRTKSAmJiAhZGVmaW5lZChCVUlMRF9WRFNPKQ0KPiAjZGVmaW5lIFNL
SVBfQllURVPCoMKgwqAgMjfCoMKgwqAgLyogUkVUIGlzICdqbXAgX194ODZfcmV0dXJuX3Ro
dW5rJyAoNSBieXRlcykgKi8NCj4gI2Vsc2UgLyogQ09ORklHX1JFVFBPTElORSAqLw0KPiAj
aWZkZWYgQ09ORklHX1NMUw0KPiAjZGVmaW5lIFNLSVBfQllURVPCoMKgwqAgMzDCoMKgwqAg
LyogUkVUIGlzICdyZXQ7IGludDMnICgyIGJ5dGVzKSAqLw0KPiAjZWxzZQ0KPiAjZGVmaW5l
IFNLSVBfQllURVPCoMKgwqAgMzHCoMKgwqAgLyogUkVUIGlzICdyZXQnICgxIGJ5dGUpICov
DQo+ICNlbmRpZg0KPiAgwqDCoMKgwqAuc2tpcCBTS0lQX0JZVEVTLCAweDkwDQo+IA0KPiAo
SSBkb24ndCBoYXZlIHBhdGNoZWQgNS4xNSBzbyBJIGFtIGdvaW5nIGJ5IHdoYXQgbWFpbmxp
bmUgbG9va3MgbGlrZSkNCj4gDQo+IE9yIHJlcGxhY2UgUkVUIHdpdGggcmV0LiAoQWx0aG91
Z2ggYXQgbGVhc3Qgd2l0aCB1bnBhdGNoZWQgNS4xNSB0aGUgd2FybmluZyANCj4gYmVsb3cg
aXMgc3RpbGwgZ2VuZXJhdGVkKQ0KDQpXaGF0IGFib3V0IGZpbGxpbmcgdGhlIGNvbXBsZXRl
IGh5cGVyY2FsbCBwYWdlIGp1c3Qgd2l0aCAiaW50IDMiIG9yICJ1ZDIiPw0KDQpBbnkgdHJ5
IHRvIGRvIGEgaHlwZXJjYWxsIGJlZm9yZSB0aGUgaHlwZXJjYWxsIHBhZ2UgaGFzIGJlZW4g
aW5pdGlhbGl6ZWQNCmlzIGEgYnVnIGFueXdheS4gV2hhdCBnb29kIGNhbiBjb21lIGZyb20g
Y2FsbGluZyBhIGZ1bmN0aW9uIHdoaWNoIHdpbGwNCnJldHVybiBhIGJhc2ljYWxseSByYW5k
b20gdmFsdWUgaW5zdGVhZCBvZiBkb2luZyBhIHByaXZpbGVnZWQgb3BlcmF0aW9uPw0KDQoN
Ckp1ZXJnZW4NCg==
--------------An3p6WjSIkMGZfJvD7k73r3z
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------An3p6WjSIkMGZfJvD7k73r3z--

--------------8epbhHZboIDosp92OlpVYKs5--

--------------7zGKpLsubE0ZasDYHbv93z3k
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmLTnBcFAwAAAAAACgkQsN6d1ii/Ey9q
mwf/SL+4KNaRGqLo52fTKu4xvsuojYaTxHE0TVn5glhFdSXkUO7URPUXMlIevHKohgAP7n3/TAKj
ogxtkuaVkr/GP18CiDzjX3tBcEE9Hz8fn5kbHaTO1HErCt4eKnE4g0VWIMMlsEgB/we4gYKwRoln
zmDb4lcp7g2LavkQ04FErpxgFnq4WCzIvAl1XQYvpS8A+y7FA1egPWw97HgSThSlF8nct+yi66c0
+NDUxg8Ecd6obkSN4NAlnM32/HQZq4Zz1FROTY0LyXZBSAwD8w2gZI97gcZQtM47yKvYzVXnkLX3
OQaw/HPSvgq2grg+b8emRWYy9td9w5mEgrDZu8pV0A==
=vrHJ
-----END PGP SIGNATURE-----

--------------7zGKpLsubE0ZasDYHbv93z3k--
