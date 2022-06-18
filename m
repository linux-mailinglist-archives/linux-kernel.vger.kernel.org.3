Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFAB550217
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383920AbiFRCnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383914AbiFRCnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:43:40 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 238B8222B9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=CiWP9
        J47fOf0SwiBXWz/6vH2KuuXSnebcHPFbMKOEds=; b=erEZwwJ4FGbX8tdHYKTW9
        pja4dXtj/h3QlBjqXD8/95vQB+6h7R73Jjo5/81j8+av7H1eSnbOUpNiAPVksnC2
        94PPcxhOja591vXmx6cf46zBZcey4r8RU0gAj/NCJW/mo0wKByGms6eyTDa3Jz7U
        S8IgR2qAY8pEgR0oZXA5bs=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Sat, 18 Jun 2022 10:43:12 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Sat, 18 Jun 2022 10:43:12 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Heiko Stuebner" <heiko@sntech.de>
Cc:     linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re:Re: [PATCH v2] arm: mach-rockchip: (pm) Add missing
 of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <165548567344.3407211.15518569345867067474.b4-ty@sntech.de>
References: <20220616021713.3973472-1-windhl@126.com>
 <165548567344.3407211.15518569345867067474.b4-ty@sntech.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <6b387941.aed.18174b16871.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowADXLPHBO61ixdU4AA--.57247W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAYkF2JVj6uAOAABsn
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTE4IDAxOjEwOjI4LCAiSGVpa28gU3R1ZWJuZXIiIDxoZWlrb0BzbnRlY2gu
ZGU+IHdyb3RlOgo+T24gVGh1LCAxNiBKdW4gMjAyMiAxMDoxNzoxMyArMDgwMCwgTGlhbmcgSGUg
d3JvdGU6Cj4+IEluIHJvY2tjaGlwX3N1c3BlbmRfaW5pdCgpLCBvZl9maW5kX21hdGNoaW5nX25v
ZGVfYW5kX21hdGNoKCkgd2lsbAo+PiByZXR1cm4gYSBub2RlIHBvaW50ZXIgd2l0aCByZWZjb3Vu
dCBpbmNyZW1lbnRlZC4gV2Ugc2hvdWxkIHVzZQo+PiBvZl9ub2RlX3B1dCgpIGluIGZhaWwgcGF0
aCBvciB3aGVuIGl0IGlzIG5vdCB1c2VkIGFueW1vcmUuCj4KPkFwcGxpZWQsIHRoYW5rcyEKPgo+
WzEvMV0gYXJtOiBtYWNoLXJvY2tjaGlwOiAocG0pIEFkZCBtaXNzaW5nIG9mX25vZGVfcHV0KCkK
PiAgICAgIGNvbW1pdCBmNDQ3MGRiZmI1ZmY5MjgwNDY1MGJjNzFkMTE1YzNmMTUwZDQzMGY2Cj4K
PlRoZXJlIHdhcyBhbiB1bm5lZWRlZCB0YWIgaW4gdGhlIGJsYW5rIGxpbmUgYWJvdmUgb3V0X3B1
dAo+YW5kIGEgY29tcGxldGVseSB1bm5lZWRlZCBibGFuayBsaW5lIGFkZGVkIGF0IHRoZSBlbmQg
b2YKPnRoZSBmdW5jdGlvbi4gSSBkcm9wcGVkIGJvdGguCgpUaGFua3MgdmVyeSBtdWNoIGZvciB5
b3VyIGVmZm9ydC4KCkkgYW0gbGVhcm5pbmcgdGhlIGNvZGluZyBzdHlsZSBmb3Iga2VybmVsIGNv
ZGUuCgo+Cj5CZXN0IHJlZ2FyZHMsCj4tLSAKPkhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2gu
ZGU+Cg==
