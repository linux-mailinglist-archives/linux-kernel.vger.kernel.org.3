Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE3524AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352802AbiELKqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352790AbiELKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:46:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A2A6CA87
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:46:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gh6so9462775ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mUztazuSyDgxN4IJuGsokHY/xl1xmIQV403RgKJ0d1A=;
        b=exBhr0feoHxv67tzko0LaAbgsRFgF+WeYOI16AQIEIEA+ahzVeV229CoWiQggBp59T
         HEQyurCaR6bbN3aFuckPLTxXF4rXreefHMr4uH8ds8t+qctxW1Mtui6o3phQUsXB74j3
         q4Oc66AA9bzAfEhIFg1tjII/FI/mqUvxxmDeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mUztazuSyDgxN4IJuGsokHY/xl1xmIQV403RgKJ0d1A=;
        b=0R8mkCC/kha3y8B2L/bThI+FCvxSV1u8JFBF73Y05MO6jw10rbR57yJw3KHrohcIZk
         itnnbORV4/wpsqEdA+bnVBbFcWEpx+xhzRM2tFrwxMmO0bzfXw12LxxpfxBbpuGeQ2xe
         EQe3GExLVW9TnXnQBBsN5bdNPfIlYyRXp8NQYdwzf2yCWU6oS/1A65GJ/VA7WitkmArA
         tGr23SEsua4O5AU1Wf6+H1bBKyiD2rXwrrdHF206BVf3Ka86ouf4r9B4GrzQ9EvGJAWA
         gOyuoQ+oik6zk9CA6OWshiFFzNOKrFkxtKLqL0PoTG76YqZWN/34t2aOu/Bv8RSESwc8
         JJmw==
X-Gm-Message-State: AOAM533+I4vTqSv+/tii+6onT8rGJoAqzdY8fk+vRym3+4/1zJ3h2tt6
        tgz+vrkIxxw/tuW3rQECjs8+2Q==
X-Google-Smtp-Source: ABdhPJysw+usrrjuAJ6WRTiu4TkZhjhOXkvdySgQAijN5gZxaVp50vUZYfUmATW2TmsDLvWo7vy+ww==
X-Received: by 2002:a17:906:58d4:b0:6f4:cebd:c4b with SMTP id e20-20020a17090658d400b006f4cebd0c4bmr28988010ejs.492.1652352405476;
        Thu, 12 May 2022 03:46:45 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-59-245.cust.vodafonedsl.it. [188.217.59.245])
        by smtp.gmail.com with ESMTPSA id sa3-20020a170906eda300b006f3ef214ddasm1961028ejb.64.2022.05.12.03.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:46:45 -0700 (PDT)
Date:   Thu, 12 May 2022 12:46:42 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Message-ID: <20220512104642.GD649073@tom-ThinkPad-T14s-Gen-2i>
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
Sorry again. You suggest to create a new structure for these entries,
for example:

/* Out Bypass mixer switch */
static const struct snd_kcontrol_new max98088_out_bypass_mixer_controls[] = {
       SOC_DAPM_SINGLE("INA Switch", M98088_REG_4A_CFG_BYPASS, 7, 1, 0),
       SOC_DAPM_SINGLE("MIC2 Switch", M98088_REG_4A_CFG_BYPASS, 4, 1, 0),
       SOC_DAPM_SINGLE("REC Switch", M98088_REG_4A_CFG_BYPASS, 1, 1, 0),
       SOC_DAPM_SINGLE("SPK Switch", M98088_REG_4A_CFG_BYPASS, 0, 1, 0),
};

Let me know.

Thanks in advance.
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
