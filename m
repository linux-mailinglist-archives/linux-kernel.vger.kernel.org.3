Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E52454392D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245759AbiFHQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245714AbiFHQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:37:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAFB46CB1;
        Wed,  8 Jun 2022 09:37:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 25so27582773edw.8;
        Wed, 08 Jun 2022 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsXUJT07pqWBirTfhy2MsbRPBMc6m63U5muWi3tvOuw=;
        b=hQy/sqqOXzZNNpm6yasW+GxImgjbGRyagGQ43laWbwOV8bc0pHMQXx8RlPpSpyyaPM
         0/CbfxBd474DXIVMng2CJpbXLv4zaHANKc4tUMKg2c9gU2jO/70BE1qMNwavRikHKYxD
         T13ODekxgkqGjXzQgtLHdl5heBLxnUTdQK+3WY9kQ90ktLPignT9B94YQOECi2+CGWc4
         7U5k54lwmg1up2GgrYD7Mbynh1n/ud7QYEUtqS556/zl1xTMijSHjR8ItI7U1YXBOZkk
         n9ZCVcDMmw1EKOul0gO+G+Bii5kFFQUe3Z2uHD+M4TzPyX7Dten7viuH2pi4OTQj6Gvb
         /v0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsXUJT07pqWBirTfhy2MsbRPBMc6m63U5muWi3tvOuw=;
        b=T6mvYbdvDL4i1znUrGkLZiCWxloqHtuceyVXpr6HhlUsrA/PeaiN1bYxOxpeAWlDct
         x0Ul4O0P9KbrfSS/D95GvPtdvGFNRphvFXPK3WOBqWZyYNOnD1SMTjDB8813Rq6Q4LDC
         kZ4QnRsyyqmvYhqCCXcPhDZCnKzNejs9H7noHXiMY5yloK7BPlIqU9WYQHDgvniQknzj
         wLH9uc7bmSrfhrJ/ktLhLFS+JsDnn1gYQWNSFRW6sGUNgmP7LuKpTsCL30nfNLXOl/li
         kxMCv7t+42REMBBFRZ878Nl3OAPB2WSfhAbwLgNVu+wEvqCFp+2rSNi+L0wTW4JKS6NW
         cZxw==
X-Gm-Message-State: AOAM53301M8WhmWcta74hmPfVm2vPzPYxt/tQ/XpKySxkddrfzeOaH+Z
        SiB8yxN+UW6fbUn0Tt5hNok5wf37Pvs4ox/bNd7RLaueU/ZeeQ==
X-Google-Smtp-Source: ABdhPJzBKdq6yAe0MLwwypV9lajsVvXBMuKl+XqhRjRAQfULPiiF3owIdEPvwKvCF230uZM3D3XZpu+1M7rh40ukbJA=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr39270205edc.97.1654706239435; Wed, 08
 Jun 2022 09:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220608153309.2899565-1-david@protonic.nl>
In-Reply-To: <20220608153309.2899565-1-david@protonic.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Jun 2022 18:36:43 +0200
Message-ID: <CAHp75Vdg_ZfEsaOq4Cn+=RbGZYzW6eB3PBNpvip++6F5t6AGVQ@mail.gmail.com>
Subject: Re: [PATCH v2] spi: <linux/spi/spi.h>: Add missing documentation for
 struct members
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Wed, Jun 8, 2022 at 5:33 PM David Jander <david@protonic.nl> wrote:
>
> Fixes these "make htmldocs" warnings:
>
> include/linux/spi/spi.h:82: warning: Function parameter or member 'syncp' not described in 'spi_statistics'
> include/linux/spi/spi.h:213: warning: Function parameter or member 'pcpu_statistics' not described in 'spi_device'
> include/linux/spi/spi.h:676: warning: Function parameter or member 'pcpu_statistics' not described in 'spi_controller'

Thanks, you may add my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

However, you don't need to put that "<include/...>:" part in the subject line.

> Fixes: 6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
> v2:
>  - Correct patch subject line style
>  - Add the text of the actual warnings that are being fixed
>  - Add a Fixes: tag
> ---
>  include/linux/spi/spi.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index eac8d3caf954..2e63b4935deb 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -35,7 +35,8 @@ extern struct bus_type spi_bus_type;
>
>  /**
>   * struct spi_statistics - statistics for spi transfers
> - * @lock:          lock protecting this structure
> + * @syncp:         seqcount to protect members in this struct for per-cpu udate
> + *                 on 32-bit systems
>   *
>   * @messages:      number of spi-messages handled
>   * @transfers:     number of spi_transfers handled
> @@ -155,7 +156,7 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
>   * @cs_inactive: delay to be introduced by the controller after CS is
>   *     deasserted. If @cs_change_delay is used from @spi_transfer, then the
>   *     two delays will be added up.
> - * @statistics: statistics for the spi_device
> + * @pcpu_statistics: statistics for the spi_device
>   *
>   * A @spi_device is used to interchange data between an SPI slave
>   * (usually a discrete chip) and CPU memory.
> @@ -439,7 +440,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>   * @max_native_cs: When cs_gpiods is used, and this field is filled in,
>   *     spi_register_controller() will validate all native CS (including the
>   *     unused native CS) against this value.
> - * @statistics: statistics for the spi_controller
> + * @pcpu_statistics: statistics for the spi_controller
>   * @dma_tx: DMA transmit channel
>   * @dma_rx: DMA receive channel
>   * @dummy_rx: dummy receive buffer for full-duplex devices
> --
> 2.32.0
>


-- 
With Best Regards,
Andy Shevchenko
