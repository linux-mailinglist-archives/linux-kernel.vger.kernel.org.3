Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC25518E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbiFTMb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240064AbiFTMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:31:22 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7C0913D33
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=W2zaJ
        ZZZmWCsovcjbBPv8wVDU6mq90VO6c2xwP7F890=; b=SjUFNX350XJ3COY/c9/Bj
        hpKd42XenFerfK5w8IUsuUbILIjb/KvkbgQHQJ9gdq+I0qL7JjQn10Y6R6Rm0Qpq
        TqZeaw1CcoIvOHWv8mCBS18/cu4Ow4dTyEvAd65LHPDB9ETOJMZbgv74P0jrN5x/
        AJtiFY035orupok84a+dGY=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Mon, 20 Jun 2022 20:27:05 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Mon, 20 Jun 2022 20:27:05 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc:     "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH] powerpc: kernel: Change the order of of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <1f3cdf9c-7437-65e7-c226-c53e17a722b7@csgroup.eu>
References: <20220617112636.4041671-1-windhl@126.com>
 <a6a5e5b3-ffd1-904b-bba1-22baff5f7b67@csgroup.eu>
 <61c85548.1a55.18175d69e21.Coremail.windhl@126.com>
 <c9785db9-b74d-540e-9c83-4db7bee10303@csgroup.eu>
 <30af2253.74d8.181806c9337.Coremail.windhl@126.com>
 <1f3cdf9c-7437-65e7-c226-c53e17a722b7@csgroup.eu>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <16a2a6b2.8542.1818114aeea.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowABXrPCaZ7Bi8RE6AA--.41388W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hkmF1uwMPrXgQABsE
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0yMCAxOToxMTozMywgIkNocmlzdG9waGUgTGVyb3kiIDxjaHJpc3RvcGhl
Lmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOgo+SGksCj4KPkxlIDIwLzA2LzIwMjIgw6AgMTE6MjMs
IExpYW5nIEhlIGEgw6ljcml0wqA6Cj4+IAo+PiBIaSwgQ2hyaXN0b3BoZS4KPj4gCj4+IFNvcnJ5
IHRvIHRyb2J1bGUgeW91IGFnYWluLgo+PiAKPj4gTm93IEkgaGF2ZSBmb3VuZCBvdGhlciBidWdz
IGluIHNhbWUgZGlyZWN0b3JpZXMgKGkuZS4sIGFyY2gvcG93ZXJwYy9zeXNkZXYpLAo+PiB3aXRo
IHRoZSBvbmVzIEkgaGF2ZSBzZW50IGJ1dCBub3QgcmVjaWV2ZWQgYWNrZWQtYnkgb3IgY29uZmly
bWVkIGVtYWlsLgo+PiAKPj4gU28gSSBuZWVkIHRvIG1lcmdlIHRoZSBvbGQgb25lcyBpbnRvIHRo
ZSBuZXcgb25lcyBhcyBhIFBBVENILXYyIGFuZCB0aGVuIHJlc2VuZCB0aGUKPj4gb2xkIG9uZXMg
Pwo+PiBvciBqdXN0IHVzZSBhIG5ldyBQQVRDSCB0byBzZW5kIG9ubHkgbmV3IG9uZXM/Cj4+IAo+
PiBJIGFtIGFmcmFpZCB0byBtYWtlIG5ldyB0cm91YmxlIGZvciBtYWludGFpbmVycywgc28gY2Fu
IHlvdSBzaGFyZSB5b3VyIHZhbHVhYmxlCj4+IGV4cGVyaWVuY2U/Cj4+IAo+Cj5IZXJlIGlzIHRo
ZSBsaXN0IG9mIHlvdXIgcGF0Y2hlcyA6IAo+aHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9w
cm9qZWN0L2xpbnV4cHBjLWRldi9saXN0Lz9zdWJtaXR0ZXI9ODQyNTgKPgo+IEZyb20gbXkgcG9p
bnQgb2YgdmlldywgZm9yIGFsbCB0aGUgcGF0Y2hlcyB0aGF0IGFyZSBzdGlsbCBpbiBzdGF0dXMg
Cj4ibmV3IiBpdCBpcyBiZXR0ZXIgdGhhbiB5b3Ugc2VuZCBhIHYyIHdpdGggbW9yZSB0aGluZ3Mg
aW50byBhIHNpbmdsZSAKPnBhdGNoLiBXaGVuIHRoZSBwYXRjaCBpcyBpbiAidW5kZXIgcmV2aWV3
IiBzdGF0ZSwgaXQgaXMgYmV0dGVyIHRvIG5vdCAKPnVwZGF0ZSBpdCBhbnltb3JlLgo+Cj5TbyBp
biB0aGUgbGlzdCB0aGVyZSBhcmUgZm9yIGluc3RhbmNlIHNldmVyYWwgcGF0Y2hlcyBmb3IgcG93
ZXJudiwgc28gaXQgCj53b3VsZCBiZSBnb29kIGlmIHlvdSBjYW4gcmVncm91cCBhbGwgb2YgdGhl
bSBpbiBhIHNpbmdsZSB2MiBwYXRjaC4KPgo+Q2hyaXN0b3BoZQoKVGhhbmtzLCBDaHJpc3RvcGhl
LgoKSSB3aWxsIGZvbGxvdyB5b3VyIHJ1bGVzIGFuZCB0cnkgdG8gZ3JvdXAgdGhlICduZXcnIHN0
YXRlIG9uZXMu
