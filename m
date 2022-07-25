Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6F580757
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbiGYW2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGYW2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:28:36 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A783B252AA;
        Mon, 25 Jul 2022 15:28:35 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id u9so15148645oiv.12;
        Mon, 25 Jul 2022 15:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ydROe5Yeqe7LKLvisIFiWDBcUFI7G/LxHrwDl1ZPZes=;
        b=UI4ZK7Mss07ztjlb0lt2hn3LtbNEPeXCcAiSyjh+USavG4RGiDy0rSy82QStGHC1wv
         H/TEnM0skLfpItvl37sxna57Wi224DnCTJKVMqgVVv8qt4b5owPsIBDdOnmklUX79zj1
         cBUjaX1yNUxUlS4Pg6WYwOhsblWL4CYgOlGaTBPJZuSCbVgp/ULUb4my0ybYVvCZPh7Q
         pjN51b78F1kImacrxUx7WlkjzVnvQ35FFidSjna8c64p0+ndwiNyZVslcZnKeD7CW/tv
         +XoL100FlzUjRIsL1Q1bG+Wv+/x7KMIKMQuAy1H/LT3L65uXXRJj8T5OSL+3n3dYPPlJ
         mbUg==
X-Gm-Message-State: AJIora8/CH8HS1oFfOGqn++Fs7Gw+uSNaqe43CRw0LXXMOViAUBjSGNH
        WFxG0TezDZeFhyxSCZnzvw==
X-Google-Smtp-Source: AGRyM1s71mYHjgRvajARzt6yUDLac3slJauP/Yk6irLnti0u1tVfqTcvRz9lQPTSlzY1oaeDkp/SWA==
X-Received: by 2002:a05:6808:bce:b0:33a:c6c8:9d6f with SMTP id o14-20020a0568080bce00b0033ac6c89d6fmr6219832oik.135.1658788114842;
        Mon, 25 Jul 2022 15:28:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b17-20020a056808011100b0033a9f4c13cesm5322861oie.13.2022.07.25.15.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:28:34 -0700 (PDT)
Received: (nullmailer pid 2859320 invoked by uid 1000);
        Mon, 25 Jul 2022 22:28:32 -0000
Date:   Mon, 25 Jul 2022 16:28:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jitao shi <jitao.shi@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, hsinyi@chromium.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        CK Hu <ck.hu@mediatek.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: display: mediatek: dpi: add
 power-domains property
Message-ID: <20220725222832.GA2859262-robh@kernel.org>
References: <20220720130604.14113-1-allen-kh.cheng@mediatek.com>
 <20220720130604.14113-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720130604.14113-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 21:06:04 +0800, Allen-KH Cheng wrote:
> DPI is part of the display / multimedia block in MediaTek SoCs
> and is managed using power controller in some platforms. We add
> the power-domains property to the binding documentation.
> 
> Fixes:9273cf7d3942("dt-bindings: display: mediatek: convert the dpi bindings to yaml")
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml   | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
