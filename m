Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530B04D0FAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbiCHGAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiCHGAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:00:19 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72BB33375;
        Mon,  7 Mar 2022 21:59:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6cqYPl_1646719159;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V6cqYPl_1646719159)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 13:59:21 +0800
Date:   Tue, 8 Mar 2022 13:59:19 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Hongnan Li <hongnan.li@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/filesystem/dax: update DAX description on
 erofs
Message-ID: <Yibwt1yDO+oXF7Pu@B-P7TQMD6M-0146.local>
References: <20220308034139.93748-1-hongnan.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308034139.93748-1-hongnan.li@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 11:41:39AM +0800, Hongnan Li wrote:
> From: lihongnan <hongnan.lhn@alibaba-inc.com>
> 
> Add missing erofs fsdax description since fsdax has been supported
> on erofs from Linux 5.15.
> 
> Signed-off-by: lihongnan <hongnan.lhn@alibaba-inc.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(If no other concern, I will apply it for -5.18 cycle...)

Thanks,
Gao Xiang

> ---
>  Documentation/filesystems/dax.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
> index e3b30429d703..c04609d8ee24 100644
> --- a/Documentation/filesystems/dax.rst
> +++ b/Documentation/filesystems/dax.rst
> @@ -23,11 +23,11 @@ on it as usual.  The `DAX` code currently only supports files with a block
>  size equal to your kernel's `PAGE_SIZE`, so you may need to specify a block
>  size when creating the filesystem.
>  
> -Currently 4 filesystems support `DAX`: ext2, ext4, xfs and virtiofs.
> +Currently 5 filesystems support `DAX`: ext2, ext4, xfs, virtiofs and erofs.
>  Enabling `DAX` on them is different.
>  
> -Enabling DAX on ext2
> ---------------------
> +Enabling DAX on ext2 and erofs
> +------------------------------
>  
>  When mounting the filesystem, use the ``-o dax`` option on the command line or
>  add 'dax' to the options in ``/etc/fstab``.  This works to enable `DAX` on all files
> -- 
> 2.32.0 (Apple Git-132)
