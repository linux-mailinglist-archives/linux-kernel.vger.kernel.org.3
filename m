Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC6F500236
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiDMXFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbiDMXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:05:07 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E56255AE;
        Wed, 13 Apr 2022 16:02:45 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e2afb80550so3613698fac.1;
        Wed, 13 Apr 2022 16:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dGLCCj51MkIzf2vXEtRhMBdKTU97nBZt+VOtgE9+Gtk=;
        b=bpcS3024J0DRQVRm123Dxd82ebkf3Bf+HRGStxTVIxQuYb/0tLgsGsunJPPDlyHH6U
         k0MBtDp09+lFRbQGmFtz168rimiKIH9ClWf9E47ufUMCHlaY0+1wgl4Ls3uJR9Cn5iQ1
         2r/mAO3/OvPJ//qJXhsOwoA/y0FxrHN9Pfbb9E+GIf3LwTvPBHe1KOOPpbFNMfgQ6XeJ
         d/QZ6fvs+RVOavA7m4ZX0TKPCIKIJCD2Hsp+y7QTZ5FEPfI5zMVqJOxNXESNwi+2Fknc
         JzXocJktE7sjTe1NopQ3ktZxUlc9trqDqbtcK28IcvVT8NDw0ISTLljejW0eO2m9rQa9
         yA2g==
X-Gm-Message-State: AOAM531INU9tfMQ7jf2prtvuxkXA+LneDOPw0i4rO4bLHC4WYIf0QGk0
        aQHB4MpVYHIHiQv7dhL5Rg==
X-Google-Smtp-Source: ABdhPJxs7Cpn96X2RQDhvRVBftdBJgNx8HGYgvUvc3HyiqWruHo7eL1oBmK4BQowGjBrYomgw4HTDg==
X-Received: by 2002:a05:6870:e893:b0:e2:ecbc:e581 with SMTP id q19-20020a056870e89300b000e2ecbce581mr189032oan.193.1649890964457;
        Wed, 13 Apr 2022 16:02:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000d277c48d18sm194761oao.3.2022.04.13.16.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:02:44 -0700 (PDT)
Received: (nullmailer pid 4101311 invoked by uid 1000);
        Wed, 13 Apr 2022 23:02:43 -0000
Date:   Wed, 13 Apr 2022 18:02:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie,
        yongqiang.niu@mediatek.com, nancy.lin@mediatek.com,
        krzk+dt@kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, jason-jh.lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        allen-kh.cheng@mediatek.com, chunkuang.hu@kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] dt-bindings: display: mediatek: Update disp_aal
 binding for MT8192 and MT8195
Message-ID: <YldWk9eTLbXBcbX+@robh.at.kernel.org>
References: <20220411035843.19847-1-rex-bc.chen@mediatek.com>
 <20220411035843.19847-4-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411035843.19847-4-rex-bc.chen@mediatek.com>
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

On Mon, 11 Apr 2022 11:58:43 +0800, Rex-BC Chen wrote:
> Disp_aal of MT8192 and MT8195 are fully compatible with disp_aal of
> MT8183. Therefore, we move the them to item "mediatek,mt8183-disp-aal".
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
