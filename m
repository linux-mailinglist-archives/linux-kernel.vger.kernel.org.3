Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD54528A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbiEPQZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiEPQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:25:25 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3228739163;
        Mon, 16 May 2022 09:25:25 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id p12-20020a9d4e0c000000b00606b40860a3so10400186otf.11;
        Mon, 16 May 2022 09:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K5njaV69c/xpUdcIluz+60lzV8MqdGOZB2Dl54ng57I=;
        b=AwhW9dO31AE0UxdPmQhaSYTtFYiZXrtDu0SJXzaJIV2GcmrPNFfIU40iQcy08LBf+U
         yjOHh8M2b9J7YyQo5Ptzump2H/BwXTULMPZKXYz4RFscxuchW0CAPrKXcZurN/S0u7cq
         zxn23aMtd2C04A2bW5z3105gbLX00m/PttFU5AibBz77rNQtPrIzO0+bLmBjxbnJEu17
         Vo5TXrxFSgk+WeVuoITZHq/ABAjKYWSAbq7mdcUYiuzpgHEyC+zGENxjT6b4/j85XgCq
         /psc5677AEFJwQaiPgrQ6yiLH7wuHNdbWBmMuGPuCO9m35dQJdMYYThv5n1o9MaCkNPp
         htKQ==
X-Gm-Message-State: AOAM5337hp84xgm68ZUlN2MACbsXHtqrsVQxSnQLD4G04cw6DXUil9Zj
        UD2EU/o8IoPsd5UpedyNNA==
X-Google-Smtp-Source: ABdhPJxjRAZExXDXIcmckfL11VmInJI+EIKA0G0IRSMqE7F83ThjrKdv3SpNxwvw1tbseXG+V7GGvw==
X-Received: by 2002:a9d:740b:0:b0:606:21eb:8f93 with SMTP id n11-20020a9d740b000000b0060621eb8f93mr6427106otk.330.1652718324452;
        Mon, 16 May 2022 09:25:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u30-20020a056871009e00b000e686d13883sm5467949oaa.29.2022.05.16.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:25:23 -0700 (PDT)
Received: (nullmailer pid 2789731 invoked by uid 1000);
        Mon, 16 May 2022 16:25:22 -0000
Date:   Mon, 16 May 2022 11:25:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     devicetree@vger.kernel.org, lee.jones@linaro.org, pavel@ucw.cz,
        gene_chen@richtek.com, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: Add bindings child nodes for the
 Mediatek MT6360
Message-ID: <20220516162522.GA2789107-robh@kernel.org>
References: <20220516062127.99647-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516062127.99647-1-gene.chen.richtek@gmail.com>
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

On Mon, 16 May 2022 14:21:27 +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add bindings child nodes for the Mediatek MT6360
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Link: https://lore.kernel.org/all/YmqTzlrVL5KaVPuz@robh.at.kernel.org/
> ---
>  .../bindings/mfd/mediatek,mt6360.yaml         | 189 ++++++++++++++++++
>  1 file changed, 189 insertions(+)
> 

As the dependency is in my tree, applied, thanks!
