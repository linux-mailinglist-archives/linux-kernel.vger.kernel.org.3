Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8927B54CF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349095AbiFOQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348943AbiFOQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:51:16 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9E713FD8E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=tGRkU
        DKjq6HJmp5eOv3l/7ThtDQMpkNYLD2KIN1UUMA=; b=ADq1oJ35FqWmxH2xgTPz6
        M02uMmPNRlKPWrouWXdsiYWGKILMRugPB2B/ynKhwV5uQBlFtDDracwdnfDrjmFZ
        5nGpWKa9Yy2tKv0LCQTOib9XKgGCtwkyzMG/oaxTNLO6aPZDtIH4G3oHH0rmUFEg
        LIoUWV5IJMCRD6g1M82jAE=
Received: from windhl$126.com ( [123.112.70.164] ) by ajax-webmail-wmsvr50
 (Coremail) ; Thu, 16 Jun 2022 00:50:16 +0800 (CST)
X-Originating-IP: [123.112.70.164]
Date:   Thu, 16 Jun 2022 00:50:16 +0800 (CST)
From:   =?GBK?B?us3BwQ==?= <windhl@126.com>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "X86 ML" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Frank Rowand" <frank.rowand@sony.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH] arch: x86: kernel: Add missing of_node_put() in
 devicetree.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <CAL_JsqLfzz=Pxk=GaOyLpDf1u5WaMGE=UYSVf4MCp+7RRQSBeg@mail.gmail.com>
References: <20220615150325.3969911-1-windhl@126.com>
 <CAL_JsqLfzz=Pxk=GaOyLpDf1u5WaMGE=UYSVf4MCp+7RRQSBeg@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <525fcb48.8d90.1816845d84e.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowAAnffHIDapi1i03AA--.50013W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAghF2JVj4Rz2gAAsT
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpIaSwgcm9iLCB0aGFua3MgZm9yIHlvdXIgcmVwbHkuCgpUaGUgb2ZfZmluZF94eCB3aWxsIGlu
Y3JlYXNlIHRoZSByZWZjb3VudGVyIGZvciB0aGUgbG9jYWwgcmVmZXJlbmNlLCBzbyB3aGVuIAp0
aGUgZnVuY3Rpb24gcmV0dXJuLCB3ZSBuZWVkIGEgZGVjcmVhc2UgZm9yIHRoZSBkZXN0cm95IG9m
IHRoZSBsb2NhbCByZWZlcmVuY2UuClRoZSBkZXZpY2Ugd2lsbCBub3QgYmUgZnJlZWQgYXMgaXRz
IHJlZmNvdW50ZXIgd2lsbCBiZSBzdXJlIGxhcmdlciB0aGFuIDAgd2hlbiAKdGhlIGZ1bmN0aW9u
IHJldHVybnMuCgpBbGwgd2UgbmVlZCBpcyB0byBrZWVwIHRoZSByZWZjb3VudGluZyBiYWxhbmNl
LCByaWdodD8KCgoKCkF0IDIwMjItMDYtMTYgMDA6MjY6MTYsICJSb2IgSGVycmluZyIgPHJvYmhA
a2VybmVsLm9yZz4gd3JvdGU6Cj5PbiBXZWQsIEp1biAxNSwgMjAyMiBhdCA5OjAzIEFNIExpYW5n
IEhlIDx3aW5kaGxAMTI2LmNvbT4gd3JvdGU6Cj4+Cj4+IEluIGR0Yl9zZXR1cF9ocGV0KCksIG9m
X2ZpbmRfY29tcGF0aWJsZV9ub2RlKCkgd2lsbCByZXR1cm4gYSBub2RlCj4+IHBvaW50ZXIgd2l0
aCByZWZjb3VudCBpbmNyZW1lbnRlZC4gV2Ugc2hvdWxkIHVzZSBvZl9ub2RlX3B1dCgpIHdoZW4g
aXQKPj4gaXMgbm90IHVzZWQgYW55bW9yZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTGlhbmcgSGUg
PHdpbmRobEAxMjYuY29tPgo+PiAtLS0KPj4gIGFyY2gveDg2L2tlcm5lbC9kZXZpY2V0cmVlLmMg
fCAzICsrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva2VybmVsL2RldmljZXRyZWUuYyBiL2FyY2gveDg2L2tlcm5lbC9kZXZp
Y2V0cmVlLmMKPj4gaW5kZXggNWNkNTFmMjVmNDQ2Li42YTM4NjQyNGRkZjcgMTAwNjQ0Cj4+IC0t
LSBhL2FyY2gveDg2L2tlcm5lbC9kZXZpY2V0cmVlLmMKPj4gKysrIGIvYXJjaC94ODYva2VybmVs
L2RldmljZXRyZWUuYwo+PiBAQCAtMTIwLDYgKzEyMCw5IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBk
dGJfc2V0dXBfaHBldCh2b2lkKQo+PiAgICAgICAgIGlmICghZG4pCj4+ICAgICAgICAgICAgICAg
ICByZXR1cm47Cj4+ICAgICAgICAgcmV0ID0gb2ZfYWRkcmVzc190b19yZXNvdXJjZShkbiwgMCwg
JnIpOwo+PiArCj4+ICsgICAgICAgb2Zfbm9kZV9wdXQoZG4pOwo+PiArCj4KPllvdSBkb24ndCB3
YW50IGEgcHV0IG9uIHN1Y2Nlc3MuIElmIHlvdSBhcmUgdXNpbmcgdGhlIGRldmljZSwgdGhlbiB5
b3UKPndhbnQgdG8gaG9sZCBhIHJlZmVyZW5jZSB0byBpdC4KPgo+SSB3b3VsZCBndWVzcyB0aGF0
IGlmIHlvdSBoYXZlIGFuIGVycm9yIGhlcmUgYW5kIGRvbid0IGhhdmUgeW91cgo+dGltZXIsIHlv
dSdyZSBub3QgZ29pbmcgdG8gZmluaXNoIGJvb3RpbmcgYW55d2F5cy4KPgo+RmluYWxseSwgd291
bGRuJ3QgZHRiX2xhcGljX3NldHVwKCkgYW5kIGR0Yl9hZGRfaW9hcGljKCkgYWxzbyBuZWVkIGEK
PnNpbWlsYXIgY2hhbmdlPyBCdXQgYWdhaW4sIGlmIHRob3NlIGFyZW4ndCBpbml0aWFsaXplZCwg
eW91IHByb2JhYmx5Cj5hcmVuJ3QgZ2V0dGluZyB2ZXJ5IGZhci4KPgo+Cj4+ICAgICAgICAgaWYg
KHJldCkgewo+PiAgICAgICAgICAgICAgICAgV0FSTl9PTigxKTsKPj4gICAgICAgICAgICAgICAg
IHJldHVybjsKPj4gLS0KPj4gMi4yNS4xCj4+Cg==
