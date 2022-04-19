Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7235075C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiDSQ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347137AbiDSQur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:50:47 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F62E9CE;
        Tue, 19 Apr 2022 09:48:04 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e5e433d66dso6780058fac.5;
        Tue, 19 Apr 2022 09:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X+AXNMLWD2gr4sUawt8zM45zbI7Ji8fHi+fcM1ppF9I=;
        b=z2MPOkgQHCWqtQzrp32OVqVwA0hVbXVQ6TWfP5uv5gPCpc+lYDpjLRAHlClFxDDFvi
         EpFayrzAI5w7TSxOymWvjLWgx6vMzJO2BinCN4QdFojjRRTCLRj7GmT2wbhuc3gf2jsp
         OdspoCd9bVFwGDzWXtRkry6lBBfba8e9+Qg4d7zzDg2fVmGRgc9SfhEB7n7mwFpeU/yf
         c75BeOnQxqQcPYKZPasQNvqDnPePdG4wwu1StU8gAxSwxrH5kZjeKPMKsZPcdWnr1rdz
         mte/Xd4+ufdgeshL1BujSIaKvQkbbLGdscinvgUfZbXH3ff0aUbbxo+t2dndtvNMZnd4
         Aa7Q==
X-Gm-Message-State: AOAM532/M9IxqkKyN9DKGFGwVs1aaezLcInJmtxUUIkc9baWuuuLWBuE
        lrcuoiy6PoiJCtRNE3QePRkNIXLv6Q==
X-Google-Smtp-Source: ABdhPJz+3g6+lO0qye+IXcUEdQNPhIlO6UqTYDf3G8PQ0F8bwlBj/dLVjj64lf/Bz8frYomFDttRkA==
X-Received: by 2002:a05:6871:b27:b0:e5:ee1a:2188 with SMTP id fq39-20020a0568710b2700b000e5ee1a2188mr4841471oab.109.1650386883998;
        Tue, 19 Apr 2022 09:48:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x24-20020a056870a79800b000e2e53716fbsm5534368oao.31.2022.04.19.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:48:03 -0700 (PDT)
Received: (nullmailer pid 2939567 invoked by uid 1000);
        Tue, 19 Apr 2022 16:48:02 -0000
Date:   Tue, 19 Apr 2022 11:48:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: opp: accept array of frequencies
Message-ID: <Yl7nwvTN2JyinAyd@robh.at.kernel.org>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411154347.491396-3-krzysztof.kozlowski@linaro.org>
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

On Mon, 11 Apr 2022 17:43:43 +0200, Krzysztof Kozlowski wrote:
> Devices might need to control several clocks when scaling the frequency
> and voltage.  Allow passing array of clock frequencies, similarly to the
> voltages.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
