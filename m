Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2A58E975
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiHJJUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiHJJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:20:11 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD776B140
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1660123204; x=1691659204;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=AnDfQDpBP4GgJEu36Hy9FNfrq6eZxD+PPcjx3+GqAqw=;
  b=c3fyiSXq9/PrQ3s0wRK4TMWBSS+PF0OHj/NJzDdd5JKUer9875lH/Zjy
   HOqlopTlH/E8BXAduLA52IwRBNwhiDAJHRRt35GtVTN60iOokoB/WNUrc
   5MUMyG/RPewuVLKCY2vn3b7T6LrozNEcs+sz5gTQP45jVprMqtLEJd62y
   0=;
X-IronPort-AV: E=Sophos;i="5.93,226,1654560000"; 
   d="scan'208";a="216762382"
Subject: Re: [PATCH 0/2] virt: vmgenid: add generation counter
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 09:19:49 +0000
Received: from EX13D37EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-35b1f9a2.us-east-1.amazon.com (Postfix) with ESMTPS id 70EEB201521;
        Wed, 10 Aug 2022 09:19:48 +0000 (UTC)
Received: from [10.85.98.134] (10.43.162.227) by EX13D37EUA003.ant.amazon.com
 (10.43.165.7) with Microsoft SMTP Server (TLS) id 15.0.1497.36; Wed, 10 Aug
 2022 09:19:44 +0000
Message-ID: <a9e4dd0f-7b1a-dad1-c86a-75059c20f68e@amazon.es>
Date:   Wed, 10 Aug 2022 11:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
From:   <bchalios@amazon.es>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        <linux-kernel@vger.kernel.org>, <tytso@mit.edu>,
        <dwmw@amazon.co.uk>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        <gregkh@linuxfoundation.org>, <mikelley@microsoft.com>
References: <20220803152127.48281-1-bchalios@amazon.es>
 <Yuve4vuAnU85mdRY@zx2c4.com>
In-Reply-To: <Yuve4vuAnU85mdRY@zx2c4.com>
X-Originating-IP: [10.43.162.227]
X-ClientProxiedBy: EX13D42UWA004.ant.amazon.com (10.43.160.18) To
 EX13D37EUA003.ant.amazon.com (10.43.165.7)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzb24KCk9uIDgvNC8yMiA0OjU5IFBNLCAiSmFzb24gQS4gRG9uZW5mZWxkIiA8SmFzb25A
engyYzQuY29tPiB3cm90ZToKPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBv
dXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlciBhbmQga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLgo+IAo+IAo+IAo+IEhpIEJhYmlzLAo+IAo+IE9uIFdlZCwgQXVnIDAz
LCAyMDIyIGF0IDA1OjIxOjI1UE0gKzAyMDAsIGJjaGFsaW9zQGFtYXpvbi5lcyB3cm90ZToKPiA+
IEZyb206IEJhYmlzIENoYWxpb3MgPGJjaGFsaW9zQGFtYXpvbi5lcz4KPiA+Cj4gPiBMaW51eCBy
ZWNlbnRseSBhZGRlZCBzdXBwb3J0IGZvciB0aGUgVk0gR2VuZXJhdGlvbiBJRCBtZWNoYW5pc20g
ZnJvbQo+ID4gTWljcm9zb2Z0LiBUaGUgd2F5IHRoaXMgd29ya3MgY3VycmVudGx5IGlzIHVzaW5n
IHRoZSAxMjgtYml0IGJsb2IKPiA+IHByb3ZpZGVkIGJ5IHRoZSB2bWdlbmlkIGRldmljZSB0byBy
ZS1zZWVkIHRoZSBSTkcuIFdoaWxlIHRoaXMgd29ya3MgaXQKPiA+IGhhcyB0d28gbWFpbiBpc3N1
ZXMsIChhKSBpdCBpcyBpbmhlcmVudGx5IHJhY3kgZHVlIHRvIHRoZSBmYWN0IHRoYXQgaXQKPiA+
IHJlbGllcyBvbiBhIEFDUEkgbm90aWZpY2F0aW9uIGJlaW5nIGRlbGl2ZXJlZCBhbmQgaGFuZGxl
ZCBhbmQgKGIpIHRoZSBJRAo+ID4gaXMgdW5zdWl0YWJsZSBmb3IgZXhwb3NpbmcgdG8gdXNlci1z
cGFjZS4KPiA+Cj4gPiBUaGlzIHBhdGNoLXNldCBleHRlbmRzIHRoZSB2bWdlbmlkIGRldmljZSB0
byBpbnRyb2R1Y2UgYSBnZW5lcmF0aW9uCj4gPiBjb3VudGVyLCBhIDMyLWJpdCBjb3VudGVyIHdo
aWNoIGlzIGRpZmZlcmVudCBldmVyeSB0aW1lIHRoZSB1bmlxdWUgSUQKPiA+IGNoYW5nZXMuIFRo
ZSBhZGRpdGlvbiB0byB0aGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24gaW4gUUVNVSBjYW4gYmUK
PiA+IGZvdW5kIGhlcmU6Cj4gPiBodHRwczovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2ZS9odG1s
L3FlbXUtZGV2ZWwvMjAyMi0wOC9tc2cwMDUyNC5odG1sLgo+ID4KPiA+IFRoZSBmaXJzdCBwYXRj
aCByZS13b3JrcyBzbGlnaHRseSB0aGUgY3VycmVudCB2bWdlbmlkIGRyaXZlciB0byBhZGQgYQo+
ID4gZnVuY3Rpb24gdGhhdCBwYXJzZXMgYW4gb2JqZWN0IGZyb20gdGhlIHZtZ2VuaWQgZGV2aWNl
IGFuZCByZXR1cm5zIHRoZQo+ID4gcGh5c2ljYWwgYWRkcmVzcyBvZiB0aGUgdm1nZW5pZCBkYXRh
LiBUaGUgc2Vjb25kIHBhdGNoIHVzZXMgdGhhdAo+ID4gZnVuY3Rpb24gdG8gcGFyc2UgYWRkaXRp
b25hbGx5IHRoZSBhZGRyZXNzIG9mIHRoZSBnZW5lcmF0aW9uIGNvdW50ZXIKPiA+IGZyb20gdGhl
IHZtZ2VuaWQgbmFtZXNwYWNlLiBUaGUgY291bnRlciBpcyB0aGVuIGV4cG9zZWQgdG8gdGhlCj4g
PiB1c2VyLXNwYWNlIHRocm91Z2ggYSBtaXNjLWRldmljZSB3aGljaCBwcm92aWRlcyBgcmVhZGAg
YW5kIGBtbWFwYAo+ID4gaW50ZXJmYWNlcy4KPiAKPiBGaXJzdCwgd2l0aCByZWdhcmRzIHRvIHlv
dXIgbW1hcCBpbnRlcmZhY2UsIGl0J3MgbW9yZSBsaWtlbHkgdGhhdCB0aGlzCj4ga2luZCBvZiB0
aGluZyB3aWxsIGJlIGV2ZW50dWFsbHkgZm9sZGVkIGludG8gbXkgaW52ZXN0aWdhdGlvbnMgcmVn
YXJkaW5nCj4gdGhlIFJORyBhbmQgdGhlIHZEU08gKHdoaWNoIHdvdWxkIG1ha2UgdGhpcyBraW5k
IG9mIHRoaW5nIGFjY2Vzc2libGUKPiB3aXRob3V0IG5lZWRpbmcgdGhlIGZpbGUgc3lzdGVtKS4K
PiAKPiBSZWdhcmRpbmcgdGhlIGNvdW50ZXIgaXRzZWxmLCBJIGRvbid0IHdhbnQgdG8gcnVzaCBp
bnRvIGF1Z21lbnRpbmcgdGhlCj4gdm1nZW5pZCBtZWNoYW5pc20gdW50aWwgd2UndmUgaGFkIHNv
bWUgY29udmVyc2F0aW9ucyB3aXRoIE1pY3Jvc29mdC4gQnV0Cj4gYWxzbywgaXQgc2VlbXMgbGlr
ZSB5b3UgbWlnaHQgaGF2ZSBtaXNzZWQgdGhlIGV4dGVuc2l2ZSBwcmV2aW91cwo+IGRpc2N1c3Np
b24gYWJvdXQgdGhpcy4gVGhlcmUgd2FzIHNvbWUgdHJhZGVvZmYgaW4gZWZmaWNpZW5jeSBhYm91
dAo+IG1hcHBpbmcgdGhpcyBhbGwgdGhlIHdheSB0aHJvdWdoLCBhcyBkb2luZyBzbyB3b3VsZCBy
ZXF1aXJlIHRoZSBjb3VudGVyCj4gdG8gYmUgaW4gYSB0b3RhbGx5IHNlcGFyYXRlIHBhZ2UgYXMg
dGhlIG1haW4gMTI4LWJpdCBJRCwgdmVyc3VzIGp1c3QKPiBoYXZpbmcgdGhlIGtlcm5lbCBtYW5h
Z2UgYSBzZXBhcmF0ZSBjb3VudGVyIGFuZCBpbmN1ciBhIHBvdGVudGlhbCBbbWF5YmUKPiBhY2Nl
cHRhYmxlPyB1bmNsZWFyXSByYWNlLgo+IAo+IEphc29uCj4gCgpKdXN0IGxpbmtpbmcgaGVyZSBh
IGNvbW1lbnQgZnJvbSBNaWNoYWVsIG9uIHRoZSBRRU1VIGRpc2N1c3Npb246IGh0dHBzOi8vd3d3
Lm1haWwtYXJjaGl2ZS5jb20vcWVtdS1kZXZlbEBub25nbnUub3JnL21zZzkwMzY5NS5odG1sCgpD
aGVlcnMsCkJhYmlzCgoKQW1hem9uIFNwYWluIFNlcnZpY2VzIHNvY2llZGFkIGxpbWl0YWRhIHVu
aXBlcnNvbmFsLCBDYWxsZSBSYW1pcmV6IGRlIFByYWRvIDUsIDI4MDQ1IE1hZHJpZC4gUmVnaXN0
cm8gTWVyY2FudGlsIGRlIE1hZHJpZCAuIFRvbW8gMjI0NTggLiBGb2xpbyAxMDIgLiBIb2phIE0t
NDAxMjM0IC4gQ0lGIEI4NDU3MDkzNgo=

