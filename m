Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078AB4E7D73
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiCYTzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiCYTzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:55:33 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2093180070;
        Fri, 25 Mar 2022 12:42:15 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-d6ca46da48so9065983fac.12;
        Fri, 25 Mar 2022 12:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=39uH3YQKGGZBLgUBUd+I6NQzRCiICBllLB8z6fgI41s=;
        b=S8BeI4+ESZosInf/EdrgGB47gKWC1CywpxqUkWVbE4pT8zg1hMflExcf/L0+sikqMi
         lTzPUomK+0qRxXgOvOd26PCR0wqKB4DI+/blh3DGYNI6ScZFtvQaWfUXuw27KduFsEQw
         lW8yy+ntYbYyvbeai+BOjA07fBokHUcjY27Dsd/be1bOa0bSUPSPYcJt48H9T+FaKsBE
         rKr09MNdaRgSah0G+gMWdvM68sGWqE1iAn6fTc19sqsSl8VRafJuT3DA472JO/r23pr1
         z48jGJIs/lmkKp//ryeXI956F7agitJJW9Q1sZ43ibfwkKjBUw29dGmwciOg5/L/YZDi
         ugfA==
X-Gm-Message-State: AOAM532LJz/Kx8yrf1fzYhh9/oui6/q8gMDXODakO2ZTfyeq2/XmMtwN
        Gl7URZvzJ0GTCiPVJKFtJpTSOMPI2w==
X-Google-Smtp-Source: ABdhPJzPJFxECJjjfdSMQ4DswXIqKqYxHnVtUvxc97pQEDJj3mfgHirhsL2vS/JmJi8uyarDbtNOvQ==
X-Received: by 2002:a05:6870:a99a:b0:ce:c0c9:64f with SMTP id ep26-20020a056870a99a00b000cec0c9064fmr9633791oab.161.1648237255377;
        Fri, 25 Mar 2022 12:40:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s125-20020acaa983000000b002ecdbaf98fesm3205283oie.34.2022.03.25.12.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:40:54 -0700 (PDT)
Received: (nullmailer pid 315917 invoked by uid 1000);
        Fri, 25 Mar 2022 19:40:53 -0000
Date:   Fri, 25 Mar 2022 14:40:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     linux-mtd@lists.infradead.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, robh+dt@kernel.org, nm@ti.com, richard@nod.at,
        kishon@ti.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: ti,elm: Convert to yaml
Message-ID: <Yj4axbrQE0vEYDP1@robh.at.kernel.org>
References: <20220325123707.22020-1-rogerq@kernel.org>
 <20220325123707.22020-2-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325123707.22020-2-rogerq@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022 14:37:05 +0200, Roger Quadros wrote:
> Convert elm.txt to ti,elm.yaml.
> 
> hwmod framework use is deprecated for new platforms
> so mark it so.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/elm.txt | 16 -------
>  .../devicetree/bindings/mtd/ti,elm.yaml       | 47 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/elm.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,elm.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
