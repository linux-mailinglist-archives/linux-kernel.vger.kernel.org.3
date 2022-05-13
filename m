Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364F15265EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381900AbiEMPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381907AbiEMPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:21:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D767D34
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:20:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z19so10353315edx.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KDglamaHwWNFsJjMH8n4M899cYov2fck92ehvXsUuIU=;
        b=bg30amuYU6wYV2P5qNbOJwBy+IHyuJBCdFy8NHgLEKqZRlbttCeGVB6vZTCxzmmzks
         TI65tZFse17Bg3FTztLPHu1C8djT/1uvA8rpdFOEs5aIVqnyD3DmRbMX/7rUU3ibecKW
         Ihf3tG7TXQU2aUXnBa5zDS+4psPozMmTmWNO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KDglamaHwWNFsJjMH8n4M899cYov2fck92ehvXsUuIU=;
        b=mrsQjooWnax2IJSU40U1OitlW8JFT/JIVFL7flESo6erjSb+jQYRfx1FHrrCtiao2I
         8MG/iUWa/jxwo8Medp+IW3+Uc02kK2mr5LdGmuO0OCiVb3I5rGdALk7LuA95bggfLVuz
         Rx0OTG7Q6/pcuaHi06hWJ/I6WxVyb4blGrt31F/q0XGf0qe5opN0SJBuxuOwvXVtsMER
         Wlki/AuYdI0pZrHiKemxPtzB0HkoMfHtDJiRG2n7rexwDFrUo5xRae7OAAsNrXKLgABq
         KtZphKpDc2OKOSmHgp2F3RZETYnwPwsksrc2LsDfyjI6TLmqSYfd/ksHlhslkn2p3w0v
         E/Jg==
X-Gm-Message-State: AOAM530rrX08Rn6IaHJqarlAQLwISNqsP2f1kzBjzwUPZ7id895Tb/L1
        w4TT2EuT879Yxp5X4FYqo0E1UQ==
X-Google-Smtp-Source: ABdhPJz5SIuwEhnGjOo1CpkBxiFz+zWBgcGI917RzqTFj2OLAcaJYHvW9ENjZfahkvxrAN9gCxWmGQ==
X-Received: by 2002:a05:6402:5190:b0:427:df4a:19d9 with SMTP id q16-20020a056402519000b00427df4a19d9mr41598107edd.384.1652455258470;
        Fri, 13 May 2022 08:20:58 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-59-245.cust.vodafonedsl.it. [188.217.59.245])
        by smtp.gmail.com with ESMTPSA id el10-20020a170907284a00b006f3ef214e2csm873386ejc.146.2022.05.13.08.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:20:58 -0700 (PDT)
Date:   Fri, 13 May 2022 17:20:55 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Message-ID: <20220513152055.GI649073@tom-ThinkPad-T14s-Gen-2i>
References: <20220512074359.446999-1-tommaso.merciai@amarulasolutions.com>
 <YnzdcubW7m+CwnvN@sirena.org.uk>
 <20220512104642.GD649073@tom-ThinkPad-T14s-Gen-2i>
 <YnznExLDOvRpXNVh@sirena.org.uk>
 <20220512110959.GF649073@tom-ThinkPad-T14s-Gen-2i>
 <YnztJxdSFau6SYC5@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnztJxdSFau6SYC5@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:19:03PM +0100, Mark Brown wrote:
> On Thu, May 12, 2022 at 01:09:59PM +0200, Tommaso Merciai wrote:
> > On Thu, May 12, 2022 at 11:53:07AM +0100, Mark Brown wrote:
> > > On Thu, May 12, 2022 at 12:46:42PM +0200, Tommaso Merciai wrote:
> > > > On Thu, May 12, 2022 at 11:12:02AM +0100, Mark Brown wrote:
> 
> > > > > These look like they should be DAPM controls since they're controlling
> > > > > audio routing but they're being added as regular controls.
> 
> > > > Sorry again. You suggest to create a new structure for these entries,
> > > > for example:
> 
> > > If that's how they fit into the routing for the device, yes - you'd need
> > > to define the bypass mixer as well and set up appropraite routes.
> 
> > I added this reg as regular controls because this reg is pretty generic
> > as you can see this controll bypass of some output, not all. 
> > What do you think about?
> 
> That sounds exactly like a DAPM control, please make them DAPM controls.

Hi Mark,
Sorry again, but I'm quite new on alsa subsystem. I need an help on figuring out
on how to implements your solution. From what you suggest I got that I need to create
a bypass mixer for every switch (4 -> SPK, REC, MIC2, INA):

/* Out Mixer SPK */
static const struct snd_kcontrol_new max98088_output_bypass_spk_mixer_controls[] = {
       SOC_DAPM_SINGLE("SPK Bypass Switch", M98088_REG_4A_CFG_BYPASS, 0, 1, 0),
};

/* Out Mixer REC */
static const struct snd_kcontrol_new max98088_output_bypass_rec_mixer_controls[] = {
       SOC_DAPM_SINGLE("REC Bypass Switch", M98088_REG_4A_CFG_BYPASS, 1, 1, 0),
};

/* Out Mixer MIC */
static const struct snd_kcontrol_new max98088_output_bypass_mic_mixer_controls[] = {
       SOC_DAPM_SINGLE("MIC2 Bypass Switch", M98088_REG_4A_CFG_BYPASS, 4, 1, 0),
};

/* Out Mixer INA */
static const struct snd_kcontrol_new max98088_output_bypass_ina_mixer_controls[] = {
       SOC_DAPM_SINGLE("INA Bypass Switch", M98088_REG_4A_CFG_BYPASS, 7, 1, 0),
};

After that, I need to route the new control mixers on the switch:

 {"Out Mixer SPK", "SPK Bypass Switch", "RECN"},
 {"Out Mixer REC", "REC Bypass Switch", "RECP"},
 {"Out Mixer MIC", "MIC2 Bypass Switch", "MIC1"},
 {"Out Mixer INA", "INA Bypass Switch", "INA"},

Then route the bypass switch to the new output:

 {"SPKL", NULL, "SPK Bypass Switch"},
 {"RECN", NULL, "REC Bypass Switch"},
 {"MIC2", NULL, "MIC2 Bypass Switch"},
 {"MIC1", NULL, "INA Bypass Switch"},

I'm in the right way? What do you think about?
Can you point me a similar bypass switch into the kernel to take as reference?
Thanks in advance

Regards,
Tommmaso




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
