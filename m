Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A095859F5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiHXI53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiHXI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:57:27 -0400
Received: from m13131.mail.163.com (m13131.mail.163.com [220.181.13.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7123F24963;
        Wed, 24 Aug 2022 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=VMGvG
        uhOZ/7acBw5rjvV2grRy+hOZh0RapQmGgsUHhY=; b=bY2d1kfnEAnVmu/aiZquW
        ciWKBkUjxv5xYuC3egldhsmV2IpwNqr4E3u9FDIvtXubapyt3bV5gYZvqOBBEeOd
        tV4iaQPZdFXe3Vhd40ZUJhOD8YZfEC8qQM2GIMI1a7F2p/8Kpj8MYnKgMdRVoiPR
        Y3zL9slAMbNJqmgBIwjyw4=
Received: from slark_xiao$163.com ( [112.97.50.93] ) by
 ajax-webmail-wmsvr131 (Coremail) ; Wed, 24 Aug 2022 16:56:45 +0800 (CST)
X-Originating-IP: [112.97.50.93]
Date:   Wed, 24 Aug 2022 16:56:45 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     johan <johan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re:Re: [PATCH] USB: serial: option: add support for Cinterion
 MV32-WA/WB RmNet mode
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <YvtoSQUVuUkMCXtl@kroah.com>
References: <20220810033050.3117-1-slark_xiao@163.com>
 <54f2b923.341c.182a606bab3.Coremail.slark_xiao@163.com>
 <YvtoSQUVuUkMCXtl@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7491a855.2224.182cf117a99.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: g8GowABn1HnN5wVjoWQdAA--.9984W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDQpnZFaEKf7uEwACs+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMDgtMTYgMTc6NTA6MDEsICJncmVna2giIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj5PbiBUdWUsIEF1ZyAxNiwgMjAyMiBhdCAwNTo0
MDozNVBNICswODAwLCBTbGFyayBYaWFvIHdyb3RlOgo+PiBBbnkgcmVzcG9uc2Wjvwo+Cj5UbyB3
aGF0Pwo+Cj5JdCB3YXMgdGhlIG1pZGRsZSBvZiB0aGUgbWVyZ2Ugd2luZG93LCB3ZSBjYW4ndCBk
byBhbnl0aGluZyB3aXRoIG5ldwo+cGF0Y2hlcyB1bnRpbCBhZnRlciAtcmMxIGlzIG91dCwgYW5k
IHRoZW4gd2UgaGF2ZSBhIGZldyB0aG91c2FuZCB0byBkaWcKPnRocm91Z2ggYWZ0ZXJ3YXJkLgo+
Cj5SZWxheCwgdGhlcmUgaXMgbm8gcnVzaCBoZXJlLgo+Cj50aGFua3MsCj4KPmdyZWcgay1oCkhp
IEdyZWcsCiAgTm93IHY2LjAtcmMyIGlzIG91dCBmb3Igc2V2ZXJhbCBkYXlzLiBJIHN0aWxsIGRp
ZG4ndCBmaW5kIGFueSBwcm9ncmVzcyBhYm91dCB0aGlzIGNvbW1pdC4KTm9ybWFsbHkgc3VjaCBj
b21taXQgd291bGQgYmUgY29tbWl0dGVkIGludG8gSm9oYW4gSG92b2xkJ3MgcGVyc29uYWwgcHJv
amVjdCBmaXJzdGx5OgppbmRleDoga2VybmVsL2dpdC9qb2hhbi91c2Itc2VyaWFsLmdpdCBhbmQg
d2FpdHRpbmcgZm9yIG1lcmdlIHdpbmRvdy4KICBJbiBzb21lIHN1Yi1zeXN0ZW0sIHRoZSBtZXJn
ZSB3aW5kb3cgd291bGQgYmUgY2xvc2VkIGFmdGVyIHJjNC4KU28gSm9oYW4gb3IgR3JlZyAsIGNv
dWxkIHlvdSBoZWxwIGhhbmRsZSB0aGlzIGFzYXA/CgpUaGFua3MhCg==
