Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1E051B680
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbiEEDYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiEEDYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:24:22 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F73140DF;
        Wed,  4 May 2022 20:20:42 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-ed9a75c453so3095630fac.11;
        Wed, 04 May 2022 20:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRBDAPVmHirfU8XkTF17XAM/zWgEEKcXvSn1diz5G3s=;
        b=FPIWwbFjPA9vYL6/q4QUrjlY5+eYE9+L1iAxCIkSRPOlBiMbuNuJ8lA5tf1QKCoOgS
         1wvQkU5Uz4ijnWivSJkToTDzUjofck3rPGg9DaHiDqazomFUVm1I+oNm3HM5DjEjAwAm
         M9V4N+piq5RQxnnJdYvL8NFovHxFBz1SY3rr4H4k0E9RAwrf6HvwVd1cfTrSxJZpJh6h
         b4yyMstEmxKEsDOnenCDVsSzXlVxdr0nm3OBeeJbEZZ+WWNH61UJMFX6E/CWxDhcT3DJ
         hConbKIG1sCQtFJboVzkr+HE886ppbwje2Ilj4wnNCqfIzFVhw1ZN6qb2mtpvLasHyHz
         fDrQ==
X-Gm-Message-State: AOAM533A/DXYKJ/5DngL0UYFQulEDroKCSn6bOS/C+0DQz0YLd5htQLv
        QjK1S++Z6NrzKdv8NVPWUg==
X-Google-Smtp-Source: ABdhPJxT3mpokGd1m5BJqGKfgMEJjonJ6vOb1sxgtGWbM24PZK3WJX7ILS37jtEPM9kp5OCRjg0VyQ==
X-Received: by 2002:a05:6870:1244:b0:ce:c0c9:620 with SMTP id 4-20020a056870124400b000cec0c90620mr1331311oao.114.1651720841656;
        Wed, 04 May 2022 20:20:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j28-20020a056830241c00b0060603221264sm159867ots.52.2022.05.04.20.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 20:20:41 -0700 (PDT)
Received: (nullmailer pid 2749715 invoked by uid 1000);
        Thu, 05 May 2022 03:20:40 -0000
Date:   Wed, 4 May 2022 22:20:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: remove the IPCC "wakeup" IRQ
Message-ID: <YnNCiNWQQU7bc/Eh@robh.at.kernel.org>
References: <20220503145559.525804-1-fabien.dessenne@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503145559.525804-1-fabien.dessenne@foss.st.com>
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

On Tue, 03 May 2022 16:55:59 +0200, Fabien Dessenne wrote:
> The stm32 ipcc mailbox driver supports only two interrupts (rx and tx), so
> remove the unsupported "wakeup" one.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> ---
>  .../devicetree/bindings/mailbox/st,stm32-ipcc.yaml    | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
