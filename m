Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3218F504840
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiDQQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiDQQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:00:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45379BD3;
        Sun, 17 Apr 2022 08:57:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so23273683ejn.2;
        Sun, 17 Apr 2022 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=DTckEI0XXLZk8YJEhUNyTatla2R+tAttZnnlIuQZrQQ=;
        b=DB34APFKfHqrfYeZOq5SKQdwfANosF7qA4kvAgYS0qrLY3OGtaPp7Osrf6/BfDl6+n
         iYZJNnc+AC0mMqMibcjCoAM5IYAEKQcqfUw95lOMQdEDYrFdwzUa2Mj5VpubYz7nXcqG
         E05A1v5xt04AbAy/20VzA/QZhBRjOQLCtmXLB1Ez4iLXQpx4o8/2xX8PefA+FngebQRA
         ix77I/Zis1+6g+25L1FxJyOFD3XpZh3dUkTDQL8OPD4CLkBlSFOAsBkL0GITu/YQ3Eda
         JplJbn1+vugy1RSf7XcEGFKegawyVuBwbXPeIMr4XfZVr67CNheG0iis9tTUjUbSGfjQ
         OxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=DTckEI0XXLZk8YJEhUNyTatla2R+tAttZnnlIuQZrQQ=;
        b=j9OduULLUI4Ij1heEi84mMjLQ/Jz59tJWwCrYunR2JfU6oWBpXK/tCi2wipumH7QHD
         XYZ60/3XUISVO/VvxUNy2qKtj4ix+dYAxwWPo/m6c/3hb1mKLxpknRyixar4LQEKAFUp
         r3JuVTw9MwY/mFv+NJl8x+w0r+3yOjhaBmqvPmdT7BwF0Mk9VUZVnyoROH/1E03+sLOs
         t1z5ZOOFZMWdKHnGL5osa9ZlOQg0BqOuBwJ5zeNUkWBhIRtc0VJnwjixnR/fbD0k+hBU
         b0wTJG2RFbLHz2cbrpb1N/zMWhFA/f6Pju/NkZ3F0Yg3CRgvfeiHBB/XCssULLs4cUmH
         DIIQ==
X-Gm-Message-State: AOAM530Ka9PZDFbFAiTJvPaMHJZ4NnsOOcfEB9SmqDqONp4KmUHsGFmk
        OyTAwFx0DNPcAgsbbIoK709y076CZEo=
X-Google-Smtp-Source: ABdhPJwCMZ86yNoeG9zUTtuMMitkZMrRqEz0y9FVo2WJQ9JnEqeFHU9C5JzDF6G4Zp8SgYyMijkFQQ==
X-Received: by 2002:a17:906:3a55:b0:6ce:c2ee:3e10 with SMTP id a21-20020a1709063a5500b006cec2ee3e10mr5788200ejf.210.1650211051443;
        Sun, 17 Apr 2022 08:57:31 -0700 (PDT)
Received: from Ansuel-xps. (host-79-33-253-62.retail.telecomitalia.it. [79.33.253.62])
        by smtp.gmail.com with ESMTPSA id o15-20020a50fd8f000000b0041f95b8a90dsm5676635edt.69.2022.04.17.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 08:57:30 -0700 (PDT)
Message-ID: <625c38ea.1c69fb81.17696.b763@mx.google.com>
X-Google-Original-Message-ID: <Ylw46Gg8wOwzSkxp@Ansuel-xps.>
Date:   Sun, 17 Apr 2022 17:57:28 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom_scm: Add compatible for ipq806x
References: <20220310220723.3772-1-ansuelsmth@gmail.com>
 <YlY3rPpYvclK8L3z@builder.lan>
 <CAA8EJprEYgWTp5KJ1TSGC8EKbuw1XP+jz7D5BaCP0rEsEPVsuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprEYgWTp5KJ1TSGC8EKbuw1XP+jz7D5BaCP0rEsEPVsuQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:03:59AM +0300, Dmitry Baryshkov wrote:
> On Wed, 13 Apr 2022 at 05:38, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Thu 10 Mar 16:07 CST 2022, Ansuel Smith wrote:
> >
> > > Add compatible for ipq806x. Just like ipq4019, ipq806x doesn't require
> > > Core, Iface or Bus clock.
> > >
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/firmware/qcom_scm.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > > index 7db8066b19fd..7348c5894821 100644
> > > --- a/drivers/firmware/qcom_scm.c
> > > +++ b/drivers/firmware/qcom_scm.c
> > > @@ -1338,6 +1338,7 @@ static const struct of_device_id qcom_scm_dt_match[] = {
> > >                                                            SCM_HAS_IFACE_CLK |
> > >                                                            SCM_HAS_BUS_CLK)
> > >       },
> > > +     { .compatible = "qcom,scm-ipq806x" },
> >
> > If you in your dt do:
> >
> >         compatible = "qcom,scm-ipq806x", "qcom,scm";
> >
> > Then we don't need to update the driver for each platform, only the DT
> > binding.
> >
> > And if we some day need to quirk something off qcom,scm-ipq806x we have
> > that option.
> 
> I suppose that ipq806x might need SCM_HAS_CORE_CLK. Or, more likely,
> an interconnect vote, once we have interconnect drivers for
> ipq/apq8064 platforms.
> 

From an old source I found that scm core clock comes from dfab_clk
(DAYTONA_FABRIC). I notice there is an interconnect driver for rpm (bw
is handled by rpm on ipq/apq8064) but why this should be related to scm
core clk? To handle the clock voter stuff? (I assume a voter logic is
not supported upstream)

But it does seems an interesting project adding interconnect support for
ipq8064 also considering I have a fab scaling driver present from ages
that I hane no idea how to handle.

> >
> > Thanks,
> > Bjorn
> >
> > >       { .compatible = "qcom,scm-ipq4019" },
> > >       { .compatible = "qcom,scm-mdm9607", .data = (void *)(SCM_HAS_CORE_CLK |
> > >                                                            SCM_HAS_IFACE_CLK |
> > > --
> > > 2.34.1
> > >
> 
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
