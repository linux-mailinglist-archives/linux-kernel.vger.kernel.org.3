Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711F44C4AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbiBYQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbiBYQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:26:11 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1E71CDDE7;
        Fri, 25 Feb 2022 08:25:39 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id u17-20020a056830231100b005ad13358af9so3928735ote.11;
        Fri, 25 Feb 2022 08:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8uwG0FXIRd57umSLyX8M5OYiYbBMIR95LygaqxBLElw=;
        b=7K/d4mX+xdr0Ld+wbA2HWNzO4JcRKpuQOk3OBfH7GiIP7gwQzFtY+4W1ZL04jPI680
         ozKJwxbuUTjBCcq4ihus2xF7eJeHmvSGknzNZyDerb0MchTlsGPytZ9CgPOxEPEoT41m
         I43GShIkiaEhWf3YtyjL0pMnI01Dk91wRinA5l3/RlUwQ1waMxMR7nx2AocW2uZukbel
         10xJHqgmZt2uX4Y1CRdvWunz5xCfW8BnPN9BzNNXNiU2YxjUUzl7V7CgtNNUxlLND/is
         NHskvyKW96SkaE5CNYPMTqCxxWo3/IqAtQ5wtX5rHauCp4JldOTcM4ww77x6guEZMELA
         wTSw==
X-Gm-Message-State: AOAM533uO+8HXdjsUfOWwiU6Ib7ZTcjFSznlxqotRYWR6rTmVlOp0QcX
        4i3/pBmWkXVl4G8UkCY0UQ==
X-Google-Smtp-Source: ABdhPJwL2MGv3IXhqMemCxWtGXumSxgzeDQMt/Y3DnXiKFv0ruRLlIYvg5DRlMcB5n5XL4qkABZ40A==
X-Received: by 2002:a05:6830:2908:b0:5ad:1ed7:70ea with SMTP id z8-20020a056830290800b005ad1ed770eamr3109515otu.186.1645806338744;
        Fri, 25 Feb 2022 08:25:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 100-20020a9d0eed000000b005af73c6f792sm1373289otj.6.2022.02.25.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:25:37 -0800 (PST)
Received: (nullmailer pid 1037975 invoked by uid 1000);
        Fri, 25 Feb 2022 16:25:36 -0000
Date:   Fri, 25 Feb 2022 10:25:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, runyang.chen@mediatek.com,
        wim@linux-watchdog.org, linux@roeck-us.net,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org
Subject: Re: [2/4] dt-bindings: reset: mt8186: add toprgu reset-controller
 header file
Message-ID: <YhkDAKC6HdnYPg/d@robh.at.kernel.org>
References: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
 <20220216014505.28428-3-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216014505.28428-3-rex-bc.chen@mediatek.com>
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

On Wed, 16 Feb 2022 09:45:03 +0800, Rex-BC Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Add toprgu reset-controller header file for MT8186.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8186-resets.h | 33 +++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mt8186-resets.h
> 

Acked-by: Rob Herring <robh@kernel.org>
