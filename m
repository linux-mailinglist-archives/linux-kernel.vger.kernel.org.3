Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774E652ACDC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbiEQUjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiEQUi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:38:57 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E99427C1;
        Tue, 17 May 2022 13:38:56 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id w123so269518oiw.5;
        Tue, 17 May 2022 13:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=76acAsy+SpmXuXdcwFP1XutJCmMfZGECecrBN17zFW8=;
        b=JTOw18T/KXwOzdgJWxFAsnQ2MuVsXxgyARK3WI2XfK8+i1ihAz+97jLb+vsbVPBE+F
         wtJB0iTqYhGJZMZpU1ZUb/nGOI4yHFWmJk3VLmbQJMlGxnOhwQF+ZNJ+W/cqMcnkraj6
         4Fxnfkyy8jPPkavs9B5HmaSATfk7RlPam0n9nzWGm7ueptiZLtvBFZNHoOzOT6pZlPeA
         KbZDQh0AcoWSXqpwl+0lXlV+iqHmu9Iseny0LY9Mwi4CzWIWORVHAc6LtjCShJcgUrCe
         QKImrz9hQq5EcLMPJpVEAdhFzp3f8HDMIwHCOEh4VIkF0GCsiSLlJn/XfY1uytIxIkR5
         g64w==
X-Gm-Message-State: AOAM5300/NGrh0GTkZocY71CKNy8OnlzzKZT1hmlNyT9zd24s370HWRK
        LShEBDRBjZ0kiXEYrKERdw==
X-Google-Smtp-Source: ABdhPJxlSCs3AI+SN/yRG4xckkFiyuJMzASwJux1bkbcf5hDQi5L76hWTxDrOghHmhidJsbaJkhsUw==
X-Received: by 2002:a05:6808:114d:b0:328:aaa2:10c9 with SMTP id u13-20020a056808114d00b00328aaa210c9mr11583137oiu.217.1652819936072;
        Tue, 17 May 2022 13:38:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r5-20020a9d5cc5000000b006060322124bsm160989oti.27.2022.05.17.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:38:55 -0700 (PDT)
Received: (nullmailer pid 1597094 invoked by uid 1000);
        Tue, 17 May 2022 20:38:54 -0000
Date:   Tue, 17 May 2022 15:38:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/4] media: dt-bindings: qcom,sdm660-camss: document
 interconnects
Message-ID: <20220517203854.GA1597034-robh@kernel.org>
References: <20220509144714.144154-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509144714.144154-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 09 May 2022 16:47:11 +0200, Krzysztof Kozlowski wrote:
> Document the interconnect properties used in the Qualcomm CAMSS on
> SDM660:
> 
>   sdm630-sony-xperia-nile-discovery.dtb: camss@ca00000: 'interconnect-names', 'interconnects' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,sdm660-camss.yaml       | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
