Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE2A4CE086
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiCDXHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCDXHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:07:06 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC786254A82;
        Fri,  4 Mar 2022 15:06:17 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso11147801ooi.1;
        Fri, 04 Mar 2022 15:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wt8pADc1Xor517rfKpON9c9f/2mIwEXF0gypcO8fZOg=;
        b=cl3zXbJXMs97BY4SDRxr6qVrZuNUbYAtxDVQDKvBZAGvi0Mjzj9rkJ7kxGs0uiQQhb
         +5kUB6GsW/etsFiLT8qAzuX4OmS+JjlGptty2wxNC7UOuqmCGWy0m6GcAaTzfM/kmiBp
         qL8nnrGJpdXAmN2+WYbINnpNDl2P0ptRe4HxhP7ek6CiAXK3nT8Fma1Nr3gq565Io78C
         1CberGmfF/x3gNFBchwt5dzTFu5/16f4XgHztloTKSa6bLHCrlVkupJ1Osltn3aQ+bFz
         eTrs+cTyPUE1zJ5CxWDl861uejRFeV90pQcsPwCrVgcJGL21kdRuhPO60vpiZamLpzBn
         Kd4g==
X-Gm-Message-State: AOAM532CRjy0Pv18fg64tIaFW1zH4GiQ3WtMUA+OqSUvNOT6YdNuDn6h
        67szyHAS7qTKkceodhJI0g==
X-Google-Smtp-Source: ABdhPJxcHFc8pGWIPi9xglYELcNC4ePLZUFOeeyR3mGpf4U+jexVsZL+RpS2hNK3I//uPFqp5YAPcg==
X-Received: by 2002:a05:6870:7a3:b0:d7:5fbf:37b7 with SMTP id en35-20020a05687007a300b000d75fbf37b7mr401545oab.16.1646435177210;
        Fri, 04 Mar 2022 15:06:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y28-20020a4aea3c000000b0031c0cddfbf9sm2936625ood.20.2022.03.04.15.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:06:16 -0800 (PST)
Received: (nullmailer pid 626164 invoked by uid 1000);
        Fri, 04 Mar 2022 23:06:15 -0000
Date:   Fri, 4 Mar 2022 17:06:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Daniel Baluta <daniel.baluta@nxp.com>, cujomalainey@google.com,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>, tzungbi@google.com,
        Jaroslav Kysela <perex@perex.cz>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v18 1/2] dt-bindings: mailbox: mtk,adsp-mbox: add mtk
 adsp-mbox document
Message-ID: <YiKbZ8NRyCbcm1Gi@robh.at.kernel.org>
References: <20220225132427.29152-1-allen-kh.cheng@mediatek.com>
 <20220225132427.29152-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225132427.29152-2-allen-kh.cheng@mediatek.com>
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

On Fri, 25 Feb 2022 21:24:26 +0800, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This patch adds document for mediatek adsp mbox
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/mailbox/mtk,adsp-mbox.yaml       | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
