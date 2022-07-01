Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDAF563B94
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiGAUy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiGAUy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:54:56 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD8C675A2;
        Fri,  1 Jul 2022 13:54:55 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id h5so2136355ili.3;
        Fri, 01 Jul 2022 13:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LPZ1DizPYBScxcXuGY/3z+PsYKOTpV0UZkb5MuqFe0=;
        b=yOKflP17UcsJ7hFCPiDqlhv2A+3AcSh8eOWgvhwkk1gzQXQASzoWwR3Hg9gxiuS5uD
         fdcLcE30n7Y7uQ2Tme5xKdzGb3uO9PnFwiRQMDaGbpuDVygTOqEZqmvy67rr1LBi0qra
         /rb3EKvbDpOpaqwvuU8uphsK00ws/usAKR8+pluxbTh8dnUYlRKcQh8KbJyz9lSts/CB
         8H8vHCxWgzXkW6ATrmZyG9sFXwzv2Yutme5FQ+jV0xXgaPpyviqpr0cPUaf7QFPTSpvs
         cKWU0Wd8h0mwb0uAwDB0Y70hvFEJg/+/9MV6PXKIYvy2am8F54oqDjwTElDLizRV5MCj
         Nczw==
X-Gm-Message-State: AJIora9jP4dhkP3esQSRR4+ueEuNBjnuJmNzeU8JVo0UgBt6pbCHab0e
        Yy5SN/AwcWzZreKvC7Nk8A==
X-Google-Smtp-Source: AGRyM1vTE3uUzjOrJeeGSTgJ/tO4QiastKGHmlTULq10GRjmMlObeExibr8KirXpiJJiC7qDmehj1Q==
X-Received: by 2002:a05:6e02:1187:b0:2da:97e5:6609 with SMTP id y7-20020a056e02118700b002da97e56609mr9630603ili.274.1656708895013;
        Fri, 01 Jul 2022 13:54:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u6-20020a056e02080600b002dbf4c67b1fsm295715ilm.46.2022.07.01.13.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:54:54 -0700 (PDT)
Received: (nullmailer pid 1511647 invoked by uid 1000);
        Fri, 01 Jul 2022 20:54:52 -0000
Date:   Fri, 1 Jul 2022 14:54:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Xiubo.Lee@gmail.com, perex@perex.cz, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, broonie@kernel.org
Subject: Re: [PATCH v2 6/6] ASoC: dt-bindings: fsl-sai: Add two PLL clock
 source
Message-ID: <20220701205452.GA1511590-robh@kernel.org>
References: <1656667961-1799-1-git-send-email-shengjiu.wang@nxp.com>
 <1656667961-1799-7-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656667961-1799-7-git-send-email-shengjiu.wang@nxp.com>
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

On Fri, 01 Jul 2022 17:32:41 +0800, Shengjiu Wang wrote:
> Add two PLL clock source, they are the parent clocks of root clock
> one is for 8kHz series rates, another one is for 11kHz series rates.
> They are optional clocks, if there are such clocks, then driver
> can switch between them for supporting more accurate rates.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
