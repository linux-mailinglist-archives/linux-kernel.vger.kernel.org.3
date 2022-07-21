Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D9F57CB7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiGUNJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiGUNJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:09:00 -0400
X-Greylist: delayed 8191 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 06:08:42 PDT
Received: from m1353.mail.163.com (m1353.mail.163.com [220.181.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBDD3422FF;
        Thu, 21 Jul 2022 06:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=yDycJ
        HNEX38nFYMkuR2P0QYIzEVoyazCWD1v3pTzJRQ=; b=kLqMYO0OYg9GwHVcypEXp
        VWwWpkBVXOKVbERk6Cq6HNnNv4RBnXHDJK6TnypoiQTBrXDQqgswVLaqZcMAxyQ4
        2k7ZB4w1SjVy4+pnrki5bf1leJ2aM9OWslu3VdLPmf/byttTJRVCHaypQKLTkpNC
        n3ihwN8SuU4sViHB4DfAKk=
Received: from slark_xiao$163.com ( [223.104.68.234] ) by
 ajax-webmail-wmsvr53 (Coremail) ; Thu, 21 Jul 2022 18:35:25 +0800 (CST)
X-Originating-IP: [223.104.68.234]
Date:   Thu, 21 Jul 2022 18:35:25 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] iio: magn: hmc5843: Fix typo 'the the' in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <20220721111812.00003038@Huawei.com>
References: <20220721084441.50065-1-slark_xiao@163.com>
 <20220721111812.00003038@Huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <45c5e3ce.3724.182205399a9.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: NcGowAAXJ5nuK9liQColAA--.31122W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAxhFZGB0LnhE9wABsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMDctMjEgMTg6MTg6MTIsICJKb25hdGhhbiBDYW1lcm9u
IiA8Sm9uYXRoYW4uQ2FtZXJvbkBIdWF3ZWkuY29tPiB3cm90ZToKPk9uIFRodSwgMjEgSnVsIDIw
MjIgMTY6NDQ6NDEgKzA4MDAKPlNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4gd3JvdGU6
Cj4KPj4gUmVwbGFjZSAndGhlIHRoZScgd2l0aCAndGhlJyBpbiB0aGUgY29tbWVudC4KPj4gCj4+
IFNpZ25lZC1vZmYtYnk6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4KPkR1cGxpY2F0
ZSBvZiAKPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDYyMjAzNTkyNS41MDA4LTEt
amlhbmdqaWFuQGNkanJsYy5jb20vCj4+IC0tLQoKCk9rLCB0aGFua3MgZm9yIHRoYXQuIEkgd2ls
bCB1cGRhdGUgbXkgbG9jYWwgZmlsZXMgaW4gdGltZSB0byBhdm9pZCB0aGlzIHNjZW5hcmlvLgpU
aGFua3MhCgoKPj4gIGRyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9obWM1ODQzX2NvcmUuYyB8IDIg
Ky0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+PiAK
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9obWM1ODQzX2NvcmUuYyBi
L2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9obWM1ODQzX2NvcmUuYwo+PiBpbmRleCA5MmViMmQx
NTZkZGIuLjRhNjNiMmRhOWRmMCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9paW8vbWFnbmV0b21l
dGVyL2htYzU4NDNfY29yZS5jCj4+ICsrKyBiL2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9obWM1
ODQzX2NvcmUuYwo+PiBAQCAtMSw2ICsxLDYgQEAKPj4gIC8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4+ICAvKgo+PiAtICogRGV2aWNlIGRyaXZlciBmb3IgdGhl
IHRoZSBITUM1ODQzIG11bHRpLWNoaXAgbW9kdWxlIGRlc2lnbmVkCj4+ICsgKiBEZXZpY2UgZHJp
dmVyIGZvciB0aGUgSE1DNTg0MyBtdWx0aS1jaGlwIG1vZHVsZSBkZXNpZ25lZAo+PiAgICogZm9y
IGxvdyBmaWVsZCBtYWduZXRpYyBzZW5zaW5nLgo+PiAgICoKPj4gICAqIENvcHlyaWdodCAoQykg
MjAxMCBUZXhhcyBJbnN0cnVtZW50cwo=
