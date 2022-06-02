Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A0253BA20
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiFBNwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiFBNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:52:34 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB3E13C09B;
        Thu,  2 Jun 2022 06:52:33 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f2e0a41009so6802002fac.6;
        Thu, 02 Jun 2022 06:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cwrty3bkHypAjRxPwNA1vccjhwmtNX2VQaw293iyBPY=;
        b=085nls7Q7lm+2vaIfufTDXvXigVOQZPP8e0vEwwZtuCa3L6b8tikn+zdIVv/vljxoY
         l78CTeopN0FzZidyS+PJOOD+f0ryv28zVEP7o9Ia++7qX9U6WapM91eGhkzQdN1Tl4Wq
         zb0WuUAEEzDja16RKhWxBzktT4LXhJVmUuvq4SqdMJObhtUeEJKPBSLeRqchstaSC1i9
         uszO8NZB9wfEo/ji36F2bB+2gH7xLSyJJK2axj3lJj6GC1Ii/dcF15adJ6zdItrtY7wM
         WFQ7xY4rPZoA/NIcAqApcnDS0SXfm+ogmwQIkAJGMScPHvNWphbhB5aU0jLMbW8kP82b
         3sHg==
X-Gm-Message-State: AOAM533Pq6vX8ZJp9xxuNasJlw1Gi0U5qUwsbrZOIW0hz0V7Lca06fk8
        EWF4gqricCqiRpJSOeg5NQ==
X-Google-Smtp-Source: ABdhPJycRtrCYcM7mCLAprLiOP0DJCpEHKtrncX2BqebZtxrrIK1XXfbFfz7x6eAIxs0AQH1vzuMhQ==
X-Received: by 2002:a05:6870:d784:b0:f1:5d2e:146a with SMTP id bd4-20020a056870d78400b000f15d2e146amr2933668oab.110.1654177953147;
        Thu, 02 Jun 2022 06:52:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k6-20020a9d1986000000b0060603221268sm2197510otk.56.2022.06.02.06.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:52:32 -0700 (PDT)
Received: (nullmailer pid 2190724 invoked by uid 1000);
        Thu, 02 Jun 2022 13:52:32 -0000
Date:   Thu, 2 Jun 2022 08:52:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v4 2/7] clk: sunxi-ng: v3s: Export MBUS and DRAM clocks
 to the public header
Message-ID: <20220602135232.GA2190690-robh@kernel.org>
References: <20220525185853.695931-1-paul.kocialkowski@bootlin.com>
 <20220525185853.695931-3-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525185853.695931-3-paul.kocialkowski@bootlin.com>
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

On Wed, 25 May 2022 20:58:48 +0200, Paul Kocialkowski wrote:
> In order to declare a mbus node for the v3s, expose its associated
> clocks to the public header.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.h      | 4 ----
>  include/dt-bindings/clock/sun8i-v3s-ccu.h | 4 ++--
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
