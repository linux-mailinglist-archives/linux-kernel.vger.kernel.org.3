Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A105136EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbiD1OfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348411AbiD1OfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:35:15 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7267AAE3E;
        Thu, 28 Apr 2022 07:31:58 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-e93ff05b23so5309998fac.9;
        Thu, 28 Apr 2022 07:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EFB95ppsemYVokN3gYO95lpxo39WR8kyQdqON1ZHZnQ=;
        b=vhGvvtJ6nVfG8Qr3nlwE2vf6S8rd29m1xuq0Y5whv0JwHI6zde7NT1lU4p7BWvppwt
         +G8kYcNnbEvnI4ctZw1elLNr3Y9ch/ZTrWolwCk/lE57/Im6496xpse4X3Ik776aD5XU
         INBpxWNBPl2iEXx+rLOT+KbpNwve2ATwFEdRlF0cq89PtUy4IdKEo5h7hYelBB3zxFah
         KUqxaSynTfak1YV4kV5EW5slIyCMQlkVdjySoBksMeEODO9CugFdJ/uAL5ckWxW4YhOF
         jdeYux/X9HfDo6fu9bp1OK+6f2XGRjWujGgBJYJosy46/3tWAyXubHW1ytWkNirm4n6E
         lVWQ==
X-Gm-Message-State: AOAM530kvfUg6kw7zH86yvEySnUl/EViXweivg5z1p8ihRO/6cugPKic
        B6UEVzBqU+pZoL0SlLehkA==
X-Google-Smtp-Source: ABdhPJw235998b030Ovpn3X4h/3URvpBnssiViFzusdjem+i4RpxdZR+j/0DQd7KDFfgjXtOmKRTVA==
X-Received: by 2002:a05:6871:809:b0:e9:1bc3:9c5c with SMTP id q9-20020a056871080900b000e91bc39c5cmr11214584oap.289.1651156318117;
        Thu, 28 Apr 2022 07:31:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o64-20020acad743000000b002ef3b249b9esm63207oig.58.2022.04.28.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:31:57 -0700 (PDT)
Received: (nullmailer pid 2185535 invoked by uid 1000);
        Thu, 28 Apr 2022 14:31:56 -0000
Date:   Thu, 28 Apr 2022 09:31:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        tzungbi@google.com, linux-mediatek@lists.infradead.org,
        trevor.wu@mediatek.com, matthias.bgg@gmail.com, aaronyu@google.com,
        julianbraha@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [v4 18/18] dt-bindings: mediatek: mt8186: add
 mt8186-mt6366-rt1019-rt5682s document
Message-ID: <YmqlXNGAQLKb5LLO@robh.at.kernel.org>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
 <20220428093355.16172-19-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428093355.16172-19-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 05:33:55PM +0800, Jiaxin Yu wrote:
> Add document for mt8186 board with mt6366, rt1019 and rt5682s.

Same comments apply to this patch too.

> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
