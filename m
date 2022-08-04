Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31E3589EE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbiHDPrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiHDPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:47:08 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5888026AE2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1659628027; x=1691164027;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=twNEXovwYOUgueETxZGdHArvB90Hfxl9vpq/QRreiZM=;
  b=Qsyt4SVCN56mg4+hGjUEsozsqepRWzuYm7HFvJ3RBM40JA8tk9z+QPo6
   E7YdQUVPepAuDvnLMFlOMMyK0chjRZgt6xP/M57kEuooCUzV41i/MkxYa
   oqBDNqVlp8/J4S6UIJ3UXx81T99vGx7E8e/yth+IUTTi4abDq2/gA0w7v
   g=;
X-IronPort-AV: E=Sophos;i="5.93,216,1654560000"; 
   d="scan'208";a="1041049345"
Subject: Re: [PATCH 0/2] virt: vmgenid: add generation counter
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-fc41acad.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 15:46:41 +0000
Received: from EX13D37EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-fc41acad.us-east-1.amazon.com (Postfix) with ESMTPS id A36FEC08E2;
        Thu,  4 Aug 2022 15:46:39 +0000 (UTC)
Received: from [192.168.16.77] (10.43.161.31) by EX13D37EUA003.ant.amazon.com
 (10.43.165.7) with Microsoft SMTP Server (TLS) id 15.0.1497.36; Thu, 4 Aug
 2022 15:46:35 +0000
Message-ID: <14961f48-93d9-1193-b4c4-bcc232016b7d@amazon.es>
Date:   Thu, 4 Aug 2022 17:46:30 +0200
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
X-Originating-IP: [10.43.161.31]
X-ClientProxiedBy: EX13D47UWC003.ant.amazon.com (10.43.162.70) To
 EX13D37EUA003.ant.amazon.com (10.43.165.7)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzb24sCgpPbiA4LzQvMjIgNDo1OSBQTSwgIkphc29uIEEuIERvbmVuZmVsZCIgPEphc29u
QHp4MmM0LmNvbT4gd3JvdGU6Cj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20g
b3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4KPiAKPiAKPiAKPiBIaSBCYWJpcywKPiAKPiBPbiBXZWQsIEF1ZyAw
MywgMjAyMiBhdCAwNToyMToyNVBNICswMjAwLCBiY2hhbGlvc0BhbWF6b24uZXMgd3JvdGU6Cj4g
PiBGcm9tOiBCYWJpcyBDaGFsaW9zIDxiY2hhbGlvc0BhbWF6b24uZXM+Cj4gPgo+ID4gTGludXgg
cmVjZW50bHkgYWRkZWQgc3VwcG9ydCBmb3IgdGhlIFZNIEdlbmVyYXRpb24gSUQgbWVjaGFuaXNt
IGZyb20KPiA+IE1pY3Jvc29mdC4gVGhlIHdheSB0aGlzIHdvcmtzIGN1cnJlbnRseSBpcyB1c2lu
ZyB0aGUgMTI4LWJpdCBibG9iCj4gPiBwcm92aWRlZCBieSB0aGUgdm1nZW5pZCBkZXZpY2UgdG8g
cmUtc2VlZCB0aGUgUk5HLiBXaGlsZSB0aGlzIHdvcmtzIGl0Cj4gPiBoYXMgdHdvIG1haW4gaXNz
dWVzLCAoYSkgaXQgaXMgaW5oZXJlbnRseSByYWN5IGR1ZSB0byB0aGUgZmFjdCB0aGF0IGl0Cj4g
PiByZWxpZXMgb24gYSBBQ1BJIG5vdGlmaWNhdGlvbiBiZWluZyBkZWxpdmVyZWQgYW5kIGhhbmRs
ZWQgYW5kIChiKSB0aGUgSUQKPiA+IGlzIHVuc3VpdGFibGUgZm9yIGV4cG9zaW5nIHRvIHVzZXIt
c3BhY2UuCj4gPgo+ID4gVGhpcyBwYXRjaC1zZXQgZXh0ZW5kcyB0aGUgdm1nZW5pZCBkZXZpY2Ug
dG8gaW50cm9kdWNlIGEgZ2VuZXJhdGlvbgo+ID4gY291bnRlciwgYSAzMi1iaXQgY291bnRlciB3
aGljaCBpcyBkaWZmZXJlbnQgZXZlcnkgdGltZSB0aGUgdW5pcXVlIElECj4gPiBjaGFuZ2VzLiBU
aGUgYWRkaXRpb24gdG8gdGhlIG9yaWdpbmFsIGltcGxlbWVudGF0aW9uIGluIFFFTVUgY2FuIGJl
Cj4gPiBmb3VuZCBoZXJlOgo+ID4gaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRt
bC9xZW11LWRldmVsLzIwMjItMDgvbXNnMDA1MjQuaHRtbC4KPiA+Cj4gPiBUaGUgZmlyc3QgcGF0
Y2ggcmUtd29ya3Mgc2xpZ2h0bHkgdGhlIGN1cnJlbnQgdm1nZW5pZCBkcml2ZXIgdG8gYWRkIGEK
PiA+IGZ1bmN0aW9uIHRoYXQgcGFyc2VzIGFuIG9iamVjdCBmcm9tIHRoZSB2bWdlbmlkIGRldmlj
ZSBhbmQgcmV0dXJucyB0aGUKPiA+IHBoeXNpY2FsIGFkZHJlc3Mgb2YgdGhlIHZtZ2VuaWQgZGF0
YS4gVGhlIHNlY29uZCBwYXRjaCB1c2VzIHRoYXQKPiA+IGZ1bmN0aW9uIHRvIHBhcnNlIGFkZGl0
aW9uYWxseSB0aGUgYWRkcmVzcyBvZiB0aGUgZ2VuZXJhdGlvbiBjb3VudGVyCj4gPiBmcm9tIHRo
ZSB2bWdlbmlkIG5hbWVzcGFjZS4gVGhlIGNvdW50ZXIgaXMgdGhlbiBleHBvc2VkIHRvIHRoZQo+
ID4gdXNlci1zcGFjZSB0aHJvdWdoIGEgbWlzYy1kZXZpY2Ugd2hpY2ggcHJvdmlkZXMgYHJlYWRg
IGFuZCBgbW1hcGAKPiA+IGludGVyZmFjZXMuCj4gCj4gRmlyc3QsIHdpdGggcmVnYXJkcyB0byB5
b3VyIG1tYXAgaW50ZXJmYWNlLCBpdCdzIG1vcmUgbGlrZWx5IHRoYXQgdGhpcwo+IGtpbmQgb2Yg
dGhpbmcgd2lsbCBiZSBldmVudHVhbGx5IGZvbGRlZCBpbnRvIG15IGludmVzdGlnYXRpb25zIHJl
Z2FyZGluZwo+IHRoZSBSTkcgYW5kIHRoZSB2RFNPICh3aGljaCB3b3VsZCBtYWtlIHRoaXMga2lu
ZCBvZiB0aGluZyBhY2Nlc3NpYmxlCj4gd2l0aG91dCBuZWVkaW5nIHRoZSBmaWxlIHN5c3RlbSku
Cj4gCgpJbnRlcmVzdGluZywgY291bGQgeW91IHNoYXJlIGEgbGluayB0byBkaXNjdXNzaW9ucyAv
IGNvZGUgcmVnYXJkaW5nIHRoaXM/CgoKPiBSZWdhcmRpbmcgdGhlIGNvdW50ZXIgaXRzZWxmLCBJ
IGRvbid0IHdhbnQgdG8gcnVzaCBpbnRvIGF1Z21lbnRpbmcgdGhlCj4gdm1nZW5pZCBtZWNoYW5p
c20gdW50aWwgd2UndmUgaGFkIHNvbWUgY29udmVyc2F0aW9ucyB3aXRoIE1pY3Jvc29mdC4gQnV0
Cj4gYWxzbywgaXQgc2VlbXMgbGlrZSB5b3UgbWlnaHQgaGF2ZSBtaXNzZWQgdGhlIGV4dGVuc2l2
ZSBwcmV2aW91cwo+IGRpc2N1c3Npb24gYWJvdXQgdGhpcy4gVGhlcmUgd2FzIHNvbWUgdHJhZGVv
ZmYgaW4gZWZmaWNpZW5jeSBhYm91dAo+IG1hcHBpbmcgdGhpcyBhbGwgdGhlIHdheSB0aHJvdWdo
LCBhcyBkb2luZyBzbyB3b3VsZCByZXF1aXJlIHRoZSBjb3VudGVyCj4gdG8gYmUgaW4gYSB0b3Rh
bGx5IHNlcGFyYXRlIHBhZ2UgYXMgdGhlIG1haW4gMTI4LWJpdCBJRCwgdmVyc3VzIGp1c3QKPiBo
YXZpbmcgdGhlIGtlcm5lbCBtYW5hZ2UgYSBzZXBhcmF0ZSBjb3VudGVyIGFuZCBpbmN1ciBhIHBv
dGVudGlhbCBbbWF5YmUKPiBhY2NlcHRhYmxlPyB1bmNsZWFyXSByYWNlLgo+IAoKQWdhaW4sIHdv
dWxkIHlvdSBoYXZlIHBvaW50ZXJzIHRvIHRoaXMgZGlzY3Vzc2lvbj8gSSBoYXZlIGJlZW4gZm9s
bG93aW5nIHRoaXMKdGhyZWFkOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMi8zLzEvNjkzLiBJ
IGFtIGludGVyZXN0ZWQgb24gdGhlIHRha2UgdGhhdAp0aGUgcmFjZSB3b3VsZCBiZSBhY2NlcHRh
YmxlLgoKPiBKYXNvbgo+CgpDaGVlcnMsCkJhYmlzCgpBbWF6b24gU3BhaW4gU2VydmljZXMgc29j
aWVkYWQgbGltaXRhZGEgdW5pcGVyc29uYWwsIENhbGxlIFJhbWlyZXogZGUgUHJhZG8gNSwgMjgw
NDUgTWFkcmlkLiBSZWdpc3RybyBNZXJjYW50aWwgZGUgTWFkcmlkIC4gVG9tbyAyMjQ1OCAuIEZv
bGlvIDEwMiAuIEhvamEgTS00MDEyMzQgLiBDSUYgQjg0NTcwOTM2Cg==

