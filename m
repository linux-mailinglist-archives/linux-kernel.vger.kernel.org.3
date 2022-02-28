Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44DC4C7C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiB1WB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiB1WBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:01:54 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A6E91372;
        Mon, 28 Feb 2022 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1646085674; x=1677621674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fn11igQC85sMzc5G8wFpQpCmWfOeTc++11vOKMEmwlQ=;
  b=ep1GIPk9FiAodaqtmRQHs9LcUUOW1viFdLiCrvxrfH7R8YziHh98Y16G
   WIPLTY1k2gAk0Bn0CX76C5Idk18IaOgtI7O6Er4odja6HfcTPGcqBw39y
   Ku9UFMiQugbNPPVBVW2o7eQptRGUPAHT+3n1m8VN+J+S63OvtX/EgCR7U
   0=;
X-IronPort-AV: E=Sophos;i="5.90,144,1643673600"; 
   d="scan'208";a="181909613"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 28 Feb 2022 22:01:03 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com (Postfix) with ESMTPS id ED156C08E3;
        Mon, 28 Feb 2022 22:01:00 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 28 Feb 2022 22:01:00 +0000
Received: from [0.0.0.0] (10.43.160.103) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.28; Mon, 28 Feb
 2022 22:00:57 +0000
Message-ID: <db551fce-632e-c84f-3a3e-2733af9dcd46@amazon.com>
Date:   Mon, 28 Feb 2022 23:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Len Brown" <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
 <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <Yh0+LA8B1jw8tnl9@smile.fi.intel.com>
X-Originating-IP: [10.43.160.103]
X-ClientProxiedBy: EX13D04UWB003.ant.amazon.com (10.43.161.231) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwKCk9uIDI4LjAyLjIyIDIyOjI3LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4gT24g
TW9uLCBGZWIgMjgsIDIwMjIgYXQgMTA6MDI6NDNQTSArMDEwMCwgQXJkIEJpZXNoZXV2ZWwgd3Jv
dGU6Cj4+IE9uIE1vbiwgMjggRmViIDIwMjIgYXQgMjE6NDcsIEFuZHkgU2hldmNoZW5rbyA8YW5k
eS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4gd3JvdGU6Cj4+PiBPbiBNb24sIEZlYiAyOCwgMjAyMiBh
dCA5OjI4IFBNIEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25AengyYzQuY29tPiB3cm90ZToKPj4+
PiBGcm9tOiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgo+Pj4+Cj4+Pj4gV2UgY3Jl
YXRlIGEgbGlzdCBvZiBBQ1BJICJQTlAiIElEcyB3aGljaCBjb250YWlucyBfSElELCBfQ0lELCBh
bmQgQ0xTCj4+Pj4gZW50cmllcyBvZiB0aGUgcmVzcGVjdGl2ZSBkZXZpY2VzLiBIb3dldmVyLCB3
aGVuIG1ha2luZyBzdHJ1Y3RzIGZvcgo+Pj4+IG1hdGNoaW5nLCB3ZSBzcXVlZXplIHRob3NlIElE
cyBpbnRvIGFjcGlfZGV2aWNlX2lkLCB3aGljaCBvbmx5IGhhcyA5Cj4+Pj4gYnl0ZXMgc3BhY2Ug
dG8gc3RvcmUgdGhlIGlkZW50aWZpZXIuIFRoZSBzdWJzeXN0ZW0gYWN0dWFsbHkgY2FwdHVyZXMg
dGhlCj4+Pj4gZnVsbCBsZW5ndGggb2YgdGhlIElEcywgYW5kIHRoZSBtb2RhbGlhcyBoYXMgdGhl
IGZ1bGwgbGVuZ3RoLCBidXQgdGhpcwo+Pj4+IHN0cnVjdCB3ZSB1c2UgZm9yIG1hdGNoaW5nIGlz
IGxpbWl0ZWQuIEl0IG9yaWdpbmFsbHkgaGFkIDE2IGJ5dGVzLCBidXQKPj4+PiB3YXMgY2hhbmdl
ZCB0byBvbmx5IGhhdmUgOSBpbiA2NTQzYmVjZjI2ZmYgKCJtb2QvZmlsZTJhbGlhczogbWFrZQo+
Pj4+IG1vZGFsaWFzIGdlbmVyYXRpb24gc2FmZSBmb3IgY3Jvc3MgY29tcGlsaW5nIiksIHByZXN1
bWFibHkgb24gdGhlIHRoZW9yeQo+Pj4+IHRoYXQgaXQgd291bGQgbWF0Y2ggdGhlIEFDUEkgc3Bl
YyBzbyBpdCBkaWRuJ3QgbWF0dGVyLgo+Pj4+IFVuZm9ydHVuYXRlbHksIHdoaWxlIG1vc3QgcGVv
cGxlIGFkaGVyZSB0byB0aGUgQUNQSSBzcGVjcywgTWljcm9zb2Z0Cj4+Pj4gZGVjaWRlZCB0aGF0
IGl0cyBWTSBHZW5lcmF0aW9uIENvdW50ZXIgZGV2aWNlIFsxXSBzaG91bGQgb25seSBiZQo+Pj4+
IGlkZW50aWZpYWJsZSBieSBfQ0lEIHdpdGggYSB2YWx1ZSBvZiAiVk1fR2VuX0NvdW50ZXIiLCB3
aGljaCBpcyBsb25nZXIKPj4+PiB0aGFuIDkgY2hhcmFjdGVycy4KPj4+IFRoZW4gd2h5IGRvIHdl
IG5vdCBzZWUgdGhlIEVDUiBmcm9tIHNvbWVib2R5IHRvIHVwZGF0ZSB0aGUgc3BlYyBvciB0bwo+
Pj4gZml4IE1TJyBhYnVzZSBvZiBpdD8KPj4+IEkgYmVsaWV2ZSBfdGhpc18gc2hvdWxkIGJlIHRo
ZSBwcmVyZXF1aXNpdGUgdG8gdGhlIHByb3Bvc2VkIGNoYW5nZS4KPj4gV2hhdCBleGFjdGx5IGFy
ZSB5b3Ugc3VnZ2VzdGluZyBoZXJlPyBUaGF0IHRoZSBjb250cmlidXRvciBvZiB0aGlzCj4+IHBh
dGNoIGpvaW5zIHRoZSBVRUZJIGZvcnVtIGFzIGFuIGluZGl2aWR1YWwgYWRvcHRlciBpbiBvcmRl
ciB0byBnZXQKPj4gdGhlIEFDUEkgc3BlYyB1cGRhdGVkIGJlZm9yZSB3ZSBjYW4gYWR2YW5jZSB3
aXRoIHRoaXMgcGF0Y2g/IE9yIHRoYXQKPj4gaGUgd29ya3Mgd2l0aCBNaWNyb3NvZnQgdG8gZ2V0
IHRoZW0gdG8gcmVmcmFpbiBmcm9tIHZpb2xhdGluZyBpdD8KPj4KPj4gSSBkb24ndCB0aGluayB0
aGF0IGlzIHJlYXNvbmFibGUgb3IgcmVhbGlzdGljLiBUaGUga2VybmVsIGlzIGFscmVhZHkKPj4g
cmlkZGxlZCB3aXRoIFVFRkkgYW5kIEFDUEkgcXVpcmtzIHRoYXQgYXJlIG9ubHkgdGhlcmUgYmVj
YXVzZSBzb21lCj4+IHRlYW1zIGF0IE1TIGRvbid0IHRha2UgdGhlIEFDUEkgc3BlYyB0b28gbGl0
ZXJhbGx5ICh3aGljaCBpcyB3aHkgdGhleQo+PiBoYXZlIHRoZWlyIG93biBBTUwgY29tcGlsZXIs
IGZvciBvbmUpLCBhbmQgUEMgdmVuZG9ycyBvbmx5IGNhcmUgYWJvdXQKPj4gdGhlIFdpbmRvd3Mg
c3RpY2tlciwgc28gdGhleSBkb24ndCBjYXJlIGFib3V0IHRoZSBBQ1BJIHNwZWMgZWl0aGVyLgo+
Pgo+PiBTbyBJIGRvbid0IHRoaW5rIHRoaXMgaXMgdGhlIHJpZ2h0IHRpbWUgdG8gZ2V0IHBlZGFu
dGljIGFib3V0IHRoaXMuCj4+IE91ciBBQ1BJIHN1YnN5c3RlbSBhbHJlYWR5IGRlYWxzIHdpdGgg
Q0lEcyB0aGF0IGFyZSBsb25nZXIgdGhhbiA4Cj4+IGNoYXJhY3RlcnMgKHdoaWNoIGFyZSBidHcg
cGVybWl0dGVkIGJ5IHRoZSBBQ1BJIHNwZWMgZm9yIGJ1cyB0b3BvbG9neQo+PiByZWxhdGVkIG1l
dGFkYXRhKSwgdGhlIG9ubHkgdGhpbmcgYmVpbmcgY2hhbmdlZCBoZXJlIGlzIHRoZSBhYmlsaXR5
IHRvCj4+IGFjdHVhbGx5IG1hdGNoIGFnYWluc3Qgc3VjaCBpZGVudGlmaWVycy4KPiBNeSBwb2lu
dCBpcyB0aGF0IHRoaXMgaXMgY2xlYXIgYWJ1c2Ugb2YgdGhlIHNwZWMgYW5kOgo+IDEpIHdlIGhh
dmUgdG8gZW5hYmxlIHRoZSBicm9rZW4sIGJlY2F1c2UgaXQgaXMgYWxyZWFkeSBpbiB0aGUgd2ls
ZCB3aXRoCj4gICAgIHRoZSBjb21tZW50IHRoYXQgdGhpcyBpcyBhbiBpc3N1ZQo+Cj4gQU5ECj4K
PiAyKSBpc3N1ZSBhbiBFQ1IgLyB3b3JrIHdpdGggTVMgdG8gbWFrZSBzdXJlIHRoZXkgdW5kZXJz
dGFuZCB0aGUgcHJvYmxlbS4KPgo+IFRoaXMgY2FuIGJlIGRvbmUgaW4gcGFyYWxsZWwuIFdoYXQg
SSBtZWFudCBhcyBhIHByZXJlcXVpc2l0ZSBpcyB0byBzdGFydCBkb2luZwo+IDIpIHdoaWxlIHdl
IGhhdmUgMSkgb24gdGFibGUuCgoKV2hpbGUgdHJ5aW5nIHRvIHJldmFsaWRhdGUgd2hldGhlciB0
aGlzIHJlYWxseSBpcyBicmVha2luZyB0aGUgc3BlYywgCkkndmUgdHJpZWQgdG8gcmVyZWFkIHRo
ZSByZXNwZWN0aXZlIHNlY3Rpb24gaW4gaXQgYW5kIEknbSBhZnJhaWQgdGhhdCBpdCAKbWF5IGJl
IHZhbGlkIHVzZSBvZiB0aGUgX0NJRCBpZGVudGlmaWVyOgoKCiIiIgoKNi4xLjIgX0NJRCAoQ29t
cGF0aWJsZSBJRCkKClRoaXMgb3B0aW9uYWwgb2JqZWN0IGlzIHVzZWQgdG8gc3VwcGx5IE9TUE0g
d2l0aCBhIGRldmljZeKAmXMgUGx1ZyBhbmQgClBsYXktQ29tcGF0aWJsZSBEZXZpY2UgSUQuIFVz
ZSBfQ0lEIG9iamVjdHMgd2hlbiBhIGRldmljZSBoYXMgbm8gb3RoZXIgCmRlZmluZWQgaGFyZHdh
cmUgc3RhbmRhcmQgbWV0aG9kIHRvIHJlcG9ydCBpdHMgY29tcGF0aWJsZSBJRHMuIFRoZSBfQ0lE
IApvYmplY3QgaXMgdmFsaWQgb25seSB3aXRoaW4gYSBGdWxsIERldmljZSBEZXNjcmlwdG9yLiBB
biBfSElEIG9iamVjdCAKbXVzdCBhbHNvIGJlIHByZXNlbnQuCgpBcmd1bWVudHM6CgpOb25lCgpS
ZXR1cm4gVmFsdWU6CkFuIEludGVnZXIgb3IgU3RyaW5nIGNvbnRhaW5pbmcgYSBzaW5nbGUgQ0lE
IG9yIGEgUGFja2FnZSBjb250YWluaW5nIGEgCmxpc3Qgb2YgQ0lEcyBBIF9DSUQgb2JqZWN0IGV2
YWx1YXRlcyB0byBlaXRoZXI6CgogICoKCiAgICBBIHNpbmdsZSBDb21wYXRpYmxlIERldmljZSBJ
RAoKICAqCgogICAgQSBwYWNrYWdlIG9mIENvbXBhdGlibGUgRGV2aWNlIElEcyBmb3IgdGhlIGRl
dmljZSDigJMgaW4gdGhlIG9yZGVyIG9mCiAgICBwcmVmZXJlbmNlLCBoaWdoZXN0IHByZWZlcmVu
Y2UgZmlyc3QuCgpFYWNoIENvbXBhdGlibGUgRGV2aWNlIElEIG11c3QgYmUgZWl0aGVyOgoKICAq
CgogICAgQSB2YWxpZCBISUQgdmFsdWUgKGEgMzItYml0IGNvbXByZXNzZWQgRUlTQSB0eXBlIElE
IG9yIGEgc3RyaW5nIHN1Y2gKICAgIGFzIOKAnEFDUEkwMDA04oCdKS4KCiAgKgoKICAgIEEgc3Ry
aW5nIHRoYXQgdXNlcyBhIGJ1cy1zcGVjaWZpYyBub21lbmNsYXR1cmUuIEZvciBleGFtcGxlLCBf
Q0lECiAgICBjYW4gYmUgdXNlZCB0byBzcGVjaWZ5IHRoZSBQQ0kgSUQuIFRoZSBmb3JtYXQgb2Yg
YSBQQ0kgSUQgc3RyaW5nIGlzCiAgICBvbmUgb2YgdGhlIGZvbGxvd2luZzoKCiJQQ0lcQ0NfY2Nz
cyIgIlBDSVxDQ19jY3NzcHAiIAoiUENJXFZFTl92dnZ2JkRFVl9kZGRkJlNVQlNZU19zc3Nzc3Nz
cyZSRVZfcnIiIAoiUENJXFZFTl92dnZ2JkRFVl9kZGRkJlNVQlNZU19zc3Nzc3NzcyIgIlBDSVxW
RU5fdnZ2diZERVZfZGRkZCZSRVZfcnIiIAoiUENJXFZFTl92dnZ2JkRFVl9kZGRkIgoKIiIiCgpJ
biB0aGlzIGNhc2UsIHlvdSBjb3VsZCBpbnRlcnByZXQgdGhpbmdzIGFzIGxvb2tpbmcgYXQgImJ1
cy1zcGVjaWZpYyAKbm9tZW5jbGF0dXJlIiBjYXNlIHdoaWNoIGV2ZW4gaW4gdGhlIGV4YW1wbGVz
IG1lbnRpb25lZCBpbiB0aGUgc3BlYyAKZXhjZWVkcyB0aGUgOCBjaGFyYWN0ZXIgbGltaXQgd2Ug
aW1wb3NlIG9uIHRoZSBtYXRjaGluZyBsb2dpYyB0b2RheS4KClRoZXJlIHN0aWxsIGlzIHNwZWMg
dmlvbGF0aW9uIGluIEh5cGVyLVYncyBWTUdlbklEIGRldmljZSdzIF9ISUQgdmFsdWUgCndoaWNo
IGRvZXNuJ3QgZm9sbG93IHRoZSBQTlAgZm9ybWF0LCBidXQgdGhhdCdzIG5vdCByZWxldmFudCBo
ZXJlLiBfQ0lEIApkb2Vzbid0IHNlZW0gdG8gaGF2ZSB0aGUgc2FtZSByZXN0cmljdGlvbnM/CgoK
QWxleAoKCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5z
dHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVn
ZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5i
dXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3
OQoKCg==

