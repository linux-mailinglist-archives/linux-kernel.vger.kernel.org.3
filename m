Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8557D9B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 06:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiGVEyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 00:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGVEyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 00:54:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15E493638;
        Thu, 21 Jul 2022 21:54:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l23so6663836ejr.5;
        Thu, 21 Jul 2022 21:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BAspDEPCtXjW6B387M1BEwowk25i6EDgUSDlagLj1Hk=;
        b=LGnXKOwviOg2k81AVWVpNLFmzOUc5v70JFyf7x43iWW2Hh0JUjh2YK4xmryjna91dF
         ZucFalVj9ZG/7e8avCiu9XE5b1O4rX3UEGx3wj4uIj4g1OAX5d2sfDZtzQz2WADF0GI/
         SjnazoFgrEmEbXuZM/h2zjjr+X61q+OwGTwmoXFevCYp5gWTKHudLHabEJGW8wcwmhtr
         35Dbfu7NAaLJ/zDMp9nbpTvnN/0KQYpFtK5r8LhLiqFjxSZUS+8PmmIbHo/URaFT6mnX
         qnp7wwq00SnFpHD/3ZIQQF0EAULCUTJYdaR1sAr5RsmwCA3piXhbaLj3R1kr80JwxU1D
         B3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BAspDEPCtXjW6B387M1BEwowk25i6EDgUSDlagLj1Hk=;
        b=HJWNXz375a/WvMc/Qpy+x9fDDRz8VWwKYfGQ21LXBKxVfI9Bfc1qRX62lqtRVdTwjm
         OGNbyeGUjrCdUHxtJrbBMFBBaeddAqQ66ZEiis4XYqGKv4MulYL0P68D0uwepZf5/jiM
         B8/PDfoH0wUgpjFsIH5yVJP6rGpu4snUJyHBsqGTtaLqEgP2xRpyhrTVm79dse3vGBfl
         B3aKFIAFEoInwV/5fPO8Rft3ODEZIqdtReb1eDK41ORQU2dp/A91h8juJbqY27zoZx9f
         sK33AiE59/tm1LvICXoqa0oX31sMYf+MWrRf3qArm8b9BVdcmZ3UHIre/XWlM6eh3KFc
         FuhQ==
X-Gm-Message-State: AJIora+OZV4SEbsf01zJMRougou0zS5eA7tgf5aj8wznM8zDAXCPwxm3
        5bft3nx3ZP9j+tD91EzDkt0=
X-Google-Smtp-Source: AGRyM1sHXShGR6o1qcwrokXbBl+lV1+M3JghaQXqCevUiOPwb4M9Sy+r3nydB9pqTt5VqYROK9/k3A==
X-Received: by 2002:a17:907:7290:b0:72b:3799:624c with SMTP id dt16-20020a170907729000b0072b3799624cmr1648824ejc.108.1658465690190;
        Thu, 21 Jul 2022 21:54:50 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6979:bc71:385a:5363:16f9? (p200300c78f2e6979bc71385a536316f9.dip0.t-ipconnect.de. [2003:c7:8f2e:6979:bc71:385a:5363:16f9])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b0072321c99b78sm1560487ejf.57.2022.07.21.21.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 21:54:49 -0700 (PDT)
Message-ID: <11b4ef15-9fb5-2c40-90ae-11ee434bbea3@gmail.com>
Date:   Fri, 22 Jul 2022 06:54:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] media: staging: media: zoran: Removed braces for single
 statement block
Content-Language: en-US
To:     Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220721150055.52096-1-abhijeet.srivastava2308@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220721150055.52096-1-abhijeet.srivastava2308@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/22 17:00, Abhijeet Srivastava wrote:
> Warning found by checkpatch.pl script.
> 
> Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
> ---
>   drivers/staging/media/zoran/zoran_card.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
> index 26f978a1cc72..0c138d47d0c3 100644
> --- a/drivers/staging/media/zoran/zoran_card.c
> +++ b/drivers/staging/media/zoran/zoran_card.c
> @@ -1038,9 +1038,9 @@ static int zr36057_init(struct zoran *zr)
>   	zr->stat_com = dma_alloc_coherent(&zr->pci_dev->dev,
>   					  BUZ_NUM_STAT_COM * sizeof(u32),
>   					  &zr->p_sc, GFP_KERNEL);
> -	if (!zr->stat_com) {
> +	if (!zr->stat_com)
>   		return -ENOMEM;
> -	}
> +
>   	for (j = 0; j < BUZ_NUM_STAT_COM; j++)
>   		zr->stat_com[j] = cpu_to_le32(1); /* mark as unavailable to zr36057 */
>   


Why does the subject line start with "media:" The subsystem is 
"staging:" so the subject should start with "staging: media: ..."

I have no clue if this is accepted.

Regards,

Philipp
