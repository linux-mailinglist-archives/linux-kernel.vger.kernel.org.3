Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503E04C35CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiBXTYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiBXTYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:24:43 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1162465C8;
        Thu, 24 Feb 2022 11:24:12 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 12so4358248oix.12;
        Thu, 24 Feb 2022 11:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AfORVdZfrnyERL/jwMlykN44+diwcOB3iaHfgbIvHUA=;
        b=FjgvRdpj/6/JPnNQglP2m4rGkWb4cWl6cARG52SBegN9tsdH2BXnwMt2gUElLXyCGY
         vj7U/Cfp1Xcq+ObLgEzAtGGGViEwmScAgxxdk/Z8oQmOWS1VmR0+Q3ohUT66cvJ8eNd8
         eAuwCdiSpgwtdpHBZAitWr8ppl/AKo2dTH2NzOklL1+YXiZuGSa9SAo1orRdcXo8+x03
         tFkagvM+E/swFN8dCQBqneirxoo84x2ZWC2bBte0IctwUlSHmko8PXL2Cm3hHWREaAj+
         EYhttpZK4Ykjh8EO4PvSciUCU4adcAcgm7tacVHNBvIReyCWKBhetQLb315J1bu79m5w
         epIA==
X-Gm-Message-State: AOAM533X+AjlQfCA1r2kLZeLC09GIdrJGzz1Mvq1e5CQDlEQngm+T/0t
        v8xMEKAOV9ZzBYM4utV7hQ==
X-Google-Smtp-Source: ABdhPJzjDPOlNFqI7xhYSvYSO2rpgTmfxPI9vN9iIN6pFYjE3yI+PHtBUbtVBPkH0vN9oRFl/6Z6AQ==
X-Received: by 2002:a05:6870:4341:b0:d3:1412:8ecb with SMTP id x1-20020a056870434100b000d314128ecbmr1881570oah.36.1645730651696;
        Thu, 24 Feb 2022 11:24:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o23-20020a9d2217000000b005ad54e6064csm94531ota.66.2022.02.24.11.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:24:10 -0800 (PST)
Received: (nullmailer pid 3440157 invoked by uid 1000);
        Thu, 24 Feb 2022 19:24:09 -0000
Date:   Thu, 24 Feb 2022 13:24:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     kernel@pengutronix.de, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH V4 2/5] dt-bindings: clock: add i.MX93 clock definition
Message-ID: <YhfbWTiRND193io1@robh.at.kernel.org>
References: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
 <20220224082251.1397754-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224082251.1397754-3-peng.fan@oss.nxp.com>
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

On Thu, 24 Feb 2022 16:22:48 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 clock definition
> 
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/dt-bindings/clock/imx93-clock.h | 201 ++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
>  create mode 100644 include/dt-bindings/clock/imx93-clock.h
> 

Acked-by: Rob Herring <robh@kernel.org>
