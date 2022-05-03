Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD8151865C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiECOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbiECOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:20:18 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE5722B10;
        Tue,  3 May 2022 07:16:44 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id a10so18275815oif.9;
        Tue, 03 May 2022 07:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ovnSXO2ai7NY/FkSGEqe8YZBBuc5/87pe4zQahwdIPY=;
        b=p4Vahkv6oY5JJXJ+Y3VZwM7dj+TOnB31HWeso0YD3eQDLfRjYTWhKmVnGFZiuJ5zaQ
         BTyM3DpSjs8kp8qaI1xNaEMihYGnpG6+fwWkIoj78pAdPM8lwyuFddWFU0uSssfLrmII
         8E8n6Sfj70X1G4zeD4MeYBRh/cnHcGXl588SchMJvD/6+DaNvdAm8RuPC42toxHykxMt
         IoFP2DyEoT7aDqRngoUiPeKBKpAjTHi7+5nJ4Q4OV9hfE3IBLxoU4fyGROVops3a9WJX
         mU49iyq3VwTTMybFHJLS2hhqs7o1z6jElAynLMiaUUThjP2qVEMgalvo/iyL8nyInjtf
         amtQ==
X-Gm-Message-State: AOAM5321ohh8sdg9k+85ed+S0U1UFgpm26wYJ8SyOLH1ss6F+1k/741R
        2a2UOlGCx86/LXxkRFrvNbxfdCMrcw==
X-Google-Smtp-Source: ABdhPJzzZUL47cd3wp/QQrD1PTtAZ/Rx3sEuLc36LxZ460xFml881B1M+erBIePNQvzpcbDCmo/R3w==
X-Received: by 2002:aca:da83:0:b0:325:432a:b45c with SMTP id r125-20020acada83000000b00325432ab45cmr1993812oig.11.1651587404241;
        Tue, 03 May 2022 07:16:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 13-20020aca0d0d000000b00325d7b6cab8sm3013442oin.16.2022.05.03.07.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 07:16:43 -0700 (PDT)
Received: (nullmailer pid 3572067 invoked by uid 1000);
        Tue, 03 May 2022 14:16:42 -0000
Date:   Tue, 3 May 2022 09:16:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: remoteproc: mediatek: Add optional
 memory-region to mtk,scp
Message-ID: <YnE5Sq8H6juQHpbM@robh.at.kernel.org>
References: <20220502192420.2548512-1-nfraprado@collabora.com>
 <20220502192420.2548512-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220502192420.2548512-3-nfraprado@collabora.com>
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

On Mon, 02 May 2022 15:24:20 -0400, Nícolas F. R. A. Prado wrote:
> The SCP co-processor can optionally be passed a reserved memory region
> to use. Add this property in the dt-binding.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> I left out Angelo's R-b since of the 3 lines in the patch from v1, only
> 1 is left.
> 
> Changes in v2:
> - Dropped type and description since it's a well-known property
> - Set maxItems to 1
> 
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
