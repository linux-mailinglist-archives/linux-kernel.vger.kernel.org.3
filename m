Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1471A54DB08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359277AbiFPGxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359051AbiFPGxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:53:41 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5A625A0BC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=5cTfm
        ODNb8lH6Wzhj3ugO3wV8oQYCCfXEhOaU7VUNVo=; b=MW3tQ5qE4hCyAEUMDRCag
        tspZif1FKg7XhQSDGJLS1PK/zU2PWeJJcOUwVziZ1MhiE4rBUY2G4T7hgGBMjj4I
        iv9oVjaCWuQRphwjZEZlHIn+p1pDevX1Y2YGpNhN8VQK5XnKT30cVYjMbJEmW6OE
        tnfwrBJzzN0i+9BReperxo=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Thu, 16 Jun 2022 14:52:58 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Thu, 16 Jun 2022 14:52:58 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     Conor.Dooley@microchip.com
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re:Re: [PATCH v2] soc: sifive: (sifive_l2_cache) Add missing
 of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <fe1c23cf-dab4-d926-ffef-7a8a5489a071@microchip.com>
References: <20220616044915.3978097-1-windhl@126.com>
 <28cd6700.3e2d.1816b13f1fa.Coremail.windhl@126.com>
 <fe1c23cf-dab4-d926-ffef-7a8a5489a071@microchip.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3098748e.4883.1816b495c44.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowAAnLydL06pijBA3AA--.9807W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBQiF2JVj47iXgABsS
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTE2IDE0OjI2OjE3LCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90
ZToKPk9uIDE2LzA2LzIwMjIgMDY6NTQsIExpYW5nIEhlIHdyb3RlOgo+PiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUKPj4gCj4+IEF0IDIwMjItMDYtMTYgMTI6NDk6MTUsICJMaWFu
ZyBIZSIgPHdpbmRobEAxMjYuY29tPiB3cm90ZToKPj4+IEluIHNpZml2ZV9sMl9pbml0KCksIG9m
X2ZpbmRfbWF0Y2hpbmdfbm9kZSgpIHdpbGwgcmV0dXJuIGEgbm9kZSBwb2ludGVyCj4+PiB3aXRo
IHJlZmNvdW50IGluY3JlbWVudGVkLiBXZSBzaG91bGQgdXNlIG9mX25vZGVfcHV0KCkgaW4gZWFj
aCBmYWlsIHBhdGgKPj4+IG9yIHdoZW4gaXQgaXMgbm90IHVzZWQgYW55bW9yZS4KPj4+Cj4+PiBS
ZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4+Pgo+Pj4gU2ln
bmVkLW9mZi1ieTogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPgo+Pj4gLS0tCj4+IAo+PiAKPj4g
U29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcyB2ZXJzaW9uIGFzIGl0IHN0aWxsIGhhcyBhIGJ1Zy4g
IEkgd2lsbCBoYXZlIGEgc3RyaWN0IGNoZWNrIGFuZCBjb21waWxlIHRoZSBjb2RlIGJlZm9yZSBt
eSBuZXh0IGNvbW1pdC4KPgo+V2hpbGUgeW91J3JlIGF0IGl0IC0gZHJvcCB0aGUgUmVwb3J0ZWQt
YnkgdG9vLgo+WW91IG9ubHkgbmVlZCB0byBpbmNsdWRlIHRoYXQgaWYgTEtQIGZvdW5kIGEgcHJv
YmxlbSB3aXRoCj5hIHBhdGNoIHRoYXQncyBiZWVuIGFwcGxpZWQgYWxyZWFkeS4gSWYgaXQncyBv
biBzb21ldGhpbmcKPmluIHByb2dyZXNzLCBqdXN0IGZpeCB3aGF0IGl0IHBvaW50ZWQgb3V0ICYg
cmVzZW5kLgo+Cj5UaGFua3MsCj5Db25vci4KPgoKClRoYW5rcyBmb3IgYWxsIHlvdXIgaGVscCwg
Q29ub3IuCgpJIHdpbGwgbWFrZSBhIHByb3BlciBwYXRjaCBjb25zaWRlcmluZyBhbGwgdGhpbmdz
IHlvdSBzdWdnZXN0ZWQu
