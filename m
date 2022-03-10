Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B44D558D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiCJXhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241152AbiCJXhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:37:11 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4BA19DE8B;
        Thu, 10 Mar 2022 15:36:09 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id q1-20020a4a7d41000000b003211b63eb7bso8700528ooe.6;
        Thu, 10 Mar 2022 15:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PN2mbzwXUHAto8HEAzTj4rJG8ZQQNjc7Bn/bempRCVw=;
        b=dWhHXIMIxOFPjAhEClpisd/kEiTGgJBjDAh/MOHDkM5bcOlLRNRkZrPDLXfHImHQf9
         VNopcks67vtNeR4aZzNZMNenLhlsLpbzV0wzUPNIqz8fHMrUKRDTzswyVOviyoPvFxrn
         m9RiJlx2RVSYGd0IL9nDcbFILk1bKFQt9ktXusXSuwVjoEGmuA9R/cS+JgcpCV8phTl4
         kCKZwcYt7Fb5bC3d1R5VWWgTSTzpHb+Z63IoVQzr5nlVW30KIVyCMwOJ1RgInvlDsZSm
         xJ0geXZVhd7gzGewR/S1VJeStEOOEzMjwLRP2dODF4MyYfnd9g4r3xRgyYyjYfuCpOv0
         YRvw==
X-Gm-Message-State: AOAM533VWHvSHFPdfrOwVt1s70bUfV51hmz3s46MtJNRFFY/CGv2ME1f
        pqXM43LgVIgHQhWhVuQCzi0mzFQ3MA==
X-Google-Smtp-Source: ABdhPJy3WyBuiJCTvq7ROLUbeX9qqGYkbaV0JeTVbnxhQPBonkoYgM8I+g7Jc0luE+fcUw2ZTX8vyQ==
X-Received: by 2002:a05:6871:7a8:b0:c5:a1b3:43eb with SMTP id o40-20020a05687107a800b000c5a1b343ebmr4189847oap.103.1646955368603;
        Thu, 10 Mar 2022 15:36:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 36-20020a9d0ba7000000b005ad59f1f783sm3112902oth.3.2022.03.10.15.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:36:08 -0800 (PST)
Received: (nullmailer pid 2331942 invoked by uid 1000);
        Thu, 10 Mar 2022 23:36:06 -0000
Date:   Thu, 10 Mar 2022 17:36:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     aaronyu@google.com, tzungbi@google.com,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        trevor.wu@mediatek.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linmq006@gmail.com,
        broonie@kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        robh+dt@kernel.org
Subject: Re: [v2 1/2] ASoC: dt-bindings: mt8192-mt6359: add new compatible
 for using rt1015p and rt5682
Message-ID: <YiqLZiRO4K4fbSNt@robh.at.kernel.org>
References: <20220310153707.29722-1-jiaxin.yu@mediatek.com>
 <20220310153707.29722-2-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310153707.29722-2-jiaxin.yu@mediatek.com>
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

On Thu, 10 Mar 2022 23:37:06 +0800, Jiaxin Yu wrote:
> Adds new compatible string "mt8192_mt6359_rt1015p_rt5682s" for machines
> with rt1015p and rt5682s.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
