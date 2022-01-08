Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7E487FF3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiAHAiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:38:21 -0500
Received: from ip59.38.31.103.in-addr.arpa.unknwn.cloudhost.asia ([103.31.38.59]:44936
        "EHLO gnuweeb.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229553AbiAHAiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:38:20 -0500
Received: from [192.168.88.87] (unknown [36.68.70.227])
        by gnuweeb.org (Postfix) with ESMTPSA id 0D191C17CF;
        Sat,  8 Jan 2022 00:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuweeb.org;
        s=default; t=1641602298;
        bh=/KNQJzMgZTLMa/7/wZMA3Jrbqcb11OqF1X54yfheD+s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ChEBo8NhyDhV4LRoLLfDLB3etxkddPKLDZORNe2ou1avKqmyIr1LBTZQDc9jmbVlK
         XjC1W79jVAyd4bHJ/IJZrOl0G5y6DEqPywNCNMIcs7VQg9urd1rL1NLoDFUKhDo4kB
         PD03/rIoN1o5G8JFygmp+omI4p3Ubl2UQDa4P5BCHNyo3LLRWOW/obScLBASvwhhXM
         +AGNrF220XNTq7VbngvTroh8WdHwm0yN3jQ2I0uIKvqReFaD87GmiIv9sWCXOQ7QvS
         OSb/VxbqmEmA5fu93jOWOcwkGuA5k/Bym8hwxi1gGn0UdPlRmlQxlo5gz9d+7vSIff
         MNkmDXb3Ksy6Q==
Message-ID: <0c2aed26-fa46-592c-7fab-209929246215@gnuweeb.org>
Date:   Sat, 8 Jan 2022 07:38:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v1 3/3] Documentation: x86-64: Document registers on entry
 and exit
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        Michael Matz <matz@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Willy Tarreau <w@1wt.eu>
References: <20220107235210.1339168-1-ammarfaizi2@gnuweeb.org>
 <20220107235210.1339168-4-ammarfaizi2@gnuweeb.org>
 <37ce01e8-43eb-7eff-9667-745e17cdd65f@kernel.org>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <37ce01e8-43eb-7eff-9667-745e17cdd65f@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mVo46IyjywYmTzFrEMp0VtgO"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mVo46IyjywYmTzFrEMp0VtgO
Content-Type: multipart/mixed; boundary="------------T08QWyQbpif3qW9jGxyMI00y";
 protected-headers="v1"
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 GNU/Weeb Mailing List <gwml@gnuweeb.org>, Michael Matz <matz@suse.de>,
 "H.J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Willy Tarreau <w@1wt.eu>
Message-ID: <0c2aed26-fa46-592c-7fab-209929246215@gnuweeb.org>
Subject: Re: [PATCH v1 3/3] Documentation: x86-64: Document registers on entry
 and exit
References: <20220107235210.1339168-1-ammarfaizi2@gnuweeb.org>
 <20220107235210.1339168-4-ammarfaizi2@gnuweeb.org>
 <37ce01e8-43eb-7eff-9667-745e17cdd65f@kernel.org>
In-Reply-To: <37ce01e8-43eb-7eff-9667-745e17cdd65f@kernel.org>

--------------T08QWyQbpif3qW9jGxyMI00y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMS84LzIyIDc6MDIgQU0sIEFuZHkgTHV0b21pcnNraSB3cm90ZToNCj4gT24gMS83LzIy
IDE1OjUyLCBBbW1hciBGYWl6aSB3cm90ZToNCj4+IFRoZXJlIHdhcyBhIGNvbnRyb3ZlcnNp
YWwgZGlzY3Vzc2lvbiBhYm91dCB0aGUgd29yZGluZyBpbiB0aGUgU3lzdGVtDQo+PiBWIEFC
SSBkb2N1bWVudCByZWdhcmRpbmcgd2hhdCByZWdpc3RlcnMgdGhlIGtlcm5lbCBpcyBhbGxv
d2VkIHRvDQo+PiBjbG9iYmVyIHdoZW4gdGhlIHVzZXJzcGFjZSBleGVjdXRlcyBzeXNjYWxs
Lg0KPj4NCj4+IFRoZSByZXNvbHV0aW9uIG9mIHRoZSBkaXNjdXNzaW9uIHdhcyByZXZpZXdp
bmcgdGhlIGNsb2JiZXIgbGlzdCBpbg0KPj4gdGhlIGdsaWJjIHNvdXJjZS4gRm9yIGEgaGlz
dG9yaWNhbCByZWFzb24gaW4gdGhlIGdsaWJjIHNvdXJjZSwgdGhlDQo+PiBrZXJuZWwgbXVz
dCByZXN0b3JlIGFsbCByZWdpc3RlcnMgYmVmb3JlIHJldHVybmluZyB0byB0aGUgdXNlcnNw
YWNlDQo+PiAoZXhjZXB0IGZvciByYXgsIHJjeCBhbmQgcjExKS4NCj4+DQpbLi4uXQ0KPj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24veDg2L2VudHJ5XzY0LnJzdCBiL0RvY3VtZW50
YXRpb24veDg2L2VudHJ5XzY0LnJzdA0KPj4gaW5kZXggZTQzM2UwOGY3MDE4Li4zZjIwMDdl
MmE5MzggMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL3g4Ni9lbnRyeV82NC5yc3QN
Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24veDg2L2VudHJ5XzY0LnJzdA0KPj4gQEAgLTEwOCwz
ICsxMDgsNTAgQEAgV2UgdHJ5IHRvIG9ubHkgdXNlIElTVCBlbnRyaWVzIGFuZCB0aGUgcGFy
YW5vaWQgZW50cnkgY29kZSBmb3IgdmVjdG9ycw0KPj4gICB0aGF0IGFic29sdXRlbHkgbmVl
ZCB0aGUgbW9yZSBleHBlbnNpdmUgY2hlY2sgZm9yIHRoZSBHUyBiYXNlIC0gYW5kIHdlDQo+
PiAgIGdlbmVyYXRlIGFsbCAnbm9ybWFsJyBlbnRyeSBwb2ludHMgd2l0aCB0aGUgcmVndWxh
ciAoZmFzdGVyKSBwYXJhbm9pZD0wDQo+PiAgIHZhcmlhbnQuDQo+PiArDQo+PiArDQo+PiAr
UmVnaXN0ZXJzIG9uIGVudHJ5Og0KPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4NCj4gVGhp
cyBpcyBTWVNDQUxMNjQgcmVnaXN0ZXJzIG9uIGVudHJ5LCBub3QgZ2VuZXJhbCByZWdpc3Rl
cnMgb24gZW50cnkuDQo+IEFsc28sIHRoaXMgaGFzIGxpdHRsZSB0byBkbyB3aXRoIHRoZSBl
bnRyeSBsb2dpYywgc28gaXQgcHJvYmFibHkNCj4gZG9lc24ndCBiZWxvbmcgaW4gdGhpcyBm
aWxlLg0KDQpBaCByaWdodCwgSSBzaG91bGQgYmUgbW9yZSBzcGVjaWZpYyBzYXlpbmcgaXQn
cyBmb3Igc3lzY2FsbDY0IGVudHJ5DQphcyB0aGVyZSBhcmUgNiBlbnRyaWVzIG1lbnRpb25l
ZCBpbiB0aGlzIGRvY3VtZW50Lg0KDQpTaG91bGQgc3lzY2FsbDY0IGVudHJ5IHRvcGljIGJl
IGRvY3VtZW50ZWQ/IElmIG5vdCBJIHdpbGwgZHJvcCBpdCwNCm90aGVyd2lzZSBzdWdnZXN0
IG1lIGEgcGxhY2UgZm9yIGl0Lg0KDQpJIHRoaW5rIHdlIGNhbiBkb2N1bWVudCBpdCBoZXJl
LCBidXQgaXQgbmVlZHMgdG8gYmUgbW9yZSBzcGVjaWZpYw0Kc2F5aW5nIGl0J3MgZm9yIHN5
c2NhbGw2NCBlbnRyeS4NCg0KSm9uYXRoYW4/DQoNCi0tIA0KQW1tYXIgRmFpemkNCg==

--------------T08QWyQbpif3qW9jGxyMI00y--

--------------mVo46IyjywYmTzFrEMp0VtgO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE6JNybcjkwN47ogEHNk+6NP8XCksFAmHY3PgFAwAAAAAACgkQNk+6NP8XCkvZ
6wgAp0q7W/RcM0KF7qZFj523QK4ruSGG4hCa7kMgDy4L7KrFNjIpdp2nWsPuQeXxzwvjsgx+zUIq
DRpEZvHdvyZZRqqVCq0zdFMUyepm6k4o9lchKxOC4EOCMriSGBM/d09aE/tBLWTLT0gG4LyLXcBt
bVk69B+sWj9Dx3RK7m4gx7s7nrRWWzLqqbTNg8LfJGYZftQx1DjagfmPtfH8S42k3a5fFO/a9Ih0
JXc3N2l/7CbrMGsGJ3d+cmaVpKWM/Z2RpAkvFLYcKtIqYw2YVCJDf8HqD7OY6kllcJRpc8kZ8wkz
Dauxpm2B114Pgl+CW6Z1Ya4JMs+nlL3LTglWpSUfcA==
=bErJ
-----END PGP SIGNATURE-----

--------------mVo46IyjywYmTzFrEMp0VtgO--
