Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8829A535DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbiE0KG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350833AbiE0KGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:06:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0413F11CA32
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:05:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id q15so4773445edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XO2hMhBNxgx/7TUo7q5hJUYtHpkBHllPRW2Qz6ze9MU=;
        b=Ynb2zIxQqTfUQ31nIcmQHvLnuM4+B56fwXc8Nqk5ai6IHMUwW0SkxXsX7b+apjVzMl
         lb6Gvk5FBxU+Hceep9vWqUwdaBmQVHKw4UHfu5F4dG+rBqJ/6I9cZaglEhysfenrPFTS
         l35X19h1cSa9p9HEu/gmJVF3gZl57awP3VUNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XO2hMhBNxgx/7TUo7q5hJUYtHpkBHllPRW2Qz6ze9MU=;
        b=HYej0RKMdpZt+xk2Vo/c1Ws9CE9ifRBJOmNn30PilXl9kZOzQ3SWpLyYM/5eZPaCDn
         KYKB/2eiD7o8af3qLZVtXlXe6URHWn1nINooDegIamZetPB+AeXD3LLfnrpCWBY5/M9Z
         uebxsqg478ITVyiBdmWxbd4DLAAWdPdybYhn/pIR7K5B5EFUnSnqDAKo3PLn4izM+m6Y
         zAhSLsRNdS+RqX2wZph7cRXe56V8CVxd3c7q82/X0OQPcHzkYJ0UlXfC78y1/n9rtqzC
         HlW97myjFXNKI2nCo8U7kfWM7WNhGD97UwTR/ZJOG5u45HA+8NP8ZifoCqunQs5sPqOF
         nCIA==
X-Gm-Message-State: AOAM532AyvxQl67Qa6e5ED0WQkr58UTPRBGvj1Fz9Agw2iYl2qiAWg5T
        5UP8TI17a4/bEiifX3udR9btyg==
X-Google-Smtp-Source: ABdhPJzjEUgEnwu83xVICmetJe6KIo2pNhiM9LyPqQWtChwb56MNYN056FGAeAfU5VJ2yRExyZqCbQ==
X-Received: by 2002:a05:6402:320f:b0:42b:c876:4e34 with SMTP id g15-20020a056402320f00b0042bc8764e34mr13061196eda.201.1653645956312;
        Fri, 27 May 2022 03:05:56 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-53-154.cust.vodafonedsl.it. [188.217.53.154])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906c00400b006fec8e8eff6sm1320036ejz.176.2022.05.27.03.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:05:55 -0700 (PDT)
Date:   Fri, 27 May 2022 12:05:53 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH] media: imx-jpeg: Leave a blank space before
 the configuration data
Message-ID: <20220527100553.GA25548@tom-ThinkPad-T14s-Gen-2i>
References: <20220527075437.16882-1-ming.qian@nxp.com>
 <20220527075437.16882-3-ming.qian@nxp.com>
 <20220527093824.GF11217@tom-ThinkPad-T14s-Gen-2i>
 <AM6PR04MB634165DE21CEE8B6780CB817E7D89@AM6PR04MB6341.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB634165DE21CEE8B6780CB817E7D89@AM6PR04MB6341.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 09:52:48AM +0000, Ming Qian wrote:
> > From: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > Sent: 2022年5月27日 17:38
> > To: Ming Qian <ming.qian@nxp.com>
> > Cc: mchehab@kernel.org; Mirela Rabulea (OSS)
> > <mirela.rabulea@oss.nxp.com>; hverkuil-cisco@xs4all.nl;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> > linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH] media: imx-jpeg: Leave a blank space before the
> > configuration data
> > 
> > Caution: EXT Email
> > 
> > Hi Ming,
> > I think have some comments on the code for this would be nice for the future
> > 
> > On Fri, May 27, 2022 at 03:54:35PM +0800, Ming Qian wrote:
> > > There is a hardware bug that it will load the first 128 bytes of
> > > configuration data twice, it will led to some configure error.
> > > so shift the configuration data 128 bytes, and make the first 128
> > > bytes all zero, then hardware will load the 128 zero twice,
> > 
> > From what I've understood you initialize cfg_stm with zeros then you start to
> > write the configuration from 0x80 (128 bytes), avoiding the hw issue right?
> > 
> 

Hi Ming,

> HI Tommaso,
>     Yes, you're right, there is a hardware bug.
> I want to write the configuration data from the offset 0x80,
> And set the first 128 bytes to zero.
> Then the hardware bug can be avoided.

Thanks for your clarification!
Unfortunately I can't test this on a real board but the implementation looks
good to me. Only thing is missing I think we need some notes to keep
track of this known issue (for the sake of clarity just a note on why we
start to write from 0x80)

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Thanks,
Tommaso

> 
> Ming.
> 
> 
> > > and ignore them as garbage.
> > > then the configuration data can be loaded correctly
> > >
> > > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > > Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> > > ---
> > >  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> > > b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> > > index 734e1b65fbc7..ad4213e020f3 100644
> > > --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> > > +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> > > @@ -519,6 +519,7 @@ static bool mxc_jpeg_alloc_slot_data(struct
> > mxc_jpeg_dev *jpeg,
> > >                                    GFP_ATOMIC);
> > >       if (!cfg_stm)
> > >               goto err;
> > > +     memset(cfg_stm, 0, MXC_JPEG_MAX_CFG_STREAM);
> > >       jpeg->slot_data[slot].cfg_stream_vaddr = cfg_stm;
> > >
> > >  skip_alloc:
> > > @@ -755,7 +756,7 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void
> > *cfg_stream_vaddr,
> > >                                             u32 fourcc,
> > >                                             u16 w, u16 h)  {
> > > -     unsigned int offset = 0;
> > > +     unsigned int offset = 0x80;
> > >       u8 *cfg = (u8 *)cfg_stream_vaddr;
> > >       struct mxc_jpeg_sof *sof;
> > >       struct mxc_jpeg_sos *sos;
> > > --
> > > 2.36.1
> > >
> > 
> > Thanks,
> > Tommaso
> > 
> > --
> > Tommaso Merciai
> > Embedded Linux Engineer
> > tommaso.merciai@amarulasolutions.com
> > __________________________________
> > 
> > Amarula Solutions SRL
> > Via Le Canevare 30, 31100 Treviso, Veneto, IT T. +39 042 243 5310
> > info@amarulasolutions.com
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.am
> > arulasolutions.com%2F&amp;data=05%7C01%7Cming.qian%40nxp.com%7C1
> > d15c3ca5ba248ae53bc08da3fc4a75b%7C686ea1d3bc2b4c6fa92cd99c5c3016
> > 35%7C0%7C0%7C637892411093606090%7CUnknown%7CTWFpbGZsb3d8eyJ
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C3000%7C%7C%7C&amp;sdata=2%2FZlmaidIXmpurQBNW56roQgaWnY7IElP
> > OJzhFaZlow%3D&amp;reserved=0

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
