Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3A4CE089
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiCDXHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCDXHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:07:21 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D34425ABC0;
        Fri,  4 Mar 2022 15:06:33 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id z8so6030435oix.3;
        Fri, 04 Mar 2022 15:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ATA11vRf0zeVLMjaFmKZ4cxLi5HueUdNVm0c6ug1+pQ=;
        b=7FZTs6e7kIaV1H4ClhZT1kPxHxiU7KhbJRgjH/zPBQornf77tu8KL+fy23OGnYyTMl
         gULTPnhg5waPke0O7NIOqYnRT6kBuA0723xyjmUtw3aaZhP7S78XajwfH+zhi1P3eWLo
         5Ael0ypNR6gF+hI4lCDEKk0UOgosl/1uI2A21KX8cYGVCSPL3Heu7VSun4JtS+1cZ6FT
         ZLKSw3S3xQlM/kVJWTwMsusA0tgXrefaGmYzvZhV5yP1lAMHgwji8xYsbeSFTpXSUtUj
         QrmrgeF9mks9h750CQUPcJeFV4xVnqlwhdrx82ZUal/mA4i0BJFJ12NhwzRtD4fdlTe+
         5hzA==
X-Gm-Message-State: AOAM532niMTr8KJ5TKyC9c7eWmSGg5r+VsIiDRt2t2v+fsn/cw5C9Y3J
        eGuUHa6vhkcb1rMX5uSWFQ==
X-Google-Smtp-Source: ABdhPJzdp9EJcfPN5djd1vxXYjKLskxK/4pozXmqkHEOZkKsqdM4MGm2KnaauDBCC70eUdFaJv6PJA==
X-Received: by 2002:a05:6808:3020:b0:2d7:2d3d:b651 with SMTP id ay32-20020a056808302000b002d72d3db651mr11024147oib.139.1646435192431;
        Fri, 04 Mar 2022 15:06:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bc24-20020a056808171800b002d722aead50sm3215928oib.27.2022.03.04.15.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:06:31 -0800 (PST)
Received: (nullmailer pid 626767 invoked by uid 1000);
        Fri, 04 Mar 2022 23:06:30 -0000
Date:   Fri, 4 Mar 2022 17:06:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [RESEND v5 1/2] dt-bindings: remoteproc: mediatek: Add binding
 for mt8186 scp
Message-ID: <YiKbdtiLHDuyOmL2@robh.at.kernel.org>
References: <20220225132747.31808-1-allen-kh.cheng@mediatek.com>
 <20220225132747.31808-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225132747.31808-2-allen-kh.cheng@mediatek.com>
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

On Fri, 25 Feb 2022 21:27:46 +0800, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> Add mt8186 compatible to binding document.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
