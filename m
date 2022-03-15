Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3564D9663
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiCOIe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346140AbiCOIeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:34:44 -0400
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586A137BDA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:33:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V7H.vfh_1647333200;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7H.vfh_1647333200)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Mar 2022 16:33:23 +0800
Date:   Tue, 15 Mar 2022 16:33:20 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
Message-ID: <YjBPUJKFtyhF2x/K@B-P7TQMD6M-0146.local>
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315075152.63789-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:51:52PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This bug
> is triggered by injecting fault in kobject_init_and_add of
> erofs_unregister_sysfs.
> 
> Fix this by remembering if kobject_init_and_add is successful.
> 
> Note that I've tested the patch and the crash does not occur any more.
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Thanks for the effort!

Fixes: 168e9a76200c ("erofs: add sysfs interface")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
