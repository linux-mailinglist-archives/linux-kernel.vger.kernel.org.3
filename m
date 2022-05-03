Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ADE517B43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 02:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiECAkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 20:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiECAkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 20:40:45 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32BA4D26C;
        Mon,  2 May 2022 17:37:09 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id m25so2921127oih.2;
        Mon, 02 May 2022 17:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPoGfUm6HdS/RdvyDE4eYbdws9jspTBGYeir1rydtWI=;
        b=A9TJ4JBeUXaqY3c1CO3CTAGFlCGj44sMrKZZbpkgnKkWWuWuLe7WzuuEjqV69qGR9r
         BKC0sY6Xs0O6wvycVkhfajCTVq8IQudPwMCXzluHZqQKiGr5HzFcH7PaDdkiN3S1oH1v
         zNOtx7/iLP8Wv1pz3mw69uN8l4ddGwHJR2p+e/CsYanwofqbncdWMVIMpKdg/x+2ZLBl
         gtY+ptHYsS/txx2k7pRgvw9gh9BqJJ/ftoydNu9bTeKcO/Sd+91nqZiOcCYxEGh41005
         aUwpalXYm0YCrapYuisbCP/QaJo5Xnqqug2zJ83SsqwLLL9AXdyhM2b7+wieQS4TxmAz
         Ym5g==
X-Gm-Message-State: AOAM5301DSzukuyLe79dJi+AZKgWWpwHfByjoGa69jXZqBhjDAHmi6D2
        saPowshxHMmAUSlp4evKJw==
X-Google-Smtp-Source: ABdhPJw3ddsqRq6pulMnNx0Fn+HlUlJlRBvLqA0Dm6SigHDMb7V21SDoPfc90N/p+iaBz3w66JpvOA==
X-Received: by 2002:a05:6808:3083:b0:325:f167:415f with SMTP id bl3-20020a056808308300b00325f167415fmr846706oib.160.1651538096054;
        Mon, 02 May 2022 17:34:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ay7-20020a056808300700b00325cda1ff8csm2864803oib.11.2022.05.02.17.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 17:34:55 -0700 (PDT)
Received: (nullmailer pid 2117695 invoked by uid 1000);
        Tue, 03 May 2022 00:34:54 -0000
Date:   Mon, 2 May 2022 19:34:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     kristo@kernel.org, amitk@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, vigneshr@ti.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Message-ID: <YnB4rtn87l5nXtRM@robh.at.kernel.org>
References: <20220427064635.24898-1-j-keerthy@ti.com>
 <20220427064635.24898-2-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427064635.24898-2-j-keerthy@ti.com>
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

On Wed, 27 Apr 2022 12:16:32 +0530, Keerthy wrote:
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 J72XX supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../bindings/thermal/ti,j72xx-thermal.yaml    | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
