Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B5F580A94
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 06:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiGZE5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 00:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiGZE5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 00:57:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A14252A1;
        Mon, 25 Jul 2022 21:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4011FB81107;
        Tue, 26 Jul 2022 04:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB725C341C0;
        Tue, 26 Jul 2022 04:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658811423;
        bh=9XVqlJEw8Rh9WbLYoXNhuqOJnw4Zrl2baS7o9b++xJA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kqacw/X19oeZg8xQWaJZFyGHeGPZ4iqAP3BRoCdNtnR71NrY7rbLzmk84t9MIr/TP
         usD5R9UMhfCWsepxGI+M5jx/3EgKaFmSyNnEk8vIpgLM8M5jliPfvPA1Vokchll5l2
         6HUx7+b83kGF6SfzkW+gTZMUU68JhANy8POpbofhKb9XWnJrcwFooUpHtSf/tZY84L
         MSnIpgQ49uLeGbc6tq5KFfEPqELwi1OMEGnkP2U69s1cYHf0KOeh76Dn5xTIzlmA4N
         o0OjwuhNPLlVXbMR0JcsTkM1iZRKs1Q5uIvBE9mO7l2udEG93BvwUmTATMnkVrDiqa
         ZCpvof2pRShUQ==
Received: by mail-yb1-f178.google.com with SMTP id 75so23507688ybf.4;
        Mon, 25 Jul 2022 21:57:03 -0700 (PDT)
X-Gm-Message-State: AJIora+wzXFdiDPT2krm5DK70/Cgmbvm/HmM1ypP5GPLyPOSiAmeeHar
        lh4upFh28vwAEmsX+krH3YkoagtIV9iPXQafl4Y=
X-Google-Smtp-Source: AGRyM1tGLkQTMOv+IyE1ovA5Ww7xYLZzLWfQDPDlrH7DIfi2KdFE1kncZq16h58e/4l1yZrMk9Mov5w7BhdByXO9+xg=
X-Received: by 2002:a25:8611:0:b0:66e:d9e7:debc with SMTP id
 y17-20020a258611000000b0066ed9e7debcmr12066500ybk.257.1658811422932; Mon, 25
 Jul 2022 21:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220722002755.71703-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220722002755.71703-1-yang.lee@linux.alibaba.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 25 Jul 2022 21:56:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6TbfN6bhgDR_WdDcWms6E0k1c=zuf1HyBwZCqCz2ngXA@mail.gmail.com>
Message-ID: <CAPhsuW6TbfN6bhgDR_WdDcWms6E0k1c=zuf1HyBwZCqCz2ngXA@mail.gmail.com>
Subject: Re: [PATCH -next] md: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 5:28 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./drivers/md/md.c:8208:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied to md-next.

Thanks,
Song
> ---
>  drivers/md/md.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 673a39042208..2b2267be5c32 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8205,7 +8205,7 @@ static void *md_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>                         break;
>                 mddev = next_mddev;
>                 tmp = mddev->all_mddevs.next;
> -       };
> +       }
>         spin_unlock(&all_mddevs_lock);
>
>         if (to_put)
> --
> 2.20.1.7.g153144c
>
