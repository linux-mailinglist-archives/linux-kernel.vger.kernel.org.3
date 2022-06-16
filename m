Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9B854E353
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377673AbiFPOYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiFPOYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:24:45 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96A102FE71;
        Thu, 16 Jun 2022 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=OMMyO
        AEEwGMF1IQ+p17secNB0QzgY5aVtSz8KMxxmIs=; b=B9pj4JmzGq5B2e/ejgyC8
        +2488aCvvoH/9E45UwhDk7Lo5whkmHJ8+AsZ6vC9CHqJTGXOwu8TEUXyahlzA8dJ
        TRE6kZ7XgVcCH+CkNgXUyDEbosIhF5ypcy/tfXGJKnGIfXaNA6AfgsD84C4hzfa1
        R+Lr8es/b7jOfM1tm+Husw=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Thu, 16 Jun 2022 22:24:00 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Thu, 16 Jun 2022 22:24:00 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "kernel test robot" <lkp@intel.com>
Cc:     linus.walleij@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] drivers: clk: (clk-nomadik) Add missing
 of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <202206162212.4SKEX9z6-lkp@intel.com>
References: <20220616032448.3974916-1-windhl@126.com>
 <202206162212.4SKEX9z6-lkp@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <4cda24de.7d99.1816ce64b6d.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowAAHXfECPatiFO03AA--.53934W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgIiF1-HZT7CyQABsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjItMDYtMTYgMjI6MDg6MTYsICJrZXJuZWwgdGVzdCByb2JvdCIgPGxrcEBpbnRlbC5j
b20+IHdyb3RlOgo+SGkgTGlhbmcsCj4KPlRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoISBZZXQgc29t
ZXRoaW5nIHRvIGltcHJvdmU6Cj4KPlthdXRvIGJ1aWxkIHRlc3QgRVJST1Igb24gY2xrL2Nsay1u
ZXh0XQo+W2Fsc28gYnVpbGQgdGVzdCBFUlJPUiBvbiBsaW51cy9tYXN0ZXIgdjUuMTktcmMyIG5l
eHQtMjAyMjA2MTZdCj5bSWYgeW91ciBwYXRjaCBpcyBhcHBsaWVkIHRvIHRoZSB3cm9uZyBnaXQg
dHJlZSwga2luZGx5IGRyb3AgdXMgYSBub3RlLgo+QW5kIHdoZW4gc3VibWl0dGluZyBwYXRjaCwg
d2Ugc3VnZ2VzdCB0byB1c2UgJy0tYmFzZScgYXMgZG9jdW1lbnRlZCBpbgo+aHR0cHM6Ly9naXQt
c2NtLmNvbS9kb2NzL2dpdC1mb3JtYXQtcGF0Y2hdCj4KPnVybDogICAgaHR0cHM6Ly9naXRodWIu
Y29tL2ludGVsLWxhYi1sa3AvbGludXgvY29tbWl0cy9MaWFuZy1IZS9kcml2ZXJzLWNsay1jbGst
bm9tYWRpay1BZGQtbWlzc2luZy1vZl9ub2RlX3B1dC8yMDIyMDYxNi0xMTI2MTIKPmJhc2U6ICAg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2xrL2xpbnV4
LmdpdCBjbGstbmV4dAo+Y29uZmlnOiBhcm0tbmhrODgxNV9kZWZjb25maWcgKGh0dHBzOi8vZG93
bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIyMDYxNi8yMDIyMDYxNjIyMTIuNFNLRVg5
ejYtbGtwQGludGVsLmNvbS9jb25maWcpCj5jb21waWxlcjogYXJtLWxpbnV4LWdudWVhYmktZ2Nj
IChHQ0MpIDExLjMuMAo+cmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKToKPiAgICAgICAg
d2dldCBodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vaW50ZWwvbGtwLXRlc3RzL21h
c3Rlci9zYmluL21ha2UuY3Jvc3MgLU8gfi9iaW4vbWFrZS5jcm9zcwo+ICAgICAgICBjaG1vZCAr
eCB+L2Jpbi9tYWtlLmNyb3NzCj4gICAgICAgICMgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxh
Yi1sa3AvbGludXgvY29tbWl0LzEyYTMwNTkxOGVhNDBjMDExMTZhM2NhYjk0ZmU2MmE0ODdlYWM0
OTkKPiAgICAgICAgZ2l0IHJlbW90ZSBhZGQgbGludXgtcmV2aWV3IGh0dHBzOi8vZ2l0aHViLmNv
bS9pbnRlbC1sYWItbGtwL2xpbnV4Cj4gICAgICAgIGdpdCBmZXRjaCAtLW5vLXRhZ3MgbGludXgt
cmV2aWV3IExpYW5nLUhlL2RyaXZlcnMtY2xrLWNsay1ub21hZGlrLUFkZC1taXNzaW5nLW9mX25v
ZGVfcHV0LzIwMjIwNjE2LTExMjYxMgo+ICAgICAgICBnaXQgY2hlY2tvdXQgMTJhMzA1OTE4ZWE0
MGMwMTExNmEzY2FiOTRmZTYyYTQ4N2VhYzQ5OQo+ICAgICAgICAjIHNhdmUgdGhlIGNvbmZpZyBm
aWxlCj4gICAgICAgIG1rZGlyIGJ1aWxkX2RpciAmJiBjcCBjb25maWcgYnVpbGRfZGlyLy5jb25m
aWcKPiAgICAgICAgQ09NUElMRVJfSU5TVEFMTF9QQVRIPSRIT01FLzBkYXkgQ09NUElMRVI9Z2Nj
LTExLjMuMCBtYWtlLmNyb3NzIFc9MSBPPWJ1aWxkX2RpciBBUkNIPWFybSBTSEVMTD0vYmluL2Jh
c2gKPgo+SWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZyB3aGVy
ZSBhcHBsaWNhYmxlCj5SZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5j
b20+Cj4KPkFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToKPgo+ICAgZHJpdmVy
cy9jbGsvY2xrLW5vbWFkaWsuYzogSW4gZnVuY3Rpb24gJ25vbWFkaWtfc3JjX2luaXQnOgo+ICAg
ZHJpdmVycy9jbGsvY2xrLW5vbWFkaWsuYzoxMzY6MTogd2FybmluZzogbGFiZWwgJ291dHB1dCcg
ZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWxhYmVsXQo+ICAgICAxMzYgfCBvdXRwdXQ6
Cj4gICAgICAgICB8IF5+fn5+fgo+Pj4gZHJpdmVycy9jbGsvY2xrLW5vbWFkaWsuYzoxMDI6MTc6
IGVycm9yOiBsYWJlbCAnb3V0X3B1dCcgdXNlZCBidXQgbm90IGRlZmluZWQKPiAgICAgMTAyIHwg
ICAgICAgICAgICAgICAgIGdvdG8gb3V0X3B1dDsKPiAgICAgICAgIHwgICAgICAgICAgICAgICAg
IF5+fn4KPgo+Cj52aW0gKy9vdXRfcHV0ICsxMDIgZHJpdmVycy9jbGsvY2xrLW5vbWFkaWsuYwo+
Cj4gICAgODcJCj4gICAgODgJc3RhdGljIHZvaWQgX19pbml0IG5vbWFkaWtfc3JjX2luaXQodm9p
ZCkKPiAgICA4OQl7Cj4gICAgOTAJCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7Cj4gICAgOTEJCXUz
MiB2YWw7Cj4gICAgOTIJCj4gICAgOTMJCW5wID0gb2ZfZmluZF9tYXRjaGluZ19ub2RlKE5VTEws
IG5vbWFkaWtfc3JjX21hdGNoKTsKPiAgICA5NAkJaWYgKCFucCkgewo+ICAgIDk1CQkJcHJfY3Jp
dCgibm8gbWF0Y2hpbmcgbm9kZSBmb3IgU1JDLCBhYm9ydGluZyBjbG9jayBpbml0XG4iKTsKPiAg
ICA5NgkJCXJldHVybjsKPiAgICA5NwkJfQo+ICAgIDk4CQlzcmNfYmFzZSA9IG9mX2lvbWFwKG5w
LCAwKTsKPiAgICA5OQkJaWYgKCFzcmNfYmFzZSkgewo+ICAgMTAwCQkJcHJfZXJyKCIlczogbXVz
dCBoYXZlIHNyYyBwYXJlbnQgbm9kZSB3aXRoIFJFR1MgKCVwT0ZuKVxuIiwKPiAgIDEwMQkJCSAg
ICAgICBfX2Z1bmNfXywgbnApOwo+ID4gMTAyCQkJZ290byBvdXRfcHV0Owo+ICAgMTAzCQl9Cj4g
ICAxMDQJCj4gICAxMDUJCS8qIFNldCBhbGwgdGltZXJzIHRvIHVzZSB0aGUgMi40IE1IeiBUSU1D
TEsgKi8KPiAgIDEwNgkJdmFsID0gcmVhZGwoc3JjX2Jhc2UgKyBTUkNfQ1IpOwo+ICAgMTA3CQl2
YWwgfD0gU1JDX0NSX1QwX0VOU0VMOwo+ICAgMTA4CQl2YWwgfD0gU1JDX0NSX1QxX0VOU0VMOwo+
ICAgMTA5CQl2YWwgfD0gU1JDX0NSX1QyX0VOU0VMOwo+ICAgMTEwCQl2YWwgfD0gU1JDX0NSX1Qz
X0VOU0VMOwo+ICAgMTExCQl2YWwgfD0gU1JDX0NSX1Q0X0VOU0VMOwo+ICAgMTEyCQl2YWwgfD0g
U1JDX0NSX1Q1X0VOU0VMOwo+ICAgMTEzCQl2YWwgfD0gU1JDX0NSX1Q2X0VOU0VMOwo+ICAgMTE0
CQl2YWwgfD0gU1JDX0NSX1Q3X0VOU0VMOwo+ICAgMTE1CQl3cml0ZWwodmFsLCBzcmNfYmFzZSAr
IFNSQ19DUik7Cj4gICAxMTYJCj4gICAxMTcJCXZhbCA9IHJlYWRsKHNyY19iYXNlICsgU1JDX1hU
QUxDUik7Cj4gICAxMTgJCXByX2luZm8oIlNYVEFMTyBpcyAlc1xuIiwKPiAgIDExOQkJCSh2YWwg
JiBTUkNfWFRBTENSX1NYVEFMRElTKSA/ICJkaXNhYmxlZCIgOiAiZW5hYmxlZCIpOwo+ICAgMTIw
CQlwcl9pbmZvKCJNWFRBTCBpcyAlc1xuIiwKPiAgIDEyMQkJCSh2YWwgJiBTUkNfWFRBTENSX01Y
VEFMU1RBVCkgPyAiZW5hYmxlZCIgOiAiZGlzYWJsZWQiKTsKPiAgIDEyMgkJaWYgKG9mX3Byb3Bl
cnR5X3JlYWRfYm9vbChucCwgImRpc2FibGUtc3h0YWxvIikpIHsKPiAgIDEyMwkJCS8qIFRoZSBt
YWNoaW5lIHVzZXMgYW4gZXh0ZXJuYWwgb3NjaWxsYXRvciBjaXJjdWl0ICovCj4gICAxMjQJCQl2
YWwgfD0gU1JDX1hUQUxDUl9TWFRBTERJUzsKPiAgIDEyNQkJCXByX2luZm8oImRpc2FibGluZyBT
WFRBTE9cbiIpOwo+ICAgMTI2CQl9Cj4gICAxMjcJCWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wo
bnAsICJkaXNhYmxlLW14dGFsbyIpKSB7Cj4gICAxMjgJCQkvKiBEaXNhYmxlIHRoaXMgdG9vOiBh
bHNvIHJ1biBieSBleHRlcm5hbCBvc2NpbGxhdG9yICovCj4gICAxMjkJCQl2YWwgfD0gU1JDX1hU
QUxDUl9NWFRBTE9WRVI7Cj4gICAxMzAJCQl2YWwgJj0gflNSQ19YVEFMQ1JfTVhUQUxFTjsKPiAg
IDEzMQkJCXByX2luZm8oImRpc2FibGluZyBNWFRBTE9cbiIpOwo+ICAgMTMyCQl9Cj4gICAxMzMJ
CXdyaXRlbCh2YWwsIHNyY19iYXNlICsgU1JDX1hUQUxDUik7Cj4gICAxMzQJCXJlZ2lzdGVyX3Jl
Ym9vdF9ub3RpZmllcigmbm9tYWRpa19jbGtfcmVib290X25vdGlmaWVyKTsKPiAgIDEzNQkJCj4g
PiAxMzYJb3V0cHV0Ogo+ICAgMTM3CSAgICBvZl9ub2RlX3B1dChucCk7CQo+ICAgMTM4CX0KPiAg
IDEzOQkKPgo+LS0gCj4wLURBWSBDSSBLZXJuZWwgVGVzdCBTZXJ2aWNlCj5odHRwczovLzAxLm9y
Zy9sa3AKClNvcnJ5IGZvciBteSBlYXJseSBtaXN0YWtlLiBBbmQgSSBoYXZlIG1lcmdlZCBhbGwg
J2NsaycgYnVnLWZpeGVzIGludG8gYSBuZXcgY29tbWl0IFtQQVRDSCB2M10uCgpUaGFua3MgZm9y
IHRoaXMgcmVwb3J0Lgo=
