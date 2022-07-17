Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A003577755
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 18:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiGQQmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 12:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQQma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 12:42:30 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB813E01
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 09:42:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=liusong@linux.alibaba.com;NM=1;PH=DW;RN=3;SR=0;TI=W4_0.1.30_DEFAULT_21283DCF_1658058041727_o7001c175l;
Received: from WS-web (liusong@linux.alibaba.com[W4_0.1.30_DEFAULT_21283DCF_1658058041727_o7001c175l]) at Mon, 18 Jul 2022 00:42:24 +0800
Date:   Mon, 18 Jul 2022 00:42:24 +0800
From:   "liusong" <liusong@linux.alibaba.com>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "linux-mm" <linux-mm@kvack.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "liusong" <liusong@linux.alibaba.com>
Message-ID: <13d6bf0e-b22b-4414-a091-264877904ab9.liusong@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbW0vZG1hcG9vbC5jOiBhdm9pZCBkdXBsaWNhdGUgbWVtc2V0IHdpdGhp?=
  =?UTF-8?B?biBkbWFfcG9vbF9hbGxvYw==?=
X-Mailer: [Alimail-Mailagent revision 7410][W4_0.1.30][DEFAULT][Chrome]
MIME-Version: 1.0
References: <1657769100-66142-1-git-send-email-liusong@linux.alibaba.com>,<20220716180110.eb9402180137d0ce84e3971c@linux-foundation.org>
x-aliyun-mail-creator: W4_0.1.30_DEFAULT_QvNTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMy4wLjAuMCBTYWZhcmkvNTM3LjM2La
In-Reply-To: <20220716180110.eb9402180137d0ce84e3971c@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gRnJvbTogTGl1IFNvbmcgPGxpdXNvbmdAbGludXguYWxpYmFiYS5jb20+Cj4+Cj4+IEluICJk
bWFfZGlyZWN0X2FsbG9jIiwgdGhlIGFsbG9jYXRlZCBtZW1vcnkgaXMgZXhwbGljaXRseSBzZXQg
dG8gMC4KPj4gSWYgdXNlIGRpcmVjdCBhbGxvYywgd2UgbmVlZCB0byBhdm9pZCBwb3NzaWJsZSBk
dXBsaWNhdGUgbWVtc2V0IGluCj4+IGRtYV9wb29sX2FsbG9jLgo+Cj5JJ20gaGF2aW5nIHRyb3Vi
bGUgc2VlaW5nIGhvdyB0aGlzIGNoYW5nZSBpcyBzYWZlIGFuZCBjb3JyZWN0IGFuZAo+bWFpbnRh
aW5hYmxlLiAgUGxlYXNlIGRlc2NyaWJlIHRoZSBjb2RlIGZsb3cgbW9yZSBjb21wbGV0ZWx5PwpU
aGUgZm9sbG93aW5nIGlzIHRoZSBjb2RlIGZsb3fvvIwgCmRtYV9wb29sX2FsbG9jCiAgICB8LS0+
IHBvb2xfYWxsb2NfcGFnZQogICAgICAgICAgIHwtLT4gZG1hX2FsbG9jX2NvaGVyZW50CiAgICAg
ICAgICAgICAgICAgIHwtLT4gZG1hX2FsbG9jX2F0dHJzCkluICJkbWFfYWxsb2NfYXR0cnMiLCBp
ZiAiZG1hX2FsbG9jX2RpcmVjdCIgaXMgdHJ1ZSwgdGhlbiBlbnRlciAiZG1hX2RpcmVjdF9hbGxv
YyIsCmFuZCBpbiAiZG1hX2RpcmVjdF9hbGxvYyIsIGFzIGxvbmcgYXMgdGhlIG1lbW9yeSBhbGxv
Y2F0aW9uIGlzIHN1Y2Nlc3NmdWwsIHdpbGwgZXhlY3V0ZQoibWVtc2V0KHJldCwgMCwgc2l6ZSk7
Iiwgd2hpY2ggc2V0IG1lbW9yeSB0byB6ZXJvLgpLZXJuZWwgdXNlICJkbWFfZ29fZGlyZWN0IiB0
byBkZXRlcm1pbmUgd2hldGhlciB0byB1c2UgZGlyZWN0IGFsbG9jYXRpb24sIHdoaWNoIG1haW5s
eQpieSBqdWRnaW5nIHdoZXRoZXIgImRtYV9tYXBfb3BzIiBleGlzdHMuCgpTbyB0aGlzIHBhdGNo
IGRldGVybWluZXMgd2hldGhlciBkaXJlY3QgYWxsb2Mgd2lsbCBiZSB1c2VkIGJ5IGp1ZGdpbmcg
ZG9lcyAiZG1hX21hcF9vcHMiIGV4aXN0cywKdGhlcmVieSBhdm9pZGluZyByZXBlYXRlZCBtZW1z
ZXQuCgo+Cj4+IC0tLSBhL21tL2RtYXBvb2wuYwo+PiArKysgYi9tbS9kbWFwb29sLmMKPj4gQEAg
LTIxLDYgKzIxLDcgQEAKPj4gIAo+PiAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgo+PiAgI2lu
Y2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvZG1hLW1hcC1v
cHMuaD4KPj4gICNpbmNsdWRlIDxsaW51eC9kbWFwb29sLmg+Cj4+ICAjaW5jbHVkZSA8bGludXgv
a2VybmVsLmg+Cj4+ICAjaW5jbHVkZSA8bGludXgvbGlzdC5oPgo+PiBAQCAtMzcyLDcgKzM3Myw3
IEBAIHZvaWQgKmRtYV9wb29sX2FsbG9jKHN0cnVjdCBkbWFfcG9vbCAqcG9vbCwgZ2ZwX3QgbWVt
X2ZsYWdzLAo+PiAgI2VuZGlmCj4+ICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9vbC0+bG9j
aywgZmxhZ3MpOwo+PiAgIAo+PiAtIGlmICh3YW50X2luaXRfb25fYWxsb2MobWVtX2ZsYWdzKSkK
Pj4gKyBpZiAod2FudF9pbml0X29uX2FsbG9jKG1lbV9mbGFncykgJiYgZ2V0X2RtYV9vcHMocG9v
bC0+ZGV2KSkKPj4gICAgbWVtc2V0KHJldHZhbCwgMCwgcG9vbC0+c2l6ZSk7Cj4KPlRoYXQgRE1B
UE9PTF9ERUJVRyBtZW1zZXQgYSBjb3VwbGUgb2YgbGluZXMgZWFybGllciBjb3VsZC9zaG91bGQg
YmUKPnRlc3RpbmcgdGhlIHNhbWUgY29uZGl0aW9uIC0gdGhlcmUncyBubyBwb2ludCBpbiBwb2lz
b25pbmcgYW4gYXJlYQo+d2hpY2ggd2UncmUgYWJvdXQgdG8gemVybyBvdXQuCgpJZiBETUFQT09M
X0RFQlVHIGlzIGNvbmZpZ3VyZWQsIGl0cyBsb2dpYyBpcyBpbnRlcm5hbGx5IHNlbGYtY29uc2lz
dGVudC4KSWYgdGhlIHVzZXIgbmVlZHMgX19HRlBfWkVSTywgdGhlIGNvcnJlc3BvbmRpbmcgbWVt
b3J5IHdpbGwgYmUgc2V0IHRvIDAu
