Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0989524B10
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352949AbiELLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbiELLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:10:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0859A224057
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:10:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i27so9469328ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=63TDKIJsFtOS/DXIb3WtgkfvcQzEXqcjOyVr2jqb54g=;
        b=Usvq3FnQ9GXr1MzKxpo62PSGW4NqFiN6LixFSNJsFFLfa0JSzfO8liMPHUrcIRHxUu
         dWe2SR01XzUYrhQPOH4VcjnrQ8uJEiUS7quyQSAim76+3Yti3jSLcDRem8YN4eYNynAK
         xwt0PzMF6gVV+OitQGQUm1AUv2fS/I3GIh5I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=63TDKIJsFtOS/DXIb3WtgkfvcQzEXqcjOyVr2jqb54g=;
        b=6sP9eT2ZEQud27DxUjZT2q8ZcHUfJ55v3PU4MQrQnDn6tKQGbwAHlKHIeV4XIMX1NS
         Ntpu9kWdWwvGch8I5NzdWulsHgjsG3VIEZHlrZ3ASj3gjThiNbmv4cHfkLUvcsJZ5W6R
         Mg3whdaYr/qxrLlSXRp6c+OFWVawMKTvZjtyNAHTyVR02ZqQIDE6l+kvY4cI/OgF0l4X
         SdIZ99HwGHMGYErunmZt5mMT4Cn7pYHlieFsTzmGJGnfP5pVylPmZV9fziyZJw+2Mdcd
         U8h7LxU2o5RRVCuxlAnloMal+bSjNPts/SNjU/61nYUfRlYSbAc5O6UrJPVaSWqL8N8b
         DX8Q==
X-Gm-Message-State: AOAM533Kg11+k9uXsQIxijOBrXLe9AjcmpkO3eFaY5cuj+KvHEL9vt2B
        WUWucv1voqnTlb6ut5TaaXpEXA==
X-Google-Smtp-Source: ABdhPJwbN0DndoP+G6HJ6OXeD58gLSzwQHv7EZjWb8yzL1y8kHpHA//NGkSaVITaTMps4V9vzHT8aQ==
X-Received: by 2002:a17:907:6e07:b0:6f4:d185:9f57 with SMTP id sd7-20020a1709076e0700b006f4d1859f57mr29890450ejc.668.1652353801609;
        Thu, 12 May 2022 04:10:01 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-59-245.cust.vodafonedsl.it. [188.217.59.245])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906494300b006f3ef214df4sm2021115ejt.90.2022.05.12.04.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:10:01 -0700 (PDT)
Date:   Thu, 12 May 2022 13:09:59 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Message-ID: <20220512110959.GF649073@tom-ThinkPad-T14s-Gen-2i>
References: <20220512074359.446999-1-tommaso.merciai@amarulasolutions.com>
 <YnzdcubW7m+CwnvN@sirena.org.uk>
 <20220512104642.GD649073@tom-ThinkPad-T14s-Gen-2i>
 <YnznExLDOvRpXNVh@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnznExLDOvRpXNVh@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:53:07AM +0100, Mark Brown wrote:
> On Thu, May 12, 2022 at 12:46:42PM +0200, Tommaso Merciai wrote:
> > On Thu, May 12, 2022 at 11:12:02AM +0100, Mark Brown wrote:
> 
> > > These look like they should be DAPM controls since they're controlling
> > > audio routing but they're being added as regular controls.
> 
> > Sorry again. You suggest to create a new structure for these entries,
> > for example:
> 
> > /* Out Bypass mixer switch */
> > static const struct snd_kcontrol_new max98088_out_bypass_mixer_controls[] = {
> >        SOC_DAPM_SINGLE("INA Switch", M98088_REG_4A_CFG_BYPASS, 7, 1, 0),
> >        SOC_DAPM_SINGLE("MIC2 Switch", M98088_REG_4A_CFG_BYPASS, 4, 1, 0),
> >        SOC_DAPM_SINGLE("REC Switch", M98088_REG_4A_CFG_BYPASS, 1, 1, 0),
> >        SOC_DAPM_SINGLE("SPK Switch", M98088_REG_4A_CFG_BYPASS, 0, 1, 0),
> > };
> 
> If that's how they fit into the routing for the device, yes - you'd need
> to define the bypass mixer as well and set up appropraite routes.

Hi,
I added this reg as regular controls because this reg is pretty generic
as you can see this controll bypass of some output, not all. 
What do you think about?

Thanks,
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
