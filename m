Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BC054D97C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 06:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349333AbiFPEzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 00:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiFPEzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:55:18 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70C98427DE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=dshfT
        7W6MY5sBDSYiWA99vNTQfl5M8jX0dK3LxKchtg=; b=kGaypZpwiRhQsvtsbLNua
        gqglHQHDFf3c2zv5nv2hPsuXQKIt0OMw9jbY+77QFvhBqhyOK/Xupjaa4uG+JUoE
        9bhn7IWxO3tKBmbFLf7JCc/KWftTz2xb22hKWYgZuA1ZOtJ9BaNmbydDc1mWOZqx
        Kj2QJXL1rvaIDZ2Oc9F4uk=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Thu, 16 Jun 2022 12:54:50 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Thu, 16 Jun 2022 12:54:50 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "kernel test robot" <lkp@intel.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, kbuild-all@lists.01.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] drivers: soc: sifive: Add missing of_node_put() in
 sifive_l2_cache.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <202206160559.fVKJx0ST-lkp@intel.com>
References: <20220615122315.3965435-1-windhl@126.com>
 <202206160559.fVKJx0ST-lkp@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3e6469ba.38b2.1816add33c5.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowACXpiaat6piW_k2AA--.1844W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuA4iF2JVj44gFgACsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCkF0IDIwMjItMDYtMTYgMDU6NTg6MDUsICJrZXJuZWwgdGVzdCByb2JvdCIgPGxrcEBpbnRl
bC5jb20+IHdyb3RlOgo+SGkgTGlhbmcsCj4KPlRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoISBZZXQg
c29tZXRoaW5nIHRvIGltcHJvdmU6Cj4KPlthdXRvIGJ1aWxkIHRlc3QgRVJST1Igb24gbGludXMv
bWFzdGVyXQo+W2Fsc28gYnVpbGQgdGVzdCBFUlJPUiBvbiB2NS4xOS1yYzIgbmV4dC0yMDIyMDYx
NV0KPltJZiB5b3VyIHBhdGNoIGlzIGFwcGxpZWQgdG8gdGhlIHdyb25nIGdpdCB0cmVlLCBraW5k
bHkgZHJvcCB1cyBhIG5vdGUuCj5BbmQgd2hlbiBzdWJtaXR0aW5nIHBhdGNoLCB3ZSBzdWdnZXN0
IHRvIHVzZSAnLS1iYXNlJyBhcyBkb2N1bWVudGVkIGluCj5odHRwczovL2dpdC1zY20uY29tL2Rv
Y3MvZ2l0LWZvcm1hdC1wYXRjaF0KPgoKV2hlbiBJIHVzZSAtLWJhc2UsIHRoZXJlIGFyZSB0b28g
bWFueSBwcmVyZXF1ZXN0cy1wYXRjaC1pZCBjYXVzZWQgYnkgbXkgbG9jYWwgY29tbWl0cy4gCkkg
ZG9uJ3Qga25vdyBpZiBpdCB3aWxsIGNhdXNlIG90aGVyIHRyb3VibGVzLiBTbyBJIHJlc2VudCBh
IG5ldyBwYXRjaCBzdGlsbCB3aXRob3V0IHRoaXMgJy0tYmFzZScuCklzIGl0IE9rPwoKU29ycnks
IEkgZm9yZ2V0IHRvIHNheSBpbiBuZXcgcGF0Y2ggdGhhdCAgaXMgYmFzZWQgb24gdjUuMTktcmMy
IG1haW5saW5lIGdpdCByZXBvLgoKPnVybDogICAgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxh
Yi1sa3AvbGludXgvY29tbWl0cy9MaWFuZy1IZS9kcml2ZXJzLXNvYy1zaWZpdmUtQWRkLW1pc3Np
bmctb2Zfbm9kZV9wdXQtaW4tc2lmaXZlX2wyX2NhY2hlLWMvMjAyMjA2MTUtMjAyNTI4Cj5iYXNl
OiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdCAwMThhYjRmYWJkZGQ5NGYxYzk2ZjNiNTllMTgwNjkxYjllODhkNWQ4Cj5j
b25maWc6IHJpc2N2LWFsbHllc2NvbmZpZyAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1j
aS9hcmNoaXZlLzIwMjIwNjE2LzIwMjIwNjE2MDU1OS5mVktKeDBTVC1sa3BAaW50ZWwuY29tL2Nv
bmZpZykKPmNvbXBpbGVyOiByaXNjdjY0LWxpbnV4LWdjYyAoR0NDKSAxMS4zLjAKPnJlcHJvZHVj
ZSAodGhpcyBpcyBhIFc9MSBidWlsZCk6Cj4gICAgICAgIHdnZXQgaHR0cHM6Ly9yYXcuZ2l0aHVi
dXNlcmNvbnRlbnQuY29tL2ludGVsL2xrcC10ZXN0cy9tYXN0ZXIvc2Jpbi9tYWtlLmNyb3NzIC1P
IH4vYmluL21ha2UuY3Jvc3MKPiAgICAgICAgY2htb2QgK3ggfi9iaW4vbWFrZS5jcm9zcwo+ICAg
ICAgICAjIGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWItbGtwL2xpbnV4L2NvbW1pdC80OWM0
MDg2NzY4YjVhZmY0MTBhNGExOWNhNzQwZjhhZThlMjExODQ0Cj4gICAgICAgIGdpdCByZW1vdGUg
YWRkIGxpbnV4LXJldmlldyBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFiLWxrcC9saW51eAo+
ICAgICAgICBnaXQgZmV0Y2ggLS1uby10YWdzIGxpbnV4LXJldmlldyBMaWFuZy1IZS9kcml2ZXJz
LXNvYy1zaWZpdmUtQWRkLW1pc3Npbmctb2Zfbm9kZV9wdXQtaW4tc2lmaXZlX2wyX2NhY2hlLWMv
MjAyMjA2MTUtMjAyNTI4Cj4gICAgICAgIGdpdCBjaGVja291dCA0OWM0MDg2NzY4YjVhZmY0MTBh
NGExOWNhNzQwZjhhZThlMjExODQ0Cj4gICAgICAgICMgc2F2ZSB0aGUgY29uZmlnIGZpbGUKPiAg
ICAgICAgbWtkaXIgYnVpbGRfZGlyICYmIGNwIGNvbmZpZyBidWlsZF9kaXIvLmNvbmZpZwo+ICAg
ICAgICBDT01QSUxFUl9JTlNUQUxMX1BBVEg9JEhPTUUvMGRheSBDT01QSUxFUj1nY2MtMTEuMy4w
IG1ha2UuY3Jvc3MgVz0xIE89YnVpbGRfZGlyIEFSQ0g9cmlzY3YgU0hFTEw9L2Jpbi9iYXNoIGRy
aXZlcnMvc29jLwo+Cj5JZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcg
dGFnIHdoZXJlIGFwcGxpY2FibGUKPlJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtw
QGludGVsLmNvbT4KPgoKVGhhbmtzIGZvciB0aGlzIHJlcG9ydCwgbm93IEkgbWFrZSBhIG5ldyBw
YXRjaCBhbmQgYWRkICJSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5j
b20+IgoKCj5BbGwgZXJyb3JzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6Cj4KPiAgIGRyaXZl
cnMvc29jL3NpZml2ZS9zaWZpdmVfbDJfY2FjaGUuYzogSW4gZnVuY3Rpb24gJ3NpZml2ZV9sMl9p
bml0JzoKPj4+IGRyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfbDJfY2FjaGUuYzoyMjQ6MTc6IGVy
cm9yOiBleHBlY3RlZCAnOycgYmVmb3JlICdnb3RvJwo+ICAgICAyMjQgfCAgICAgICAgICAgICAg
ICAgZ290byBvdXRfcHV0Owo+ICAgICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fgo+Cj4KClRo
YW5rcyBmb3IgYWxsIHlvdXIgZWZmb3J0IHRvIGltcHJvdmUgdGhlIHBhdGNoLgo=
