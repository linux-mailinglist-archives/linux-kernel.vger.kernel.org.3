Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9EB4CB2CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 00:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiCBXqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiCBXqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:46:47 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C762239D4E;
        Wed,  2 Mar 2022 15:45:29 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id y7so3278394oih.5;
        Wed, 02 Mar 2022 15:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVwAiWa85hMzvOKS5YqVsqzuP2wtpcfL3Lp/rwM7cLo=;
        b=8K23GeIOfhOpv9ZFmOgBshxXL5YKvz4as3CZXWrBpdY8/kRnCwlDf2I1KH5E7jEKgd
         mTxHFMvzSvaRVZo8EWUmzpI76aot50X7kKNkooHKHTt95Ht+8rq6hhH/QZ8d6CZ+lwtl
         l2ikuKblLOr0FUZLMc/sti30wIoXzVekZNgkyanuVoyIgqPYTJnGSnnUR9ZhiPWeuPPy
         MuCTp3wh3DRP3opZsSm9baM7J3WHl+rAf/tJwYW4Ldmg08W20wmEnGsQCLWSaUOOBhYu
         4mWtB944tTH3yJV2l2MzTMwbZB1l85J1L7SvxHv7tLkP3lOkXpXJcjQE47LLF9vOWNuC
         tSuQ==
X-Gm-Message-State: AOAM5307URGWwYN4yk1PrR/JY3PLQ2oINURgS4/ympA0uDtXjZ1Y76eL
        au07jFcRf3N7OOSlKzhweA==
X-Google-Smtp-Source: ABdhPJxe/GLJSdnuwSrDlaLTvAy6qRBAvzK/N3ff9doZ/bxjytEkDVKgKi94KuMwdbOu6KjZ1it+Lw==
X-Received: by 2002:a05:6808:bd2:b0:2d7:9ab4:a0a9 with SMTP id o18-20020a0568080bd200b002d79ab4a0a9mr2128835oik.81.1646264728524;
        Wed, 02 Mar 2022 15:45:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e7-20020a056830200700b005a09222e268sm203009otp.7.2022.03.02.15.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:45:27 -0800 (PST)
Received: (nullmailer pid 281569 invoked by uid 1000);
        Wed, 02 Mar 2022 23:45:26 -0000
Date:   Wed, 2 Mar 2022 17:45:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, yongqiang.niu@mediatek.com,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, jassisinghbrar@gmail.com
Subject: Re: [PATCH 2/2] dt-bindings: gce: add gce header file for mt8186
Message-ID: <YiABlmL55ZJBOPUz@robh.at.kernel.org>
References: <20220223030138.13939-1-rex-bc.chen@mediatek.com>
 <20220223030138.13939-3-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223030138.13939-3-rex-bc.chen@mediatek.com>
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

On Wed, 23 Feb 2022 11:01:38 +0800, Rex-BC Chen wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Add gce header file to define the gce subsys id, hardware event id and
> constant for mt8186.
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  include/dt-bindings/gce/mt8186-gce.h | 421 +++++++++++++++++++++++++++
>  1 file changed, 421 insertions(+)
>  create mode 100644 include/dt-bindings/gce/mt8186-gce.h
> 

Acked-by: Rob Herring <robh@kernel.org>
