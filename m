Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237AD524C29
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353475AbiELLwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353469AbiELLwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:52:31 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFB95A17F;
        Thu, 12 May 2022 04:52:30 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ebf4b91212so53031807b3.8;
        Thu, 12 May 2022 04:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dMbgdBJ7v3pnBezXlQe7FuBpjFL4Jdp9pglUsY9h+E=;
        b=bwHSTj48doUHYMQ03ZT9x79VcE56FNIvqBd+wFsZM3TVznihbaMuCWZrYpMTrmBklt
         WFPbz53jGcC4FiOJKnhl7gnA/SlM1WZoYzQxo8rGv5lBcgqU62caUKliesftqzSd4BkD
         XzCuCpODHIpFS0FO1ue8i75Qcem8Cm6DvYvDRfmYQs/IzNeO5gsbDRWb9hj+VUwbM7B0
         +0NFK4h2BIb0E8yakepy8H7HFoFsjqNp/0K/YLLfJuCL3uJMmR06xGXeUky0oLuNDmYu
         PijqAwOwJwGfD03qyuo5R5F/eSWr3iflL+dU0on0zgyBOZFgYMqNhJO3Ojyd8H4E8//x
         f+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dMbgdBJ7v3pnBezXlQe7FuBpjFL4Jdp9pglUsY9h+E=;
        b=ty5FVNEgjVHlqlTY3XyYUa/4ecz6bsl7G5rEPVc7eUIcXt6QMLCZPH7zag/tznrzkw
         6RAcPpeZacvsI+yXKcDgwJeNm1uKcMlstQG4+i3VLch5NIKuEK6LJWgpU/LK+zjEO9Vy
         BXIhO5s0uQtwB5o/eSmCrz35rH0C0v5K0gAw+tCeDBNK+ZhPyIrmAGEbcmbFS2Jxwc2b
         29YdC5ZzoTeNG23xuLeWxNKOOKtvB0wm7cig+yjmbivo+ckJt23qLXVtFqzXEp7DKxBA
         X4RPFUneiAmdZlJplPCzqLzNlU5ITYdWUOHwjM1wNOZfOKUGJt3NjuZJcsajQrOSQLy1
         RBqw==
X-Gm-Message-State: AOAM530WWywum6LCCkEWd2LNHC75kAS1QwuFlFk/hGu5NYi6DtVKoNUT
        +rAfAN4S+7aq2wDhzK9xcRLimYfI8tz9TSlBTSDxV7KY3KY=
X-Google-Smtp-Source: ABdhPJyHLt04itFWvdt6UCYnDY2Rhaj5egWy7kMuPfcxwY3R63u4BIUcD0LZ8nE5vpIUqDGrHIsEzSsL2I9GB7R4E9U=
X-Received: by 2002:a81:949:0:b0:2f7:c45b:e291 with SMTP id
 70-20020a810949000000b002f7c45be291mr30288622ywj.503.1652356349352; Thu, 12
 May 2022 04:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220512182650.7d1a94c7@canb.auug.org.au>
In-Reply-To: <20220512182650.7d1a94c7@canb.auug.org.au>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 12 May 2022 20:52:17 +0900
Message-ID: <CAKFNMokFYi4AGd8+B6sT73Pu9k_bAu53-d_u1=0fsiHbz3Jgxg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm tree with the folio tree
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
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

On Thu, May 12, 2022 at 5:26 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the mm tree got a conflict in:
>
>   fs/nilfs2/inode.c
>
> between commit:
>
>   f132ab7d3ab0 ("fs: Convert mpage_readpage to mpage_read_folio")
>
> from the folio tree and commit:
>
>   e38ed506c42f ("nilfs2: Fix some kernel-doc comments")
>
> from the mm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, Stephen.

Andrew,  please once drop

 e38ed506c42f ("nilfs2: Fix some kernel-doc comments")

from -mm tree.   I will resend a modified patch after the folio patch is merged
to the mainline.

Thanks,
Ryusuke Konishi
