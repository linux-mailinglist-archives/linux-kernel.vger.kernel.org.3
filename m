Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829024E327D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 22:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiCUV5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 17:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiCUV5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 17:57:46 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571783DBBE0;
        Mon, 21 Mar 2022 14:52:37 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o64so17696888oib.7;
        Mon, 21 Mar 2022 14:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d+9QdUNzXb5pmLvt2FMBpD/un8EwCgivlwcq3BPgDKo=;
        b=RnEoMjswvMf7No6ztoAqjQIP5DHSXZFPMv4uQpSTy1HaragPfyrJ+hLyhRiyFJ7HZO
         jlwFjqMWv1oGS8HJPrnZKYHAxAJUn/6nCZaGt9Jpogk8T6vsvZZA6tRRS8VQ9N1hx3jP
         8ncHa7XpPl30No304N6PT1cUFoNWqHsHm1GsCNHx7jMeOOVllK3TRtUnKSl6FR5gexGa
         3r2+GciQhKW7OfgPDjk+XBrTHnnN1HaWHWwbcWuV7j2wTvYCu9fccZibitpEsYEl1Tel
         jy/ULD5BPAuntxUL+bodz5Jl/TsWEmU9htY6IIE/j5ZrDhZ36qgleE3MHaMNklAGQ14Y
         Vmsw==
X-Gm-Message-State: AOAM533qcPuEQ2+PiaSr69ZlG7ZVBVHLP47b/lhyBV9Ob4D09rVirux0
        AkMVeRzKGH0D895lff+U6A==
X-Google-Smtp-Source: ABdhPJwwkIJLLXC6SDoKJ/5qk6FVBsTjioiC2WdygGpaGTYJC+hAJyGx9eyECCh80HYH74LiKhdVbw==
X-Received: by 2002:aca:2b0d:0:b0:2d9:dc99:38a2 with SMTP id i13-20020aca2b0d000000b002d9dc9938a2mr587534oik.198.1647899205635;
        Mon, 21 Mar 2022 14:46:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a30-20020a4ad1de000000b00320fccd02cfsm7405810oos.5.2022.03.21.14.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 14:46:44 -0700 (PDT)
Received: (nullmailer pid 594751 invoked by uid 1000);
        Mon, 21 Mar 2022 21:46:43 -0000
Date:   Mon, 21 Mar 2022 16:46:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,qmp: Add SM6350 UFS PHY
 bindings
Message-ID: <YjjyQzGGPEgsKDwJ@robh.at.kernel.org>
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-3-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321133318.99406-3-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 14:33:14 +0100, Luca Weiss wrote:
> Document the compatible string for the UFS PHY found in SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes in v2:
> - add second hunk for clock validation
> 
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
