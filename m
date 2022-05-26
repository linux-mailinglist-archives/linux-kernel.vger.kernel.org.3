Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E7535052
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbiEZOBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243057AbiEZOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:01:44 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE729C94;
        Thu, 26 May 2022 07:01:43 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-f2ccb58ee0so2305932fac.1;
        Thu, 26 May 2022 07:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=630+yzM+8ZRIJgGt1PX3q1U65CqKqFKTdKKAusXegFE=;
        b=rcjF+7aSZ/5BumB/dq1ImV9wrYA799LTdVGeunT712a+LFs2M/oFI09z9Aw+o0TzoZ
         9VQMnckDE8oUxR5YLDx/IIDb1WvmR6SxqlgwVMhbKR0ny8SRGG2z5IT7uDVYXu7pTrfp
         TkWznDfxtY/ExrjiTzZ/UZhrrw13QD+9fP8B9O58kmjVhvw0PDliJiGWvl30mwvHPFo8
         uy8GMqufk2sPuin3zynNsLEDLe6Cr3spxXMT83fGLMbwrEwbCEL/QDdMC/TQiACXM+JA
         4xYJFMvzq5FQnh5XU8jBBMRG3XDHGcdNNXA4gaG9eB1Ht3gDxYq0BOU8YKSJVmUab/Zs
         m86w==
X-Gm-Message-State: AOAM533TQsOwxUmqHp1SQRtrJa+fPzpYSaC1hHehPj7xPD/CaZUQgV/n
        yzsnfDnDkP+zBH1DREuSLw==
X-Google-Smtp-Source: ABdhPJy31ULAG1BKRj44Pgem6fGllcaudG8S/xoYaoxphrtX8KQ4nv2oag+sqs8aPxZF2nK8XvYt0g==
X-Received: by 2002:a05:6871:82c:b0:f2:bbc3:8e1a with SMTP id q44-20020a056871082c00b000f2bbc38e1amr1305312oap.66.1653573703045;
        Thu, 26 May 2022 07:01:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j6-20020a056830270600b0060b0c9e7ff1sm621876otu.47.2022.05.26.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:01:42 -0700 (PDT)
Received: (nullmailer pid 3918964 invoked by uid 1000);
        Thu, 26 May 2022 14:01:41 -0000
Date:   Thu, 26 May 2022 09:01:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: Fix unevaluatedProperties warnings in
 examples
Message-ID: <20220526140141.GB3831942-robh@kernel.org>
References: <20220526014141.2872567-1-robh@kernel.org>
 <13a92f37-2491-9daa-05a7-f831d9bbb0e0@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13a92f37-2491-9daa-05a7-f831d9bbb0e0@microchip.com>
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

On Thu, May 26, 2022 at 06:52:23AM +0000, Conor.Dooley@microchip.com wrote:
> On 26/05/2022 02:41, Rob Herring wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > The 'unevaluatedProperties' schema checks is not fully working and doesn't
> > catch some cases where there's a $ref to another schema. A fix is pending,
> > but results in new warnings in examples.
> > 
> > 'spi-max-frequency' is supposed to be a per SPI peripheral device property,
> > not a SPI controller property, so drop it.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> As this property is in the mpfs devicetree & I'll need to fix it, is this
> patch targeted at 5.19? (I assume given the window is open and there's no
> fixes tag that it isn't).

5.18 ideally because warnings are going to appear when I push the 
dtschema fix for 'unevaluatedProperties'.

Rob
