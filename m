Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301C64C30C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiBXQCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiBXQCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:02:12 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3CC193DE;
        Thu, 24 Feb 2022 08:01:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id x15so352553wrg.8;
        Thu, 24 Feb 2022 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y05yvb52Nsp11oYlXTQ2W1T0axwKZmDa9In+lb+g4zo=;
        b=GnV/17WEDbgkTXw5Szy0hHTJZKC90jXe/+zj3SQueTq7TBeyrs/8twssH/6UgvEWGu
         pPgsabBuHeUszXbWvLXy/atvo+h9H0fC5fwuRWN62mYXf2UQfXT6VW3H4PLtmrjQGRSc
         mAvEnyt2IQe7TWSx+uEwkT1FSFXGo+rvonqUhxnXQ7YK/ZBFeaOHR6pE+Bztb17HMaTY
         33eY9IDdWby1GJpfZDib5RhuFyoG7lAiRK7+OsCBHiGr5ULBD5HHm+kw7qYUn9f5XhRx
         5iCMR9Fu3kUjdY3/vnGgrvMpr+h2eP2jLs0UZhY79trzcbqYp3NLACDL19mS0FIvKWDa
         8Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y05yvb52Nsp11oYlXTQ2W1T0axwKZmDa9In+lb+g4zo=;
        b=RoHFnikPONWlKmrINVZx1RZO+XhP/AFViV5Sn/tjofukfSSnFUs6CIfF2oVg7c9VY+
         Jkp148Sjb1hwQtzFCSY6DxtHCYJqGCC5GtuemQNhm+OhJ+SY6E+e9WVogQWeZSwyrhsg
         77zIB9xrj6OrXJ+a7APyK0GdZuz9Dy25rm6wKtuHefLXo8gVg98FLdUVkfspeyb0Trub
         asxWDkMaI9ecweAXlhZC89YTebPksJOX0aFV/QeotdnU0CUt9CPC68Nz02gXuZC9mKRG
         fZsYU7RIIMyukY/jrutIkxqWQpbdaCz9B+3NjfWVUWzCZaYPl/by0hhCPOWwF8zS+aHq
         y4wg==
X-Gm-Message-State: AOAM532CDcNgdn7gUQ+FFMd57IMnJKCcHhXL/ClVdtFslR3gwElnH/Do
        WLOBkKF8jQlhQDAMzTQye3o=
X-Google-Smtp-Source: ABdhPJwbEWyLUPKgPfJM8rbkKwDuyxaneNxCj7/Lstjc1QdxMEN0ykJ1Lu83MJZHWz7N7SoUgv2+Yw==
X-Received: by 2002:a05:6000:8f:b0:1ed:bb0e:6cbe with SMTP id m15-20020a056000008f00b001edbb0e6cbemr2769902wrx.209.1645718491173;
        Thu, 24 Feb 2022 08:01:31 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.gmail.com with ESMTPSA id d13sm3704964wri.38.2022.02.24.08.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:01:30 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:01:27 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/16] dt-bindings: clock: add ipq8064 ce5 clk define
Message-ID: <Yher1ybYkFCVLLVt@Ansuel-xps.localdomain>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-13-ansuelsmth@gmail.com>
 <YhcDCnMFRppk3Mo+@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhcDCnMFRppk3Mo+@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:01:14PM -0600, Bjorn Andersson wrote:
> On Thu 17 Feb 17:56 CST 2022, Ansuel Smith wrote:
> 
> > Add ipq8064 ce5 clk define needed for CryptoEngine in gcc driver.
> > 
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  include/dt-bindings/clock/qcom,gcc-ipq806x.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/dt-bindings/clock/qcom,gcc-ipq806x.h b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> > index 7deec14a6dee..02262d2ac899 100644
> > --- a/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> > +++ b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
> > @@ -240,7 +240,7 @@
> >  #define PLL14					232
> >  #define PLL14_VOTE				233
> >  #define PLL18					234
> > -#define CE5_SRC					235
> > +#define CE5_A_CLK				235
> >  #define CE5_H_CLK				236
> >  #define CE5_CORE_CLK				237
> >  #define CE3_SLEEP_CLK				238
> > @@ -283,5 +283,8 @@
> >  #define EBI2_AON_CLK				281
> >  #define NSSTCM_CLK_SRC				282
> >  #define NSSTCM_CLK				283
> 
> You don't like 284?
> 
> Regards,
> Bjorn
>

In the QSDK 284 is used for a virtual clk used to scale the NSS core.
I skipped that in case we will implement it and to keep these header
similar across QSDK and linux.

> > +#define CE5_A_CLK_SRC				285
> > +#define CE5_H_CLK_SRC				286
> > +#define CE5_CORE_CLK_SRC			287
> >  
> >  #endif
> > -- 
> > 2.34.1
> > 

-- 
	Ansuel
