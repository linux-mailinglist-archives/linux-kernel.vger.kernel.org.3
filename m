Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0D52AFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiERBTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiERBTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:19:04 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E504E541A2;
        Tue, 17 May 2022 18:19:02 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id r1so996992oie.4;
        Tue, 17 May 2022 18:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dOjSbvFJzU0CvnEoNIDV+xsV7SachX6kYcOQb2jSCAM=;
        b=lEBhydxqxHeaGDWjMuXTxxkVBOrDQZgOgHQEC+qbpBDJA++cPel2KLEM9v2lBh73Hj
         JvBO0cnlQgUkj6CNthDKRTUJWYBFykBWC+jojEXn9DKuiIgehUE7dexQ3FpWK78lqg6g
         JCFZHMI6DCWPlHSs+CcUpS5puo2JxmEutmrL8VxzSoDWEblENTvqcDLZ030cXZ6TeuJ1
         9vFnsAC1W/dhPDFlTWOEmSxN2FwCZ3QEi9tv16r1wSrvGcEwTWi0h9BuXIEFq6fknGuh
         mFU0Q7ivpCZ8RVdEPeX4acl2eGKv1by5U+wKu+IH87cB1lv1lDaDHe8Kb+YVZTMbge6i
         AehQ==
X-Gm-Message-State: AOAM530v9X+1zBVx4sQK8jjdLNbFZpEGFIN9o/VpRWorcd2P5L2Pln4O
        2T5edsnphblyTeRi3S4oFA==
X-Google-Smtp-Source: ABdhPJyVW9lX0u/Tduf0sfn4uTDKDDaASqIWzfS2BhX29afIHFZz6eAchY3e07N8O1YLBwNa0VbJYw==
X-Received: by 2002:a05:6808:219c:b0:326:4456:d0be with SMTP id be28-20020a056808219c00b003264456d0bemr12044296oib.79.1652836741965;
        Tue, 17 May 2022 18:19:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000e686d1386asm536373oao.4.2022.05.17.18.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:19:01 -0700 (PDT)
Received: (nullmailer pid 2012064 invoked by uid 1000);
        Wed, 18 May 2022 01:19:00 -0000
Date:   Tue, 17 May 2022 20:19:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, shawnguo@kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: imx-mu: add RST channel
Message-ID: <20220518011900.GA2012006-robh@kernel.org>
References: <20220517073518.34474-1-peng.fan@oss.nxp.com>
 <20220517073518.34474-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517073518.34474-2-peng.fan@oss.nxp.com>
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

On Tue, 17 May 2022 15:35:17 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX MU has a MUR bit which is to reset both the Processor B and the
> Processor A sides of the MU module, forcing all control and status
> registers to return to their default values (except the BHR bit in the ACR
> register and BHRM bit in BCR register), and all internal states to be
> cleared.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
