Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E4588FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbiHCQAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbiHCQAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:00:33 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A47513D46
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1659542432; x=1691078432;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YnukQX1NaPPxnCt9j6BcQMbDXjmoLHezBB1bg8OWWI0=;
  b=nfLEXhldioOU8/en2DUsJuILl5q6JjQTkMCNy1qmzeBd8x6xEdoAINOc
   1/9XLk7ah2j4QWdRk9D5ER82duVSO+XDBO4LLfY2Vk1VD6L2WOFjXpWu0
   0+KwAWsft6Rr90LwWaHyg50hwhAccHWoVFsetkYmIwGjVkDfFFp9kFXnP
   0=;
X-IronPort-AV: E=Sophos;i="5.93,214,1654560000"; 
   d="scan'208";a="115239824"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-1box-2b-3386f33d.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:57:19 +0000
Received: from EX13D37EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-1box-2b-3386f33d.us-west-2.amazon.com (Postfix) with ESMTPS id 141F4A2723;
        Wed,  3 Aug 2022 15:57:19 +0000 (UTC)
Received: from [192.168.18.61] (10.43.162.227) by EX13D37EUA003.ant.amazon.com
 (10.43.165.7) with Microsoft SMTP Server (TLS) id 15.0.1497.36; Wed, 3 Aug
 2022 15:57:14 +0000
Message-ID: <5d199960-bad7-e2ea-d3fb-d9b92eefbcf8@amazon.es>
Date:   Wed, 3 Aug 2022 17:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH 0/2] virt: vmgenid: add generation counter
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>
CC:     <tytso@mit.edu>, <Jason@zx2c4.com>, <dwmw@amazon.co.uk>,
        <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        <gregkh@linuxfoundation.org>, <mst@redhat.com>, <ani@anisinha.ca>,
        <imammedo@redhat.com>
References: <20220803152127.48281-1-bchalios@amazon.es>
From:   "Chalios, Babis" <bchalios@amazon.es>
In-Reply-To: <20220803152127.48281-1-bchalios@amazon.es>
X-Originating-IP: [10.43.162.227]
X-ClientProxiedBy: EX13d09UWA004.ant.amazon.com (10.43.160.158) To
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

KENvcnJlY3RseSkgQ0MnaW5nIG1vcmUgcGVvcGxlIGluIHRoZSBkaXNjdXNzaW9uLiBBcG9sb2dp
ZXMgZm9yIHRoaXMuCgpPbiAzLzgvMjIgMTc6MjEsIGJjaGFsaW9zQGFtYXpvbi5lcyB3cm90ZToK
PiBGcm9tOiBCYWJpcyBDaGFsaW9zIDxiY2hhbGlvc0BhbWF6b24uZXM+Cj4KPiBMaW51eCByZWNl
bnRseSBhZGRlZCBzdXBwb3J0IGZvciB0aGUgVk0gR2VuZXJhdGlvbiBJRCBtZWNoYW5pc20gZnJv
bQo+IE1pY3Jvc29mdC4gVGhlIHdheSB0aGlzIHdvcmtzIGN1cnJlbnRseSBpcyB1c2luZyB0aGUg
MTI4LWJpdCBibG9iCj4gcHJvdmlkZWQgYnkgdGhlIHZtZ2VuaWQgZGV2aWNlIHRvIHJlLXNlZWQg
dGhlIFJORy4gV2hpbGUgdGhpcyB3b3JrcyBpdAo+IGhhcyB0d28gbWFpbiBpc3N1ZXMsIChhKSBp
dCBpcyBpbmhlcmVudGx5IHJhY3kgZHVlIHRvIHRoZSBmYWN0IHRoYXQgaXQKPiByZWxpZXMgb24g
YSBBQ1BJIG5vdGlmaWNhdGlvbiBiZWluZyBkZWxpdmVyZWQgYW5kIGhhbmRsZWQgYW5kIChiKSB0
aGUgSUQKPiBpcyB1bnN1aXRhYmxlIGZvciBleHBvc2luZyB0byB1c2VyLXNwYWNlLgo+Cj4gVGhp
cyBwYXRjaC1zZXQgZXh0ZW5kcyB0aGUgdm1nZW5pZCBkZXZpY2UgdG8gaW50cm9kdWNlIGEgZ2Vu
ZXJhdGlvbgo+IGNvdW50ZXIsIGEgMzItYml0IGNvdW50ZXIgd2hpY2ggaXMgZGlmZmVyZW50IGV2
ZXJ5IHRpbWUgdGhlIHVuaXF1ZSBJRAo+IGNoYW5nZXMuIFRoZSBhZGRpdGlvbiB0byB0aGUgb3Jp
Z2luYWwgaW1wbGVtZW50YXRpb24gaW4gUUVNVSBjYW4gYmUKPiBmb3VuZCBoZXJlOgo+IGh0dHBz
Oi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIyLTA4L21zZzAw
NTI0Lmh0bWwuCj4KPiBUaGUgZmlyc3QgcGF0Y2ggcmUtd29ya3Mgc2xpZ2h0bHkgdGhlIGN1cnJl
bnQgdm1nZW5pZCBkcml2ZXIgdG8gYWRkIGEKPiBmdW5jdGlvbiB0aGF0IHBhcnNlcyBhbiBvYmpl
Y3QgZnJvbSB0aGUgdm1nZW5pZCBkZXZpY2UgYW5kIHJldHVybnMgdGhlCj4gcGh5c2ljYWwgYWRk
cmVzcyBvZiB0aGUgdm1nZW5pZCBkYXRhLiBUaGUgc2Vjb25kIHBhdGNoIHVzZXMgdGhhdAo+IGZ1
bmN0aW9uIHRvIHBhcnNlIGFkZGl0aW9uYWxseSB0aGUgYWRkcmVzcyBvZiB0aGUgZ2VuZXJhdGlv
biBjb3VudGVyCj4gZnJvbSB0aGUgdm1nZW5pZCBuYW1lc3BhY2UuIFRoZSBjb3VudGVyIGlzIHRo
ZW4gZXhwb3NlZCB0byB0aGUKPiB1c2VyLXNwYWNlIHRocm91Z2ggYSBtaXNjLWRldmljZSB3aGlj
aCBwcm92aWRlcyBgcmVhZGAgYW5kIGBtbWFwYAo+IGludGVyZmFjZXMuCj4KPiBCYWJpcyBDaGFs
aW9zICgyKToKPiAgICB2aXJ0OiB2bWdlbmlkOiBhZGQgaGVscGVyIGZ1bmN0aW9uIHRvIHBhcnNl
IEFERFIKPiAgICB2aXJ0OiB2bWdlbmlkOiBhZGQgc3VwcG9ydCBmb3IgZ2VuZXJhdGlvbiBjb3Vu
dGVyCj4KPiAgIERvY3VtZW50YXRpb24vdmlydC92bWdlbmlkLnJzdCB8IDEyMCArKysrKysrKysr
KysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy92aXJ0L3ZtZ2VuaWQuYyAgICAgICAgIHwgMTUx
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAy
NTEgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi92aXJ0L3ZtZ2VuaWQucnN0Cj4KCkFtYXpvbiBTcGFpbiBTZXJ2aWNlcyBz
b2NpZWRhZCBsaW1pdGFkYSB1bmlwZXJzb25hbCwgQ2FsbGUgUmFtaXJleiBkZSBQcmFkbyA1LCAy
ODA0NSBNYWRyaWQuIFJlZ2lzdHJvIE1lcmNhbnRpbCBkZSBNYWRyaWQgLiBUb21vIDIyNDU4IC4g
Rm9saW8gMTAyIC4gSG9qYSBNLTQwMTIzNCAuIENJRiBCODQ1NzA5MzYK

