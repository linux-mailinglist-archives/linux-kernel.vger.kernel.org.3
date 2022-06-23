Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB59557A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiFWMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiFWMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:30:58 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD62240935
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:30:57 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 4-20020a4a1404000000b0041bfe1a4cffso4018279ood.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVRculqp+8YlE8R1a3c/ayoMskwxPMfVf3UlLMhmDhU=;
        b=RlevhDgG85c21yWvbAvjWXGG4oq+QSxPI4MzhJ2M5njYt7JbpUuvuggLqmUe9je3U/
         XN4SX4JgkNMW1PyyiSmMa3tS1migQVbHQOUC0FmEN5iZ1igS003VX+TuLxWSdw/VTF0j
         xr673leE2DphsOfujUk25TWi5VY8FpQUxTZxERM+YXIs9WXNOGPyHvrQPqRoi102DPTH
         iL/6p42GqkUF7C8ebPbVGQdGNSBycxZ2mNPnpQnOLNJ5V5+3UmDVWY8xOUE459viyIYK
         8hut325I50KHduZZfCdoPcvlQE3VPxXMBbj4woNOKzSwz6BPQ0ZncSTSGJA7DDLC9KKp
         Zefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVRculqp+8YlE8R1a3c/ayoMskwxPMfVf3UlLMhmDhU=;
        b=72CRRXvjLKtOceN/8Ahn2XaYQd/3F4dY7QK92a4PTtCX9MZFjysutB0oR8j7eEMY4+
         y+aBlVoHbilno6b6CLC91L9GtUQfQIpKCQHZpu0/dy/rGderhAPqh7PTh9s853wgcev+
         U94y+fsuxr9zVEWmgCi/3yjUI1jiI0FKxHgXGlDrWFrc96DAgKKysvG1HT95cXq0nMip
         fTpUp00S3kkYfymFnfNbWUp3XybzTcYxamZ82xf7qRIm0iM5owr+1E06CFwlVaC/XGKj
         NE9saYc7YH9/ZuGgJRmIOKOUi7oCkwUMJHSAzYtmQNRKwUp3f0lGre/crraLwDfxJaXK
         PHTg==
X-Gm-Message-State: AJIora+p22kiGEYHm5A/gvzRVbO5R+1HgMKe4TYarMlpRHt6ZEC9tGFR
        9bDat47IR4RRBew99arelWXtI7DmjW6DjfiLKMXfmg==
X-Google-Smtp-Source: AGRyM1vuVf7rC6lm4jrnpHo2nLtmUEuUP8h6EK6raDzX/y8U9qlprmYuclmVvQx9xKqnxcgIrD8Ym/grYKDl5RlImmg=
X-Received: by 2002:a4a:978d:0:b0:425:78aa:f546 with SMTP id
 w13-20020a4a978d000000b0042578aaf546mr48715ooi.1.1655987457148; Thu, 23 Jun
 2022 05:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220621094146.77216-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220621094146.77216-1-jiangjian@cdjrlc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Jun 2022 14:30:21 +0200
Message-ID: <CAPDyKFqFLGeLGk6mupPwNdKSbGk5=F9TzCukq-a2hYuF1LYFtw@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw_mmc: remove unexpected word "the"
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     jh80.chung@samsung.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 11:42, Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> there is an unexpected word "the" in the comments that need to be removed
>
>  * command hasn't already completed (indicating the the irq

I am fine with picking up patches for these kinds of trivial
spelling/wording mistakes. However, in this case, it seems silly to
have one patch per single line of change. Would you mind walking
through the entire drivers/mmc/host/* directory and make one patch for
all the mmc host drivers instead?

Then if you want to continue with the mmc core files, that could be
another separate patch.

Kind regards
Uffe

>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 581614196a84..7f00d7d7e35e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1363,7 +1363,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
>                  * is just about to roll over.
>                  *
>                  * We do this whole thing under spinlock and only if the
> -                * command hasn't already completed (indicating the the irq
> +                * command hasn't already completed (indicating the irq
>                  * already ran so we don't want the timeout).
>                  */
>                 spin_lock_irqsave(&host->irq_lock, irqflags);
> --
> 2.17.1
>
>
