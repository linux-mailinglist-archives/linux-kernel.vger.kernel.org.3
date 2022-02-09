Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37F44AE6BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbiBICki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiBICNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:13:22 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8318EC06157B;
        Tue,  8 Feb 2022 18:13:22 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id p3-20020a0568301d4300b005a7a702f921so545110oth.9;
        Tue, 08 Feb 2022 18:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K0p54TUxYjtgjJ8K6aiAZ7box7N0Ff3t+YQASKAN+Sg=;
        b=c7H50vEBg9omjcxztWZ9rXhE/ogHQOR53u1xc4+trWm5MxGSbkMWYgub3HfL3T12FO
         IS6a9Kk6+B2dF3+fS1z14L8GCtKRf20qhcXzzyd1Ah82xCdwlLtp3YINBvgHBJTuXeGT
         E3BnDHs3RCO2FyVz2RfjEnY7x6oMkdt5xv2yZJQRNTI3/FwUz8LpS2k2K4078o1hpcD0
         xZSTAIZwbkRY5NKSc4XF/1/+LeQuUYNJpn6xjUyolnlwtgNU+wGU+/PzB7BJGCQLK4y+
         XhQaUzhN7abFY0dyMc6myTnppg7kXTbINY5cAWc0JWUSvonyoFwLL7VL/0ZO/Aqjlu8G
         LP2w==
X-Gm-Message-State: AOAM530BGLBLefNuaSPerUTcmO7wriyn8cktmMk6InItDjOf4ptNfkai
        MAS2BLzuVnhZhGI6xi1lgQ==
X-Google-Smtp-Source: ABdhPJzFqeh83AG6MbHipWskwLxsnT59BcS9u7lW1olMaD5rTgCkZdBxf8TXwg86UhHDg0YfpH2plw==
X-Received: by 2002:a05:6830:1dc5:: with SMTP id a5mr90463otj.147.1644372801842;
        Tue, 08 Feb 2022 18:13:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g20sm6281491oiy.34.2022.02.08.18.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:13:21 -0800 (PST)
Received: (nullmailer pid 3466385 invoked by uid 1000);
        Wed, 09 Feb 2022 02:13:20 -0000
Date:   Tue, 8 Feb 2022 20:13:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 06/15] dt-bindings: thermal: tsens: Add msm8953 compatible
Message-ID: <YgMjQHZRy7zgoRe8@robh.at.kernel.org>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-7-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-7-luca@z3ntu.xyz>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 20:40:55 +0100, Luca Weiss wrote:
> Document the compatible string for tsens found in msm8953.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
