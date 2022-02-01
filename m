Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9714A677B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiBAWB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiBAWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:01:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE7BC061714;
        Tue,  1 Feb 2022 14:01:56 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id s5so58305909ejx.2;
        Tue, 01 Feb 2022 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R0oDzW7lZxNMxzwEYgDFNIULTJR1H9xhIVSMbpB3qcA=;
        b=fJCdTh+YjknsFqCDTMy+q5FI1q66I6hRN4ZtCkjnV8PaagCwxNmRNnnmYgBnEmCBWu
         wcywL6zZXQ7rKLlxASmrJa3SU4ML0xad0IkQZEf3edOKHed0in2e9pJPAEh73zyW9xu/
         hxXtBD+DEOsZcJGLSg9s1v5aNhONzlv03vNWYuuesXIS/wszp/uLezpSMh9RUb3cq4Nx
         42FDjX2tcZ6UIBxl7zJraGY7G9imZ1uOztNsMl/FAy1Bvy2a90yEZdltJk/r4wGS7SwZ
         78vxsssOfmi7N3aO/7SM4U2TlAmSm9E2O+UGkar5n6/spqOb+hYh2nrtDxCeU8CQPqwI
         e2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R0oDzW7lZxNMxzwEYgDFNIULTJR1H9xhIVSMbpB3qcA=;
        b=Dy0+MfEGsdpGHtj9DJmnmgYU+a7vnXW5d+AvRLzvZvZtQKDfXXLSSmXSR4TwKyyLED
         i4468g9Du8R51+mxzsAv9lf8SiUW8evuoV/FPsQ/sUM08j93iGJ45yL9zfRrUCMxTy2P
         eLBtFjMOEYz8kSnhlB8ukLD+g1Io3gr+3FKopbcP861wno84T5TyThFJzk7YKdWP0K/n
         jE2NNHg6S5FX1q0xnJqv9pcjU5PMDKKZRS2OnbGbo8WNDuqdzeugZdXztZ6JMuaiI5DN
         oMqchqjLjziRUS+lBzCppHPbcAgRB0jYD3uWjDusqdAMNSNNmKBxBILRJH/owR31Scaw
         uftw==
X-Gm-Message-State: AOAM530HqOX93Z/piK1I0iGcovIoJNp2NeS1euuV3+oHGCI2PfOa3z8K
        mcsm/B5VuSyr0hrS/4ZOyeU=
X-Google-Smtp-Source: ABdhPJweuW5z5eu2VjtEooGH/3nczS+igDkKrvIc6alNaQ0j8cRGUn88XlXSTEeXk7AWD/OKkseT9Q==
X-Received: by 2002:a17:906:bc97:: with SMTP id lv23mr23155487ejb.154.1643752914767;
        Tue, 01 Feb 2022 14:01:54 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id r3sm15103499ejd.129.2022.02.01.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 14:01:54 -0800 (PST)
Date:   Tue, 1 Feb 2022 23:01:40 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/15] drivers: clk: qcom: gcc-ipq806x: add additional
 freq for sdc table
Message-ID: <YfmtxA7fCmbBWK0Z@Ansuel-xps.localdomain>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
 <20220121210340.32362-11-ansuelsmth@gmail.com>
 <20220125204555.91DB4C340E0@smtp.kernel.org>
 <61f065b9.1c69fb81.ed14d.b9e2@mx.google.com>
 <20220125221825.D9B78C340E0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125221825.D9B78C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:18:24PM -0800, Stephen Boyd wrote:
> Quoting Ansuel Smith (2022-01-25 13:03:52)
> > On Tue, Jan 25, 2022 at 12:45:53PM -0800, Stephen Boyd wrote:
> > > Quoting Ansuel Smith (2022-01-21 13:03:35)
> > > > Add additional freq supported for the sdc table.
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >  drivers/clk/qcom/gcc-ipq806x.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> > > > index 77bc3d94f580..dbd61e4844b0 100644
> > > > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > > > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > > > @@ -1292,6 +1292,7 @@ static const struct freq_tbl clk_tbl_sdc[] = {
> > > >         {  20210000, P_PLL8,  1, 1,  19 },
> > > >         {  24000000, P_PLL8,  4, 1,   4 },
> > > >         {  48000000, P_PLL8,  4, 1,   2 },
> > > > +       {  52000000, P_PLL8,  1, 2,  15 }, /* 51.2 Mhz */
> > > 
> > > Why the comment and fake rate? Can it be 51200000 instead and drop the
> > > comment?
> > 
> > I will add the related reason in the commit.
> > 
> > We cannot achieve exact 52Mhz(jitter free) clock using PLL8.
> > As per the MND calculator the closest possible jitter free clock
> > using PLL8 is 51.2Mhz. This patch adds the values, which will provide
> > jitter free 51.2Mhz when the requested frequency is 52mhz.
> 
> Sounds like this clk should use the round down clk_ops instead of the
> round up ones. Then the actual frequency can be in the table.

Some hint on how to do that? This use the rcg generic ops that doesn't
use any round. Should I crate some special ops in the rcg driver to
implement the round ops?

-- 
	Ansuel
