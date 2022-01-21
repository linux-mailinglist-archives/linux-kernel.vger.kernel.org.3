Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE644957CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbiAUBhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:37:43 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38624 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiAUBhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:37:41 -0500
Received: by mail-oi1-f177.google.com with SMTP id g205so11559536oif.5;
        Thu, 20 Jan 2022 17:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lwx/3sI/jAgnGg6BbYNTq2g4K7zJzyk25fhYkr3exC0=;
        b=t8VFvFhmokBMq5hdyD47XrcVaaRq9Blc6EZwVd2Mckp3jhx+LodO6HWZSIQnrQq3wL
         3pewnyc7SdBo/iPhkNu3t33cF7eh34HUKLZF66ErQx7hLP0jC1ym2gvy7ao4dHa5ZrBC
         2/l/Zk6VMu0V3YTKydLL3TcWZW1soN0aAQZQD2haK55S/Vj9r1wTRaV8dmhg4msbE/dH
         V3O7/G/n3EQQjERTSCLG7BRJGXSeTTblICulS+cTuxw2jBzlCYdW/By32LirEiPk9+RM
         gzG5WASeOFl4VUoin7QlvrTtQOywTB5iFPR6E2LROy/LtRZHMrcHvAcH++TOJTeaHTtm
         Z2+g==
X-Gm-Message-State: AOAM5319yGRvILIv0c+R+pQE2qzqUcX/M+qdyP51Xf73ZZdYMuBM988u
        LqQoS+jGYeb/g8Y0lrzVsA==
X-Google-Smtp-Source: ABdhPJxw18vz18oJhNnQmNv3Pg97sN04HSdTjldQBZY7zJAkoFUNRxgJGeo1b/7bNUVA/HdTHKyzKw==
X-Received: by 2002:a05:6808:aa7:: with SMTP id r7mr1447327oij.47.1642729060372;
        Thu, 20 Jan 2022 17:37:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o21sm440941ote.4.2022.01.20.17.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 17:37:39 -0800 (PST)
Received: (nullmailer pid 2314865 invoked by uid 1000);
        Fri, 21 Jan 2022 01:37:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
In-Reply-To: <20220120232028.6738-3-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com> <20220120232028.6738-3-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 02/15] dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
Date:   Thu, 20 Jan 2022 19:37:38 -0600
Message-Id: <1642729058.530862.2314864.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 00:20:15 +0100, Ansuel Smith wrote:
> Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc.yaml as a
> template.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-apq8064.yaml      | 27 +++----------------
>  1 file changed, 3 insertions(+), 24 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.example.dt.yaml:0:0: /example-0/clock-controller@900000: failed to match any schema with compatible: ['qcom,gcc-apq8064']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1582347

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

