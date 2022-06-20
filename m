Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57357551463
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241183AbiFTJak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbiFTJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:29:52 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07C5B13CED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=zT4U/
        fz1eiWDLH7q5fiG9Q/QwJj3U2DVutcOl8kZKow=; b=BKs/oBB6Byv5dBYceFP9W
        2hu2D/LDrdRGKKPO7mdtBzWBnz94pdnszGp6KthP5VFJGsx6w5cKpjYAExZx7aU1
        2t9VcVGCRjGdeqLxIcIgd/jcyPkuab/CTHGsOxHClgXzwJhUK7HRYf3UZzLKXaWH
        QWrttnbG+jVpjnHB+/x1IM=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Mon, 20 Jun 2022 17:23:28 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Mon, 20 Jun 2022 17:23:28 +0800 (CST)
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
In-Reply-To: <c9785db9-b74d-540e-9c83-4db7bee10303@csgroup.eu>
References: <20220617112636.4041671-1-windhl@126.com>
 <a6a5e5b3-ffd1-904b-bba1-22baff5f7b67@csgroup.eu>
 <61c85548.1a55.18175d69e21.Coremail.windhl@126.com>
 <c9785db9-b74d-540e-9c83-4db7bee10303@csgroup.eu>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <30af2253.74d8.181806c9337.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowAAXbPCRPLBi4_g5AA--.28579W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBkmF2JVj8mP2AABs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0xOCAxNjo0ODoyNiwgIkNocmlzdG9waGUgTGVyb3kiIDxjaHJpc3RvcGhl
Lmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOgo+Cj4KPkxlIDE4LzA2LzIwMjIgw6AgMTA6MDMsIExp
YW5nIEhlIGEgw6ljcml0wqA6Cj4+IAo+PiAKPj4gCj4+IAo+PiAKPj4g5ZyoIDIwMjItMDYtMTgg
MTU6MTM6MTPvvIwiQ2hyaXN0b3BoZSBMZXJveSIgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5l
dT4g5YaZ6YGT77yaCj4+Pgo+Pj4KPj4+IExlIDE3LzA2LzIwMjIgw6AgMTM6MjYsIExpYW5nIEhl
IGEgw6ljcml0wqA6Cj4+Pj4gSW4gYWRkX3Bjc3BrcigpLCBpdCBpcyBiZXR0ZXIgdG8gY2FsbCBv
Zl9ub2RlX3B1dCgpIGFmdGVyIHRoZQo+Pj4+ICdpZighbnApJyBjaGVjay4KPj4+Cj4+PiBXaHkg
aXMgaXQgYmV0dGVyID8KPj4+Cj4+Pgo+Pj4KPj4+IC8qKgo+Pj4gICAqIG9mX25vZGVfcHV0KCkg
LSBEZWNyZW1lbnQgcmVmY291bnQgb2YgYSBub2RlCj4+PiAgICogQG5vZGU6CU5vZGUgdG8gZGVj
IHJlZmNvdW50LCBOVUxMIGlzIHN1cHBvcnRlZCB0byBzaW1wbGlmeSB3cml0aW5nIG9mCj4+PiAg
ICoJCWNhbGxlcnMKPj4+ICAgKi8KPj4+IHZvaWQgb2Zfbm9kZV9wdXQoc3RydWN0IGRldmljZV9u
b2RlICpub2RlKQo+Pj4gewo+Pj4gCWlmIChub2RlKQo+Pj4gCQlrb2JqZWN0X3B1dCgmbm9kZS0+
a29iaik7Cj4+PiB9Cj4+PiBFWFBPUlRfU1lNQk9MKG9mX25vZGVfcHV0KTsKPj4+Cj4+Pgo+Pj4K
Pj4+IENocmlzdG9waGUKPj4gCj4+IEhpLCBDaHJpc3RvcGhlLgo+PiAKPj4gVGhhbmtzIGZvciB5
b3VyIHJlcGx5IGFuZCBJIHdhbnQgdG8gaGF2ZSBhIGRpc2N1c3Npb24uCj4+IAo+PiBJbiBteSB0
aG91Z2h0LCB4eHhfcHV0KHBvaW50ZXIpJ3Mgc2VtYW50aWMgdXN1YWxseSBtZWFucwo+PiB0aGlz
IHJlZmVyZW5jZSBoYXMgYmVlbiB1c2VkIGRvbmUgYW5kIHdpbGwgbm90IGJlIHVzZWQKPj4gYW55
bW9yZS4gSXMgdGhpcyBzZW1hbnRpYyBtb3JlIHJlYXNvbmFibGUsIHJpZ2h0Pwo+PiAKPj4gQmVz
aWRlcywgaWYgdGhlIG5wIGlzIE5VTEwsIHdlIGNhbiBqdXN0IHJldHVybiBhbmQgc2F2ZSBhIGNw
dQo+PiB0aW1lIGZvciB0aGUgeHh4X3B1dCgpIGNhbGwuCj4+IAo+PiBPdGhlcndpc2UsIEkgcHJl
ZmVyIHRvIGNhbGwgaXQgJ3VzZShjaGVjayktYWZ0ZXItcHV0Jy4KPj4gCj4+IEluIGZhY3QsIEkg
aGF2ZSBtZWV0IG1hbnkgb3RoZXIgJ3VzZShjaGVjayktYWZ0ZXItcHV0JyBpbnN0YW5jZXMKPj4g
YWZ0ZXIgSSBzZW5kIHRoaXMgcGF0Y2gtY29tbWl0LCBzbyBJIGFtIHdhaXRpbmcgZm9yIHRoaXMK
Pj4gZGlzY3Vzc2lvbi4KPj4gCj4+IFRoaXMgaXMganVzdCBteSB0aG91Z2h0LCBpdCBtYXkgYmUg
d3JvbmcuCj4+IAo+PiBBbnl3YXksIHRoYW5rcyBmb3IgeW91ciByZXBseS4KPgo+V2VsbCBpbiBw
cmluY2lwbGUgeW91IGFyZSByaWdodCwgaW4gYW4gaWRlYWwgd29ybGQgaXQgc2hvdWxkIGJlIGxp
a2UgCj50aGF0LiBIb3dldmVyLCB5b3UgaGF2ZSB0byB3b25kZXIgaWYgaXQgaXMgd29ydGggdGhl
IGNodXJuLiBUaGUgQ1BVIAo+Y3ljbGUgYXJndW1lbnQgaXMgdmFsaWQgb25seSBpZiB0aGF0IGZ1
bmN0aW9uIGlzIHVzZWQgaW4gYSBob3QgcGF0aC4gQnV0IAo+YXMgd2UgYXJlIHRhbGtpbmcgYWJv
dXQgZXJyb3IgaGFuZGxpbmcsIGl0IGNhbid0IGJlIGEgaG90IHBhdGguCj4KPlRha2luZyBpbnRv
IGFjY291bnQgdGhlIGNvbW1lbnQgYXNzb2NpYXRlZCBvZiBvZl9ub2RlX3B1dCA6ICJOVUxMIGlz
IAo+c3VwcG9ydGVkIHRvIHNpbXBsaWZ5IHdyaXRpbmcgb2YgY2FsbGVycyIsIGl0IG1lYW5zIHRo
YXQgdXNhZ2UgaXMgdmFsaWQsIAo+anVzdCBsaWtlIGl0IGlzIHdpdGggZnVuY3Rpb24ga2ZyZWUo
KSBhZnRlciBhIGttYWxsb2MoKS4KPgo+U28gaW4gYSBuZXcgZGV2ZWxvcHBlbWVudCwgb3Igd2hl
biBkb2luZyByZWFsIG1vZGlmaWNhdGlvbnMgdG8gYSBkcml2ZXIsIAo+dGhhdCBraW5kIG9mIGNo
YW5nZSBjYW4gYmUgZG9uZSBpZGVhbGx5LiBIb3dldmVyIGZvciBkcml2ZXJzIHRoYXQgaGF2ZSAK
PmJlZW4gdGhlcmUgZm9yIHllYXJzIHdpdGhvdXQgYW55IGNoYW5nZSwgYXNrIHlvdXJzZWxmIGlm
IGl0IGlzIHdvcnRoIHRoZSAKPmNodXJuLiBZb3Ugc3BlbmQgdGltZSBvbiBpdCwgeW91IHJlcXVp
cmUgb3RoZXIgcGVvcGxlIHRvIHNwZW5kIHRpbWUgb24gCj5pdCBmb3IgcmV2aWV3aW5nIGFuZCBh
cHBseWluZyB5b3VyIHBhdGNoZXMgYW5kIGR1cmluZyB0aGF0IHRpbWUgdGhleSAKPmRvbid0IGRv
IG90aGVyIHRoaW5ncyB0aGF0IGNvdWxkIGhhdmUgYmVlbiBtb3JlIHVzZWZ1bGwuCj4KPlNvIHVu
bGVzcyB0aGlzIGNoYW5nZSBpcyBwYXJ0IG9mIGEgbW9yZSBnbG9iYWwgcGF0Y2gsIEkgdGhpbmsg
aXQgaXMgbm90IAo+d29ydGggdGhlIGVmZm9ydC4KPgo+QnkgdGhlIHdheSwgYWxzbyBmb3IgYWxs
IHlvdXIgb3RoZXIgcGF0Y2hlcywgSSB0aGluayB5b3Ugc2hvdWxkIHN0YXJ0IAo+ZG9pbmcgYWxs
IHRoZSBjaGFuZ2VzIGxvY2FsbHkgb24geW91ciBzaWRlLCBhbmQgd2hlbiB5b3UgYXJlIGZpbmlz
aGVkIAo+dHJ5IHRvIGdyb3VwIHRoaW5ncyB0b2dldGhlciBpbiBiaWdnZXIgcGF0Y2hlcyBwZXIg
YXJlYSBpbnN0ZWFkIG9mIAo+c2VuZGluZyBvbmUgYnkgb25lLiBJIHNlZSB5b3UgaGF2ZSBhbHJl
YWR5IHN0YXJ0ZWQgZG9pbmcgdGhhdCBmb3IgCj5vcGFsL3Bvd2VybnYgZm9yIGluc3RhbmNlLCBi
dXQgdGhlcmUgYXJlIHN0aWxsIGluZGl2aWR1YWwgcG93ZXJudi9vcGFsIAo+aW4gdGhlIHF1ZXVl
LiBJIHRoaW5rIHlvdSBzaG91bGQgZ3JvdXAgYWxsIHRvZ2V0aGVyIGluIGEgc2luZ2xlIHBhdGNo
LiAKPkFuZCBzYW1lIGZvciBvdGhlciBhcmVhcywgcGxlYXNlIHRyeSB0byBtaW5pbWlzZSB0aGUg
bnVtYmVyIG9mIHBhdGNoZXMuIAo+V2UgZG9uJ3QgbGluayBodWdlIGJvbWJzIHRoYXQgbW9kaWZ5
IGFsbCB0aGUga2VybmVsIGF0IG9uY2UsIGJ1dCB5b3UgY2FuIAo+Z3JvdXAgdGhpbmdzIHRvZ2V0
aGVyLCBvbmUgcGF0Y2ggZm9yIHBvd2VycGMgY29yZSBwYXJ0cywgb25lIHBhdGNoIGZvciAKPmVh
Y2ggcGxhdGZvcm0gaW4gYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy8gZXRjIC4uLgo+Cj4KPkNocmlz
dG9waGUKCgpIaSwgQ2hyaXN0b3BoZS4KClNvcnJ5IHRvIHRyb2J1bGUgeW91IGFnYWluLgoKTm93
IEkgaGF2ZSBmb3VuZCBvdGhlciBidWdzIGluIHNhbWUgZGlyZWN0b3JpZXMgKGkuZS4sIGFyY2gv
cG93ZXJwYy9zeXNkZXYpLCAKd2l0aCB0aGUgb25lcyBJIGhhdmUgc2VudCBidXQgbm90IHJlY2ll
dmVkIGFja2VkLWJ5IG9yIGNvbmZpcm1lZCBlbWFpbC4KClNvIEkgbmVlZCB0byBtZXJnZSB0aGUg
b2xkIG9uZXMgaW50byB0aGUgbmV3IG9uZXMgYXMgYSBQQVRDSC12MiBhbmQgdGhlbiByZXNlbmQg
dGhlIApvbGQgb25lcyA/Cm9yIGp1c3QgdXNlIGEgbmV3IFBBVENIIHRvIHNlbmQgb25seSBuZXcg
b25lcz8KCkkgYW0gYWZyYWlkIHRvIG1ha2UgbmV3IHRyb3VibGUgZm9yIG1haW50YWluZXJzLCBz
byBjYW4geW91IHNoYXJlIHlvdXIgdmFsdWFibGUgCmV4cGVyaWVuY2U/CgpUaGFua3MgdmVyeSBt
dWNoLgoKTGlhbmcKCgo=
