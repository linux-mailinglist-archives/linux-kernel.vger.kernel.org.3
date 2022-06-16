Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2C54DCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359308AbiFPI1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFPI1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:27:00 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B7FA393C5;
        Thu, 16 Jun 2022 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=as9Cc
        zfU4pBW9WzJ5FIGAqVUtplg6qawQ77z7V7IwXE=; b=e+C4bgt6/6lvYf2mR8tUQ
        5/ppsTjn208uSQpP4MkF3UhbzCcWpVYXMd+v7z/3LH0YnjpV1nD0/cF0H3Qz+nH1
        lCqXjXLgJU/VsH56RWNKfvv5C8MguA3MN8Gz15tRuutITZosRzhjZzuR8h+cY0QX
        D2+jPXG4L1YFu21SKjzwMM=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Thu, 16 Jun 2022 16:24:46 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Thu, 16 Jun 2022 16:24:46 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Stephen Boyd" <sboyd@kernel.org>, Conor.Dooley@microchip.com
Cc:     linus.walleij@linaro.org, mturquette@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] drivers: clk: (clk-nomadik) Add missing
 of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220616060225.3495EC34114@smtp.kernel.org>
References: <20220616032448.3974916-1-windhl@126.com>
 <20220616060225.3495EC34114@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <22796950.5fb1.1816b9d67a7.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowABHTyfP6Kpi1TI3AA--.10962W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgEiF1-HZTzNtAABsX
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTE2IDE0OjAyOjIzLCAiU3RlcGhlbiBCb3lkIiA8c2JveWRAa2VybmVsLm9y
Zz4gd3JvdGU6Cj5TYW1lIHN1YmplY3QgbGluZSBjb21tZW50IGFwcGxpZXMgaGVyZS4gTG9vayBh
dCBwcmV2aW91cyBwYXRjaGVzIHRvIHRoZQo+ZmlsZS4KClNvcnJ5LCB3aGF0IGRvIHlvdSBtZWFu
IHNhbWUgc3ViamVjdCBsaW5lIGNvbW1lbnQ/CgpJIGFkZCBhIFtQQVRDSCB2Ml0gdGFnIHdoZW4g
SSB1c2UgJ2dpdCBmb3JtYXQtcGF0Y2ggLXYgMicuCgpZb3UgbWVhbiB0aGUgdHdvIGNvbW1pdCBo
YXMgc2FtZSBzdWJqZWN0IGNvbnRlbnQ/CgpTb3JyeSwgSSBhbSBhIGJlZ2lubmVyIHRvIHN1Ym1p
dCBwYXRjaCBjb21taXQuCgo+Cj5RdW90aW5nIExpYW5nIEhlICgyMDIyLTA2LTE1IDIwOjI0OjQ4
KQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLW5vbWFkaWsuYyBiL2RyaXZlcnMvY2xr
L2Nsay1ub21hZGlrLmMKPj4gaW5kZXggYmFkMjY3N2UxMWFlLi40OGQ1NzcyYjM2YTUgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1ub21hZGlrLmMKPj4gKysrIGIvZHJpdmVycy9jbGsv
Y2xrLW5vbWFkaWsuYwo+PiBAQCAtOTksNyArOTksNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgbm9t
YWRpa19zcmNfaW5pdCh2b2lkKQo+PiAgICAgICAgIGlmICghc3JjX2Jhc2UpIHsKPj4gICAgICAg
ICAgICAgICAgIHByX2VycigiJXM6IG11c3QgaGF2ZSBzcmMgcGFyZW50IG5vZGUgd2l0aCBSRUdT
ICglcE9GbilcbiIsCj4+ICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIG5wKTsKPj4g
LSAgICAgICAgICAgICAgIHJldHVybjsKPj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0X3B1dDsK
Pj4gICAgICAgICB9Cj4+ICAKPj4gICAgICAgICAvKiBTZXQgYWxsIHRpbWVycyB0byB1c2UgdGhl
IDIuNCBNSHogVElNQ0xLICovCj4+IEBAIC0xMzIsNiArMTMyLDkgQEAgc3RhdGljIHZvaWQgX19p
bml0IG5vbWFkaWtfc3JjX2luaXQodm9pZCkKPj4gICAgICAgICB9Cj4+ICAgICAgICAgd3JpdGVs
KHZhbCwgc3JjX2Jhc2UgKyBTUkNfWFRBTENSKTsKPj4gICAgICAgICByZWdpc3Rlcl9yZWJvb3Rf
bm90aWZpZXIoJm5vbWFkaWtfY2xrX3JlYm9vdF9ub3RpZmllcik7Cj4+ICsgICAgICAgCj4+ICtv
dXRwdXQ6Cj4+ICsgICAgb2Zfbm9kZV9wdXQobnApOyAgIAo+Cj50YWJiZWQgaW5jb3JyZWN0bHk/
CgpTb3JyeSBmb3IgdGhpcyBpbmNvcnJjdCB0YWIgc2V0dGluZy4=
