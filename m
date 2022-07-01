Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F1563B63
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiGAUyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiGAUyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:54:49 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E3D6758A;
        Fri,  1 Jul 2022 13:54:47 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id w10so2132063ilj.4;
        Fri, 01 Jul 2022 13:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HrTG0yud13UmQCFPBZCzpXGEK9vy1R8RoOTRKyUValo=;
        b=hsZ38frC9/v4kyCR0xX5oPjxfvz0ZzBnppjpnuvsi+zbkyfQGoNo4CVN04ihBBAppP
         PwktEFyKiqUos25gq+yhTO/XozNyW9NbY+CzqB4EBv8XR0MOAgO8d8SSNTZqlBl25xK6
         HyVaSN9XQ1XbuNQqG20kz8B9hmhoTDhdOZCvXg1WlEPoT1JiNyRDHOC3P7I7ZAo8QkP7
         uvSZyzkWpbZ7QARQQzM7dD9nkyitNTFR3GUnllstwDZvwnJwbtv0S6BooB7ayJxOsd61
         SBP5JNXIGqnBYjQpUf+bA+g2DCcdLZRWRnO2XPVPy95elzPGM0tzCn2jr1JRcXPp5U7a
         p5Wg==
X-Gm-Message-State: AJIora+cBi3gRIYCkPsOTTirL0NBsDlXa7t1r+M0vsGNRcybptP8M4i6
        sKP8y29UOsKJsFdIRNeMwA==
X-Google-Smtp-Source: AGRyM1tN03ajV9JtjOBB9YmRsmAfhh0DZ3pRb8uoazawRe++MW5uDTrgKNun8JIBUIZsI2Usu7M1NQ==
X-Received: by 2002:a92:ddd1:0:b0:2d5:4877:65c8 with SMTP id d17-20020a92ddd1000000b002d5487765c8mr9847783ilr.267.1656708886842;
        Fri, 01 Jul 2022 13:54:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f65-20020a0284c7000000b00339ddd8adddsm10257382jai.98.2022.07.01.13.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:54:46 -0700 (PDT)
Received: (nullmailer pid 1511267 invoked by uid 1000);
        Fri, 01 Jul 2022 20:54:44 -0000
Date:   Fri, 1 Jul 2022 14:54:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
        shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org,
        festevam@gmail.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 5/6] ASoC: dt-bindings: fsl_spdif: Add two PLL clock
 source
Message-ID: <20220701205444.GA1511232-robh@kernel.org>
References: <1656667961-1799-1-git-send-email-shengjiu.wang@nxp.com>
 <1656667961-1799-6-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656667961-1799-6-git-send-email-shengjiu.wang@nxp.com>
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

On Fri, 01 Jul 2022 17:32:40 +0800, Shengjiu Wang wrote:
> Add two PLL clock source, they are the parent clocks of root clock
> one is for 8kHz series rates, another one is for 11kHz series rates.
> They are optional clocks, if there are such clocks, then driver
> can switch between them for supporting more accurate rates.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
