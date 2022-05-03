Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C4B517FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiECI0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiECIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:25:57 -0400
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5437B29800
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651566143;
        bh=NJIAh5guHFYvIB8e0zXNUzDaqjoEDhd3vxvk7zdlYu0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=fbgVE9LlJZjZlgkn8NTq8dUtqDOxRIhvmg9V0wplcBTFU20hivPWmzflKsDSBHlkB
         j+X9bepqOWzKvh4k8hOJYZp1KjDMQ+E+mvecBArbbb15KiBmryNB7KGtDk6TSbrYuv
         8zTnu1s5Sps5nigQnwM6aPs6ed55iBGW+olElisc=
Received: from helloworld ([59.172.176.225])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id 59505804; Tue, 03 May 2022 16:22:21 +0800
X-QQ-mid: xmsmtpt1651566141t4gamjj7h
Message-ID: <tencent_8C37B90E1C06149CE1844A8CFF232048CC08@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur98GHdWRxeREKHoJraU6N7Zpu3RFXNrcHFmccrfKmKpRC0aSHajM
         0xoCCao+zyW5Uwxq05ouYTpTy4mORa4CSZ73BTVwSuh8KBADSalcwJmEmo1lkjcCzAgjXJzcQbed
         0c9EssZQc+9847elFZsSqyS1aSWB4nQuQt/O3VFLQ8jl9ECsxw9PFqvEyAeCti4dbefwiXS3DuM/
         oACOplW5fiO2gEEFyhdNJe3fMPjILtH2uUQjAHmV89iAHo2GjJev5x9H+7lAjUUFmP+Pb1UzF8Sf
         VPNFSnFQaLvi1+02Wbq3GFoeQ4NR1es5W2UAeWYvJHLY2xojObIyLLv3HgpY7LiTHhl6r+jgWZhH
         gSiVX8mUDNVb1CnbruIOei+U5rj4CUot2YIZzoAlZP3FvfAIkZ8CjH95iTPA8MEXSOoQ8G/3prxA
         azMeUIvM77R0faPsduJnRTFz5IMfGeTP4WbwogDU2MqY4hk4F+ZHF21LvEHW3UV4OYgP5joa9zIQ
         TZlCgyEZJUagZ05Ht+LO3m3H+IM/WEehCHe6FZEpDwYKumekzHzfW5vU8+iwwVJgTYi2JzloyKgr
         UVzof+3wOzwnUgHtVTK+BHcdNXwl70ejCnwzjPjVU5KPzTyuf0OmwIw99U7wbxDOBaGcw9FOLdls
         7ciaUJKPI9g3Zp0F9orOzkabEScBxEhlz2oFX75av8DHtb0xeY4yrxnmYOX7XXcvey8UGI1llNeT
         2ZJ4T752ljbVOsnXuInNx0qDsG7qpola0EyOTUBKgixN1ccJTPeSJB1NwTM2SiyHJE4+XbrLPlLH
         bE6tqvWbC3MgNTGTjTVIhwBm4+2ufrtWBqFjMzwPyDqfZik+dWuS5OU6VialilmR4j8Lh3Ze/rZ9
         AlNUJfAuil0bnanKPiJ6pH+oQpishDGJf9mI2vTD60ViifHnO2+UqgHKb4cwKTOn7kuy8fZ9DZFD
         jWFre1zJixtyhK5hcWjjAnop6Gkkc4Iml9Jzp2kNeFyz9fSIDqiqlLnun1jkCZ
From:   <xkernel.wang@foxmail.com>
To:     <joe@perches.com>
Cc:     <Larry.Finger@lwfinger.net>, <phil@philpotter.co.uk>,
        <gregkh@linuxfoundation.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>        <tencent_702C3C4AA9F65F0EE48859211795E3800205@qq.com> <f6421e8f75a030222bf9cc7ef191648f7495a511.camel@perches.com>
In-Reply-To: <f6421e8f75a030222bf9cc7ef191648f7495a511.camel@perches.com>
Subject: Re: [PATCH 12/12] staging: r8188eu: check the return of kzalloc()
Date:   Tue, 3 May 2022 16:22:21 +0800
X-OQ-MSGID: <000701d85ec6$ea14b1f0$be3e15d0$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIV0YZsN+y1sjhn79f1inyeXg2RTwLRgsQJAVYDQBuscJ1dsA==
Content-Language: zh-cn
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 3, 2022 3:09 PM +0800, joe@perches.com wrote:
> It'd be better to use the typical error returns

Hi Joe,

Thank you for your suggestion. The typical error returns will make these
codes unified with the code in other places.
But now we can not directly do that in this patch, otherwise, the original
functionality will be affected:

Apart from the returns of the error paths in _rtw_init_xmit_priv itself,
the functions on its call chain such as rtw_init_drv_sw() in
staging/r8188eu/os_dep/os_intfs.c are also sensitive to _SUCCESS or _FAIL.
If we want to unify all of them, there are a lot of changes need to do
which I think is at least beyond the purpose of this patch.

So I just keeps the form of error returns consistent with the original
logic.

Regards,
Xiaoke Wang


