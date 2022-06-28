Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A028C55E7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbiF1OmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiF1OmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:42:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F7A2A268;
        Tue, 28 Jun 2022 07:42:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g26so26235931ejb.5;
        Tue, 28 Jun 2022 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8d6e8VlgKNljLwdtvogvE7E20oujzONVvU7lH7VUVY=;
        b=Ced1WYKRTc2AY0+y4fTNHnJQ/WwposEoSjqAMPFlDhp07sjFvsN2L2jto25G8xOpX9
         wH92Ev+6hDHWOEH7caBomeAOBBOE6M3Ebjy/WIzQpAwOwNdpktv/PgFqRR/0N9jmyd3P
         dl2D+yxP1FAwBhbWG8a/PepNjMADhV7QWm+sJ9U67i8bdpfZSd0ejdF7TKB59054NTgI
         dOH/g0g7E/bAUWS5/y56YZZKnhoKeCUwtmZLc6Ztxm3DG6/2xlbsGSu//zckLisxl6kl
         ZYjGYJs1KcA3wCj1iSGen4/M3TwGSjKCqLShIvNrWxBBTefwcUHQ758aLxZIaqyAM36h
         9FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8d6e8VlgKNljLwdtvogvE7E20oujzONVvU7lH7VUVY=;
        b=NsKJmu4zeeY0WslBlnzrys2W6HWSwEMivbvLA0RdjEREdUtSH3z4Jhv77OC3N/9HnO
         pg0uxnj6KlrhyGHHSinm/R1nrS3sRywCvS32opXikRureAwzF6gAHPygRwbt90P+u44+
         3k7rU9Jpif9mpxzn0J15WqFb23y0i4Z9OcUj2lf6RF2BfZCOLCkrer1j+dPVLbR9EsAK
         DNBxmJizt/1hKkDtZZ6OrEJh8+TZ5+xhL1r/46e11WB81tPtBZQeL2BeHIQe0XjBQuEC
         Uf5rySfeTHkmMEB+57Yxj80t2Pjx4H6YCctk1H4dFxVXWwoJ6Hq880eHWlTGAJr6ugm0
         wDFw==
X-Gm-Message-State: AJIora/+YLs5PwQytqRnteo8gzqYkPscxruO/EC8b4m6abux7a2T5ijU
        LxGqmYp0/ZaxjZFPScvppLpqVVczL1xfjYKii80=
X-Google-Smtp-Source: AGRyM1sPB+bqpAGxaW/+7kmrQ0Zy1eN6Ctko8Tko+6xd2JJXm0YyavGqRFgtvRCiHcC98o1oVJdKLxyIGf+ZaAv9VNQ=
X-Received: by 2002:a17:906:5d0b:b0:726:a043:fcb4 with SMTP id
 g11-20020a1709065d0b00b00726a043fcb4mr11201597ejt.508.1656427336914; Tue, 28
 Jun 2022 07:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656409369.git.mchehab@kernel.org> <e0a1fd8942a0e13ecf391ccd5634759d2281e2c2.1656409369.git.mchehab@kernel.org>
In-Reply-To: <e0a1fd8942a0e13ecf391ccd5634759d2281e2c2.1656409369.git.mchehab@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 28 Jun 2022 10:42:05 -0400
Message-ID: <CADnq5_PAW_et564Sjt7HvQwnqcMyzukc3paeU-pWPMKRM55DMA@mail.gmail.com>
Subject: Re: [PATCH 13/22] drm: scheduler: add a missing kernel-doc parameter
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>
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

On Tue, Jun 28, 2022 at 5:46 AM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> Add a description for struct device at drm_sched_init(), in order
> to solve this warning:
>
>         drivers/gpu/drm/scheduler/sched_main.c:999: warning: Function parameter or member 'dev' not described in 'drm_sched_init'
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Generally in the drm tree we use / rather than : in the patch titles.  E.g.,

drm/scheduler: add a missing kernel-doc parameter

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/
>
>  drivers/gpu/drm/scheduler/sched_main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 76fd2904c7c6..b45bd8473e9e 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -987,6 +987,7 @@ static int drm_sched_main(void *param)
>   *             used
>   * @score: optional score atomic shared with other schedulers
>   * @name: name used for debugging
> + * @dev: pointer to struct device
>   *
>   * Return 0 on success, otherwise error code.
>   */
> --
> 2.36.1
>
