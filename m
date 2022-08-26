Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378275A22F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbiHZI11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiHZI1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:27:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01194D4BF0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:27:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e13so17243wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=GBMNHKgmlLZmRoOmLgOsJQI53g42Q9M0aDglnnaPagc=;
        b=B+DYa+KbrU50DAy++HBgIfohmvD4Gf8cT8jDZgJPN6Nm2v08AmIH31k1kk8B58nxZN
         1w/8RIOdHEEJnimlnaLBot2h/MBCOHaenKkNTHXAn15BZLqnY8XdhBKiQOcLjlamGVes
         KBiV5WD4yoSBP2BLgkwBHyErE2bXWNeBZBu0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GBMNHKgmlLZmRoOmLgOsJQI53g42Q9M0aDglnnaPagc=;
        b=NZWEgJYKsTJ5PMFx3rDZpaq/yIMRIrlH7ZcXSHNK7bsXokhF2wIdUWmvR/nRDs5IWR
         e++H1JfhB4wvXG3TG9UAFGyp1bV+rVxcM/Wk02MAzUMDM2CsqqpBed9sqWe5+UySzoYw
         jczvmICX3JHAiitm24YKndhNZ+0uHe7ScHMPBk1AVALnzY8rlfPYxg3KEoN3RTz0fyXI
         YuGUTzh2qKCQluzL1huzIeuJF/uC0thJWkRGWISRgEJkMfwKiYtGNCPZwrEQ5pZT2uPZ
         I9sKz0+wmcBfXrdcpb0c0s7aN7AXtNV3L7MU3IQuiQflUAcVQrR1BtY7YWzyM8grnaaz
         gB8g==
X-Gm-Message-State: ACgBeo3VFuqO28QwEB6A/4YhLbXe24HHMzLO7Y12N97ma2apa25nefgV
        j0FkjsJ1q2hr3bThva+uMq7hSA==
X-Google-Smtp-Source: AA6agR7GM6gWWwI3wgm2Udw4t8VS9EqIwry+dAh9cXCgQ6uD+xW8gC6HdlFuHlv/wjdFDAKuIBzGaA==
X-Received: by 2002:a5d:4d49:0:b0:225:70d5:e988 with SMTP id a9-20020a5d4d49000000b0022570d5e988mr4223637wru.327.1661502441095;
        Fri, 26 Aug 2022 01:27:21 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-49-118.cust.vodafonedsl.it. [188.217.49.118])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d48c7000000b002253604bbefsm1273922wrs.75.2022.08.26.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:27:20 -0700 (PDT)
Date:   Fri, 26 Aug 2022 10:27:17 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v5 2/4] media: amphion: tell and handle
 contiguous and non contiguous format
Message-ID: <20220826082717.GB3151@tom-ThinkPad-T14s-Gen-2i>
References: <cover.1661390673.git.ming.qian@nxp.com>
 <7e6a945b898254679bd93e7e001e7c24b5aea0ef.1661390673.git.ming.qian@nxp.com>
 <20220826072047.GA3151@tom-ThinkPad-T14s-Gen-2i>
 <AM6PR04MB634128ED70894F35B629C69AE7759@AM6PR04MB6341.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB634128ED70894F35B629C69AE7759@AM6PR04MB6341.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Fri, Aug 26, 2022 at 07:47:47AM +0000, Ming Qian wrote:
> [snip]
> 
> >> diff --git a/drivers/media/platform/amphion/vpu_helpers.c
> >> b/drivers/media/platform/amphion/vpu_helpers.c
> >> index e9aeb3453dfc..019c77e84514 100644
> >> --- a/drivers/media/platform/amphion/vpu_helpers.c
> >> +++ b/drivers/media/platform/amphion/vpu_helpers.c
> >> @@ -59,6 +59,36 @@ const struct vpu_format
> >*vpu_helper_find_format(struct vpu_inst *inst, u32 type,
> >>       return NULL;
> >>  }
> >>
> >> +const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst
> >> +*inst, u32 type, u32 pixelfmt) {
> >> +     const struct vpu_format *fmt;
> >> +     const struct vpu_format *sibling;
> >> +
> >> +     fmt = vpu_helper_find_format(inst, type, pixelfmt);
> >> +     if (!fmt || !fmt->sibling)
> >> +             return NULL;
> >> +
> >> +     sibling = vpu_helper_find_format(inst, type, fmt->sibling);
> >> +     if (!sibling || sibling->sibling != fmt->pixfmt ||
> >> +         sibling->comp_planes != fmt->comp_planes)
> >> +             return NULL;
> >
> >I think to preserve code style you need the following solutions on this if
> >statement:
> >
> >if (!sibling || (sibling->sibling != fmt->pixfmt) ||
> >    (sibling->comp_planes != fmt->comp_planes))
> >         return NULL;
> >
> >I think I have suggested to you this solution on the v4. But never mind we
> >need this :)
> >
> >Thanks
> >
> 
> Hi Tommaso,
>     The parentheses are unnecessary, the checkpatch.pl will report the following style problems if I add the parentheses:
> 
> CHECK: Unnecessary parentheses around 'sibling->sibling != fmt->pixfmt'
> #11: FILE: drivers/media/platform/amphion/vpu_helpers.c:72:
> +       if (!sibling || (sibling->sibling != fmt->pixfmt) ||
> +           (sibling->comp_planes != fmt->comp_planes))
> 
> CHECK: Unnecessary parentheses around 'sibling->comp_planes != fmt->comp_planes'
> #11: FILE: drivers/media/platform/amphion/vpu_helpers.c:72:
> +       if (!sibling || (sibling->sibling != fmt->pixfmt) ||
> +           (sibling->comp_planes != fmt->comp_planes))
> 
> total: 0 errors, 0 warnings, 2 checks, 10 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 1.patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.

Sorry, my bad. I don't check this using checkpatch.pl, but checking the
others driver code, you are right. Thanks for clarify this.

Then, Looks good to me.

Regards,
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
