Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296A24CE09C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiCDXLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCDXLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:11:44 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE7E27B8DC;
        Fri,  4 Mar 2022 15:10:56 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id k22-20020a9d4b96000000b005ad5211bd5aso8572354otf.8;
        Fri, 04 Mar 2022 15:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RuShRiqoesbAiGJ0CpdraJFq/JZTca6v5cXOWBV0j8A=;
        b=gBNuMvI5CW5dZL+9usV5Zodh7v0t4/dB8thnabJ4tl6/RoYt2Rda+3JIk6PBC9e2fH
         3c+m6XylLBwECTtp6708uRbMG0sa+5TWnJG8LyjBTggPQBj8ueaMskO0W3QVmQxgcThZ
         uuDAb1G6taPuKiKXoFpnNYR2bK85+v8BAZg2FWcaYC4xz6UCk+fkfaxfp+sW2viu2c3k
         4XooiV/DPsO/8OSxGNgdOoYtOZFsFZiME0qqcfqL1hW1DIhX6rtxUAIJ+qHiZtnZG28G
         uOZ3yO2dXyy/vWl+YmqS9HUG0DvaCNUL2ZqP4wZ/ElcpmJSamFme/llYtxyMwColzb0j
         S2Tw==
X-Gm-Message-State: AOAM532R/r2C3SNNBujRWqrfhLYMGinfGAOBQrebBi12jgcGjQZyzk7s
        q2S2b5nnPmxUUrLUC+jgZA==
X-Google-Smtp-Source: ABdhPJxoHOlh3iJcAzoGmaWLYOE0MAvCtrMZ9X79UTOLyDJ2P5w9QsU2Oj3dFAizgZutXoAKGvi5HQ==
X-Received: by 2002:a05:6830:1e4d:b0:5af:3fad:e09b with SMTP id e13-20020a0568301e4d00b005af3fade09bmr444951otj.334.1646435455450;
        Fri, 04 Mar 2022 15:10:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o22-20020a0568080bd600b002d49b19bc2fsm3337303oik.23.2022.03.04.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:10:54 -0800 (PST)
Received: (nullmailer pid 635132 invoked by uid 1000);
        Fri, 04 Mar 2022 23:10:53 -0000
Date:   Fri, 4 Mar 2022 17:10:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-media@vger.kernel.org, kernel@collabora.com,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/3] media: dt-bindings: mtk-vcodec-encoder: Add
 power-domains property
Message-ID: <YiKcfeo7yjbljr+h@robh.at.kernel.org>
References: <20220225225854.81038-1-nfraprado@collabora.com>
 <20220225225854.81038-4-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225225854.81038-4-nfraprado@collabora.com>
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

On Fri, 25 Feb 2022 17:58:54 -0500, Nícolas F. R. A. Prado wrote:
> The encoder node may be dependent on a power-domain. Add a property for
> it.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml     | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
