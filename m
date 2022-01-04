Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19F484845
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiADTHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:07:48 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:33542 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiADTHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:07:46 -0500
Received: by mail-ot1-f42.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso48524757otf.0;
        Tue, 04 Jan 2022 11:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZNE5mx7rEhZ7Le90Os2oa7/MAEiBxj4U8DgdPt451Q=;
        b=XgRfmgWc1l/Jbd3WqgcF66bVcnOGFNOl/LJNu2pW8XjOF3SLLw+6q7GehiPmQZA2p/
         habWwfh0dJca+xV3F92usi/zFJUyPKWerNfC4qqpn78it6PoUlsGRbGxzoY2XxdG330L
         tBgLnNdq4woyQbCxlR5y5CCOBM8BvVae5NB9D+Gdd+g10YKPNK00H97KfhappJXLUgLU
         /tYzbpFqm79SJ/vfQMHKYvi3kNQVdhUd/VVYY2eOkr3UkgDlvD9M0WsiR/VbFWu8tWeG
         NikBGcsJDl00mI0ltx+1TGe3eGdgdD+/RnZruZuGt7WcQ/oIWECkeEKMERvuTjsWVupL
         OGVg==
X-Gm-Message-State: AOAM530b8iifYFCP629asSvJLPU3T3s8neGGmLK4eaYQi167Ecpw1iOx
        nI2keIapaBgQMGhiSpJ5VH8iriHqwg==
X-Google-Smtp-Source: ABdhPJytfvV+hwtkFJBZUQ66jDEOQUh9tIx/8nd34uFsnLCf+TCrqub3U7DjefxZSJjRwIxrm+Ij8A==
X-Received: by 2002:a9d:6a7:: with SMTP id 36mr36888976otx.260.1641323265684;
        Tue, 04 Jan 2022 11:07:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v25sm7490806oof.18.2022.01.04.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:07:45 -0800 (PST)
Received: (nullmailer pid 1228819 invoked by uid 1000);
        Tue, 04 Jan 2022 19:07:43 -0000
Date:   Tue, 4 Jan 2022 13:07:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     Mr.Bossman075@gmail.com, adrian.hunter@intel.com,
        kernel@pengutronix.de, nobuhiro1.iwamatsu@toshiba.co.jp,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        sboyd@kernel.org, soc@kernel.org, linux-imx@nxp.com,
        abel.vesa@nxp.com, olof@lixom.net, jirislaby@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        aisheng.dong@nxp.com, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, mturquette@baylibre.com,
        giulio.benetti@benettiengineering.com, linus.walleij@linaro.org,
        festevam@gmail.com, linux@armlinux.org.uk, shawnguo@kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org, stefan@agner.ch,
        linux-serial@vger.kernel.org, s.hauer@pengutronix.de
Subject: Re: [PATCH v7 3/7] dt-bindings: imx: Add clock binding for i.MXRT1050
Message-ID: <YdSa/7BZBDJO3J0V@robh.at.kernel.org>
References: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
 <20220103233948.198119-4-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103233948.198119-4-Mr.Bossman075@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2022 18:39:44 -0500, Jesse Taube wrote:
> From: Giulio Benetti <giulio.benetti@benettiengineering.com>
> 
> Add the clock binding doc for i.MXRT1050.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> [Giulio: added all clocks up to IMXRT1050_CLK_USBOH3]
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> [Jesse: added clocks from IMXRT1050_CLK_IPG_PDOF to
> IMXRT1050_CLK_DMA_MUX and moved IMXRT1050_CLK_END on]
> ---
> V1->V2:
> * Nothing done
> V2->V3:
> * Added GPT binding
> V3->V4:
> * Change License to MIT or GPL-2
> V4->V5:
> * Nothing done
> V5->V6:
> * Nothing done
> V6->V7:
> * Fix typo in numbering
> * Remove GPT
> ---
>  include/dt-bindings/clock/imxrt1050-clock.h | 72 +++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

