Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BC94FE472
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356911AbiDLPSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351015AbiDLPSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:18:32 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB545E753
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:16:14 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so21032512fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Go9IvpDXSR7Gejk41sTME4/PVZMxW5LbmIPwH42ez3c=;
        b=oB8XLCKEtXmigDeFjQNL0sJlBLv5iwNx5epuN9ygeoE616XfYi7Kw9lPPA7oNqzegL
         Tc9QtYGbbMOktFi30wj2BH+QltPtIO8XxT/7iWGR/yZzeAwzP9ENRzoPxegYkw5ZQoyK
         KQmeEYzcooeQmyv8TwVqqfr6DZaya0NOCz8o7ICwh1GK7NPKPSTpk5bJBBDwJeIEFt7x
         YW+o9o5VENEHkc06/TlfvBGbYjIuFaWsHL0434BCsFbHj03V/oYorKQKXrh0LZInyWTk
         a9PLafjcUEdXVVbnK7ufRzlEke41wAMRr4U1B83CL7tiMg9dDHbsLJJh3GqB3yqse+HL
         +MPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Go9IvpDXSR7Gejk41sTME4/PVZMxW5LbmIPwH42ez3c=;
        b=SCeNFWmz+Ial3zWmhP6FBGK48MqmAR38OPpA2qV24SYsQj99SGHB8lbgh1LeRmxVq9
         jDUqD+R3GqfkT9HTxbrza3eBPiEDko2GAHAjEYHIJVna0BaW/FactDgBD717AmzHLHh3
         UTovl61jVihAx6DnOFKh496pdb4lbHVwx+BzzsHOyIF5FbnwoTAuorG/Ik1mJeuYQ1nl
         pdOHdKmrOLW+V5HK725lzppVLxm9cKnJDjonpqyiBKtYqmJeCgvZK5P1LzUCeGjIUzHr
         fMkPvvctXY/g7Unv5a8bq95atmWvmorP3kUbhTCIIcTrK1agealEbIP4J41ST0mh7I39
         lXUw==
X-Gm-Message-State: AOAM531U5EzavNwOD9hZFGMCXqdXRlmQb8tsELO3ahDyyAL+/aZaLJ0p
        9r/+7e+yoWoBmDul29AqazmcIGqnkrIXTQiq
X-Google-Smtp-Source: ABdhPJxEP7GnS1O5iaSgUztxZ1RQViAVxjyIijKeQzEMMM0+b5vJiMuOKmwEAEZ01Bj66KpDFQmesg==
X-Received: by 2002:a05:6870:232a:b0:db:360c:7f5a with SMTP id w42-20020a056870232a00b000db360c7f5amr2215026oao.230.1649776573359;
        Tue, 12 Apr 2022 08:16:13 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d2d88000000b005b238f7551csm13319217otb.53.2022.04.12.08.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:16:12 -0700 (PDT)
Date:   Tue, 12 Apr 2022 10:16:10 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND 2/2] soc: qcom: rpmhpd: add sc8280xp rpmh power-domains
Message-ID: <YlWXuiHZQXHBXz6F@builder.lan>
References: <20220225054345.2479565-1-bjorn.andersson@linaro.org>
 <20220225054345.2479565-2-bjorn.andersson@linaro.org>
 <YlQtfu5K9IeJLPcS@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlQtfu5K9IeJLPcS@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Apr 08:30 CDT 2022, Johan Hovold wrote:

> On Thu, Feb 24, 2022 at 09:43:45PM -0800, Bjorn Andersson wrote:
> > The Qualcomm sc8280xp platform has 8 power-domains. Add these, and their
> > relevant active-only variants, to the RPMh power-domain driver.
> 
> As we discussed off-list, the sc8280xp apparently has 13 domains. Guess
> the commit message should be updated even if you don't expose all of
> these to Linux.
> 

Thanks for spotting that, I will update the patch and rewrite the commit
message accordingly.

> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/soc/qcom/rpmhpd.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> > index 58f1dc9b9cb7..71602eb824f7 100644
> > --- a/drivers/soc/qcom/rpmhpd.c
> > +++ b/drivers/soc/qcom/rpmhpd.c
> > @@ -180,6 +180,11 @@ static struct rpmhpd mxc_ao = {
> >  	.res_name = "mxc.lvl",
> >  };
> >  
> > +static struct rpmhpd nsp = {
> > +	.pd = { .name = "nsp", },
> > +	.res_name = "nsp.lvl",
> > +};
> > +
> >  /* SDM845 RPMH powerdomains */
> >  static struct rpmhpd *sdm845_rpmhpds[] = {
> >  	[SDM845_CX] = &cx_w_mx_parent,
> > @@ -363,10 +368,31 @@ static const struct rpmhpd_desc sc8180x_desc = {
> >  	.num_pds = ARRAY_SIZE(sc8180x_rpmhpds),
> >  };
> >  
> > +/* SC8280xp RPMH powerdomains */
> > +static struct rpmhpd *sc8280xp_rpmhpds[] = {
> > +	[SC8280XP_CX] = &cx,
> > +	[SC8280XP_CX_AO] = &cx_ao,
> > +	[SC8280XP_MX] = &mx,
> > +	[SC8280XP_MX_AO] = &mx_ao,
> > +	[SC8280XP_EBI] = &ebi,
> > +	[SC8280XP_LCX] = &lcx,
> > +	[SC8280XP_LMX] = &lmx,
> > +	[SC8280XP_GFX] = &gfx,
> > +	[SC8280XP_MMCX] = &mmcx,
> > +	[SC8280XP_MMCX_AO] = &mmcx_ao,
> > +	[SC8280XP_NSP] = &nsp,
> > +};
> 
> Commit 90c74c1c2574 ("soc: qcom: rpmhpd: Sort power-domain definitions
> and lists") recently sorted the other arrays. Sorting by address like
> you've implicitly done here makes it easy to compare with the firmware
> interface, but perhaps you want to sort alphabetically for consistency.
> 

I like consistency.

> Since there apparently are no users for active-only domains in the tree,
> perhaps they can also be added later.
> 

I'll take an extra look at this as well. Seems we do cx, mx and mmcx ao
on the other platforms, but question is if that's only because we do it
on previous platforms...

Thanks for the review,
Bjorn

> > +
> > +static const struct rpmhpd_desc sc8280xp_desc = {
> > +	.rpmhpds = sc8280xp_rpmhpds,
> > +	.num_pds = ARRAY_SIZE(sc8280xp_rpmhpds),
> > +};
> > +
> >  static const struct of_device_id rpmhpd_match_table[] = {
> >  	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
> >  	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
> >  	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
> > +	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = &sc8280xp_desc },
> >  	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
> >  	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
> >  	{ .compatible = "qcom,sm6350-rpmhpd", .data = &sm6350_desc },
> 
> Johan
