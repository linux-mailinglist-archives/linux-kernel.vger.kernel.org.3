Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC165B1265
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 04:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIHCUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 22:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIHCUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 22:20:39 -0400
Received: from m139.mail.163.com (m139.mail.163.com [220.181.13.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DE9C9674C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 19:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=adB2T
        bCim0/7Z3FjEjn7M9eko7cFm+XzbKkkKIHKxkg=; b=qNNBEgIYHZRjdq2HqoUQX
        tW0pVuiUJfa72VqOeHBgg9feQI77jFeI+H9srLguBvAETlXDw0+VD6MwwE7JdMFN
        oEZt23lqLDdApDw82kP0UYwMw8KlKjoRXyCVWri7C5AintrZKclNQKosvF6VHkqD
        wKbbx5yG2jKlPLCt/4yyi0=
Received: from 13667453960$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr9 (Coremail) ; Thu, 8 Sep 2022 10:19:14 +0800 (CST)
X-Originating-IP: [116.128.244.169]
Date:   Thu, 8 Sep 2022 10:19:14 +0800 (CST)
From:   "Yi Jiangshan" <13667453960@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiangshan Yi" <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re:Re: [PATCH] init.h: fix spelling typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <YxiP+t/ejJQ5mJE3@kroah.com>
References: <20220905021034.947701-1-13667453960@163.com>
 <YxiP+t/ejJQ5mJE3@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <27713f0a.dc5.1831ae4ef94.Coremail.13667453960@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CcGowADXp14iURljD3UqAA--.42694W
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbizRZ2+1c7OCpErwABsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjItMDktMDcgMjA6MzU6MDYsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gTW9uLCBTZXAgMDUsIDIwMjIgYXQgMTA6MTA6MzRBTSArMDgwMCwg
SmlhbmdzaGFuIFlpIHdyb3RlOgo+PiBGcm9tOiBKaWFuZ3NoYW4gWWkgPHlpamlhbmdzaGFuQGt5
bGlub3MuY24+Cj4+IAo+PiBGaXggc3BlbGxpbmcgdHlwbyBpbiBjb21tZW50Lgo+PiAKPj4gUmVw
b3J0ZWQtYnk6IGsyY2kgPGtlcm5lbC1ib3RAa3lsaW5vcy5jbj4KPj4gU2lnbmVkLW9mZi1ieTog
SmlhbmdzaGFuIFlpIDx5aWppYW5nc2hhbkBreWxpbm9zLmNuPgo+Cj5XaGF0IGlzICJrMmNpIj8K
ClRoZSBrMmNpIGlzIGFuIGF1dG9tYXRlZCBjb21waWxhdGlvbiwgZGV0ZWN0aW9uIGFuZCB0ZXN0
aW5nIHBsYXRmb3JtIGJ1aWx0IGJ5IHRoZSBjb21wYW55oaNKdXN0IGxpa2UgdGhlIGtlcm5lbCB0
ZXN0IHJvYm90IGJ1aWx0IGJ5IEludGVsoaMKU28gSSB3cml0ZSBsaWtlIHRoaXOjugpSZXBvcnRl
ZC1ieTogazJjaSA8a2VybmVsLWJvdEBreWxpbm9zLmNuPgpSZWZlciB0byB0aGUgZm9sbG93aW5n
OgpSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+CkRvY3VtZW50
YXRpb24vcHJvY2Vzcy9yZXNlYXJjaGVyLWd1aWRlbGluZXMucnN0Cgp0aGFua3MsCgpKaWFuZ3No
YW4gWWk=
