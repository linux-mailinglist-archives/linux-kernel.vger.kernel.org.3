Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7750ED97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbiDZAbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiDZAbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:31:17 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DD33EABF;
        Mon, 25 Apr 2022 17:28:12 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id g30-20020a4a251e000000b0033a39d8340aso3105149ooa.5;
        Mon, 25 Apr 2022 17:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SFFQr41CrK0hpZb0QawVnEuLVgHVc+Fj3FqF1lnbmG0=;
        b=TpQzXGobhzhXUBCx/xO6fLvNNOdqOjeHEAH5iO8Lr0FlWKQkxuJy3h7A2niVtUoB0y
         EuZ99f2WpVWswT1RrcErsOZaEPWt1xavSDpc0Ac/nviXDGFCE14pF5Mzu2RBG8wnkHKg
         A7VrrqLdEREevVKkOncCc/3x2topL+6aghsjLSCSfwfZ3W1b35OquhXQV5/vwQYbyT3L
         M8z1OLpv7LJVYPZsJcC5X923lUzWODwjSgzgJl47i3xvFh8NPeCG3Xb8suo8HlxysyeO
         ZfbGogWNemxqrsIqHcN/zYaTJm7eZj5a+NoCAHmHEhnHOgVW7Bv8ITEPwSO8rzteTsax
         iL8Q==
X-Gm-Message-State: AOAM532UfvBvAr6PYKanXX0KZjJKk1CJ3iYZCAtIeBDyj6IkW0MT1vCT
        FZNHdSy8Pw0OjMw3f7UroQ==
X-Google-Smtp-Source: ABdhPJw59OK2Y1K9vrvU+qPU7j7PKh3L5AfO5Jhnd7VcgAhlOX360MKdf1AxoRUnz0bNQSUohxdmOw==
X-Received: by 2002:a4a:e85a:0:b0:333:2aa8:264f with SMTP id j26-20020a4ae85a000000b003332aa8264fmr7277374ooj.65.1650932892015;
        Mon, 25 Apr 2022 17:28:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t3-20020a056870048300b000e686d1389fsm264473oam.57.2022.04.25.17.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:28:11 -0700 (PDT)
Received: (nullmailer pid 613027 invoked by uid 1000);
        Tue, 26 Apr 2022 00:28:10 -0000
Date:   Mon, 25 Apr 2022 19:28:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: remoteproc: mediatek: add
 firmware-name property
Message-ID: <Ymc8mjDNx36OWm1/@robh.at.kernel.org>
References: <20220419123331.14377-1-allen-kh.cheng@mediatek.com>
 <20220419123331.14377-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419123331.14377-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 20:33:30 +0800, Allen-KH Cheng wrote:
> The SCP needs firmware which differs between other platforms and SoCs.
> Add a new property "firmware-name" to allow the DT to specify the
> platform/board specific path to this firmware file.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
