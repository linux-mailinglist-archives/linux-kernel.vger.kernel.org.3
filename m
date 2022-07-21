Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78457C48E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiGUGjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiGUGjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:39:44 -0400
Received: from m1353.mail.163.com (m1353.mail.163.com [220.181.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2578F37191
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=hPmGP
        BYB6qxeZDJav1pSkWffMErnFcb5ijoj1Va5ekw=; b=E7AmvWZRDE2UPCTsaBTlS
        8QqpxkY74g916TxMkgETDqVMhg8n+GyESPkc7bwfW+IqG2d4QEyA4GTqrv+6CQCZ
        MAbKSIK9oZaao0kYjeeR2cGUkOHNX2KCOoMjSaABPA9xyhqthAAWnbeWfAK4sY1c
        NIeu/EFFx2xnRsuyGluM5s=
Received: from slark_xiao$163.com ( [112.97.57.47] ) by ajax-webmail-wmsvr53
 (Coremail) ; Thu, 21 Jul 2022 14:39:08 +0800 (CST)
X-Originating-IP: [112.97.57.47]
Date:   Thu, 21 Jul 2022 14:39:08 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] s390: Fix typo 'the the' in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <YtjxaKSMDvdTsyM+@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220721033358.44838-1-slark_xiao@163.com>
 <YtjxaKSMDvdTsyM+@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3e932eb1.1f0c.1821f7b4643.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: NcGowACXpzON9NhiRAIlAA--.5999W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQJFZGBbEa58pQABsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpLArCoCBPS2F5LCBJIHdpbGwgc2VuZCB2MiBsYXRlci4KwqAgQlRXLCBhZGQgc3Vic3lzdGVt
cyB0byB0aGUgdGl0bGUgd291bGQgYmUgZW5vdWdoLCByaWdodD8KCgoKCgpBdCAyMDIyLTA3LTIx
IDE0OjI1OjQ0LCAiQWxleGFuZGVyIEdvcmRlZXYiIDxhZ29yZGVldkBsaW51eC5pYm0uY29tPiB3
cm90ZToKPk9uIFRodSwgSnVsIDIxLCAyMDIyIGF0IDExOjMzOjU4QU0gKzA4MDAsIFNsYXJrIFhp
YW8gd3JvdGU6Cj4+IFJlcGxhY2UgJ3RoZSB0aGUnIHdpdGggJ3RoZScgaW4gdGhlIGNvbW1lbnQu
Cj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+Cj4+
IC0tLQo+PiAgYXJjaC9zMzkwL2tlcm5lbC9wZXJmX2NwdW1fc2YuYyB8IDIgKy0KPj4gIGFyY2gv
czM5MC9rZXJuZWwvc3RoeWkuYyAgICAgICAgfCAyICstCj4KPlBsZWFzZSwgc3BsaXQgaW4gdHdv
IHBhdGNoZXMgYW5kIGFkZCBzdWJzeXN0ZW1zIHRvIHRoZSBkZXNjcmlwdGlvbnMuCj4KPlRoYW5r
cyEK
