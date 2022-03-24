Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FEC4E5D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 04:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347117AbiCXDkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 23:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiCXDki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 23:40:38 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE8191AC3;
        Wed, 23 Mar 2022 20:39:07 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2e64a6b20eeso38408117b3.3;
        Wed, 23 Mar 2022 20:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZfjREZ8FUx9c4b2sjgAYGes5irtI27++mGowWVmjkw=;
        b=ntKuFibhVve4a7LxVr5qFm2l6asluhgUYiBbNXbbG519O8SWFGDkD48XG9bR/K+3C2
         mikBUfGDpYgGA1Q22jX6mDTMzaEE3x0LgrJ1wAZ35rXzLbQkp3BNwkT3jzpfuRJ0Pu8X
         uHdmq0tJX5aJp7+ZxA0XizGLdFf9QNeWEnHtPu1XcfL/aZRsUwF9J4L7o/s9/5VcbsCe
         xzMzMGLC3zDLco+k+bPJmunRD6jNStzHhm/8A4QfRjqvOUaWRaKOMA6Pq4bylynz3aK9
         0SJARn8TGmcY+nF/wosRM1wjEKhBb1rD3P2dw4WX24Qpiv4reZyGHOIjuKiFaxHp7riA
         vJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZfjREZ8FUx9c4b2sjgAYGes5irtI27++mGowWVmjkw=;
        b=03eBtaQ3sY/eAzgGCyCw3B9IDwFbi77891XeL6YfRiPZVKXbCksRf//QWbOFQ/GhFP
         c0wlddZ1kSNhZBNhBwf2JK1dZJ4epKNPTFbAge0JhnJQuW7fQYi8K+QoFPMBhxZKmg8L
         tzRHi1E2xo+9EWjStxiRpf82J4Q5IIns7YbrVkMV/C+hTJ9wWnsublqUeeva9ZP14TV4
         VrjHYPU1aqmvCuqIaPO9vz0mT00HhSwziPXhS8+Q/LD9UpRx+93fIrFaOWMaeYp+cC1n
         2O/Ntk6L6jRbKM9aTe79n0leebvSKPtumeeiTGmoVhnscpHde2xvoHsWXnzcdKFIMOFq
         LkNQ==
X-Gm-Message-State: AOAM532mamv+/bwhqW8mpbTRhHARTBCbSk7ZqNd33/kPdmr7Vj289cvw
        uXKJXlZiVGzp8sR1jVP1uptrg6Wn7hXg5iLEcNNoRLQdU0Q=
X-Google-Smtp-Source: ABdhPJx9nDMhV8NDnDiiOKbDfR23FcyYDLgJZ4iqf1SU0za962OhftUhWW1C7y8bnqwqHZN5A2OvpBrvUhGeEcJuBRs=
X-Received: by 2002:a81:23ce:0:b0:2e5:c9c7:2005 with SMTP id
 j197-20020a8123ce000000b002e5c9c72005mr2936591ywj.261.1648093146315; Wed, 23
 Mar 2022 20:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220324024215.63479-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220324024215.63479-1-yang.lee@linux.alibaba.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 24 Mar 2022 12:38:54 +0900
Message-ID: <CAKFNMokxqD1ouhaNf5KeMD3gEO32QOBJUdSEZbWHmmi2Oj9s+Q@mail.gmail.com>
Subject: Re: [PATCH -next v2] fs: Fix some kernel-doc comments
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

On Thu, Mar 24, 2022 at 11:42 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
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
>
> --Changes in v2:
> Modified description of @flags in nilfs_dirty_inode() kernel-doc comment
>
>  fs/nilfs2/inode.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Will apply, thanks!

Ryusuke Konishi
