Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A858E071
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbiHITrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346364AbiHITqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:46:51 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F17E5;
        Tue,  9 Aug 2022 12:46:50 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id l9so7116566ilq.1;
        Tue, 09 Aug 2022 12:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FUZurhOVWbSFlq4M53I1Rb6VAfl1vXlk/stu+pqTW7s=;
        b=Hylv0q5Hcln4BccHcPu+pqqkrbEO+8XKno3ylKBzTBp2I3SEnO9Z5w4LzrTj+G5/8M
         bzXhbEs+AXONGx4KTt1iQXHSy/fgi2lkqmWo/bJI5nsGegFsVGB5r18O5Lv9OCNkXhzY
         mMlc92N6x2+YU2AMBPXZA5xoirrTUUvb8gVnPcegvUggDcM1LjSuNpqyrPb3Qo0fK74X
         kB1qK0zljSzYbMemR8IYnwigY6sXD1Ve1oqJAaAWjPP1lUYp2CDl7GVknfeUGR4mqv2z
         BefIiwgPSK3su800o4D5BQSCmN9Fwlexh37Dfv0ywSPfXTvoY5J31t5TlbV5PPNjRQk/
         YROg==
X-Gm-Message-State: ACgBeo0NeK3Ff9ZdCCRqdJFlQ4TSC1g9LqveZle5aAGMisu//5S/Etfh
        fu4UWU0126ncTKrTxkwJ8w==
X-Google-Smtp-Source: AA6agR6tDsZo27ZLWdYBCuktolWxGN7xvWY3iudAMl4Ek0rvZPqnjNE6AERrQZNVv3UbX1qewNYK1w==
X-Received: by 2002:a05:6e02:1aa7:b0:2de:b9f1:593f with SMTP id l7-20020a056e021aa700b002deb9f1593fmr10779350ilv.243.1660074409570;
        Tue, 09 Aug 2022 12:46:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b3-20020a056638388300b00342f67a4789sm3448164jav.164.2022.08.09.12.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 12:46:49 -0700 (PDT)
Received: (nullmailer pid 2272995 invoked by uid 1000);
        Tue, 09 Aug 2022 19:46:47 -0000
Date:   Tue, 9 Aug 2022 13:46:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        msp@baylibre.com, jitao.shi@mediatek.com, p.zabel@pengutronix.de,
        tzimmermann@suse.de, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        ck.hu@mediatek.com, linux-kernel@vger.kernel.org, deller@gmx.de,
        wenst@chromium.org, linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com, mripard@kernel.org,
        granquet@baylibre.com, chunkuang.hu@kernel.org,
        liangxu.xu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, daniel@ffwll.ch,
        airlied@linux.ie
Subject: Re: [PATCH v16 1/8] dt-bindings: mediatek,dp: Add Display Port
 binding
Message-ID: <20220809194647.GA2272961-robh@kernel.org>
References: <20220805101459.3386-1-rex-bc.chen@mediatek.com>
 <20220805101459.3386-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805101459.3386-2-rex-bc.chen@mediatek.com>
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

On Fri, 05 Aug 2022 18:14:52 +0800, Bo-Chen Chen wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This controller is present on several mediatek hardware. Currently
> mt8195 and mt8395 have this controller without a functional difference,
> so only one compatible field is added.
> 
> The controller can have two forms, as a normal display port and as an
> embedded display port.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
