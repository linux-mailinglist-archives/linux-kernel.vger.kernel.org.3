Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3854E5D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbiCXCJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348721AbiCXCJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:09:37 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB31094;
        Wed, 23 Mar 2022 19:08:03 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2e5e176e1b6so36939267b3.13;
        Wed, 23 Mar 2022 19:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MWzf/zP0aSYuHjZ45euTh/n7opZg/N8+Hh/usuT9m8=;
        b=aR8cFt4Z4t8heY8CccVQowH/VgUecLt043+tnFwlGTUknj1pP/fmKiTGHhLX5xxqoT
         xSFhNvxwGQLETEy0vBED6vF5i/c74fh4zgpw63Y+XBV5o+QuXkh4O4gmyOlxWb9HQbvu
         fQPIutk2w93ZXxQaGsa5PwD5djOte2QvTS9bf+RcnFu/jSqNc0hxwYmfL1CwpkiKSyUW
         01CNX9VwcezL6ITkJbqBGk6Re9zjlEHwgCIhrBIMrJ6bmmU4OJS6/IvkpE7h0zY/FNKo
         0A6DJ2txlZa3U5bZVYI8vwn6k5QnRgeGloLE0Oq+FHxDB7h9zFN3UBVhihXeQtex+opw
         ABOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MWzf/zP0aSYuHjZ45euTh/n7opZg/N8+Hh/usuT9m8=;
        b=XfljKHr+6T6UUxC3BmUqJ5ZhX4tn1klaIWbt3/2xETZPrSZ3nUyvBIwhobQJ4/vme3
         nhYmuAGXQdGN/wyKAEyviYh0A6XRZgZZkYWAxcR1MnH5+bxhnc/aZqmHcF5mO7aMSUSE
         iQInFDezpQAY5noZzp4wvk/cNnl7CpwQ7I9plwofNBm1pY8QFNloQRDvtmehN+lOwgF+
         4mTnks5gP0TyspOGXls3ikV0Qv75SHRr+rkjZKkR/w5rgIrHB0t3Q1YQAmpkz3ITw5RN
         PJHW3C9B7Y0F7EvxGDUdEAa/Zy/rwz2DeGse5nZyYQwCVdzLFWjUb2a/Gr5TbYZ8Gg39
         bZlg==
X-Gm-Message-State: AOAM531/lSQB/3kCQSKA4LbmOWqOUYCVAYDHuqWIxO7HAMPKto1LRX6B
        GNQ+6dWzP9FjA/eCma03+iRtxbGcNf8mODjm82YMmeBrVIA=
X-Google-Smtp-Source: ABdhPJxsRaLV7UcEyOv089NnhMcx++ww6GuWDsVZJ6Mi9BdTz4pKI9Ya2pJ+wzKQscHXLxD2JpW341WJN7fxEVe52ww=
X-Received: by 2002:a81:69c6:0:b0:2e6:bb26:3d24 with SMTP id
 e189-20020a8169c6000000b002e6bb263d24mr2398444ywc.41.1648087682728; Wed, 23
 Mar 2022 19:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220324002959.48592-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220324002959.48592-1-yang.lee@linux.alibaba.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 24 Mar 2022 11:07:51 +0900
Message-ID: <CAKFNMonU7Ov9v7_WB6x+fMae4N+AWbtzTDzts4M-s7iG0tqS+w@mail.gmail.com>
Subject: Re: [PATCH -next] fs: Fix some kernel-doc comments
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Thu, Mar 24, 2022 at 9:30 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> The description of @flags in nilfs_dirty_inode() kernel-doc
> comment is missing, and some functions had kernel-doc that
> used a hash instead of a colon to separate the parameter
> name from the one line description.
>
> Fix them to remove some warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
>
> fs/nilfs2/inode.c:73: warning: Function parameter or member 'inode' not
> described in 'nilfs_get_block'
> fs/nilfs2/inode.c:73: warning: Function parameter or member 'blkoff' not
> described in 'nilfs_get_block'
> fs/nilfs2/inode.c:73: warning: Function parameter or member 'bh_result'
> not described in 'nilfs_get_block'
> fs/nilfs2/inode.c:73: warning: Function parameter or member 'create' not
> described in 'nilfs_get_block'
> fs/nilfs2/inode.c:145: warning: Function parameter or member 'file' not
> described in 'nilfs_readpage'
> fs/nilfs2/inode.c:145: warning: Function parameter or member 'page' not
> described in 'nilfs_readpage'
> fs/nilfs2/inode.c:968: warning: Function parameter or member 'flags' not
> described in 'nilfs_dirty_inode'
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/nilfs2/inode.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 476a4a649f38..eb1ba17acb0b 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -59,10 +59,10 @@ void nilfs_inode_sub_blocks(struct inode *inode, int n)
>
>  /**
>   * nilfs_get_block() - get a file block on the filesystem (callback function)
> - * @inode - inode struct of the target file
> - * @blkoff - file block number
> - * @bh_result - buffer head to be mapped on
> - * @create - indicate whether allocating the block or not when it has not
> + * @inode: inode struct of the target file
> + * @blkoff: file block number
> + * @bh_result: buffer head to be mapped on
> + * @create: indicate whether allocating the block or not when it has not
>   *      been allocated yet.
>   *
>   * This function does not issue actual read request of the specified data
> @@ -138,8 +138,8 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
>  /**
>   * nilfs_readpage() - implement readpage() method of nilfs_aops {}
>   * address_space_operations.
> - * @file - file struct of the file to be read
> - * @page - the page to be read
> + * @file: file struct of the file to be read
> + * @page: the page to be read
>   */
>  static int nilfs_readpage(struct file *file, struct page *page)
>  {
> @@ -957,6 +957,8 @@ int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
>  /**
>   * nilfs_dirty_inode - reflect changes on given inode to an inode block.
>   * @inode: inode of the file to be registered.

> + * @flags: tell the filesystem if we just updated timestamp(I_DIRTY_SYNC)
> + *     or anything else

Thanks for the patch.
Could you please modify the description of the 'flags' argument ?

This flag is used in nilfs2 to determine if a data sync is enough or
metadata needs to be updated together.   "just updated timestamp" is assigned
to I_DIRTY_TIME in kernel, but the current nilfs2 implementation does not
distinguish this (i.e. lazytime is not supported).

How about "flags to determine the dirty state of the inode" as a generic
description of the argument ?
I think the detailed behavior should be written in the later function spec
part if we explain it.

Other than that, it looks good to me.

Thanks,
Ryusuke Konishi


>   *
>   * nilfs_dirty_inode() loads a inode block containing the specified
>   * @inode and copies data from a nilfs_inode to a corresponding inode
> --
> 2.20.1.7.g153144c
>
