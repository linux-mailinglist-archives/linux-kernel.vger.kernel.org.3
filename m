Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8201E516261
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 09:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbiEAHFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 03:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbiEAHF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 03:05:28 -0400
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BF41A051
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651388520;
        bh=a8p/beQuYoG6HbG5O776YKIv8httHP96RkhZpN8ssbs=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=EzcQcbZmRYTgkly6SzjQblY+JGnfh+Sdzll99PyzivzAfjh4Xp2GCOp4DIaKQrxJR
         /YYFcDhbNNQR4DHrUbWGdYhx7oSQ0M7MwyiVXVPuBmdTwNg1UW5Lk525apyL+yn744
         GPPw3+OMKaOCiNUwGsfggvHSR6N+CIAZ5mltkCTs=
Received: from helloworld ([59.172.176.225])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id 7A390BB; Sun, 01 May 2022 15:01:58 +0800
X-QQ-mid: xmsmtpt1651388518tiivffook
Message-ID: <tencent_3A32A3E4AA726450348797294DFCCB81600A@qq.com>
X-QQ-XMAILINFO: NgK2g0LaajGfVebqiSpxy+6pe9sjWuLEBbidSk5qMly00XJlVme3IpgkzT+C6y
         v2q1liDu/DX4rg4/t0Uw9XMPpPWUJoS63PiVqxeXl0zsW9VACCyT/NPu01zwwCOjkIDhQMsP3O0s
         FCWyxgaZsepivcSXi4cuNgBkHKI5UhRKB8CQJrYxLuyJ8bUHgdBcZEdEscTsP7PbCEAUGVDgu6BE
         ey6Tiwj0KMOCvkaYNT/JH++sQpvOt3yHXl8UaJxmzbaZc9S/kkqmfRgUiZg6YdzPNxMRtaP2dp+X
         69w1d/6sCtMVKRnWuniBG2HqQUQxdn745LL1iCGKcRpsh4neAG3j8zg4NM7RriMOOkVjveKd83yX
         3QpqAzPQPEkDlqZmIfyVBJr02+XkJh/lK1UeBPpiCk7l2xUBGf4aPvFWhn/WIqJCOyP9WkTv5H8M
         XaWDehsewEUEVATwjPZwRqsyghw/gNAYoTR+WJIHZffZuubTq1J1jkZqjvwFoLc8l1tRMmpkEYQl
         91tia9+poX7xqM92hG4r7V3cqQ3Lg1Hl2nW1/HjGQFpsT5y/wm/2qq7IO9Cjd/WNZsQe1FUeI0Qz
         guSg5S2Up2tF9vEzC4QPmmY5ASsUJNjYGOmtSlBxu9eqwhDUhTC5NiGclnp/HeGRkNvyD24N/KoT
         jIcPdW45I29kRQ8O1xmPFoFATly4O4rpUJ8WX1TTH7Z3PIWbq1/gb33swhVFRHqGBE6rHJRFT+9X
         G54MGexMoSVo+baAnzkt56mrNS6tXac9MfNzHkW2bpvtW9G90HwvSeeWUCn9iiD1F4Wt1Pz5Dc/5
         g7bOGDy5AgkgDt/1vPYISqKbKKAeNxMQ3yZkF0Tl/LOnl0uA+muWKSldLbIsiWJ3nnDX4eNd/2sV
         BqYfhH+BycDG7RV18up9FKRKRhiF8h0+6GrK7kVMeBBtxCNw4mpAuhCfQCVFEoYp0dn/yKu+wH6v
         cWpSCe+DUpblHLOouUgK48mMoBIqzicb6fV5ATBT0=
From:   <xkernel.wang@foxmail.com>
To:     <linux@armlinux.org.uk>
Cc:     <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <tencent_1D9E7394538085872BE9FD6780483137E70A@qq.com> <YmwB83u68uPKuU0a@shell.armlinux.org.uk>
In-Reply-To: <YmwB83u68uPKuU0a@shell.armlinux.org.uk>
Subject: Re: [PATCH] ARM: mvebu: check the validation of memory allocation
Date:   Sun, 1 May 2022 15:01:58 +0800
X-OQ-MSGID: <009b01d85d29$5a1fdeb0$0e5f9c10$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKWC/NpS5yVGNKjZwJUNiP5WlVJ6gGNT8eoq4HKkAA=
Content-Language: zh-cn
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 29, 2022 11:19 PM +0800, linux@armlinux.org.uk wrote:
> Are these failures silent, or will they be reported in the kernel log =
to
> make their failure obvious to those who debug the kernel?

According to chapter 14 of the coding style document:
"These generic allocation functions all emit a stack dump on failure =
when used
without __GFP_NOWARN so there is no use in emitting an additional =
failure
message when NULL is returned."

I think that these failures are not silent since __GFP_NOWARN is not
enabled.

Regards,
Xiaoke Wang

