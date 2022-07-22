Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99C57D8E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiGVDIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVDIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:08:15 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 259C28C588;
        Thu, 21 Jul 2022 20:08:13 -0700 (PDT)
Received: by ajax-webmail-mail-app3 (Coremail) ; Fri, 22 Jul 2022 11:08:01
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.176.244]
Date:   Fri, 22 Jul 2022 11:08:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     dongchun.zhu@mediatek.com, zhengsq@rock-chips.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v0] media: i2c: fix the erroneous pointer initializer
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20220722022459.5030-1-linma@zju.edu.cn>
References: <20220722022459.5030-1-linma@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <693a3b3e.519a0.18223e0575b.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgD3_6uSFNpiD7U3AQ--.18250W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwMTElNG3HhAaAACsa
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gdGhlcmUsCgoKPiAKPiBUaGVyZSBhcmUgb2J2aW91cyBlcnJvcnMgZm9yIHRoZSBpbml0
aWFsaXplciBvZiBvdjAyYTEwX2kyY19kcml2ZXIsCj4gb3YyNjgyX2kyY19kcml2ZXIsIGFuZCBv
djU2OTVfaTJjX2RyaXZlciBhcyB0aGUgY29kZSBpbnRlbmRlZCB0byBhc3NpZ24KPiAiYWRkcmVz
cyBvZiBmdW5jdGlvbiBwb2ludGVyIiB0byBmdW5jdGlvbiBwb2ludGVyLiBUaGlzIHBhdGNoIGZp
eGVzIHRoZW0KPiBieSByZW1vdmluZyByZWR1bmRhbnQgJiBvcGVyYXRvcnMuCj4gCj4gU2lnbmVk
LW9mZi1ieTogTGluIE1hIDxsaW5tYUB6anUuZWR1LmNuPgoKU29ycnkgYXMgdGhpcyBpcyBhIGZh
bHNlIGFsYXJtIDooCkkganVzdCBnZXQgY29uZnVzZWQgYnkgdGhlIGZ1bmN0aW9uIHBvaW50ZXJz
IGFuZCBmdW5jdGlvbiBhZGRyZXNzZXMgYW5kCnRoZSBvcmlnaW5hbCBjb2RlIHdvcmtzIGZpbmUu
CgpSZWdhcmRzCkxpbg==
