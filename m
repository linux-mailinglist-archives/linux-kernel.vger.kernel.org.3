Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66486524B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353046AbiELL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiELL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:27:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFA66541F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:27:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y21so5870006edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PVKTAkZWOtF0qyn8I/Rv8b8BKYr5D3k07Vp2fZXHBUc=;
        b=HMG6PGAp0NzUlJPHCXVXfIEnrpOttXDH9X4ElC+zoiZ+0nP9EmFwWsTpqbhRqPUxYZ
         KXX8uoqzjq2h4OWz0CfDGmIm/nbmlkIYRJh9bZmspHOmzjVrAyopQUf/WPJx9jtub6Us
         rdFJn3ON5iPU6Pu+2fdB49Us+LbFaFvLjE+Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PVKTAkZWOtF0qyn8I/Rv8b8BKYr5D3k07Vp2fZXHBUc=;
        b=tUFNXisst/jTwAUhgaPRbrnZgAqyOvKKl+Ei4uOsJ1WbVIIDDhL+KN5UhfnoS3vJ0F
         4uClkIHpy7Xp4Pxv/SmdBgm6A9UxD8UNI4KP0xMxJitVdbfv6LrRi2wWjTz05WeYifBG
         dcj45YfHUNN7+lcrDZzEXDbqQoqD3d0gv1eK4QI1apizqqeBHTHCBTG5uzP2xop0zDJf
         ATGm6S8xZcp08d6FinjFgLBQctBku7xWfs7VH4nMXFtZ3Xj7DAvKBS1t+HeyEox08LPl
         9bltSBgQckCSNV77GyiCjZ/iVSkX7/XsVtwdPXi2ihGw9CjpAstpUx7qcJG23iplKcKC
         CZ4Q==
X-Gm-Message-State: AOAM5327ab+6lJryTa5ikTV0MDar3nzXwA4gpf8JaFPI2YA73A6bcjIQ
        CeJoae5cz1cshW81Xrgxh1A+0g==
X-Google-Smtp-Source: ABdhPJyQwH8SIP40Z+z+9H2+IPjpKXwvRygEJl+xzFDJ3pxWTcbvUzocP29MaOKd97cMpgZ417k0yg==
X-Received: by 2002:a05:6402:354f:b0:418:849a:c66a with SMTP id f15-20020a056402354f00b00418849ac66amr35108033edd.234.1652354854313;
        Thu, 12 May 2022 04:27:34 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-59-245.cust.vodafonedsl.it. [188.217.59.245])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709067e4a00b006f3ef214dfdsm2046661ejr.99.2022.05.12.04.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:27:34 -0700 (PDT)
Date:   Thu, 12 May 2022 13:27:31 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Message-ID: <20220512112731.GH649073@tom-ThinkPad-T14s-Gen-2i>
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
Perfect, thanks for your suggestion.
I'll do it in V2.

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
