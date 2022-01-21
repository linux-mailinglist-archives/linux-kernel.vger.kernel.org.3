Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D093F495814
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 03:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378351AbiAUCBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 21:01:52 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:40656 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbiAUCBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:01:51 -0500
Received: by mail-oi1-f173.google.com with SMTP id bx18so11614729oib.7;
        Thu, 20 Jan 2022 18:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HeEiFX5iFoio4nel8fZga7YdC7oehYZwW46XNPuEjy0=;
        b=FyRRMZfNxyixuUC3MKm8KPQcbMBvuRX91NpeQKtjIXtNCYgFDAVG+TAcZx1tZQdeWa
         TZUJc9daL3oSifA7n9Y5uXO06WyPtz5eHhqJojC13Wzj2sqjcyHQ4xYOIOe4USwx9IDF
         Jl6eCjCCbXs7OzZCoslYtfCdnjeoP5UvHftQro2afWSiVG2c/xHgP82I+etyaQNnV/kD
         UUEkvU5qzi2QhLrWeh4aa1lD19dZLqJzL6yw7Vt86Yzy4XpyWLmo/ohebbqB2ECpo4Di
         nzTUjuGspdZ3BIhLzae8uYq7g/Fx9fGsysElKxvSlGbayohzV3+YYhhWrlYmO6LhHTuC
         G2ag==
X-Gm-Message-State: AOAM532/WGfbToZXO97jNoBDqhqSXLVaLEmnj0bixcwYSJpFapkR5hlT
        tf5X+dzeY9/aSM0gpVWnKg==
X-Google-Smtp-Source: ABdhPJxHQdK7BrDp7vMRO0UqMJiFXtBHc8MMtuRP+WAP99y2VnzkxwapFXfClK0GdtuVPcR6JxFdJA==
X-Received: by 2002:aca:abc1:: with SMTP id u184mr1449149oie.109.1642730511044;
        Thu, 20 Jan 2022 18:01:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o7sm433637otj.5.2022.01.20.18.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 18:01:50 -0800 (PST)
Received: (nullmailer pid 2348904 invoked by uid 1000);
        Fri, 21 Jan 2022 02:01:49 -0000
Date:   Thu, 20 Jan 2022 20:01:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 02/15] dt-bindings: clock: simplify qcom,gcc-apq8064
 Documentation
Message-ID: <YeoUDdDCIFtRik2K@robh.at.kernel.org>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
 <20220120232028.6738-3-ansuelsmth@gmail.com>
 <1642729058.530862.2314864.nullmailer@robh.at.kernel.org>
 <61ea0f73.1c69fb81.44cb7.5093@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ea0f73.1c69fb81.44cb7.5093@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 02:41:59AM +0100, Ansuel Smith wrote:
> On Thu, Jan 20, 2022 at 07:37:38PM -0600, Rob Herring wrote:
> > On Fri, 21 Jan 2022 00:20:15 +0100, Ansuel Smith wrote:
> > > Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc.yaml as a
> > > template.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../bindings/clock/qcom,gcc-apq8064.yaml      | 27 +++----------------
> > >  1 file changed, 3 insertions(+), 24 deletions(-)
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.example.dt.yaml:0:0: /example-0/clock-controller@900000: failed to match any schema with compatible: ['qcom,gcc-apq8064']
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/patch/1582347
> > 
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> > 
> 
> Mhh, think these error comes from running the bot with the single change.
> Or the bot runs the test with the previous commits merged?

It should apply the whole series one by one. However, if patch 1 didn't 
apply it will still try the rest. It's only smart enough to apply to the 
last rc1. Given it's the merge window, I suspect you have dependency in the 
next rc1.

Rob
