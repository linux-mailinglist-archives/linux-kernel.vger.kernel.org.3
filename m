Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1911570DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiGKXES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiGKXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:04:16 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392D811172;
        Mon, 11 Jul 2022 16:04:15 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id p13so3916139ilq.0;
        Mon, 11 Jul 2022 16:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NbY/7Z18T3rfQ5ngeaYSTuxGg4aJvX0MObLvYqlXd7s=;
        b=2YrFlpQfi5ozeUCo6EEGtScYkMq3//3l0UwMJj1Z1aGLLfP+p1HB997/2+bSacGfJn
         Qpl4LrfISD+RcKpG/E9jF+ep2paJUsxM384z20eLQpR+pQ3u7tmJAtOeuNAA2k5vlRab
         2Kju/JDe0VxpyF32TNYcRW2x7sdIRT9f21dxEd8G91oUXLbVUbgSW1u1yQw2ZyxU6Dex
         F+oGIdyNZFUdnrwnpwvQZezGXVP7ScnMOpNygof8CgkATe/89RNSsTHJAxlnR06lAebK
         iOFDWoHOahFxQ3INROUPnHqSCG3Tu+19gVPa4VAxzhNgmBB6LOaqlBAgXtc3RKl/HXh0
         aplQ==
X-Gm-Message-State: AJIora9EY9KtCEF489PW4pONJowKwkuxFLHGFKi+D3fmLycZB+5sCNR7
        clI2qPkWOfuvh+NYDPcuzHdIp89GHA==
X-Google-Smtp-Source: AGRyM1uMoeWR7PzsRDrBvUEqy0bblpLHVg5sWj7o26/ynW/mXtmz0uMxRbw9bbdMhZS09TsefyKoDQ==
X-Received: by 2002:a92:cc05:0:b0:2dc:51f5:f6cd with SMTP id s5-20020a92cc05000000b002dc51f5f6cdmr11108584ilp.175.1657580654473;
        Mon, 11 Jul 2022 16:04:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l9-20020a92d8c9000000b002dc100ab6fdsm3166725ilo.35.2022.07.11.16.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:04:14 -0700 (PDT)
Received: (nullmailer pid 434848 invoked by uid 1000);
        Mon, 11 Jul 2022 23:04:12 -0000
Date:   Mon, 11 Jul 2022 17:04:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, ulf.hansson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2] dt-bindings: mmc: Add compatible for MediaTek MT8188
Message-ID: <20220711230412.GA434794-robh@kernel.org>
References: <20220708114747.13878-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708114747.13878-1-johnson.wang@mediatek.com>
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

On Fri, 08 Jul 2022 19:47:47 +0800, Johnson Wang wrote:
> This commit adds dt-binding documentation of mmc for MediaTek MT8188 SoC
> platform.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
