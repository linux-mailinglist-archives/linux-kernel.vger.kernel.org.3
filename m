Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606374E836E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 19:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiCZSoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 14:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiCZSoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:44:19 -0400
X-Greylist: delayed 442 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Mar 2022 11:42:42 PDT
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BFD97BBA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:42:42 -0700 (PDT)
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
        by mailscanner01.zoner.fi (Postfix) with ESMTPS id 273F841556;
        Sat, 26 Mar 2022 20:35:17 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
        by www25.zoner.fi with esmtp (Exim 4.95)
        (envelope-from <lasse.collin@tukaani.org>)
        id 1nYBFt-0003zZ-1o;
        Sat, 26 Mar 2022 20:35:17 +0200
Date:   Sat, 26 Mar 2022 20:35:16 +0200
From:   Lasse Collin <lasse.collin@tukaani.org>
To:     Jubin Zhong <zhongjubin@huawei.com>
Cc:     <akpm@linux-foundation.org>, <liaohua4@huawei.com>,
        <linux-kernel@vger.kernel.org>, <wangfangpeng1@huawei.com>
Subject: Re: [PATCH v2] kbuild: Enable armthumb BCJ filter for Thumb-2
 kernel
Message-ID: <20220326203516.1ddb6492@kaneli>
In-Reply-To: <1647834017-23673-1-git-send-email-zhongjubin@huawei.com>
References: <20211121233722.708131a8@kaneli>
        <1647834017-23673-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-21 Jubin Zhong wrote:
> >On 2021-11-20 Jubin Zhong wrote:  
> >> xz_wrap.sh use $SRCARCH to detect the BCJ filter. However,
> >> assigning arm BCJ filter to Thumb-2 kernel is not optimal. In my
> >> case, about 5% decrease of image size is observed with armthumb
> >> BCJ filter:
> >> 
> >> Test results:
> >>   hardware:      QEMU emulator version 3.1.0
> >>   config:        vexpress_defconfig with THUMB2_KERNEL & KERNEL_XZ
> >> on
> >>   arm BCJ:       4029808
> >>   armthumb BCJ:  3827280
> >> 
> >> Choose armthumb BCJ filter for Thumb-2 kernel to make smaller
> >> images.
> >> 
> >> Signed-off-by: Jubin Zhong <zhongjubin@huawei.com>  
> 
> >I still didn't test it but it looks good to me.  
> 
> Hi, this patch is not accepted into the kernel mainline yet.
> Please let me know if there is any problem with the patch, thanks.

I see no replies and don't know what could be wrong. So perhaps you
could resend it with my Acked-by.

-- 
Lasse Collin
