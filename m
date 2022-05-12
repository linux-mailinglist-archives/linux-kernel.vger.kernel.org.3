Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF2B524A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352648AbiELKbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbiELKbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:31:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E84CD56
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:31:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g6so9342502ejw.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5MXfcUrY9hOKURYsbrGhzUx93Mf/JygzWXuJTExiX6A=;
        b=n3ojiDL8X/Z3JJpHeZ3KpwcIDtMK9lk+zxRPqOmiw9++VRYDa6HJvSv85Dym9DjNz3
         vpLDn0kYSFCR9bYfcJJrSI+uNVEyPOt0o1tTX7zrbYh0nDoYjdbHZx3Vg8Dgp0W7FnYC
         EAdWgVwLRyYTVlgCxl6Do4Hm0cuSFtuywRt2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MXfcUrY9hOKURYsbrGhzUx93Mf/JygzWXuJTExiX6A=;
        b=d/0pNzbIRVFbxtGWFoRi2MwaOFFz3nnFLM9l5UOmgdW0NcHgYRA2VlSQCqiHxWBW/4
         esp5fFdygKwiBiiVpH38gjxGjAfPERjkzuvukGQQErAOltJFewjJIGbjpPwzRxo76XDb
         OpX5wT9BX4yutxUAoC5u6ScHVEvqYLDg7xebpaYYNirevVInV9a+VoAKwEkecp7FFH0V
         /maTPnOMF7UEqcEaYyDqEfkDL51G3Tcn+2IjFGKpcpPrn6+cdsk4lOLjCXPOAjG5b2gZ
         GaHPONF1wdoU6+wDpfd7ja5ACE7rYOxroAEieAgkeN4XlLBQDAv+/ztH93NtYKSIR0QM
         DHig==
X-Gm-Message-State: AOAM530s2RkR0ccIN3FQWSoeWkwM5yIRAsjz3CHfYcc+mnUZvJEQF0n+
        4R0eWlgKbptBxr5IE5fD+NWKBw==
X-Google-Smtp-Source: ABdhPJw3/7SDvQibZnzyAqVT3zem9hMR5ZS5pek6KBOHUgS3MH78W6+hF3SfMcrkHz6sUmfeCF/nXg==
X-Received: by 2002:a17:907:960d:b0:6f4:3b68:8d55 with SMTP id gb13-20020a170907960d00b006f43b688d55mr29150808ejc.105.1652351495343;
        Thu, 12 May 2022 03:31:35 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-59-245.cust.vodafonedsl.it. [188.217.59.245])
        by smtp.gmail.com with ESMTPSA id n9-20020aa7c789000000b0042617ba63cbsm2370277eds.85.2022.05.12.03.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:31:35 -0700 (PDT)
Date:   Thu, 12 May 2022 12:31:32 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Message-ID: <20220512103132.GC649073@tom-ThinkPad-T14s-Gen-2i>
References: <20220512074359.446999-1-tommaso.merciai@amarulasolutions.com>
 <YnzdcubW7m+CwnvN@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnzdcubW7m+CwnvN@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:12:02AM +0100, Mark Brown wrote:
> On Thu, May 12, 2022 at 09:43:58AM +0200, Tommaso Merciai wrote:
> 
> > Add mixer controls support for M98088_REG_4A_CFG_BYPASS register
> 
> > +++ b/sound/soc/codecs/max98088.c
> > @@ -486,6 +486,11 @@ static const struct snd_kcontrol_new max98088_snd_controls[] = {
> >         SOC_SINGLE("EQ1 Switch", M98088_REG_49_CFG_LEVEL, 0, 1, 0),
> >         SOC_SINGLE("EQ2 Switch", M98088_REG_49_CFG_LEVEL, 1, 1, 0),
> >  
> > +       SOC_SINGLE("SPK Bypass Switch", M98088_REG_4A_CFG_BYPASS, 0, 1, 0),
> > +       SOC_SINGLE("REC Bypass Switch", M98088_REG_4A_CFG_BYPASS, 1, 1, 0),
> > +       SOC_SINGLE("MIC2 Bypass Switch", M98088_REG_4A_CFG_BYPASS, 4, 1, 0),
> > +       SOC_SINGLE("INA Bypass Switch", M98088_REG_4A_CFG_BYPASS, 7, 1, 0),
> 
> These look like they should be DAPM controls since they're controlling
> audio routing but they're being added as regular controls.

Hi Mark,
Thanks for the review, I'll send v2.

Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
