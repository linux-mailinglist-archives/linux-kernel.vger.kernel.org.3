Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE93514ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378115AbiD2PPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378132AbiD2PPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:15:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9FCD4462;
        Fri, 29 Apr 2022 08:11:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l7so16066738ejn.2;
        Fri, 29 Apr 2022 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=SAsWIU2W3p7Q0ZXwzZUArSy317phcc7hhmyzyg+rjOE=;
        b=LmHXoutrrKYA3NkvsF48dfb6fC6YhTRK1ftbNp4Gzpzi14cOaEzW3e9qqS1aYaPg6x
         seWl5AUFEMU133I7Bo7NfL3WDL7fHEgWifWGj9kUEOdNJBkZsrydw9KmcwPC8sJjfPDi
         3blnJu3dmZQvjRAwKsupb5f3lKmeSRR2VsMyKQ70aVa5uEC084uOLB7hSSVbCovLldr1
         Uu5gwB08c70O5Z96MvTQayLOYGOf2AAgHdQ2O4LPoT49Bw3RC6Ul9B6uiR1IQrfrlhAG
         6FlG0yRd8MVlzkuC90iI6kk3pXf0kp/A+Ok7WKhnrMtEAjCrimqxv1V2bO7CIUQyx+9b
         PZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=SAsWIU2W3p7Q0ZXwzZUArSy317phcc7hhmyzyg+rjOE=;
        b=O4jGzsc6TMreRcNHx6W1Sdy5G3SmvYBmEbtgxHlWOX5XSR1A8EB/ap1j44BaWgVGIu
         TLlRQpsq+3JVQOUErQP1wN+SogEW6NB+pN6VbVwSXuJxT2ZdMJAD6K7mu/BXP0lK+t2T
         sb7cTwH/RwiPLmO9jgt/S+F6JnaTIydbKNbrFCQ0aeVzMcpFDkm2eJmto2v2uHD5Z4KU
         C1sMNb/SFkbqrH/6zFvHpdM6Y83JzCnLCXlIDQn0pJ5zwIU5Lrwu5d1djq7bPhk4srX6
         swa+8zuDsRELPoR0g23GehoRi/pNk5TYV3BLroW3AAu11mGcQWeBjl0iokuMYeOhlZHe
         7GHg==
X-Gm-Message-State: AOAM532RTg4WkYUFs1fVS+NuKFZytMMgWUQIZD0vBbYLjuwyFOm2m9Ga
        qzTWTGZ3IATWlETNHUhVnMk=
X-Google-Smtp-Source: ABdhPJwTJtflClacx/dV6nHIRCHf6sS/C3krPJR9QkVUVkmk10jnwAYw/sT7Gv6/SRP0OpjpC18FyQ==
X-Received: by 2002:a17:907:3e8c:b0:6f4:7bb:d548 with SMTP id hs12-20020a1709073e8c00b006f407bbd548mr1254390ejc.695.1651245108994;
        Fri, 29 Apr 2022 08:11:48 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id zd21-20020a17090698d500b006f3ef214e4csm720411ejb.178.2022.04.29.08.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:11:48 -0700 (PDT)
Message-ID: <626c0034.1c69fb81.d55d4.4f09@mx.google.com>
X-Google-Original-Message-ID: <Ymv/oshQ1tmxwSDR@Ansuel-xps.>
Date:   Fri, 29 Apr 2022 17:09:22 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] clk: qcom: clk-krait: add apq/ipq8064 errata
 workaround
References: <20220429120108.9396-1-ansuelsmth@gmail.com>
 <20220429120108.9396-5-ansuelsmth@gmail.com>
 <1f013429-8a5b-47c8-a146-41bb66af3f03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f013429-8a5b-47c8-a146-41bb66af3f03@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 06:00:45PM +0300, Dmitry Baryshkov wrote:
> On 29/04/2022 15:01, Ansuel Smith wrote:
> > Add apq/ipq8064 errata workaround where the sec_src clock gating needs to
> > be disabled during switching. To enable this set disable_sec_src_gating
> > in the mux struct.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >   drivers/clk/qcom/clk-krait.c | 16 ++++++++++++++++
> >   drivers/clk/qcom/clk-krait.h |  1 +
> >   drivers/clk/qcom/krait-cc.c  |  1 +
> >   3 files changed, 18 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
> > index 6c367ad6506a..4a9b3296c45b 100644
> > --- a/drivers/clk/qcom/clk-krait.c
> > +++ b/drivers/clk/qcom/clk-krait.c
> > @@ -18,13 +18,23 @@
> >   static DEFINE_SPINLOCK(krait_clock_reg_lock);
> >   #define LPL_SHIFT	8
> > +#define SECCLKAGD	BIT(4)
> > +
> >   static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
> >   {
> >   	unsigned long flags;
> >   	u32 regval;
> >   	spin_lock_irqsave(&krait_clock_reg_lock, flags);
> > +
> >   	regval = krait_get_l2_indirect_reg(mux->offset);
> > +
> > +	/* apq/ipq8064 Errata: disable sec_src clock gating during switch. */
> > +	if (mux->disable_sec_src_gating) {
> > +		regval |= SECCLKAGD;
> > +		krait_set_l2_indirect_reg(mux->offset, regval);
> > +	}
> > +
> >   	regval &= ~(mux->mask << mux->shift);
> >   	regval |= (sel & mux->mask) << mux->shift;
> >   	if (mux->lpl) {
> > @@ -33,6 +43,12 @@ static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
> >   	}
> >   	krait_set_l2_indirect_reg(mux->offset, regval);
> > +	/* apq/ipq8064 Errata: re-enabled sec_src clock gating. */
> > +	if (mux->disable_sec_src_gating) {
> > +		regval &= ~SECCLKAGD;
> > +		krait_set_l2_indirect_reg(mux->offset, regval);
> > +	}
> > +
> >   	/* Wait for switch to complete. */
> >   	mb();
> >   	udelay(1);
> > diff --git a/drivers/clk/qcom/clk-krait.h b/drivers/clk/qcom/clk-krait.h
> > index 9120bd2f5297..f930538c539e 100644
> > --- a/drivers/clk/qcom/clk-krait.h
> > +++ b/drivers/clk/qcom/clk-krait.h
> > @@ -15,6 +15,7 @@ struct krait_mux_clk {
> >   	u8		safe_sel;
> >   	u8		old_index;
> >   	bool		reparent;
> > +	bool		disable_sec_src_gating;
> >   	struct clk_hw	hw;
> >   	struct notifier_block   clk_nb;
> > diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
> > index 4d4b657d33c3..0f88bf41ec6e 100644
> > --- a/drivers/clk/qcom/krait-cc.c
> > +++ b/drivers/clk/qcom/krait-cc.c
> > @@ -138,6 +138,7 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
> >   	mux->parent_map = sec_mux_map;
> >   	mux->hw.init = &init;
> >   	mux->safe_sel = 0;
> > +	mux->disable_sec_src_gating = true;
> 
> This has to be guarded with the of_compatible checks. Otherwise you'd apply
> this errata to all Krait CPUs, not only apq/ipq8064.
> 
> At least this should be limited to krait-cc-v1 with the note that there is
> no way to distinguish between platforms.
>

Mhh can't i check the machine compatible directly to limit this to
apq/ipq8064?

> >   	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
> >   	if (!init.name)
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
