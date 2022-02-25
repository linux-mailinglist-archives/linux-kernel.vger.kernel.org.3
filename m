Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC244C4BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243471AbiBYRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243497AbiBYRKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:10:54 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15261FED96;
        Fri, 25 Feb 2022 09:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1645809023; x=1677345023;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dRL0/jPg1fxrA+PWLdwiEJHSkoRCHV/X2J+x9Q0h534=;
  b=o3vUQ/2ueirHoHx53QxyBUf+EZadZtsYFKfxH35+XEtsJaqDoeorA2/B
   V1fsYObeE0LEUBPptz1E9pbMV5TQpFECpVdpscPVemxxwIAUVNHltlz7+
   v/AC7i1dy4TuntubkVdZfv84Ngiv9zd3ekssNgfaT2ASh/JC9hdj4U5NY
   o=;
X-IronPort-AV: E=Sophos;i="5.90,136,1643673600"; 
   d="scan'208";a="179912807"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 25 Feb 2022 17:10:11 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com (Postfix) with ESMTPS id 1515FC0292;
        Fri, 25 Feb 2022 17:10:08 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 25 Feb 2022 17:10:03 +0000
Received: from [0.0.0.0] (10.43.161.89) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.28; Fri, 25 Feb
 2022 17:10:01 +0000
Message-ID: <7a98e9c5-e0e5-9bf9-71b5-f75b9ddcdc4b@amazon.com>
Date:   Fri, 25 Feb 2022 18:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, <ardb@kernel.org>,
        <dwmw@amazon.co.uk>
References: <20220225155552.30636-1-graf@amazon.com>
 <YhkKc2fa8dSTA9pc@zx2c4.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <YhkKc2fa8dSTA9pc@zx2c4.com>
X-Originating-IP: [10.43.161.89]
X-ClientProxiedBy: EX13D02UWB004.ant.amazon.com (10.43.161.11) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEphc29uLAoKT24gMjUuMDIuMjIgMTc6NTcsIEphc29uIEEuIERvbmVuZmVsZCB3cm90ZToK
PiBIaSBBbGV4LAo+Cj4gVGhhbmtzIGZvciB0aGlzLgo+Cj4gSSB0ZXN0ZWQgdGhpcyBvdXQgd2l0
aCB0aGUgdm1nZW5pZCBkcml2ZXIsIGFuZCBJIGZvdW5kIGEgYnVnIGluIHRoaXMgdjE6Cj4KPiBP
biBGcmksIEZlYiAyNSwgMjAyMiBhdCAwNDo1NTo1MlBNICswMTAwLCBBbGV4YW5kZXIgR3JhZiB3
cm90ZToKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGlkLT5pZFswXSAmJiAh
c3RyY21wKChjaGFyICopaWQtPmlkLCBod2lkLT5pZCkpCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChpZC0+aWRbMF0gJiYgIXN0cm5jbXAoKGNoYXIgKilpZC0+aWQsIGh3aWQt
PmlkLCBBQ1BJX0lEX0xFTikpCj4gVGhpcyBvbmx5IHdvcmtlZCBvbmNlIEkgbWFkZSB0aGF0IGBB
Q1BJX0lEX0xFTiAtIDFgLCBiZWNhdXNlIHRoYXQgbGVuZ3RoCj4gaW5jbHVkZXMgdGhlIG51bGwg
dGVybWluYXRvci4gVGhlIGJlbG93IHBhdGNoIHdvcmtzIGZpbmUuIElmIHlvdSBhZGp1c3QKPiB0
aGF0IGFuZCBzZW5kIGEgcXVpY2sgdjIgZm9sbG93LXVwLCBJJ20gaGFwcHkgdG8gYWNrIGl0Lgo+
Cj4gUmVnYXJkcywKPiBKYXNvbgo+Cj4gLS0tLS0tLS04PC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2J1cy5jIGIvZHJpdmVycy9hY3BpL2J1
cy5jCj4gaW5kZXggMDdmNjA0ODMyZmQ2Li5mMTc5ZWJmMTZmMjEgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9hY3BpL2J1cy5jCj4gKysrIGIvZHJpdmVycy9hY3BpL2J1cy5jCj4gQEAgLTgyOSw3ICs4
MjksNyBAQCBzdGF0aWMgYm9vbCBfX2FjcGlfbWF0Y2hfZGV2aWNlKHN0cnVjdCBhY3BpX2Rldmlj
ZSAqZGV2aWNlLAo+ICAgICAgICAgICAgICAgICAgLyogRmlyc3QsIGNoZWNrIHRoZSBBQ1BJL1BO
UCBJRHMgcHJvdmlkZWQgYnkgdGhlIGNhbGxlci4gKi8KPiAgICAgICAgICAgICAgICAgIGlmIChh
Y3BpX2lkcykgewo+ICAgICAgICAgICAgICAgICAgICAgICAgICBmb3IgKGlkID0gYWNwaV9pZHM7
IGlkLT5pZFswXSB8fCBpZC0+Y2xzOyBpZCsrKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpZiAoaWQtPmlkWzBdICYmICFzdHJjbXAoKGNoYXIgKilpZC0+aWQsIGh3aWQtPmlk
KSkKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChpZC0+aWRbMF0gJiYgIXN0
cm5jbXAoKGNoYXIgKilpZC0+aWQsIGh3aWQtPmlkLCBBQ1BJX0lEX0xFTiAtIDEpKQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRfYWNwaV9tYXRjaDsK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoaWQtPmNscyAmJiBfX2FjcGlf
bWF0Y2hfZGV2aWNlX2NscyhpZCwgaHdpZCkpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIG91dF9hY3BpX21hdGNoOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZpcnQvdm1nZW5pZC5jIGIvZHJpdmVycy92aXJ0L3ZtZ2VuaWQuYwo+IGluZGV4IGI1MDNjMjEw
YzJkNy4uMDQ3NTFmYzFkMzY1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydC92bWdlbmlkLmMK
PiArKysgYi9kcml2ZXJzL3ZpcnQvdm1nZW5pZC5jCj4gQEAgLTc4LDggKzc4LDcgQEAgc3RhdGlj
IHZvaWQgdm1nZW5pZF9hY3BpX25vdGlmeShzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgdTMy
IGV2ZW50KQo+ICAgfQo+Cj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIHZt
Z2VuaWRfaWRzW10gPSB7Cj4gLSAgICAgICB7ICJRRU1VVkdJRCIsIDAgfSwgICAgICAvKiBRRU1V
ICovCj4gLSAgICAgICB7ICJWTUdFTklEIiwgMCB9LCAgICAgICAvKiBGaXJlY3JhY2tlciAqLwo+
ICsgICAgICAgeyAiVk1fR0VOX0MiLCAwIH0sIC8qIFRydW5jYXRlZCAiVk1fR2VuX0NvdW50ZXIi
ICovCgoKWW91IGhhdmUgdG8gbWFrZSB0aGlzICJWTV9HRU5fQ08iLiBJIG5vdyBtYXRjaCB0aGUg
ZnVsbCA5IGJ5dGVzIC0gdW5saWtlIAp0aGUgcHJldmlvdXMgcGF0Y2ggSSBzZW50IDopCgoKQWxl
eAoKCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIu
IDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIs
IEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJn
IHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoK
Cg==

