Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EF457D3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiGUTJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiGUTJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:09:47 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294C28810A;
        Thu, 21 Jul 2022 12:09:47 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id p81so2098612iod.2;
        Thu, 21 Jul 2022 12:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQFrxHeJdzvANrllAmKTlhCi9vN8C5VKpFJVCaVkLFs=;
        b=VWPiNLSn0Aa9VueuUFNp3wyNc40LbraMgH72mBQvRqEfy9/IxjAmprJ9KzwCiF5VD6
         v+NZNGjBSrQy+2tAE3Oxp0bnBVTfpWkr1hu6a5/zZjm2uVOln0D8DdhgldLzUC7g/rCp
         WFhQIq6XujMQWvmbSA2ImH8FmKSi9Y+X+REwh9394TsW234yCcL1xUxOaeWT7PuUFoMm
         FrchU8o6CoLijpSZo1MQPMeKaTyqbK5dGFFuC6lIBsTIyYv3GIx+d2lP1ez9qUEigydu
         /qNBgB/jXeBQsQb5+RkeotEEVdgztyB+nqxbWQtbFkMf97hfA3f/aIQjQyfukpT+Cido
         cx7Q==
X-Gm-Message-State: AJIora95FXC8cO8jG9pA+MObvO0hPf3uWbkMGFx2/WL2l3uoFuc0xHW9
        SWLES00xQJcxZYCrl+Z1tl1/WWYk3A==
X-Google-Smtp-Source: AGRyM1u7fzVuv/Kt9k58mUx+0yDPia+vIuP9OYCu9LHllLtFNlhXxaPyN6CZT32rGhwqGmpJvoNGGg==
X-Received: by 2002:a6b:fe05:0:b0:67b:ec2a:8138 with SMTP id x5-20020a6bfe05000000b0067bec2a8138mr13302755ioh.185.1658430586339;
        Thu, 21 Jul 2022 12:09:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c27-20020a023b1b000000b0033f86542abfsm1119995jaa.37.2022.07.21.12.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:09:45 -0700 (PDT)
Received: (nullmailer pid 1763155 invoked by uid 1000);
        Thu, 21 Jul 2022 19:09:44 -0000
Date:   Thu, 21 Jul 2022 13:09:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: stm32-timers: Move fixed string node
 names under 'properties'
Message-ID: <20220721190944.GA1759974-robh@kernel.org>
References: <20220706211934.567432-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706211934.567432-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:19:33PM -0600, Rob Herring wrote:
> Fixed string node names should be under 'properties' rather than
> 'patternProperties'. Additionally, without beginning and end of line
> anchors, any prefix or suffix is allowed on the specified node name.
> 
> Move the stm32 timers 'counter' and 'timer' nodes to the 'properties'
> section.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/st,stm32-lptimer.yaml        | 28 +++++++++----------
>  .../bindings/mfd/st,stm32-timers.yaml         | 20 ++++++-------
>  2 files changed, 24 insertions(+), 24 deletions(-)

Lee, going to pick this one up?

Rob
