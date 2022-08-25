Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F115A0D45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiHYJxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbiHYJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:52:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ECEAD9BE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:49:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id by6so18869961ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1kMg/2p/VcNDyKRVfg3f4w41z9TXz8csd9rtLeh30yg=;
        b=JPJ4blOvYwitTMl23yXWeycie0bBgeSFYvPKyHK5c+DX/UV3eLOi7ipKWFd7gxSiID
         /niOBRbGue7lXXtpqXVz9K4MC5YZOv28slYAWFSUZHe/+GGkWekd8KCqkcWim0h9C/bH
         VOE5c2x4+8CV5xEbrPnGdWySF3I7otsX6MgXZl7BZ63oqVvmbLeqiIosca1DCN5pNoj6
         Ko6/bOQNX4P5dKOl4Ovas5sEMXZWL1hVgWCTTrYIR23AMZMivV+7ee9XUYKnsTPzRu33
         UX46wgmW2LtAoGwTB32nSmxubTRpMeEokfdKjGb9Cq04TO4zBxwqWLIoIlnujIMjjwvq
         7UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1kMg/2p/VcNDyKRVfg3f4w41z9TXz8csd9rtLeh30yg=;
        b=m2LSMVHihFa3iglJcA6b9iosdPt7ux+MQnrGU/b+OPYDEtLScYjPaBJ8aKOKMbX1CQ
         nuctnhk7RZwZ3tClb6hEMUjeNxYnKJbhaLbXHmog8NyJXkbN6s6dxfko9Q2l2OXtyu2u
         EOvu2x6ZOjeGTb7oKMHmep64gmUADHbxSHCHjvH3ymNJTS27xwl7iR0RmXRQ+q3TT+4a
         y8xXtfXFdRnmuxdjDpOvObWGyp2wGuOW4Kv+2FZFjZ0QcNED20VxqLi992KrbmvZoLYC
         8G9X9C1E8oE6Iw6RZwjVqMKxOrbMW1+schhOtImUzUobbZk6SAq69zIxKIj7T0OMJ3lm
         ve2A==
X-Gm-Message-State: ACgBeo3Vs3Hww5b7fZMEtVQ9Bc2x5Fchn0PWyXzrNfPoXL1xqbnPFGp5
        eErBiBnz4wngxiXI9koq8oOd20f+Z6vHEl5GuOPR7w==
X-Google-Smtp-Source: AA6agR5VFuzVZBBnz6OLJeVypCiPXq+1ADkMDZL2eMmhYiYGO41+tPsO3k2IUM59LGmJN5qCZIaiCFiTYWPyb75F7o8=
X-Received: by 2002:a2e:884c:0:b0:261:ca69:6023 with SMTP id
 z12-20020a2e884c000000b00261ca696023mr788260ljj.300.1661420981618; Thu, 25
 Aug 2022 02:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220823143034.20543-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220823143034.20543-1-wangjianli@cdjrlc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Aug 2022 11:49:05 +0200
Message-ID: <CAPDyKFroJgv=47Q2sAn3cT4rgeu3ntk6euxJ7k-ZQOAMQpeteg@mail.gmail.com>
Subject: Re: [PATCH] mmc/host: fix repeated words in comments
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     jh80.chung@samsung.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 at 16:30, wangjianli <wangjianli@cdjrlc.com> wrote:
>
> Delete the redundant word 'the'.

Patches that correct spelling mistakes make sense to me. However, I am
no longer willing to pick one patch per spelling mistake, it's just
silly and I feel like I waste my time.

Instead, I suggest you go through all mmc host drivers and fix *all*
of the spelling mistakes in one single patch. The similar can be done
for the mmc core.

Kind regards
Uffe

>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
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
> 2.36.1
>
