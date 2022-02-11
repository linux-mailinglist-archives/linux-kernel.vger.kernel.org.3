Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B734B279A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350694AbiBKOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:10:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiBKOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:10:49 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EDBC75;
        Fri, 11 Feb 2022 06:10:48 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id q145-20020a4a3397000000b002e85c7234b1so10455781ooq.8;
        Fri, 11 Feb 2022 06:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=58jwa/G2ZvrUglihf5MvQ0lT7m6LgGsigiLYzVf/zVk=;
        b=C9Jk9Eib884RwN/Yry8awtERJTt0zse3r2hjBvI/Eegl+8xQJXpN03sbMUfHIqHucH
         2Knz4uJmehhZtcKxg1v4hc+3pR1RwUGIetRBAXJMtZiR2/bLMYJOv0CLRR4gfmGCIPTT
         H1Wdq+TifDhD39pgvmDRzQucZy9TZT7nCg6Nja/yqq+iUFiRwM5qorCuiZFUdmFL/JDq
         eAR1/cM5LIQDofdwNlFearSUdEu7llCK6qDjpE9cZAq0lF2cNmVi8N/x7xq6wedfFOjo
         /d9XRB3WvEmCDI96pwkUe55K5QqEoIqtwvG7dp1agWzGesLg0gcRQjF2g/FRnBBlA5Nc
         aNug==
X-Gm-Message-State: AOAM5332si3OEiPYxX+porb01uMLqGyC5wjULR/JHDkOA/M3+ei9QpP2
        egfJTBLOzqZx3FUSXFa9dQ==
X-Google-Smtp-Source: ABdhPJyerPG2pTuUBQT23cuh3kh1thpIt3Q9tW0Hh8171jlMjXE2vC7gXL7FUM/JW+eU0MlsEgXmHw==
X-Received: by 2002:a05:6870:1211:: with SMTP id 17mr184874oan.248.1644588647201;
        Fri, 11 Feb 2022 06:10:47 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id p26sm8996990oth.14.2022.02.11.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:10:46 -0800 (PST)
Received: (nullmailer pid 287976 invoked by uid 1000);
        Fri, 11 Feb 2022 14:10:44 -0000
Date:   Fri, 11 Feb 2022 08:10:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: omap: Add clock-output-names and
 #clock-cells
Message-ID: <YgZuZIeTAIIrkhSi@robh.at.kernel.org>
References: <20220203112337.19821-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203112337.19821-1-tony@atomide.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2022 13:23:35 +0200, Tony Lindgren wrote:
> This allows us to use clock-output-names for the clock manager instance
> name instead of relying on non-standard node names.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Tero Kristo <kristo@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/prcm.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
