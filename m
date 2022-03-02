Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55AA4CB2D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 00:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiCBXqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiCBXq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:46:27 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D27A6C970;
        Wed,  2 Mar 2022 15:44:44 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id k2so3291538oia.2;
        Wed, 02 Mar 2022 15:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YMUTnsXm+M9+dNQuf4G0QInghug+tyPAlId0Vy17Ks=;
        b=QkySPkCdAqY2R840qmJbCam+0jv7xou9VktKh0yHWCWSGvKnp03OBfqnjY+dSGR4X3
         GJspR9PT7vXvgMT2LUWtvnL2kkqRE771AskCklji1iAsfreQbGu9wIgs8915Is6TVKMA
         AI7FzTBkLB56mo6mC7d6+HEpl6mrcVel1dBOrhmO+Ws6HfyOKhPP9rg0neSzzuvTa3/8
         qUhPxhhZbo4o0eYKik1kcbo1NUAyhZYMdRkNhrR4yNSQw7T16aqGxztbjko376ONSijR
         6PtR9NxQkot6pmDp5oXwbaetzlEnpydXhEfZi64pzM1AOrz06SObMUNX3H6gJcTQkwIC
         Y0lg==
X-Gm-Message-State: AOAM533qzLEoduH8YgPmgYQ7QWwG7bROlhZpuG8a79pTFtr7DTRIbflD
        fxEsOAVS2Lj8OP3FD/Qw7+Yk9pZ9WQ==
X-Google-Smtp-Source: ABdhPJzvdLVwsrsmUmbCdsCY2U5wylRZU+h6HwxMq7Pa9QA826lZdCUOl1ytBb0OIpfFS70UHUh+VQ==
X-Received: by 2002:aca:5f87:0:b0:2d9:1363:1613 with SMTP id t129-20020aca5f87000000b002d913631613mr2092022oib.165.1646264683475;
        Wed, 02 Mar 2022 15:44:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z9-20020a9d71c9000000b005ad12cbc899sm202195otj.36.2022.03.02.15.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:44:42 -0800 (PST)
Received: (nullmailer pid 280433 invoked by uid 1000);
        Wed, 02 Mar 2022 23:44:41 -0000
Date:   Wed, 2 Mar 2022 17:44:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, yongqiang.niu@mediatek.com,
        jassisinghbrar@gmail.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: add definition for mt8186
Message-ID: <YiABadKsmVNt0bnB@robh.at.kernel.org>
References: <20220223030138.13939-1-rex-bc.chen@mediatek.com>
 <20220223030138.13939-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223030138.13939-2-rex-bc.chen@mediatek.com>
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

On Wed, 23 Feb 2022 11:01:37 +0800, Rex-BC Chen wrote:
> Add definition of compatible and dt-binding header for mt8186.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
