Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41836558CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 03:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiFXBp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 21:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXBpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:45:25 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517B72E9D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 18:45:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=liusong@linux.alibaba.com;NM=1;PH=DW;RN=4;SR=0;TI=W4_0.1.30_DEFAULT_21254454_1656034815429_o7001c25f;
Received: from WS-web (liusong@linux.alibaba.com[W4_0.1.30_DEFAULT_21254454_1656034815429_o7001c25f]) at Fri, 24 Jun 2022 09:45:22 +0800
Date:   Fri, 24 Jun 2022 09:45:22 +0800
From:   "liusong" <liusong@linux.alibaba.com>
To:     "Will Deacon" <will@kernel.org>
Cc:     "catalin.marinas" <catalin.marinas@arm.com>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "liusong" <liusong@linux.alibaba.com>
Message-ID: <75a92083-ccbd-4584-92e3-63df177feb7b.liusong@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXJtNjQ6IGNwdWZlYXR1cmU6IG1ha2Ugc3VyZSBjcHVfbWl0aWdhdGlv?=
  =?UTF-8?B?bnNfb2ZmIHRoZW4ga3B0aSBvZmY=?=
X-Mailer: [Alimail-Mailagent][W4_0.1.30][DEFAULT][Chrome]
MIME-Version: 1.0
References: <1655382938-126283-1-git-send-email-liusong@linux.alibaba.com>,<20220623172730.GA16966@willie-the-truck>
x-aliyun-mail-creator: W4_0.1.30_DEFAULT_M3LTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMi4wLjUwMDUuMTE1IFNhZmFyaS81MzcuMzY=vN
In-Reply-To: <20220623172730.GA16966@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIFRodSwgSnVuIDE2LCAyMDIyIGF0IDA4OjM1OjM4UE0gKzA4MDAsIExpdSBTb25nIHdyb3Rl
Ogo+PiBGcm9tOiBMaXUgU29uZyA8bGl1c29uZ0BsaW51eC5hbGliYWJhLmNvbT4KPj4KPj4gSWYg
a2FzbHIgaXMgZW5hYmxlZCwga3B0aSBjYW5ub3QgYmUgdHVybmVkIG9mZiBldmVuIGlmICJtaXRp
Z2F0aW9ucz1vZmYiLAo+PiBhZGp1c3QgdGhlIGNvZGUgb3JkZXIgdG8gZW5zdXJlIHRoYXQga3B0
aSBpcyBvZmYgd2hlbiAibWl0aWdhdGlvbnM9b2ZmIi4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTGl1
IFNvbmcgPGxpdXNvbmdAbGludXguYWxpYmFiYS5jb20+Cj4+IC0tLQo+PiAgYXJjaC9hcm02NC9r
ZXJuZWwvY3B1ZmVhdHVyZS5jIHwgMTAgKysrKystLS0tLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQva2VybmVsL2NwdWZlYXR1cmUuYyBiL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYwo+
PiBpbmRleCA0MmVhMmJkLi4yN2Q0ODUwIDEwMDY0NAo+PiAtLS0gYS9hcmNoL2FybTY0L2tlcm5l
bC9jcHVmZWF0dXJlLmMKPj4gKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvY3B1ZmVhdHVyZS5jCj4+
IEBAIC0xNjE2LDYgKzE2MTYsMTEgQEAgc3RhdGljIGJvb2wgdW5tYXBfa2VybmVsX2F0X2VsMChj
b25zdCBzdHJ1Y3QgYXJtNjRfY3B1X2NhcGFiaWxpdGllcyAqZW50cnksCj4+ICAgIF9fa3B0aV9m
b3JjZWQgPSAtMTsKPj4gICB9Cj4+IAo+PiArIGlmIChjcHVfbWl0aWdhdGlvbnNfb2ZmKCkgJiYg
IV9fa3B0aV9mb3JjZWQpIHsKPj4gKyAgc3RyID0gIm1pdGlnYXRpb25zPW9mZiI7Cj4+ICsgIF9f
a3B0aV9mb3JjZWQgPSAtMTsKPj4gKyB9Cj4+ICsKPj4gICAvKiBVc2VmdWwgZm9yIEtBU0xSIHJv
YnVzdG5lc3MgKi8KPj4gICBpZiAoa2FzbHJfcmVxdWlyZXNfa3B0aSgpKSB7Cj4+ICAgIGlmICgh
X19rcHRpX2ZvcmNlZCkgewo+PiBAQCAtMTYyNCwxMSArMTYyOSw2IEBAIHN0YXRpYyBib29sIHVu
bWFwX2tlcm5lbF9hdF9lbDAoY29uc3Qgc3RydWN0IGFybTY0X2NwdV9jYXBhYmlsaXRpZXMgKmVu
dHJ5LAo+PiAgICB9Cj4+ICAgfQo+PiAKPj4gLSBpZiAoY3B1X21pdGlnYXRpb25zX29mZigpICYm
ICFfX2twdGlfZm9yY2VkKSB7Cj4+IC0gIHN0ciA9ICJtaXRpZ2F0aW9ucz1vZmYiOwo+PiAtICBf
X2twdGlfZm9yY2VkID0gLTE7Cj4+IC0gfQo+Cj5UaGUgY3VycmVudCBiZWhhdmlvdXIgaXMgaW50
ZW50aW9uYWw6IEtBU0xSIGlzIHRyaXZpYWwgdG8gYnlwYXNzIHdoZW4ga3B0aQo+aXMgZGlzYWJs
ZWQuCj4KPldpbGwKCkhpCgpBY2NvcmRpbmcgdG8gdGhlIGRlc2NyaXB0aW9uIG9mIG1pdGlnYWlv
bnM9b2ZmIGluIGtlcm5lbC1wYXJhbWV0ZXJzLnR4dCwKaXQgaXMgZXF1aXZhbGVudCB0byBrcHRp
PTAgdW5kZXIgQVJNNjQsIHNvIHRoZSBkZXNjcmlwdGlvbiBoZXJlIHdpbGwgbWlzbGVhZAp1c2Vy
cy4gSSBoYXZlIHByb3Bvc2VkIGEgcGF0Y2ggdG8gZml4IHRoaXMuCgpUaGFua3M=
