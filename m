Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F8454DCBA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359169AbiFPIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359431AbiFPIU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:20:57 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 414855D672;
        Thu, 16 Jun 2022 01:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=kdfWx
        6XZzO9qni6lYYIV53hUL9pVC8liXgCxesDNue4=; b=fDdsfZSOIjmmMME9HNlGp
        s3ZAOyD1rJd6nF/EL5bezm4dK64DttUz9gL3AfeqUsPeVyen774bO5c6T/SDB2bc
        mpZU01Kl0/Bcm0E8R5zmORY058MsoCAoiKD56jemA6V1kN968Smea6aHeHB6EY4L
        IIEHVZQgw/FZ9Xd90mEz30=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Thu, 16 Jun 2022 16:19:41 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Thu, 16 Jun 2022 16:19:41 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Stephen Boyd" <sboyd@kernel.org>, Conor.Dooley@microchip.com
Cc:     jonathanh@nvidia.com, mturquette@baylibre.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] clk: tegra: (clk-tegra30) Add missing
 of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220616060037.5AEB8C34114@smtp.kernel.org>
References: <20220616033622.3975621-1-windhl@126.com>
 <20220616060037.5AEB8C34114@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <1a776c99.5e5c.1816b98bfee.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowABHTyef56pi0jA3AA--.10921W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGhQiF1-HZTyeegACsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKQXQgMjAyMi0wNi0xNiAxNDowMDozNSwgIlN0ZXBoZW4gQm95ZCIgPHNib3lkQGtlcm5l
bC5vcmc+IHdyb3RlOgo+VGhlIHN1YmplY3Qgc2hvdWxkIG1hdGNoIGhpc3RvcmljYWwgc3ViamVj
dHMKPgo+ICQgZ2l0IGxvZyAtLW9uZWxpbmUgLTMgLS0gZHJpdmVycy9jbGsvdGVncmEvY2xrLXRl
Z3JhMzAuYwo+Cj5zaG93cyBtb3N0bHkgImNsazogdGVncmE6ICIuIENhbiB5b3UgYWxzbyBjb21i
aW5lIHRoaXMgd2l0aCB0aGUgb3RoZXIKPnRlZ3JhIHBhdGNoPyBEb24ndCB0aGluayB3ZSBuZWVk
IHR3byBwYXRjaGVzIGZvciBlc3NlbnRpYWxseSB0aGUgc2FtZQo+dGhpbmcuCj4KPlF1b3Rpbmcg
TGlhbmcgSGUgKDIwMjItMDYtMTUgMjA6MzY6MjIpCj4+IEluIHRlZ3JhMzBfY2xvY2tfaW5pdCwg
b2ZfZmluZF9tYXRjaGluZ19ub2RlKCkgd2lsbCByZXR1cm4gYSBub2RlCj4+IHBvaW50ZXIgd2l0
aCByZWZjb3VudCBpbmNyZW1lbnRlZC4gV2Ugc2hvdWxkIHVzZSBvZl9ub2RlX3B1dCgpIHdoZW4K
Pj4gdGhlIG5vZGUgcG9pbnRlciBpcyBub3QgdXNlZCBhbnltb3JlLgo+PiAKPj4gU2lnbmVkLW9m
Zi1ieTogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPgo+PiAtLS0KPj4gIGNoYW5nZWxvZzoKPj4g
Cj4+ICB2MjogdXNlIHJlYWwgbmFtZSBmb3IgU29iCj4KPlRoYW5rcyEKPgo+PiAgdjE6IGZpeCBt
aXNzaW5nIGJ1ZwoKU29ycnkgZm9yIG15IGZhdWx0LiBJIGhhdmUgYmVlbiBhZHZpc2VkIHRvIHVz
ZSByZWFsIG5hbWUgYW5kIEkgcmVzZW5kIGEgUEFUQ0ggdjIgd2l0aCBteSByZWFsIG5hbWUsIGJ1
dCByZWFsbHkgd2l0aCB0aGUgc2FtZSBwYXRjaCBjb2RlLgoKU28gaG93IGNhbiBJIHdpdGhkcmF3
IHRoZSBmaXJzdCBwYXRjaCBvciByZXNlbmQgb3RoZXIgdGhpbmc/IEkgYW0gY29uZnVzZWQuIAoK
Q2FuIHlvdSBoZWxwIG1lLCBDb25vcj8K
