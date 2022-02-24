Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379074C33C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiBXRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiBXRbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:31:24 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7D2186B9C;
        Thu, 24 Feb 2022 09:30:53 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id b35so865187ybi.13;
        Thu, 24 Feb 2022 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YN3o5AHfbGVmbeaZUJjmbDqTCWv/jzMc3EILlut6Oww=;
        b=a1WdcUy4rP1D+h2JWaW3NZ7cj7mMuh72pwuxNzL9nm3dxxunfRyAUaKgFx/ynm5sJk
         Fb1eD1BUAyDPcJJIbAP+2TYtWC0umJJBRstjSjWNhhYYMgeLf9AwliKwI8oye4bFPRVX
         /cERCPKOAMd8igNl35lFYoXqAeAiEv5fxAii3NUBubgd4ffDG9xJuES8SyZbJbORPbyz
         Qu35wM6y4ILBESw64aV6Qg5yPH3fmmw3qsoMAUgp4NkVgt7qryVSYkLc7L3crqEnNA7H
         5wi2UDdYC8vTpVkeMgL3pw1bhWDOOFOU6OTN0oYLmJPHo1cqf+lmkaDhGf5CHGp25mPa
         avXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YN3o5AHfbGVmbeaZUJjmbDqTCWv/jzMc3EILlut6Oww=;
        b=62NaEoyawj7nHPCFiyFvEB2/XSHFwAG/93cho+K0PFgYLPQj/74ilMR5V+BOLw1Rry
         ZPTXwTc1R9kOtqYaWFD1o6lYgybibw1qzb0pWk1ZT1jlgEOPxw3s5shKPno18qsAXQPg
         dGfwguUDYPdoz6nuUh4tLoRAxFH3XZ2CrIcRToRThqTl4krl/gwbhO7h98ImP1x5xwBu
         5vnY6uwLsHYmeTZnZ+ES0zlCvjM/aCTa2/J+4Sa76rla2NoorWmK7FqtXjU4DG/kpx45
         QXSnVlZiQsFYIo4Sugzd6mNMcEONdziO5ACsDB3khKWwzRYVEVqTepaLveucOZBJTUIu
         SeEg==
X-Gm-Message-State: AOAM533LLNtG9BjcMkQ6oiqAB98gDb9CsIzXhdwVUxjbyrmUvzeULqUM
        B73sH/123JBipilcL5c7h08NEQYIW/fC813tspY8KJqbQTg=
X-Google-Smtp-Source: ABdhPJwVE+iLZioAdIPSMXrJNMwFqMMEtMyE883chlGCzYhTLHZADwd1z+5sE5iGyyZNus3T/vJIrX8Y52GSTTvISaw=
X-Received: by 2002:a05:6902:567:b0:624:649e:1b14 with SMTP id
 a7-20020a056902056700b00624649e1b14mr3297272ybt.84.1645723852614; Thu, 24 Feb
 2022 09:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20220207103738.103661-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220207103738.103661-1-jiapeng.chong@linux.alibaba.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 25 Feb 2022 02:30:40 +0900
Message-ID: <CAKFNMokx2Qk4jJx6s0vzseYRbfjejZwoDY3MnPODWhT7-_1K=g@mail.gmail.com>
Subject: Re: [PATCH] mm/fs: Remove redundant code
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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

Hi Jiapeng,

On Mon, Feb 7, 2022 at 7:37 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Clean up the following smatch warning:
>
> fs/nilfs2/segbuf.c:358 nilfs_segbuf_submit_bio() warn: ignoring
> unreachable code.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/nilfs2/segbuf.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
> index 9e5dd6324ea1..50d7e2e4daed 100644
> --- a/fs/nilfs2/segbuf.c
> +++ b/fs/nilfs2/segbuf.c
> @@ -341,7 +341,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
>                                    int mode_flags)
>  {
>         struct bio *bio = wi->bio;
> -       int err;
>
>         bio->bi_end_io = nilfs_end_bio_write;
>         bio->bi_private = segbuf;
> @@ -354,9 +353,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
>         wi->nr_vecs = min(wi->max_pages, wi->rest_blocks);
>         wi->start = wi->end;
>         return 0;
> -
> -       wi->bio = NULL;
> -       return err;
>  }

Sorry for my late reply.

I will send this to Andrew to report and fix the regression on the -mm
patch series.

I'd like to change the patch title to something like "nilfs2: Remove
redundant code"
since the "mm/fs" prefix does not properly represent what it applies to.
(this patch may be folded into the patch that is causing the warning)

Regards,
Ryusuke Konishi
