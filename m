Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28854BCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbiFNVXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiFNVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:23:13 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1964F446;
        Tue, 14 Jun 2022 14:23:13 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id a10so10775094ioe.9;
        Tue, 14 Jun 2022 14:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QF/c/sbDpid9lKfsX1+PEgNc47kEnqD9odpDPZ9e32s=;
        b=nLjLLrprGAaf9xxUkBhVOy1ab4K7L3I127x/FFobPafai4Jf/RCq0CSaVVVJl/0a9Z
         aOsK/yEmdd3gvlrenElX8yIf2CVPfi/61RzmoYaKjH+rPF1W0a8rFH91CA55eTlWIUfm
         sqsdCdHUylctMBm/RtU66JEcvg1c2OnszIOm5dvfOfconoKRL8wHgK0hWWW28Ba8Yb7O
         70DjBCLBTwcrMJ2bDvFwqoCjyLImD972mB81t5ZOOE5mCqS1ORRdkKOQV3VLyZQ044ub
         +s5VeTDmcr8LtAnU3BBlp/Puklrg09RgsNhVnYgqSLHyIkotPWXpwRIPJLimnbHErMMK
         S+/A==
X-Gm-Message-State: AOAM5315uXo8/2Op5Lge6JH4jT+Mw+75zHI3lMly4ShvkhbQnN9Ckeqs
        AXDvHc9dLwwzYUrKujeX7w==
X-Google-Smtp-Source: ABdhPJzP/eILta8F3QwsxavVLr3IVNQONV+nMlaVrd/nNntBN49IzxH0J2nEHNnQOwSQ0Ha7Fsb9SA==
X-Received: by 2002:a05:6602:29d0:b0:669:1723:c249 with SMTP id z16-20020a05660229d000b006691723c249mr3524181ioq.208.1655241792474;
        Tue, 14 Jun 2022 14:23:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p15-20020a92d68f000000b002cf28d7ad23sm5924544iln.51.2022.06.14.14.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:23:12 -0700 (PDT)
Received: (nullmailer pid 2652997 invoked by uid 1000);
        Tue, 14 Jun 2022 21:23:09 -0000
Date:   Tue, 14 Jun 2022 15:23:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     fancer.lancer@gmail.com, alcooperx@gmail.com,
        devicetree@vger.kernel.org, p.yadav@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, samuel@sholland.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, yamada.masahiro@socionext.com,
        broonie@kernel.org, piotrs@cadence.com,
        suravee.suthikulpanit@amd.com, arnd@arndb.de, blarson@amd.com,
        thomas.lendacky@amd.com, adrian.hunter@intel.com,
        linux-arm-kernel@lists.infradead.org, brijeshkumar.singh@amd.com,
        rdunlap@infradead.org, will@kernel.org, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de, ulf.hansson@linaro.org,
        catalin.marinas@arm.com, gerg@linux-m68k.org, krzk@kernel.org,
        gsomlo@gmail.com
Subject: Re: [PATCH v5 03/15] dt-bindings: spi: cdns: Add compatible for AMD
 Pensando Elba SoC
Message-ID: <20220614212309.GA2652759-robh@kernel.org>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-4-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613195658.5607-4-brad@pensando.io>
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

On Mon, 13 Jun 2022 12:56:46 -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Document the cadence qspi controller compatible for AMD Pensando
> Elba SoC boards.  The Elba qspi fifo size is 1024.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
