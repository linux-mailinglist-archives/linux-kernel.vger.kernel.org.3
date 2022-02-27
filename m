Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD364C5AB9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiB0LtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiB0LtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:49:22 -0500
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE48E37A8E;
        Sun, 27 Feb 2022 03:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1645962525; x=1677498525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yVhmvV79BlMSLyTbnCrhb9o/8ryhq3aTZ7jM8+D44yA=;
  b=kcjh/cHavwB6o3zbgTguxWABtneaAhMzE2+zJgy+Mp9uS7EoOVKiEbGz
   6CRmQ21NTTI7CSIDvqPkMeyO1CRMXmuGP+UTxvYx9kMlm17Cc92dCtsvN
   1vfX2iUkSdklTTXUg5voXE2aQtBMkBijrKZez9USG1NsOWmeLLdpNNF0E
   E=;
X-IronPort-AV: E=Sophos;i="5.90,141,1643673600"; 
   d="scan'208";a="995276245"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-72dc3927.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 27 Feb 2022 11:48:29 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-72dc3927.us-west-2.amazon.com (Postfix) with ESMTPS id 8299C41636;
        Sun, 27 Feb 2022 11:48:28 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sun, 27 Feb 2022 11:48:28 +0000
Received: from [0.0.0.0] (10.43.162.207) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.28; Sun, 27 Feb
 2022 11:48:26 +0000
Message-ID: <fdd0abc8-8ce7-e183-721e-d2e4f45540f5@amazon.com>
Date:   Sun, 27 Feb 2022 12:48:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220226220639.1173594-1-Jason@zx2c4.com>
 <20220226220639.1173594-3-Jason@zx2c4.com>
 <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com>
 <CAHmME9rPd8Nu8Q0+R6B4Bz-caKpq5SSvLaiKdwXcyNHY8Ebfqg@mail.gmail.com>
 <CAMj1kXEwsyPcoTvK6PZyA5L3q9u_dd_wXUiyHw7TtPM5LecP7g@mail.gmail.com>
 <CAMj1kXHAeqrPjMZi_VD6fYWXatV5UUy5N3ZbtZf=SaDpN3GPVQ@mail.gmail.com>
 <b023481d-7a25-2343-63d9-0a34874f2ba8@amazon.com>
 <CAMj1kXEcM1Q=utgfj1b+NGGH=+dcjdC6OhDhCqJhR8ZNXbUM2A@mail.gmail.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <CAMj1kXEcM1Q=utgfj1b+NGGH=+dcjdC6OhDhCqJhR8ZNXbUM2A@mail.gmail.com>
X-Originating-IP: [10.43.162.207]
X-ClientProxiedBy: EX13P01UWA001.ant.amazon.com (10.43.160.213) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDI3LjAyLjIyIDEyOjQzLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiBPbiBTdW4sIDI3IEZl
YiAyMDIyIGF0IDEyOjM5LCBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPiB3cm90ZToK
Pj4KPj4gT24gMjcuMDIuMjIgMTE6NDcsIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+Pj4gT24gU3Vu
LCAyNyBGZWIgMjAyMiBhdCAxMTozMCwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4g
d3JvdGU6Cj4+Pj4gT24gU3VuLCAyNyBGZWIgMjAyMiBhdCAxMTowMywgSmFzb24gQS4gRG9uZW5m
ZWxkIDxKYXNvbkB6eDJjNC5jb20+IHdyb3RlOgo+Pj4+PiBPbiAyLzI3LzIyLCBBcmQgQmllc2hl
dXZlbCA8YXJkYkBrZXJuZWwub3JnPiB3cm90ZToKPj4+Pj4+IE9uIFNhdCwgMjYgRmViIDIwMjIg
YXQgMjM6MDcsIEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25AengyYzQuY29tPiB3cm90ZToKPj4+
Pj4+PiBGcm9tOiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgo+Pj4+Pj4+Cj4+Pj4+
PiBQbGVhc2UgZG9uJ3QgaW52ZW50IHBhdGNoIGF1dGhvcnMgbGlrZSB0aGF0LiBBbGV4J3MgcGF0
Y2ggdGhhdCBzdGFydGVkCj4+Pj4+PiB0aGlzIGRpc2N1c3Npb24gd2FzIGNvbXBsZXRlbHkgZGlm
ZmVyZW50Lgo+Pj4+PiBDb25zaWRlcmluZyB0aGUgaW52ZXN0aWdhdGl2ZSBzaWRlICgid2h5IHdv
bid0IHRoZSBfQ0lEIG1hdGNoPyIpIGFuZAo+Pj4+PiBtb3N0IHRoZSBjb21taXQgbWVzc2FnZSB3
ZXJlIEFsZXgncywgYW5kIHRoYXQgdGhvc2UgdGhpbmdzIGNvbXByaXNlCj4+Pj4+IDk1JSBvZiB3
aGF0IHRoaXMgcGF0Y2ggaXMsIGFuZCB0aGF0IHRoZSBjb2RlIGNoYW5nZSBpdHNlbGYgaXNuJ3Qg
ZXZlbgo+Pj4+PiBwYXJ0IG9mIGFueXRoaW5nIFR1cmluZyBjb21wbGV0ZSwgSSBtb3N0IGNlcnRh
aW5seSBkaWQgbm90IGZlZWwKPj4+Pj4gY29tZm9ydGFibGUgc3RyaXBwaW5nIEFsZXgncyBhdXRo
b3JzaGlwLiBJbnN0ZWFkIEkgYWRkZWQgbXlzZWxmIGFzIGEKPj4+Pj4gY28tYXV0aG9yIGF0IHRo
ZSBib3R0b20uIFdoZW4gaW4gZG91YnQsIGVyciBvbiB0aGUgc2lkZSBvZiBjcmVkaXRpbmcKPj4+
Pj4gb3RoZXJzLiBBbGV4IGFsc28gdG9vayBhIGxvb2sgYXQgdGhpcyBwYXRjaCwgSSBhbSB1bmRl
ciB0aGUgaW1wcmVzc2lvbgo+Pj4+PiBvZiBhdCBsZWFzdCwgYmVmb3JlIGl0IHdlbnQgb3V0LiBM
ZXQncyBtaW5pbWl6ZSB0aGUgcGFwZXJ3b3JrCj4+Pj4+IHBvbGljaW5nLCBva2F5PyBJIHRoaW5r
IGl0J2QgbWFrZSBmb3IgYSBtdWNoIG1vcmUgcGxlYXNhbnQgc3BhY2UgaGVyZS4KPj4+IC4uLgo+
Pj4+IFBsZWFzZSBzdG9wIHdpdGggdGhlIGFkIGhvbWluZW1zIGluIHJlc3BvbnNlIHRvIGNyaXRp
Y2lzbSBvbiBmYWN0dWFsCj4+Pj4gYXNwZWN0cyBvZiB5b3VyIGNvZGUuIFB1dHRpbmcgc29tZW9u
ZSBlbHNlJ3MgYXV0aG9yc2hpcCBvbiBjb2RlIHRoZXkKPj4+PiBkaWQgbm90IHdyaXRlIGlzIG5v
dCBjb29sLCBhbmQgcG9pbnRpbmcgdGhhdCBvdXQgaXMgKm5vdCogd2hhdCBpcwo+Pj4+IG1ha2lu
ZyB0aGlzIHNwYWNlIHVucGxlYXNhbnQuCj4+Pj4gQW5kICdwYXBlcndvcmsgcG9saWNpbmcnIGlz
IHNhZGx5IGFuIGltcG9ydGFudCBhc3BlY3Qgb2YgYSBoaWdoCj4+Pj4gcHJvZmlsZSBvcGVuIHNv
dXJjZSBwcm9qZWN0IHN1Y2ggYXMgTGludXguCj4+Pj4KPj4+IEkgdHlwZWQgdGhpcyBiZWZvcmUg
cmVhZGluZyB5b3VyIG1lc3NhZ2Ugb24gSVJDLCB3aGljaCByZWFkczoKPj4+Cj4+PiAiQWxleCBs
b29rZWQgYXQgdGhhdCBwYXRjaCBiZWZvcmUgaSBzZW50IGl0IG91dCBhbmQgZGlkIG5vdCBvYmpl
Y3QgdG8KPj4+IG1lIGtlZXBpbmcgaGlzIGF1dGhvcnNoaXAuIEkgd291bGRuJ3QgaGF2ZSBzZW50
IGl0IG91dCBvdGhlcndpc2UuIgo+Pj4KPj4+IGFuZCBzbyBJIHN0YW5kIGNvcnJlY3RlZCBpZiB0
aGlzIGlzIHRydWUuIEJ1dCBwbGVhc2UsIG5leHQgdGltZSwKPj4+IHBsZWFzZSBiZSBtb3JlIGNs
ZWFyIGFib3V0IHRoZXNlIHRoaW5ncy4KPj4KPj4gWWVzLCBoZSBkaWQgcmVhY2ggb3V0IHRvIG1l
IG9uIGEgc2VwYXJhdGUgY2hhbm5lbCBhbmQgSSB0b2xkIGhpbSB0byBnbwo+PiBmb3IgaXQgOiku
IFNvcnJ5IGlmIEkgY3JlYXRlZCBzb21lIGNvbmZ1c2lvbiB3aXRoIHRoYXQuCj4+Cj4gTm8sIG15
IGJhZC4gQnV0IGluIG15IGRlZmVuY2UsIGV2ZXJ5b25lIG9uIHRoZSBvcmlnaW5hbCB0aHJlYWQg
a25vd3MKPiB0aGF0IHRoaXMgc2luZ2xlIG9uZWxpbmUgY2hhbmdlIHdhcyBzdWdnZXN0ZWQgYnkg
SmFzb24sIG5vdCB5b3UsIGFuZAo+IHNvIHNlZWluZyBoaW0gcG9zdGluZyBpdCBhcyB5b3VyIHBh
dGNoIGRpZCBjb25mdXNlIG1lIGEgbGl0dGxlLgoKClRoZSBpZGVhIGNhbWUgdXAgMXkgYWdvIGlu
IGNvbnZlcnNhdGlvbnMgd2l0aCBBZHJpYW4gd2hlbiB3ZSB0cmllZCB0byAKbWFrZSBfQ0lEIG1h
dGNoaW5nIHdvcmsuIFVuZm9ydHVuYXRlbHkgSSBkaWQgbm90IGZpbGUgYSBwYXRlbnQgZm9yIHRo
ZSAKbWVjaGFuaXNtIHRvIGluY3JlYXNlIHRoZSBhcnJheSBzaXplIHVudGlsIGRhdGEgZml0cyA6
KS4gSXQncyBzdWNoIGEgCnJldm9sdXRpb25hcnkgaW52ZW50aW9uIQoKQmFjayB0byBzZXJpb3Vz
bmVzcywgSSdtIHByZXR0eSBpbmRpZmZlcmVudCBvbiB0aGUgYXR0cmlidXRpb24gZm9yIGl0LiAK
V2hhdCBJJ20gbW9yZSBpbnRlcmVzdGVkIGluIGlzIGEgc29sdXRpb24gdGhhdCBhbGxvd3MgdXMg
dG8gbWF0Y2ggdGhlIApjb3JyZWN0IGlkZW50aWZpZXIgOikuIE15IHRha2UgaXMgdGhhdCBKYXNv
biBqdXN0IHdhbnRlZCB0byBiZSBuaWNlIGFuZCAKd2FzIHRyeWluZyB0byBnaXZlIGNyZWRpdC4K
CgpBbGV4CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vu
c3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFl
Z2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVu
YnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4
NzkKCgo=

