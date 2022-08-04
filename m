Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C64589CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbiHDNeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiHDNeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:34:03 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F0B3D5B5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1659620041; x=1691156041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NnjAqrNGeQSC1eWsCYvEk4E0QzHC/h4c6V3TXdI7xZ4=;
  b=d4VJ0xgMSc7GtNkQ3R17NEvpmADr28ambwWxe83PpniJGy15ebd3H45R
   kSFEFabypSgZ+cqoCUeZWABRGWHqP4TisFgceIh8RTFDQsS7ONwDV/g8a
   71ByhdpJbB/tw1uJVBf+7YW0EdzC5+VSt3EWJJTE1auB5MrqMJHF7Q3Aj
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,215,1654560000"; 
   d="scan'208";a="245465099"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-6a4112b2.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 13:33:45 +0000
Received: from EX13D37EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-6a4112b2.us-west-2.amazon.com (Postfix) with ESMTPS id 7D6B94C00AA;
        Thu,  4 Aug 2022 13:33:45 +0000 (UTC)
Received: from [10.85.101.228] (10.43.160.75) by EX13D37EUA003.ant.amazon.com
 (10.43.165.7) with Microsoft SMTP Server (TLS) id 15.0.1497.36; Thu, 4 Aug
 2022 13:33:40 +0000
Message-ID: <f1c6f809-ab10-fbe5-c9df-ce8c2de7b1ff@amazon.es>
Date:   Thu, 4 Aug 2022 15:33:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH 0/2] virt: vmgenid: add generation counter
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>
CC:     <tytso@mit.edu>, <Jason@zx2c4.com>, <dwmw@amazon.co.uk>,
        <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        <gregkh@linuxfoundation.org>, <bchalios@amazon.es>
References: <20220803152127.48281-1-bchalios@amazon.es>
From:   "Chalios, Babis" <bchalios@amazon.es>
In-Reply-To: <20220803152127.48281-1-bchalios@amazon.es>
X-Originating-IP: [10.43.160.75]
X-ClientProxiedBy: EX13D43UWC001.ant.amazon.com (10.43.162.69) To
 EX13D37EUA003.ant.amazon.com (10.43.165.7)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy84LzIyIDE3OjIxLCBiY2hhbGlvc0BhbWF6b24uZXMgd3JvdGU6Cj4gRnJvbTogQmFiaXMg
Q2hhbGlvcyA8YmNoYWxpb3NAYW1hem9uLmVzPgo+Cj4gTGludXggcmVjZW50bHkgYWRkZWQgc3Vw
cG9ydCBmb3IgdGhlIFZNIEdlbmVyYXRpb24gSUQgbWVjaGFuaXNtIGZyb20KPiBNaWNyb3NvZnQu
IFRoZSB3YXkgdGhpcyB3b3JrcyBjdXJyZW50bHkgaXMgdXNpbmcgdGhlIDEyOC1iaXQgYmxvYgo+
IHByb3ZpZGVkIGJ5IHRoZSB2bWdlbmlkIGRldmljZSB0byByZS1zZWVkIHRoZSBSTkcuIFdoaWxl
IHRoaXMgd29ya3MgaXQKPiBoYXMgdHdvIG1haW4gaXNzdWVzLCAoYSkgaXQgaXMgaW5oZXJlbnRs
eSByYWN5IGR1ZSB0byB0aGUgZmFjdCB0aGF0IGl0Cj4gcmVsaWVzIG9uIGEgQUNQSSBub3RpZmlj
YXRpb24gYmVpbmcgZGVsaXZlcmVkIGFuZCBoYW5kbGVkIGFuZCAoYikgdGhlIElECj4gaXMgdW5z
dWl0YWJsZSBmb3IgZXhwb3NpbmcgdG8gdXNlci1zcGFjZS4KPgo+IFRoaXMgcGF0Y2gtc2V0IGV4
dGVuZHMgdGhlIHZtZ2VuaWQgZGV2aWNlIHRvIGludHJvZHVjZSBhIGdlbmVyYXRpb24KPiBjb3Vu
dGVyLCBhIDMyLWJpdCBjb3VudGVyIHdoaWNoIGlzIGRpZmZlcmVudCBldmVyeSB0aW1lIHRoZSB1
bmlxdWUgSUQKPiBjaGFuZ2VzLiBUaGUgYWRkaXRpb24gdG8gdGhlIG9yaWdpbmFsIGltcGxlbWVu
dGF0aW9uIGluIFFFTVUgY2FuIGJlCj4gZm91bmQgaGVyZToKPiBodHRwczovL2xpc3RzLm5vbmdu
dS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMi0wOC9tc2cwMDUyNC5odG1sLgo+Cj4g
VGhlIGZpcnN0IHBhdGNoIHJlLXdvcmtzIHNsaWdodGx5IHRoZSBjdXJyZW50IHZtZ2VuaWQgZHJp
dmVyIHRvIGFkZCBhCj4gZnVuY3Rpb24gdGhhdCBwYXJzZXMgYW4gb2JqZWN0IGZyb20gdGhlIHZt
Z2VuaWQgZGV2aWNlIGFuZCByZXR1cm5zIHRoZQo+IHBoeXNpY2FsIGFkZHJlc3Mgb2YgdGhlIHZt
Z2VuaWQgZGF0YS4gVGhlIHNlY29uZCBwYXRjaCB1c2VzIHRoYXQKPiBmdW5jdGlvbiB0byBwYXJz
ZSBhZGRpdGlvbmFsbHkgdGhlIGFkZHJlc3Mgb2YgdGhlIGdlbmVyYXRpb24gY291bnRlcgo+IGZy
b20gdGhlIHZtZ2VuaWQgbmFtZXNwYWNlLiBUaGUgY291bnRlciBpcyB0aGVuIGV4cG9zZWQgdG8g
dGhlCj4gdXNlci1zcGFjZSB0aHJvdWdoIGEgbWlzYy1kZXZpY2Ugd2hpY2ggcHJvdmlkZXMgYHJl
YWRgIGFuZCBgbW1hcGAKPiBpbnRlcmZhY2VzLgo+Cj4gQmFiaXMgQ2hhbGlvcyAoMik6Cj4gICAg
dmlydDogdm1nZW5pZDogYWRkIGhlbHBlciBmdW5jdGlvbiB0byBwYXJzZSBBRERSCj4gICAgdmly
dDogdm1nZW5pZDogYWRkIHN1cHBvcnQgZm9yIGdlbmVyYXRpb24gY291bnRlcgo+Cj4gICBEb2N1
bWVudGF0aW9uL3ZpcnQvdm1nZW5pZC5yc3QgfCAxMjAgKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiAgIGRyaXZlcnMvdmlydC92bWdlbmlkLmMgICAgICAgICB8IDE1MSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjUxIGluc2VydGlvbnMo
KyksIDIwIGRlbGV0aW9ucygtKQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
dmlydC92bWdlbmlkLnJzdAo+CgpJIGFtIGFsc28gQ0NpbmcgTWljaGFlbCBmcm9tIE1pY3Jvc29m
dCBzaW5jZSBoZSB3YXMgaW52b2x2ZWQgaW4gdGhlCmxhc3QgZGlzY3Vzc2lvbnMgcmVnYXJkaW5n
IHRoZSBMaW51eCBkcml2ZXIuCgpDaGVlcnMsCkJhYmlzCkFtYXpvbiBTcGFpbiBTZXJ2aWNlcyBz
b2NpZWRhZCBsaW1pdGFkYSB1bmlwZXJzb25hbCwgQ2FsbGUgUmFtaXJleiBkZSBQcmFkbyA1LCAy
ODA0NSBNYWRyaWQuIFJlZ2lzdHJvIE1lcmNhbnRpbCBkZSBNYWRyaWQgLiBUb21vIDIyNDU4IC4g
Rm9saW8gMTAyIC4gSG9qYSBNLTQwMTIzNCAuIENJRiBCODQ1NzA5MzYK

