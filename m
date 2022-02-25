Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C034C4AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbiBYQ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiBYQ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:29:11 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A912B755;
        Fri, 25 Feb 2022 08:28:38 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id 12so7933270oix.12;
        Fri, 25 Feb 2022 08:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/qpEObgS3Mrx6MTCn9DFV0A8DvCbIfP/OPe4aJKhsA=;
        b=YTdiJZTze3Yx2YD6k0qj1/obt3zSRhZ7BTsn879r18ctGz6Im6f4NjpejAh8ooA8eQ
         PYtlKM9fUqGf1mNNXmKhr8kO0F0Zpbiu9SGYqwu2Ne8G9gCTeu51JCu+pD4TNRB5Lu9y
         ZNkidNJIVEVAjC0g6lx64UzDm6HUQRBhypB/bP4SgtobYjoOviaetq+baH9nzYwcGDdw
         kfhqzlcPvT5+VZC5wTxThBtKIlu02r//h0O1fkfAVmb2aQypJIHUwtINJiWyEN8RPUGv
         uns5J5T6S340KrGEZjpP7uJQkk+6iEFRi9JtMRNo+i+b6rhhKpzsJK+VWrfwuSHm0Gut
         8wYw==
X-Gm-Message-State: AOAM532qCK4XP+LQaA13hB7140RL2vaOxT3c3wSC6lRv57C0tx07wlI3
        HGCrCmIy6cmX0wnR2plHNA==
X-Google-Smtp-Source: ABdhPJz6HE/6y2WBKz5LNahiBbqbjozKHG6vhfmf6HiNlePZxR7q6dbdvITWPJqYK8tAZj89258umQ==
X-Received: by 2002:a05:6808:15a9:b0:2d4:5775:d06a with SMTP id t41-20020a05680815a900b002d45775d06amr46770oiw.138.1645806518218;
        Fri, 25 Feb 2022 08:28:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n22-20020a056870e41600b000d6d4ac3c64sm1296488oag.39.2022.02.25.08.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:28:37 -0800 (PST)
Received: (nullmailer pid 1042574 invoked by uid 1000);
        Fri, 25 Feb 2022 16:28:35 -0000
Date:   Fri, 25 Feb 2022 10:28:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org, Min Guo <Min.Guo@mediatek.com>,
        Hsin-Yi Wang <hsinyi@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: mtk-xhci: add compatible for mt8186
Message-ID: <YhkDs9FUlGNl473i@robh.at.kernel.org>
References: <20220216120025.29860-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216120025.29860-1-allen-kh.cheng@mediatek.com>
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

On Wed, 16 Feb 2022 20:00:25 +0800, Allen-KH Cheng wrote:
> Add compatible for mt8186
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
