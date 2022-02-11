Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFFD4B2AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351630AbiBKQlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:41:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiBKQlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:41:21 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D9102;
        Fri, 11 Feb 2022 08:41:20 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id k25so9546782qtp.4;
        Fri, 11 Feb 2022 08:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mwUYCx5TcJdlJ6u+bUNAAw+WUFVcvK/qP69H5nXaJf0=;
        b=wvRKLNczrXrI4R8GoxH9x/B6mPA5VW5TSbWqahJzBQnak4VDuWkX38ME7/vYK2WSnp
         /RUIvh47B+andXJmzvklHhfcPksYMxQl2Me6mutv4EayYoLlwg/p/I+PC/hyLqoJ+3F7
         Uoh1qljwRA7x1VobE6JaweD3I2Y9AFeD5sFaLCMBEiJ5rwFYrcKthxj29XvbxkWBl8SZ
         Tbxe1pRqz3qqs9X7MyJ0HYEgiJYjad1F3VKnmYEBUplCy+yOWMjYP9WE9LJ9GZEJ6W1g
         9GEm9WrKGaeO15trT4lt0ffuLUHNtFJM17ULT4WkaeoKGZ6MOM71jyn1ApNDAL0aR9wV
         iHhQ==
X-Gm-Message-State: AOAM531X/fEXQeQOyJ2GorDHhRJfcl1wBM9wNNnqAVEYtnwiP6bJTBmA
        cB/3i0iD0q/vLD70OalsqIdbWG6v6g==
X-Google-Smtp-Source: ABdhPJzMDtBp3bSECgsIe08Kqg1EVnDZCpnXeJ8baGM285Py26dZskYnbAjL+TOmk5y1D1ecClwwLg==
X-Received: by 2002:ac8:59c4:: with SMTP id f4mr1707878qtf.184.1644597679795;
        Fri, 11 Feb 2022 08:41:19 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id b10sm12980609qtb.34.2022.02.11.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:41:19 -0800 (PST)
Received: (nullmailer pid 491234 invoked by uid 1000);
        Fri, 11 Feb 2022 16:41:16 -0000
Date:   Fri, 11 Feb 2022 10:41:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions for AM62
Message-ID: <YgaRrBVMP/Jv67cs@robh.at.kernel.org>
References: <20220208131827.1430086-1-vigneshr@ti.com>
 <20220208131827.1430086-4-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208131827.1430086-4-vigneshr@ti.com>
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

On Tue, 08 Feb 2022 18:48:25 +0530, Vignesh Raghavendra wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> Add pinctrl macros for AM62x SoCs. These macro definitions are similar
> to that of previous platforms, but adding new definitions to avoid any
> naming confusions in the SoC dts files.
> 
> checkpatch insists the following error exists:
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> However, we do not need parentheses enclosing the values for this
> macro as we do intend it to generate two separate values as has been
> done for other similar platforms.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  include/dt-bindings/pinctrl/k3.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
