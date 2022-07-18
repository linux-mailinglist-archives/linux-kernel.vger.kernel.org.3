Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0496578B89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiGRUKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiGRUKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:10:45 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B7C2983A;
        Mon, 18 Jul 2022 13:10:45 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id p81so10245904iod.2;
        Mon, 18 Jul 2022 13:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5rjfTGrt4xmymVGtpNrhi9ebxqtPFU1Wg32kJfF6yZM=;
        b=D8kEk++cwfE8fJBtBguczQr2Bin8tzXktbfZ8AlHp5jd/O7I36WCOe9yI3h5C2XVsh
         DhKhENK/NA6RG3DpxB+N3c4pXpXpCuVg116W6ng5GTYnQKkEe1Js/p/uX38+wZFhQmuA
         Mnm89g8vrFPhc3WxUtH2Gqqb1NtmmdNqHo5fnquYFYOiekLoKLbIziiFkr1F7t2I3/iU
         M1kJg7/MwzFdedK9lmYU5CPNx7fnO6+INh9ZKc6FgH0HqJ96jZnafaKGSm3zc3qCP5mJ
         +t61deg0KjNk+RcfThF5Qgn6d9mD7LeNaDlsxCjP2bAoi5PLxrOmqnOwOfa9/lRfsjFx
         d+5w==
X-Gm-Message-State: AJIora+pan+SRUp/YQfCFVgnV8kq0K9RJPxfkKLSVUzm24JnySHBglpF
        kHma/4XYntubcGdM3DBmXncxif66AA==
X-Google-Smtp-Source: AGRyM1ua0GjyZ64NbEhZxZhxjYVvv+/wFm0Bro8rMy75FpwbrAzy6qGL73JtXq8/EIoL73W0XywYIQ==
X-Received: by 2002:a05:6602:2b10:b0:67b:bef0:65b4 with SMTP id p16-20020a0566022b1000b0067bbef065b4mr12925297iov.182.1658175044407;
        Mon, 18 Jul 2022 13:10:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q24-20020a027b18000000b003415de88347sm3165447jac.123.2022.07.18.13.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:10:44 -0700 (PDT)
Received: (nullmailer pid 3465081 invoked by uid 1000);
        Mon, 18 Jul 2022 20:10:42 -0000
Date:   Mon, 18 Jul 2022 14:10:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        benliang.zhao@mediatek.com, linux-mediatek@lists.infradead.org,
        bin.zhang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] dt-bindings: mediatek: Add axi clock in mt8173 dts
 example
Message-ID: <20220718201042.GA3465001-robh@kernel.org>
References: <20220712111106.31089-1-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712111106.31089-1-xiangsheng.hou@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 19:11:07 +0800, Xiangsheng Hou wrote:
> For mt8173, it is needed to add the axi clock for dma mode.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ---
> Changes from v3:
> - fix number of column characters
> 
> Changes from v2:
> - remove assigned clocks and parents in dt-binding
> 
> Changes from v1:
> - none
> ---
>  .../devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml        | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
