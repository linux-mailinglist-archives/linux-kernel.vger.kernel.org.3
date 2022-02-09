Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83C4AE72E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbiBICnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244587AbiBICMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:12:23 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73025C06157B;
        Tue,  8 Feb 2022 18:12:22 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id i5so1108798oih.1;
        Tue, 08 Feb 2022 18:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nlmUCfg/TsNV+SiNylr1xm+pWvvvGFxxsoKbQjaTYNU=;
        b=m0e5PRnh58J5Af0AR6L0lkYpKeuQD0+H22SXBCd71QqJ0JoNAxCZWFf/Tm7aI580iy
         nFn024ZwEJ7VI9yPTuQOxtXclsco2Hae5LeKLuCyjRFF0AnW3GCIoW+D+mEWxI4hqh5/
         g0FvH+Qb5RrPg+jaHd6tTEzKaDk3s8Yo4H3aSfU0heOm7kHqSFRqVlvi6YZao9WlLP0F
         dyE3hp0fQjwu5LtDBhfZ7zKr3pkNxnUCS/Z7F0Mmqp04mW2HqS+I0VaA4KREFms6z2Fa
         ar1aa2BOxUW8vydkLVmN1PdWJ4DJqRoFSCqWqESCsSlAveiWKoa3iDgYoTthQ7TlmAnj
         N4ng==
X-Gm-Message-State: AOAM532jNQk+2DPeMzqT7RFS2D+U66yZGwCmYdt4fqLk1yNdrf01qoON
        mBFoEoPyvd3rMHd9+csiSg==
X-Google-Smtp-Source: ABdhPJyQadfsR8b5L9kSrJzsSfTAFNbfrREPCRLJXA8FAibeYAOpDQGIopnrrdoELusgTvFyYC2Ang==
X-Received: by 2002:a05:6808:1897:: with SMTP id bi23mr395136oib.66.1644372741785;
        Tue, 08 Feb 2022 18:12:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a32sm6081715oaf.17.2022.02.08.18.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:12:21 -0800 (PST)
Received: (nullmailer pid 3464864 invoked by uid 1000);
        Wed, 09 Feb 2022 02:12:20 -0000
Date:   Tue, 8 Feb 2022 20:12:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 03/15] dt-bindings: mfd: qcom,tcsr: Document msm8953
 compatible
Message-ID: <YgMjBJ1fm63/x6p7@robh.at.kernel.org>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-4-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-4-luca@z3ntu.xyz>
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

On Wed, 12 Jan 2022 20:40:52 +0100, Luca Weiss wrote:
> Document the compatible for tcsr found in msm8953.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
