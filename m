Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91754EEB8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378512AbiFQBUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiFQBUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:20:38 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4005762201;
        Thu, 16 Jun 2022 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=sWQM3
        9UnjCAPyGb6n+UzLQBAULepaLyIUJckb/BXXUo=; b=ATGtbKgdaJ2zKRKBEchCR
        3K4nh+ZSXMN/gJUkXUENZfys0+J3WbY9rpFkC6okmKlTBMe+Rs8565oPG//dqUmm
        9d+D037ydgUqRGlkhxD0l+0dpS2znJRnD2nClSkHiWAWvCTZ8d9ZEygRP9+y7Li9
        YTGaLp2KDWo3XFdDDzpk1k=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Fri, 17 Jun 2022 09:20:13 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Fri, 17 Jun 2022 09:20:13 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Stephen Boyd" <sboyd@kernel.org>
Cc:     jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v3] drivers: clk: Add missing of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220617000913.24A4CC34114@smtp.kernel.org>
References: <20220616125409.3986745-1-windhl@126.com>
 <20220617000913.24A4CC34114@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <454850f.e70.1816f3f14a6.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowABXrPDP1qtiOA44AA--.31659W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgYiF1-HZUGFPAACsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTE3IDA4OjA5OjExLCAiU3RlcGhlbiBCb3lkIiA8c2JveWRAa2VybmVsLm9y
Zz4gd3JvdGU6Cj5RdW90aW5nIExpYW5nIEhlICgyMDIyLTA2LTE2IDA1OjU0OjA5KQo+PiBJbiB0
aGVzZSBjbGstcmVsYXRlZCBkcml2ZXJzJyB4eHhfaW5pdCgpIGZ1bmNpdG9ucywgb2ZfZmluZF9t
YXRjaGluZ19ub2RlKCkKPj4gd2lsbCByZXR1cm4gYSBub2RlIHBvaW50ZXIgd2l0aCByZWZjb3Vu
dCBpbmNyZW1lbnRlZC4gV2Ugc2hvdWxkIHVzZQo+PiBvZl9ub2RlX3B1dCgpIGluIGZhaWwgcGF0
aCBvciB3aGVuIGl0IGlzIG5vdCB1c2VkIGFueW1vcmUuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBM
aWFuZyBIZSA8d2luZGhsQDEyNi5jb20+Cj4+IC0tLQo+PiAgY2hhbmdlbG9nOgo+PiAKPj4gIHYz
OiBtZXJnZSBjbGsgJ21pc3Npbmcgb2Zfbm9kZV9wdXQoKScgcGF0Y2hlcyBpbnRvIG9uZSBjb21t
aXQuCj4+ICB2MjogdXNlIExpYW5nIEhlIGFzIHJlYWwgbmFtZSBmb3IgUy1vLWIuCj4+ICB2MTog
Zml4IHRoZSBtaXNzaW5nIG9mX25vZGVfcHV0KCkuCj4+IAo+PiAKPj4gIGRyaXZlcnMvY2xrL2Ns
ay1ub21hZGlrLmMgICAgICAgIHwgNSArKysrLQo+PiAgZHJpdmVycy9jbGsvdGVncmEvY2xrLXRl
Z3JhMTI0LmMgfCAxICsKPj4gIGRyaXZlcnMvY2xrL3RlZ3JhL2Nsay10ZWdyYTMwLmMgIHwgMSAr
Cj4KPlBsZWFzZSBzcGxpdCBpbnRvIGEgdGVncmEgcGF0Y2ggYW5kIGEgbm9tYWRpayBwYXRjaC4K
ClRoYW5rcywgSSB3aWxsIHNwbGl0IHRoZW0gYW5kIHJlc2VuZCBzb29uLgo=
