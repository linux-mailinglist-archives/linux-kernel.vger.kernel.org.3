Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E058E803
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiHJHpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiHJHpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:45:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FC85C978
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:45:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z16so16711574wrh.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6Uw3kz/8NE9eLSWipW36eeeHUbFLrCfATfO5HX/aFsE=;
        b=WbkMFHWquUz7qTU+9q0NJ9P6FwGVlfW5SrbnX7wPWfRZxpeSryTVFtn0BhW1tUOjKf
         WT552D/0+Xtm18djn8Rsz67hJ1+kqsNu4lKiFgqUQxuKy6K4U6Fmlgio3C15pvZVYnOm
         WZIcYx7s+WLqKTIrd4CMYStGhunJR8ZFbN/3jx8xwjxobzkVNRv1SMB7kAMhBFd/6JgX
         YBQD9lICB8Y31u87Xs2DyPVKciMuT6H5rL3RoJB8XI7f7CFySR+wwjpFY0hcl7/nd87a
         ifC5ClDCinIJcYgsaG/E57dHk00jlKaLTq7kedUCFEcG/76qdPrjG4RCaDoIm0GxnAxF
         g4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6Uw3kz/8NE9eLSWipW36eeeHUbFLrCfATfO5HX/aFsE=;
        b=w6iloZr/HzhA8t2dPXgYhY5bnZ72SEGeBRWpJmUZMIo6U/WR4oh2lzKAfwRWn+oRrY
         1DfBZPxSjZ8baw4R/5DkCkalFBayx8VXkkDMp+Mi0VbfxbD7UOwuRUa6CNKNvh6Ywv3v
         iyL38PK2c0izTi9sp5FMD9hge4HxexHbNVXDOubWhQCPgtyYVd3lior8LsHPoTieMjzy
         Z46ZgVGiSeSuhHhlzrurxSfOrDaJ5/guO862bdfOXQ3W4wZZ2Yj06YvMKFFxCeKpeaLU
         oFenvgZaJREBnqH4cBG5xzmkwdNBKa2RIw2OZQm1tyNLLmnX2MA5LtnOFIKMSAt17ftQ
         uK5A==
X-Gm-Message-State: ACgBeo1E7oB0rmvYwiXaQ16dqJes1UMNTun11B12ASzrSioY2Ctkpwbp
        4UKoQFGJIpsw3xJffDSxkGZinQ==
X-Google-Smtp-Source: AA6agR55Cpy1O8VEdoM8U/q8g1TM0O2Oy7uvLADwG6awex+w3YOrSzCm+V28bsDgSwR0VRBj4TpFlA==
X-Received: by 2002:a05:6000:786:b0:222:764d:9e9e with SMTP id bu6-20020a056000078600b00222764d9e9emr10722013wrb.503.1660117547202;
        Wed, 10 Aug 2022 00:45:47 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5a5069107sm1380853wma.24.2022.08.10.00.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 00:45:46 -0700 (PDT)
Date:   Wed, 10 Aug 2022 10:45:45 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/9] clk: qcom: qcc-sdm845: Collapse gdsc structs into
 macros
Message-ID: <YvNiKRHywar2YbtC@linaro.org>
References: <20220726142303.4126434-1-abel.vesa@linaro.org>
 <20220726142303.4126434-2-abel.vesa@linaro.org>
 <YvLCwyB9rBWXmfZt@baldur>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvLCwyB9rBWXmfZt@baldur>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-09 15:25:39, Bjorn Andersson wrote:
> On Tue 26 Jul 09:22 CDT 2022, Abel Vesa wrote:
> 
> > Collapse gdsc structs definitions into macros to make them
> > more compact visually.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/clk/qcom/gcc-sdm845.c | 129 ++++------------------------------
> >  drivers/clk/qcom/gdsc.h       |  10 +++
> >  2 files changed, 23 insertions(+), 116 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> > index 58aa3ec9a7fc..8529e9c8c90c 100644
> > --- a/drivers/clk/qcom/gcc-sdm845.c
> > +++ b/drivers/clk/qcom/gcc-sdm845.c
> > @@ -3191,122 +3191,19 @@ static struct clk_branch gcc_lpass_sway_clk = {
> >  };
> >  #endif
> >  
> > -static struct gdsc pcie_0_gdsc = {
> > -	.gdscr = 0x6b004,
> > -	.pd = {
> > -		.name = "pcie_0_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = POLL_CFG_GDSCR,
> > -};
> > -
> > -static struct gdsc pcie_1_gdsc = {
> > -	.gdscr = 0x8d004,
> > -	.pd = {
> > -		.name = "pcie_1_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = POLL_CFG_GDSCR,
> > -};
> > -
> > -static struct gdsc ufs_card_gdsc = {
> > -	.gdscr = 0x75004,
> > -	.pd = {
> > -		.name = "ufs_card_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = POLL_CFG_GDSCR,
> > -};
> > -
> > -static struct gdsc ufs_phy_gdsc = {
> > -	.gdscr = 0x77004,
> > -	.pd = {
> > -		.name = "ufs_phy_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = POLL_CFG_GDSCR,
> > -};
> > -
> > -static struct gdsc usb30_prim_gdsc = {
> > -	.gdscr = 0xf004,
> > -	.pd = {
> > -		.name = "usb30_prim_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = POLL_CFG_GDSCR,
> > -};
> > -
> > -static struct gdsc usb30_sec_gdsc = {
> > -	.gdscr = 0x10004,
> > -	.pd = {
> > -		.name = "usb30_sec_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = POLL_CFG_GDSCR,
> > -};
> > -
> > -static struct gdsc hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc = {
> > -	.gdscr = 0x7d030,
> > -	.pd = {
> > -		.name = "hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = VOTABLE,
> > -};
> > -
> > -static struct gdsc hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc = {
> > -	.gdscr = 0x7d03c,
> > -	.pd = {
> > -		.name = "hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = VOTABLE,
> > -};
> > -
> > -static struct gdsc hlos1_vote_aggre_noc_mmu_tbu1_gdsc = {
> > -	.gdscr = 0x7d034,
> > -	.pd = {
> > -		.name = "hlos1_vote_aggre_noc_mmu_tbu1_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = VOTABLE,
> > -};
> > -
> > -static struct gdsc hlos1_vote_aggre_noc_mmu_tbu2_gdsc = {
> > -	.gdscr = 0x7d038,
> > -	.pd = {
> > -		.name = "hlos1_vote_aggre_noc_mmu_tbu2_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = VOTABLE,
> > -};
> > -
> > -static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
> > -	.gdscr = 0x7d040,
> > -	.pd = {
> > -		.name = "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = VOTABLE,
> > -};
> > -
> > -static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc = {
> > -	.gdscr = 0x7d048,
> > -	.pd = {
> > -		.name = "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = VOTABLE,
> > -};
> > -
> > -static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf_gdsc = {
> > -	.gdscr = 0x7d044,
> > -	.pd = {
> > -		.name = "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc",
> > -	},
> > -	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = VOTABLE,
> > -};
> > +DEFINE_QCOM_CC_GDSC(pcie_0_gdsc, 0x6b004, "pcie_0_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> > +DEFINE_QCOM_CC_GDSC(pcie_1_gdsc, 0x8d004, "pcie_1_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> > +DEFINE_QCOM_CC_GDSC(ufs_card_gdsc, 0x75004, "ufs_card_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> > +DEFINE_QCOM_CC_GDSC(ufs_phy_gdsc, 0x77004, "ufs_phy_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> > +DEFINE_QCOM_CC_GDSC(usb30_prim_gdsc, 0xf004, "usb30_prim_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> > +DEFINE_QCOM_CC_GDSC(usb30_sec_gdsc, 0x10004, "usb30_sec_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> > +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc, 0x7d030, "hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc", PWRSTS_OFF_ON, VOTABLE);
> > +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc, 0x7d03c, "hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc", PWRSTS_OFF_ON, VOTABLE);
> > +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_tbu1_gdsc, 0x7d034, "hlos1_vote_aggre_noc_mmu_tbu1_gdsc", PWRSTS_OFF_ON, VOTABLE);
> > +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_tbu2_gdsc, 0x7d038, "hlos1_vote_aggre_noc_mmu_tbu2_gdsc", PWRSTS_OFF_ON, VOTABLE);
> > +DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc, 0x7d040, "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc", PWRSTS_OFF_ON, VOTABLE);
> > +DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc, 0x7d048, "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc", PWRSTS_OFF_ON, VOTABLE);
> > +DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_sf_gdsc, 0x7d044, "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc", PWRSTS_OFF_ON, VOTABLE);
> 
> Personally I have a really hard time looking at such a compact chunk of
> text and hence this is harder for me to spot mistakes and differences
> in.

Understood.

> 
> While I like the effort of making things easier to maintain this made me
> further appreciate the change we've done in the interconnect providers,
> where we're doing the exact opposite - and remove magical macros.

Lets ignore this patchset then.

> 
> Regards,
> Bjorn
> 
> >  
> >  static struct clk_regmap *gcc_sdm845_clocks[] = {
> >  	[GCC_AGGRE_NOC_PCIE_TBU_CLK] = &gcc_aggre_noc_pcie_tbu_clk.clkr,
> > diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> > index 5de48c9439b2..c0e616b49dee 100644
> > --- a/drivers/clk/qcom/gdsc.h
> > +++ b/drivers/clk/qcom/gdsc.h
> > @@ -78,6 +78,16 @@ struct gdsc_desc {
> >  	size_t num;
> >  };
> >  
> > +#define DEFINE_QCOM_CC_GDSC(_name, _gdscr, _pd_name, _pwrsts, _flags) \
> > +	static struct gdsc _name = {			\
> > +		.gdscr = _gdscr,		\
> > +		.pd = {				\
> > +			.name = _pd_name,	\
> > +		},				\
> > +		.pwrsts = _pwrsts,		\
> > +		.flags = _flags,		\
> > +	}
> > +
> >  #ifdef CONFIG_QCOM_GDSC
> >  int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
> >  		  struct regmap *);
> > -- 
> > 2.34.3
> > 
