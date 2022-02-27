Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29384C5AAF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiB0Lms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiB0Lmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:42:47 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF782610B;
        Sun, 27 Feb 2022 03:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1645962131; x=1677498131;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R4oQvTqm6F6vO+0nb8QAABXkVb+76E/oM8HPveUAZfM=;
  b=AA+W0oH//n/3GqTDKayiIhvhKFX3Tp0VYDCtWHEKnOVes4M1QKU9E+rX
   AUj66c9X3eWB1pOhZZVI0YKEdUfTSq+lYzBRhOIWMODbORgDv4DcHUqwD
   OLYgGRUnfh3I4dRbN5kTGN5g2iJlYzY8gw/tJOlCzLDCyhh6L1Kp3/u1J
   4=;
X-IronPort-AV: E=Sophos;i="5.90,141,1643673600"; 
   d="scan'208";a="178640669"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-9938edb1.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 27 Feb 2022 11:42:09 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-9938edb1.us-west-2.amazon.com (Postfix) with ESMTPS id 92B1881C0C;
        Sun, 27 Feb 2022 11:42:08 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sun, 27 Feb 2022 11:42:07 +0000
Received: from [0.0.0.0] (10.43.160.203) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.28; Sun, 27 Feb
 2022 11:42:05 +0000
Message-ID: <0c73d29e-e558-efb9-d0d7-c612b2bb7e90@amazon.com>
Date:   Sun, 27 Feb 2022 12:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <20220226220639.1173594-1-Jason@zx2c4.com>
 <20220226220639.1173594-3-Jason@zx2c4.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <20220226220639.1173594-3-Jason@zx2c4.com>
X-Originating-IP: [10.43.160.203]
X-ClientProxiedBy: EX13D31UWA004.ant.amazon.com (10.43.160.217) To
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

Ck9uIDI2LjAyLjIyIDIzOjA2LCBKYXNvbiBBLiBEb25lbmZlbGQgd3JvdGU6Cj4gRnJvbTogQWxl
eGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4KPgo+IFdlIGNyZWF0ZSBhIGxpc3Qgb2YgQUNQ
SSAiUE5QIiBJRHMgd2hpY2ggY29udGFpbnMgX0hJRCwgX0NJRCwgYW5kIENMUwo+IGVudHJpZXMg
b2YgdGhlIHJlc3BlY3RpdmUgZGV2aWNlcy4gSG93ZXZlciwgd2Ugc3F1ZWV6ZSB0aGVtIGludG8g
c3RydWN0Cj4gYWNwaV9kZXZpY2VfaWQsIHdoaWNoIG9ubHkgaGFzIDkgYnl0ZXMgc3BhY2UgdG8g
c3RvcmUgdGhlIGlkZW50aWZpZXIuIEl0Cj4gb3JpZ2luYWxseSBoYWQgMTYgYnl0ZXMsIGJ1dCB3
YXMgY2hhbmdlZCB0byBvbmx5IGhhdmUgOSBpbiA2NTQzYmVjZjI2ZmYKPiAoIm1vZC9maWxlMmFs
aWFzOiBtYWtlIG1vZGFsaWFzIGdlbmVyYXRpb24gc2FmZSBmb3IgY3Jvc3MgY29tcGlsaW5nIiks
Cj4gcHJlc3VtYWJseSBvbiB0aGUgdGhlb3J5IHRoYXQgaXQgd291bGQgbWF0Y2ggdGhlIEFDUEkg
c3BlYyBzbyBpdCBkaWRuJ3QKPiBtYXR0ZXIuCj4KPiBVbmZvcnR1bmF0ZWx5LCB3aGlsZSBtb3N0
IHBlb3BsZSBhZGhlcmUgdG8gdGhlIEFDUEkgc3BlY3MsIE1pY3Jvc29mdAo+IGRlY2lkZWQgdGhh
dCBpdHMgVk0gR2VuZXJhdGlvbiBDb3VudGVyIGRldmljZSBbMV0gc2hvdWxkIG9ubHkgYmUKPiBp
ZGVudGlmaWFibGUgYnkgX0NJRCB3aXRoIGEgdmFsdWUgb2YgIlZNX0dlbl9Db3VudGVyIiwgd2hp
Y2ggaXMgbG9uZ2VyCj4gdGhhbiA5IGNoYXJhY3RlcnMuCj4KPiBUbyBhbGxvdyBkZXZpY2UgZHJp
dmVycyB0byBtYXRjaCBpZGVudGlmaWVycyB0aGF0IGV4Y2VlZCB0aGUgOSBieXRlCj4gbGltaXQs
IHRoaXMgc2ltcGx5IHVwcyB0aGUgbGVuZ3RoIHRvIDE2LCBqdXN0IGxpa2UgaXQgd2FzIGJlZm9y
ZSB0aGUKPiBhZm9yZW1lbnRpb25lZCBjb21taXQuIEVtcGlyaWNhbCB0ZXN0aW5nIGluZGljYXRl
cyB0aGF0IHRoaXMKCgpUaGlzIGlzIG9ubHkgdHJ1ZSBmb3IgNjRiaXQgc3lzdGVtcyB3aGVyZSBw
YWRkaW5nIGF1dG9tYXRpY2FsbHkgYmxvYXRlZCAKdG8gOSBieXRlIGFycmF5IHRvIDE2LiBJIHN0
aWxsIGJlbGlldmUgdGhlIHBhdGNoIGlzIGZpbmUgYXMgaXQgaXMsIGJ1dCAKdGhlcmUgd2lsbCBi
ZSBtaW5vciAucm9kYXRhIG92ZXJoZWFkIG9uIDMyYml0IHRhcmdldHMgd2hpY2ggeW91IG1heSB3
YW50IAp0byBxdWFudGlmeSBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uCgoKVGhhbmtzIGEgbG90
IGZvciBzZW5kaW5nIHRoaXMgb3V0ISBBbmQgbGV0J3MgaG9wZSB0aGF0IDE2IGJ5dGVzIGlzIApl
bm91Z2ggZm9yIGV2ZXJ5b25lLgoKQWxleAoKCj4gZG9lc24ndCBhY3R1YWxseSBpbmNyZWFzZSB2
bWxpbnV4IHNpemUsIGJlY2F1c2UgdGhlIHVsb25nIGluIHRoZSBzYW1lCj4gc3RydWN0IGNhdXNl
ZCB0aGVyZSB0byBiZSA3IGJ5dGVzIG9mIHBhZGRpbmcgYW55d2F5Lgo+Cj4gVGhpcyBwYXRjaCBp
cyBhIHByZXJlcXVpc2l0ZSB0byBhZGQgc3VwcG9ydCBmb3IgVk1HZW5JRCBpbiBMaW51eCwgdGhl
Cj4gc3Vic2VxdWVudCBwYXRjaCBpbiB0aGlzIHNlcmllcy4gSXQgaGFzIGJlZW4gY29uZmlybWVk
IHRvIGFsc28gd29yayBvbgo+IHRoZSB1ZGV2L21vZGFsaWFzIHNpZGUgaW4gdXNlcnNwYWNlLgo+
Cj4gWzFdIGh0dHBzOi8vZG93bmxvYWQubWljcm9zb2Z0LmNvbS9kb3dubG9hZC8zLzEvQy8zMUNG
QzMwNy05OENBLTRDQTUtOTE0Qy1EOTc3MjY5MUUyMTQvVmlydHVhbE1hY2hpbmVHZW5lcmF0aW9u
SUQuZG9jeAo+Cj4gQ2M6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+Cj4gQ2M6IExl
biBCcm93biA8bGVuYkBrZXJuZWwub3JnPgo+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+Cj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+Cj4gQ28tYXV0aG9yZWQtYnk6IEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25Aengy
YzQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+Cj4g
LS0tCj4gSGkgUmFmYWVsICYgTGVuLAo+Cj4gVGhpcyBwYXRjaHNldCBpcyBkaXJlY3RlZCB0b3dh
cmQgeW91IHR3byBzcGVjaWZpY2FsbHkuIFBhdGNoZXMgMS8zIGFuZAo+IDMvMyBoYXZlIGJlZW4g
dGhyb3VnaCB0aGUgcmluZ2VyIG9mIHJldmlldyBhIGJpdCBhbHJlYWR5IGFuZCBkbyBub3QKPiBz
cGVjaWZpY2FsbHkgcmVxdWlyZSB5b3VyIGF0dGVudGlvbiwgYnV0IGluIHY0IHdlIHdvdW5kIHVw
IGdldHRpbmcgaHVuZwo+IHVwIG9uIGFuIEFDUEkgQVBJIGxpbWl0YXRpb24uIFRoaXMgdjUgZml4
ZXMgdGhhdCBsaW1pdGF0aW9uIHdpdGggdGhpcwo+IDIvMyBwYXRjaCB0aGF0IHlvdSBzZWUgaGVy
ZSwgd2l0aCBhIHRyaXZpYWwgb25lIGxpbmUgZml4LCB3aGljaCBkb2VzCj4gcmVxdWlyZSB5b3Vy
IGF0dGVudGlvbi4KPgo+IFBhdGNoZXMgMS8zIGFuZCAzLzMgd2lsbCBnbyB0aHJvdWdoIG15IHJh
bmRvbS5naXQgdHJlZS4gSG93ZXZlciwgMy8zCj4gYWN0dWFsbHkgZGVwZW5kcyBvbiB0aGlzIG9u
ZSBoZXJlLCAyLzMsIGluIG9yZGVyIHRvIGNvbXBpbGUgd2l0aG91dAo+IHdhcm5pbmdzIChhbmQg
YmUgZnVuY3Rpb25hbCBhdCBhbGwpLiBUaGVyZWZvcmUsIGl0IHdvdWxkIGJlIG5pY2UgaWYgeW91
Cj4gd291bGQgcHJvdmlkZSBhbiAiQWNrZWQtYnkiIG9uIGl0IGFuZCBwZXJtaXQgbWUgdG8gL2Fs
c28vIHRha2UgaXQKPiB0aHJvdWdoIG15IHJhbmRvbS5naXQgdHJlZSAoaWYgaXQgbG9va3MgbGlr
ZSBhIGNvcnJlY3QgcGF0Y2ggdG8geW91LCBvZgo+IGNvdXJzZSkuIFRoaXMgd291bGQgbWFrZSB0
aGUgbWVyZ2UgbG9naXN0aWNzIGEgbG90IGVhc2llci4gUGx1cyBpdCdzIGEKPiBzbWFsbCArMS8t
MSBsaW5lIGNoYW5nZS4KPgo+IFBsZWFzZSBoYXZlIGEgbG9vayBhbmQgbGV0IG1lIGtub3cgd2hh
dCB5b3UgdGhpbmsuCj4KPiBUaGFua3MsCj4gSmFzb24KPgo+ICAgaW5jbHVkZS9saW51eC9tb2Rf
ZGV2aWNldGFibGUuaCB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW9kX2RldmljZXRh
YmxlLmggYi9pbmNsdWRlL2xpbnV4L21vZF9kZXZpY2V0YWJsZS5oCj4gaW5kZXggNGJiNzE5Nzlh
OGZkLi41ZGE1ZDk5MGZmNTggMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9tb2RfZGV2aWNl
dGFibGUuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvbW9kX2RldmljZXRhYmxlLmgKPiBAQCAtMjEx
LDcgKzIxMSw3IEBAIHN0cnVjdCBjc3NfZGV2aWNlX2lkIHsKPiAgICAgICAgICBrZXJuZWxfdWxv
bmdfdCBkcml2ZXJfZGF0YTsKPiAgIH07Cj4KPiAtI2RlZmluZSBBQ1BJX0lEX0xFTiAgICA5Cj4g
KyNkZWZpbmUgQUNQSV9JRF9MRU4gICAgMTYKPgo+ICAgc3RydWN0IGFjcGlfZGV2aWNlX2lkIHsK
PiAgICAgICAgICBfX3U4IGlkW0FDUElfSURfTEVOXTsKPiAtLQo+IDIuMzUuMQo+CgoKCkFtYXpv
biBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJl
cmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdl
aXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAx
NDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

