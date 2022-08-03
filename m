Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC3F588FB7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiHCPvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbiHCPvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:51:00 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90463AE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1659541851; x=1691077851;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vbNjvWo9f+/d+tD4NWqVeIvN7ZjhWAIDsLKKATW3nhM=;
  b=bp79CEhMiMrdAX6Vw2yUTIqQJmLyJsC1PHCtZNG5hKv71ZUYVNl0M7HS
   zoG6nsglRGlTc9j89cj2adZ2TTnyQnWrRvop1PxaRJWFh9cEwRkB3bUjE
   Y84lNyNf5tJTs6yEd+b41r8zKbgbiabmSkrQplt76VB8+rAy3LFIYxjqn
   E=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-2520d768.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:50:34 +0000
Received: from EX13D37EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-2520d768.us-west-2.amazon.com (Postfix) with ESMTPS id F405C4326B;
        Wed,  3 Aug 2022 15:50:32 +0000 (UTC)
Received: from [192.168.18.61] (10.43.162.227) by EX13D37EUA003.ant.amazon.com
 (10.43.165.7) with Microsoft SMTP Server (TLS) id 15.0.1497.36; Wed, 3 Aug
 2022 15:50:28 +0000
Message-ID: <ccc1112e-7ae9-3c81-0b72-41bdd7c058ec@amazon.es>
Date:   Wed, 3 Aug 2022 17:50:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH 0/2] virt: vmgenid: add generation counter
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>
CC:     <tytso@mit.edu>, <Jason@zx2c4.com>, <dwmw@amazon.co.uk>,
        <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        <gregkh@linuxfoundation.org>,
        <"mst@redhat.com ani@anisinha.ca imammedo"@redhat.com>
References: <20220803152127.48281-1-bchalios@amazon.es>
From:   "Chalios, Babis" <bchalios@amazon.es>
In-Reply-To: <20220803152127.48281-1-bchalios@amazon.es>
X-Originating-IP: [10.43.162.227]
X-ClientProxiedBy: EX13D25UWC004.ant.amazon.com (10.43.162.201) To
 EX13D37EUA003.ant.amazon.com (10.43.165.7)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q0MnaW5nIHNvbWUgbW9yZSBwZW9wbGUgdG8gdGhlIGRpc2N1c3Npb24uCgpPbiAzLzgvMjIgMTc6
MjEsIGJjaGFsaW9zQGFtYXpvbi5lcyB3cm90ZToKPiBGcm9tOiBCYWJpcyBDaGFsaW9zIDxiY2hh
bGlvc0BhbWF6b24uZXM+Cj4KPiBMaW51eCByZWNlbnRseSBhZGRlZCBzdXBwb3J0IGZvciB0aGUg
Vk0gR2VuZXJhdGlvbiBJRCBtZWNoYW5pc20gZnJvbQo+IE1pY3Jvc29mdC4gVGhlIHdheSB0aGlz
IHdvcmtzIGN1cnJlbnRseSBpcyB1c2luZyB0aGUgMTI4LWJpdCBibG9iCj4gcHJvdmlkZWQgYnkg
dGhlIHZtZ2VuaWQgZGV2aWNlIHRvIHJlLXNlZWQgdGhlIFJORy4gV2hpbGUgdGhpcyB3b3JrcyBp
dAo+IGhhcyB0d28gbWFpbiBpc3N1ZXMsIChhKSBpdCBpcyBpbmhlcmVudGx5IHJhY3kgZHVlIHRv
IHRoZSBmYWN0IHRoYXQgaXQKPiByZWxpZXMgb24gYSBBQ1BJIG5vdGlmaWNhdGlvbiBiZWluZyBk
ZWxpdmVyZWQgYW5kIGhhbmRsZWQgYW5kIChiKSB0aGUgSUQKPiBpcyB1bnN1aXRhYmxlIGZvciBl
eHBvc2luZyB0byB1c2VyLXNwYWNlLgo+Cj4gVGhpcyBwYXRjaC1zZXQgZXh0ZW5kcyB0aGUgdm1n
ZW5pZCBkZXZpY2UgdG8gaW50cm9kdWNlIGEgZ2VuZXJhdGlvbgo+IGNvdW50ZXIsIGEgMzItYml0
IGNvdW50ZXIgd2hpY2ggaXMgZGlmZmVyZW50IGV2ZXJ5IHRpbWUgdGhlIHVuaXF1ZSBJRAo+IGNo
YW5nZXMuIFRoZSBhZGRpdGlvbiB0byB0aGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24gaW4gUUVN
VSBjYW4gYmUKPiBmb3VuZCBoZXJlOgo+IGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZl
L2h0bWwvcWVtdS1kZXZlbC8yMDIyLTA4L21zZzAwNTI0Lmh0bWwuCj4KPiBUaGUgZmlyc3QgcGF0
Y2ggcmUtd29ya3Mgc2xpZ2h0bHkgdGhlIGN1cnJlbnQgdm1nZW5pZCBkcml2ZXIgdG8gYWRkIGEK
PiBmdW5jdGlvbiB0aGF0IHBhcnNlcyBhbiBvYmplY3QgZnJvbSB0aGUgdm1nZW5pZCBkZXZpY2Ug
YW5kIHJldHVybnMgdGhlCj4gcGh5c2ljYWwgYWRkcmVzcyBvZiB0aGUgdm1nZW5pZCBkYXRhLiBU
aGUgc2Vjb25kIHBhdGNoIHVzZXMgdGhhdAo+IGZ1bmN0aW9uIHRvIHBhcnNlIGFkZGl0aW9uYWxs
eSB0aGUgYWRkcmVzcyBvZiB0aGUgZ2VuZXJhdGlvbiBjb3VudGVyCj4gZnJvbSB0aGUgdm1nZW5p
ZCBuYW1lc3BhY2UuIFRoZSBjb3VudGVyIGlzIHRoZW4gZXhwb3NlZCB0byB0aGUKPiB1c2VyLXNw
YWNlIHRocm91Z2ggYSBtaXNjLWRldmljZSB3aGljaCBwcm92aWRlcyBgcmVhZGAgYW5kIGBtbWFw
YAo+IGludGVyZmFjZXMuCj4KPiBCYWJpcyBDaGFsaW9zICgyKToKPiAgICB2aXJ0OiB2bWdlbmlk
OiBhZGQgaGVscGVyIGZ1bmN0aW9uIHRvIHBhcnNlIEFERFIKPiAgICB2aXJ0OiB2bWdlbmlkOiBh
ZGQgc3VwcG9ydCBmb3IgZ2VuZXJhdGlvbiBjb3VudGVyCj4KPiAgIERvY3VtZW50YXRpb24vdmly
dC92bWdlbmlkLnJzdCB8IDEyMCArKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVy
cy92aXJ0L3ZtZ2VuaWQuYyAgICAgICAgIHwgMTUxICsrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNTEgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRp
b25zKC0pCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi92aXJ0L3ZtZ2VuaWQu
cnN0Cj4KCkFtYXpvbiBTcGFpbiBTZXJ2aWNlcyBzb2NpZWRhZCBsaW1pdGFkYSB1bmlwZXJzb25h
bCwgQ2FsbGUgUmFtaXJleiBkZSBQcmFkbyA1LCAyODA0NSBNYWRyaWQuIFJlZ2lzdHJvIE1lcmNh
bnRpbCBkZSBNYWRyaWQgLiBUb21vIDIyNDU4IC4gRm9saW8gMTAyIC4gSG9qYSBNLTQwMTIzNCAu
IENJRiBCODQ1NzA5MzYK

