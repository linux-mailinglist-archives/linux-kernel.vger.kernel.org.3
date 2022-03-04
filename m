Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432224CE0C5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiCDXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiCDXNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:13:32 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C275E0AF;
        Fri,  4 Mar 2022 15:12:43 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id l25so9368172oic.13;
        Fri, 04 Mar 2022 15:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVWbDqpK6bOdzGo2h0qtWE+fgf4PwelKmZTMZdMDaZ0=;
        b=fEdj2ho0HTfVmwb6ikxcEh9FQXfnI4SMJ+2iiPxAfCKBbPhMehzGxDP2V0nHK8hQsJ
         wnb8M5KkvWVPZn8K+dcZqbfnwjA6pXT2L46MmLaT231svEw6OVjHd5xMtPyyB7mAbeL6
         wMU915nOBRe74Miq209nrfBjOu3GDN8qt1jWro/aT1969D7EYzsImPMYlE37i7iYelHJ
         qW5JzpZFA9bfLmuG4p5W91CbvkhoANTGq1Fsfhz4TRdY9jDnw1Hus2ocq7L6eBit5WZa
         0W0IvmVzItMQHGhg/ItqNCQzqxfXt78es9zIGKTMPE/7zm9nAI6MSQCFI1f53gL3mTAZ
         z3Kw==
X-Gm-Message-State: AOAM530vZIlIuXIRsVY3xkeywT0dTSK4Qy5Pjs6PbCoF+v4vFprfVRLb
        aQkWzf5j9RJ5IcvlADXKGvRhHcYYdA==
X-Google-Smtp-Source: ABdhPJzBGD3S4vU8ZCKqlhfZLNdTutmb70tW40mVotqvoPSlg1sjO3pVV1WVraWzwiGw/TjOnMbAiw==
X-Received: by 2002:a05:6808:2393:b0:2d9:a01a:487b with SMTP id bp19-20020a056808239300b002d9a01a487bmr994342oib.198.1646435562446;
        Fri, 04 Mar 2022 15:12:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l15-20020a0568302b0f00b005b0285d2434sm144236otv.40.2022.03.04.15.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:12:41 -0800 (PST)
Received: (nullmailer pid 638646 invoked by uid 1000);
        Fri, 04 Mar 2022 23:12:40 -0000
Date:   Fri, 4 Mar 2022 17:12:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v6 02/15] dt-bindings: clock: simplify qcom,gcc-apq8064
 Documentation
Message-ID: <YiKc6Ho9D1VLiOqB@robh.at.kernel.org>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
 <20220226135235.10051-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226135235.10051-3-ansuelsmth@gmail.com>
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

On Sat, 26 Feb 2022 14:52:22 +0100, Ansuel Smith wrote:
> Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc.yaml as a
> template and remove the compatible from qcom,gcc.yaml
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-apq8064.yaml      | 29 +++++--------------
>  .../bindings/clock/qcom,gcc-other.yaml        |  3 --
>  2 files changed, 7 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
