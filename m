Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604A54957DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348338AbiAUBmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiAUBmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:42:14 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1762DC061574;
        Thu, 20 Jan 2022 17:42:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so18438105wmb.5;
        Thu, 20 Jan 2022 17:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=U25YZWIahU0TlivxPhX7fypYdif1ZsngEfiwlfENvXw=;
        b=Q1bUMv4Swxs3gE7JkCAbHq/CMnNSSFTme/vjdh+UdrDKXnXGlEGsy1WvopjEuXaoH1
         Tp9POVUU9eo/RiOlNfDO4RRin6dImCSgUKqo8RznoRc/ZmRJsm7wGz+EmZQbiOMnssRX
         oSwZJM3UjKI5haPIXihJ8HYswKTTlQ+HfIm6TXy+PskOaaJaesYSrmrmbYj5Cx/74Nf/
         Fbr2nsFaAIv2Gi6+WWlAO5q1e32aYkI1qAbF7LLbqmn4RBynTKZKF6hoyTJRNsLFv5DV
         Wiy7YjUUyC4n+A4WKMSDfC6KtOY3T8gkFxl8BEkaVwjYhukf52w2GxtWnwcSkEkzVsrA
         RbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=U25YZWIahU0TlivxPhX7fypYdif1ZsngEfiwlfENvXw=;
        b=QsbTRHWvkROIpGUTfuJrbS8UsxRs9xYobfdyRpMoXKFXe2vVQsIZQIqGxTsHBv7pcJ
         UafxP2DUuhb+9LrF6csOGgnFYbr0QfXsIm2TdpLLW4bkHklrOlgJK6TREf6dhEfqdZ1A
         hDFfd2/mWk05j8P38vXzGEONSX43PKnQ8YKywnaymu8AKrglyulbsB2vi1zMNtDNZs1Q
         DJ2qRumsyLYA1333YlbyknjUlhJe1bT/r9dHM+2Kku615UjP4SsDvMRPz4jJ8NDC3vUn
         MqLIOeOic8oM82S8SHaiCYFW052Dm/+B8SzUy9JT1d0pOA7/LKo+bbgCdwE0antgEPaw
         VXHQ==
X-Gm-Message-State: AOAM530oftjGtoPZOtAYYRJc5yQzi402ym9mk7hwurCPWo4VdEMqA275
        5xj8PGWXgDVAPY0kD+575ZyZcnz+d+Y=
X-Google-Smtp-Source: ABdhPJyPp+fQaI0+suIrZNd2DB3awxWMrv1Vbx9O3lG28p+M0vGPIdwOIhsP1RDZCYRS+PeN2REckg==
X-Received: by 2002:a05:600c:2289:: with SMTP id 9mr10852081wmf.104.1642729332322;
        Thu, 20 Jan 2022 17:42:12 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id 1sm1271433wry.88.2022.01.20.17.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 17:42:11 -0800 (PST)
Message-ID: <61ea0f73.1c69fb81.44cb7.5093@mx.google.com>
X-Google-Original-Message-ID: <YeoPZ4yT7mqLEGuL@Ansuel-xps.>
Date:   Fri, 21 Jan 2022 02:41:59 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 02/15] dt-bindings: clock: simplify qcom,gcc-apq8064
 Documentation
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
 <20220120232028.6738-3-ansuelsmth@gmail.com>
 <1642729058.530862.2314864.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642729058.530862.2314864.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 07:37:38PM -0600, Rob Herring wrote:
> On Fri, 21 Jan 2022 00:20:15 +0100, Ansuel Smith wrote:
> > Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc.yaml as a
> > template.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/clock/qcom,gcc-apq8064.yaml      | 27 +++----------------
> >  1 file changed, 3 insertions(+), 24 deletions(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.example.dt.yaml:0:0: /example-0/clock-controller@900000: failed to match any schema with compatible: ['qcom,gcc-apq8064']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1582347
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Mhh, think these error comes from running the bot with the single change.
Or the bot runs the test with the previous commits merged?

I don't have these errors on my system with make dt_binding_check.

-- 
	Ansuel
