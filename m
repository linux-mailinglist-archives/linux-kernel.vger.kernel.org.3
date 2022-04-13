Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4468D4FFCE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbiDMRhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiDMRhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:37:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB26AA61;
        Wed, 13 Apr 2022 10:35:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ks6so5455382ejb.1;
        Wed, 13 Apr 2022 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ee95gHV7iSr2ekFH5AqCetn8VvvbFG2KHgCxR9Ie+EA=;
        b=o7z90tVRYo6neZuK50x9VfaPNc7tIV/W8MMAuwWMA6cq9RoeIQDchRjhBKIotuy7Wz
         uSk9srBLFiCIal3R4/FqmCK+x4Ab5nFVs0MFr+s8LDavRZvHFMH0TjaDPXApNkFtlF9z
         DjqVVFopHWs389N8IiPYmd4Md25gDIwZTCAN2ZWs3SzjGNubpMYis/KbFq/eshpLDNHm
         BwAHw4pgUX2kbBcTskMHsPLP/oOJLTBB76c+HbTf32kjWTAcmeut//Oio30IJFa4XSjW
         ivdDMfIglPEeVRkwJZsm2w7Og895RD+Hh6yPgi+NG+bNEetzfTfLUj7fVepF1VVAE6uE
         W4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ee95gHV7iSr2ekFH5AqCetn8VvvbFG2KHgCxR9Ie+EA=;
        b=DODd4WJTIBwYiCjwFurAYUCnxXo9bsllYXxvmjuj6lPaCZ8Fqm+sKlWXY79+jomhKp
         +6nWaWjaiwclHZBvDECaRXw4ycmBqmUmQJ//iqrrWSMLcs7DpqCmIfuEmhmCHEK1Q6HV
         O+ZCahztbYXmTn9vN7Egsql9HIeK+TR3HBnXJEaE9GeYMaT8bMfUrGIQGyFsiR/IKSV7
         ZaoAVQ0Bdw6NsZuty6pGba2aF9n+2rxJzppLFQ1BHYo9JxRz9EhXORekL1gpHjZ1yGtF
         /UiDePchX85bv0u4R/me7NHWqxc63BRymt4udcAm1NWzaFGXLTeiwmqVNyR+9jDKuO/W
         449A==
X-Gm-Message-State: AOAM530y36GHesxWxocbxGxKKdZFrwupOWEe3J8ePDJM2ak/L1JhviMD
        3E/FJ2ztCOor+8IqmG+kavg=
X-Google-Smtp-Source: ABdhPJx/VFClNMNxVfV1csAt6X2D/AhdKhzf7bDlszwJGAzro5t3Qu4KxO35lHSCxx4nBualo3WMTg==
X-Received: by 2002:a17:907:6e03:b0:6e8:c12b:fb3f with SMTP id sd3-20020a1709076e0300b006e8c12bfb3fmr5410618ejc.98.1649871307291;
        Wed, 13 Apr 2022 10:35:07 -0700 (PDT)
Received: from Ansuel-xps. (host-80-182-176-248.retail.telecomitalia.it. [80.182.176.248])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709063b1800b006e8cf786ee8sm196570ejf.21.2022.04.13.10.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:35:06 -0700 (PDT)
Message-ID: <625709ca.1c69fb81.b4268.12bc@mx.google.com>
X-Google-Original-Message-ID: <YlcJyWxC8vIZpLVc@Ansuel-xps.>
Date:   Wed, 13 Apr 2022 19:35:05 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 10/18] clk: qcom: krait-cc: drop hardcoded safe_sel
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-11-ansuelsmth@gmail.com>
 <af104d82-34bc-2ab6-75bf-e54aafb3ae83@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af104d82-34bc-2ab6-75bf-e54aafb3ae83@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:25:31PM +0300, Dmitry Baryshkov wrote:
> On 22/03/2022 02:15, Ansuel Smith wrote:
> > Drop hardcoded safe_sel definition and use helper to correctly calculate
> > it. We assume qsb clk is always present as it should be declared in DTS
> > per Documentation and in the absence of that, it's declared as a fixed
> > clk.
> 
> Why? Can safe_sel (sec_mux index) change?
>

No it can't but I think it would be better to have stuff that is based
on real defined data instead of wrong struct that works just because a
hardcoded value is used.

Example for the reason of using this hardcoded value, nobody notice that
the mux list for the secondary mux was wrong. Now it didn't cause any
problem as we use the secondary mux just to source out of qsb and we
used the hardcoded value so the error was bypassed but as soon as the
value was actually parsed from the defined table, bam secondary mux was
sourcing out of pll8.

I honestly think that dropping the hardcoded value would make more clear
what the safe sel is and what is referring to.

> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >   drivers/clk/qcom/krait-cc.c | 40 +++++++++++++++++++++++++------------
> >   1 file changed, 27 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
> > index e9508e3104ea..5f98ee1c3681 100644
> > --- a/drivers/clk/qcom/krait-cc.c
> > +++ b/drivers/clk/qcom/krait-cc.c
> > @@ -26,6 +26,17 @@ static unsigned int pri_mux_map[] = {
> >   	0,
> >   };
> > +static u8 krait_get_mux_sel(struct krait_mux_clk *mux, struct clk *safe_clk)
> > +{
> > +	struct clk_hw *safe_hw = __clk_get_hw(safe_clk);
> > +
> > +	/*
> > +	 * We can ignore errors from clk_hw_get_index_of_parent()
> > +	 * as we create these parents in this driver.
> > +	 */
> > +	return clk_hw_get_index_of_parent(&mux->hw, safe_hw);
> > +}
> > +
> >   /*
> >    * Notifier function for switching the muxes to safe parent
> >    * while the hfpll is getting reprogrammed.
> > @@ -116,8 +127,8 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
> >   }
> >   static struct clk *
> > -krait_add_sec_mux(struct device *dev, int id, const char *s,
> > -		  unsigned int offset, bool unique_aux)
> > +krait_add_sec_mux(struct device *dev, struct clk *qsb, int id,
> > +		  const char *s, unsigned int offset, bool unique_aux)
> >   {
> >   	int ret;
> >   	struct krait_mux_clk *mux;
> > @@ -144,7 +155,6 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
> >   	mux->shift = 2;
> >   	mux->parent_map = sec_mux_map;
> >   	mux->hw.init = &init;
> > -	mux->safe_sel = 0;
> >   	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
> >   	if (!init.name)
> > @@ -166,6 +176,7 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
> >   	if (IS_ERR(clk))
> >   		goto err_clk;
> > +	mux->safe_sel = krait_get_mux_sel(mux, qsb);
> >   	ret = krait_notifier_register(dev, clk, mux);
> >   	if (ret)
> >   		clk = ERR_PTR(ret);
> > @@ -204,7 +215,6 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
> >   	mux->lpl = id >= 0;
> >   	mux->parent_map = pri_mux_map;
> >   	mux->hw.init = &init;
> > -	mux->safe_sel = 2;
> >   	init.name = kasprintf(GFP_KERNEL, "krait%s_pri_mux", s);
> >   	if (!init.name)
> > @@ -226,6 +236,7 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
> >   	if (IS_ERR(clk))
> >   		goto err_clk;
> > +	mux->safe_sel = krait_get_mux_sel(mux, sec_mux);
> >   	ret = krait_notifier_register(dev, clk, mux);
> >   	if (ret)
> >   		clk = ERR_PTR(ret);
> > @@ -238,7 +249,9 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
> >   }
> >   /* id < 0 for L2, otherwise id == physical CPU number */
> > -static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
> > +static struct clk *
> > +krait_add_clks(struct device *dev, struct clk *qsb, int id,
> > +	       bool unique_aux)
> >   {
> >   	unsigned int offset;
> >   	void *p = NULL;
> > @@ -261,7 +274,7 @@ static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
> >   		goto err;
> >   	}
> > -	sec_mux = krait_add_sec_mux(dev, id, s, offset, unique_aux);
> > +	sec_mux = krait_add_sec_mux(dev, qsb, id, s, offset, unique_aux);
> >   	if (IS_ERR(sec_mux)) {
> >   		clk = sec_mux;
> >   		goto err;
> > @@ -301,18 +314,19 @@ static int krait_cc_probe(struct platform_device *pdev)
> >   	int cpu;
> >   	struct clk *clk;
> >   	struct clk **clks;
> > -	struct clk *l2_pri_mux_clk;
> > +	struct clk *l2_pri_mux_clk, *qsb;
> >   	id = of_match_device(krait_cc_match_table, dev);
> >   	if (!id)
> >   		return -ENODEV;
> >   	/* Rate is 1 because 0 causes problems for __clk_mux_determine_rate */
> > -	if (IS_ERR(clk_get(dev, "qsb")))
> > -		clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
> > +	qsb = clk_get(dev, "qsb");
> > +	if (IS_ERR(qsb))
> > +		qsb = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
> > -	if (IS_ERR(clk))
> > -		return PTR_ERR(clk);
> > +	if (IS_ERR(qsb))
> > +		return PTR_ERR(qsb);
> >   	if (!id->data) {
> >   		clk = clk_register_fixed_factor(dev, "acpu_aux",
> > @@ -327,13 +341,13 @@ static int krait_cc_probe(struct platform_device *pdev)
> >   		return -ENOMEM;
> >   	for_each_possible_cpu(cpu) {
> > -		clk = krait_add_clks(dev, cpu, id->data);
> > +		clk = krait_add_clks(dev, qsb, cpu, id->data);
> >   		if (IS_ERR(clk))
> >   			return PTR_ERR(clk);
> >   		clks[cpu] = clk;
> >   	}
> > -	l2_pri_mux_clk = krait_add_clks(dev, -1, id->data);
> > +	l2_pri_mux_clk = krait_add_clks(dev, qsb, -1, id->data);
> >   	if (IS_ERR(l2_pri_mux_clk))
> >   		return PTR_ERR(l2_pri_mux_clk);
> >   	clks[4] = l2_pri_mux_clk;
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
