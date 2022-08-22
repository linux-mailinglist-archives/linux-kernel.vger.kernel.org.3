Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25C159C5B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiHVSDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiHVSDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:03:49 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF67F24973;
        Mon, 22 Aug 2022 11:03:45 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11cab7d7e0fso12669017fac.6;
        Mon, 22 Aug 2022 11:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=idMfuD2zEo0N/aCLaa/K6CPIPax9pS0RRcVWahbddWc=;
        b=sfO4vJQddGWn+Hj9P/BRLeKvmk+pfn5NzCtzadT4OI4BXUbTwG/KkWUIBCg3xKeE6F
         XQn3wvcOnRuU+SeHEzKwAiEJXl/gRaAk5WDGSUrgl6fj6rqjF7rzFN2xuLH4yel6ehgy
         IGWb7oEL1UBkcjh4XUGSuq9x1vLqso8zMrCbp61KftV391K3qxaoHKkP7wpi4wh24URQ
         /yKf+/oZGAhfmJw5OGfzEp7eMRdhq/en5CzJfzA0EREv0H2uz5nFDGwdHkbiYhcarCLs
         4WyMcu0KPBS46vlTX1TFDJ1QEcuryOzKTuFn9Creo/vtgFAihuCwEBqRQuHv9HtC/00D
         4K5g==
X-Gm-Message-State: ACgBeo3uehCn0U9GR8dPj30Fef622RDh+bFXyGDTbsec4X5gpR4OHnp5
        xxGEG0PtYVuI+BGRJd100w==
X-Google-Smtp-Source: AA6agR5caevdQJIpuUJcJU+vYIMa1d+PLa6CQycxD5ZLzoIdwyfUwyzCojtz+4jXMYTuGA6yKQlIqg==
X-Received: by 2002:a05:6870:51ca:b0:116:afaf:429e with SMTP id b10-20020a05687051ca00b00116afaf429emr12809362oaj.253.1661191424565;
        Mon, 22 Aug 2022 11:03:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l6-20020a9d4c06000000b0063911de9fd8sm1834997otf.24.2022.08.22.11.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:03:43 -0700 (PDT)
Received: (nullmailer pid 73977 invoked by uid 1000);
        Mon, 22 Aug 2022 18:03:42 -0000
Date:   Mon, 22 Aug 2022 13:03:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: memory-controllers: fsl,imx8m-ddrc:
 restrict opp-table to objects
Message-ID: <20220822180342.GA73903-robh@kernel.org>
References: <20220818061549.9087-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818061549.9087-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 09:15:49 +0300, Krzysztof Kozlowski wrote:
> Simple 'opp-table:true' accepts a boolean property as opp-table, so
> restrict it to object to properly enferce real OPP table nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> 
> ---
> 
> Changes since v2:
> 1. Correct typo in msg (Peng).
> 2. Add Ack.
> 
> Changes since v1:
> 1. Correct typo in subject.
> ---
>  .../devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!
