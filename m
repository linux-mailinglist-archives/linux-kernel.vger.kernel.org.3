Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13B4C13AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiBWNNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240750AbiBWNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:13:27 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0968297BB3;
        Wed, 23 Feb 2022 05:12:59 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id f14so16595059ioz.1;
        Wed, 23 Feb 2022 05:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kg3NfGTP7xtW+RHtX3nLpmxM0bxqyeSW2sGTGXR6rYI=;
        b=RLNKdhGnNv/VidZ7E6jD1X2Ny6I19V2Uh7tv3hNVfzXJyf21LiKHJTuoTIoQmAps6U
         9E3uY7j8/b0pq+FfchlEDotZA6gOjzjPnySe/FSYspGmXbUtu0j09fuV3Kr05c7416Wa
         60Y+Za3GNbpsRKIn2PlrbP05xoE9wM4mqAWKJYogA0I2zU4xZQIwCgCI1zxSAdLnacYH
         yYvo9ZZ/i0UxM3/rhHeuvEHVC1ZyJq5cybbD+PiL/EW+zcQjHUt54JcbiUuFMr59AYov
         VR/HxLMGfWG4M58HJWm0JaDpDKnnX0BDsrnqctQ4o9+txEXQFDK6jBEkzAD3mwLEHQWo
         VH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kg3NfGTP7xtW+RHtX3nLpmxM0bxqyeSW2sGTGXR6rYI=;
        b=ZtiatXTKHph9UDKqrgu7gRZBxF2kyEoXFTbk/DuJ7yU0Xibc61ilNVwDt+9kGNh0Gw
         dGd1vHh2T1jbHFHudIpi1+eZFNT19xQpI7gGS4S8edjpornEgYS3UX39YoZ8nogcoNnF
         zShRZUl1Lwhsw+HazS0quBmkBCINtdIhnfXBWXxGxsAkyUSwURzA2cz+7mfNOoR5lgpv
         8BYXe9HArectSDgF7BD2gdj+Nt/Pn8sJIUX0ima4m2RRGMviElX/HNNah6zofIP+G/bb
         hWHZIuj7Z2dfTH3kNcaG7ORNoZLTk0uQXrlKI8iVMZw5U6+t0eBY8X/49mDUAhnVUptW
         RFcA==
X-Gm-Message-State: AOAM530UHp6nRHYEbYx+XsFdqhpyOVd6GSiwteueR6xbht58nRspzp53
        lhP6MzfSKnXWK6DNdHwOIMGOfNRi6c4hZOAdXVrHjj67jgY=
X-Google-Smtp-Source: ABdhPJwKhCMkDe5RRx9nZfDnSzFw1nU5bkD6jEejBb9QamYTZdVRctSZnGusrzpH30dMWL8CXUv114NbWmwrvaGUwaM=
X-Received: by 2002:a05:6638:1453:b0:308:eafa:41c with SMTP id
 l19-20020a056638145300b00308eafa041cmr23028637jad.30.1645621978151; Wed, 23
 Feb 2022 05:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20220223004801.66602-1-skhan@linuxfoundation.org>
In-Reply-To: <20220223004801.66602-1-skhan@linuxfoundation.org>
From:   Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Date:   Wed, 23 Feb 2022 10:12:47 -0300
Message-ID: <CAPW4XYag6r33W2LHie1AYN9UrP0fk5O1S=HUNoAuEknhjBs3pg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update media vimc driver maintainers
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-kernel@vger.kernel.org
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

On Tue, Feb 22, 2022 at 9:48 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Based on the dicussion with Hans Verkuil and others in the thread below,
> vimc is need of a maintainer. I will start maintaining the driver with
> help from Kieran Bingham as the reviewer.
>
> Link: https://lore.kernel.org/linux-media/5d5dee88-9dbf-e4d0-4a91-11ff4ecd82ea@xs4all.nl/
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Acked-by: Helen Koike <helen@koikeco.de>

Thanks
Helen

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 777cd6fa2b3d..a7b9eccafeb9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20383,8 +20383,8 @@ F:      drivers/media/common/videobuf2/*
>  F:     include/media/videobuf2-*
>
>  VIMC VIRTUAL MEDIA CONTROLLER DRIVER
> -M:     Helen Koike <helen.koike@collabora.com>
> -R:     Shuah Khan <skhan@linuxfoundation.org>
> +M:     Shuah Khan <skhan@linuxfoundation.org>
> +R:     Kieran Bingham <kieran.bingham@ideasonboard.com>
>  L:     linux-media@vger.kernel.org
>  S:     Maintained
>  W:     https://linuxtv.org
> --
> 2.32.0
>


-- 
Helen Koike
