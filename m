Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3644AE766
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbiBIDCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbiBICxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:53:45 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67184C0613CC;
        Tue,  8 Feb 2022 18:53:44 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id s185so1169390oie.3;
        Tue, 08 Feb 2022 18:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fNZGPXUROmHp4KkqnE4bBZ82gCwkY+Gd8mQE5E/HzyA=;
        b=ntoQ7p2k/V3RDrDImlNg2et31bpQjw1r6C3ZBcsGMgt7e30WYCqL+egYx27pokydER
         PzJtCE5oFvXLNDAGsh7X5udcXPQeLkdAD4gspS+SFc2aaBuerAQ5wP902oMLAp24H4dJ
         5FG/bCmqSZBTf7jqpLcutAIuFoH+KyEwcyHO0bF/HeOD1EZIwhON85DyI+RnXXW7s2Po
         QpkKsGTsf12a0td0peEPHDOgWSnbcmAyaS1LCbIogmnRq3c4kSpTzyo5hrORfRkWb2Wn
         Cv2rfLK/LFfVNthPBZxXtgd6QyRmSJw5KJAFvs2aA981nggFP7d78ubYpH2r4yRx4Onx
         UKvw==
X-Gm-Message-State: AOAM5332HOVuPeIwmDeamQapiZJ8fBP2FUmXcCGhba+NtV9ay8Fg9b0s
        2lC3m04HklMvLB3gnLqvlw==
X-Google-Smtp-Source: ABdhPJwklX3+feeACa2Kp9/ndGvpPiCo+Q+Utu1UgIfNFSyTdtDznL0XFZ3V63+D63H5b3nML99SJA==
X-Received: by 2002:a05:6808:198d:: with SMTP id bj13mr78932oib.146.1644375223674;
        Tue, 08 Feb 2022 18:53:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q41sm6054935ooh.38.2022.02.08.18.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:53:42 -0800 (PST)
Received: (nullmailer pid 3525989 invoked by uid 1000);
        Wed, 09 Feb 2022 02:53:41 -0000
Date:   Tue, 8 Feb 2022 20:53:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Peng Fan <peng.fan@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: serial: fsl-lpuart: Drop i.MX8QXP
 backwards compatibility
Message-ID: <YgMstcQHIB0dWzuT@robh.at.kernel.org>
References: <20220118135918.2126010-1-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118135918.2126010-1-abel.vesa@nxp.com>
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

On Tue, 18 Jan 2022 15:59:17 +0200, Abel Vesa wrote:
> Drop the i.MX8QXP backwards compatibility with i.MX7ULP since they
> differ from clocks handling point of view.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
