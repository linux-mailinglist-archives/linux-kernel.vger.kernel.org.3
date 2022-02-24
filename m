Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7868A4C3781
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiBXVUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBXVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:20:12 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB12763F3;
        Thu, 24 Feb 2022 13:19:42 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id x193so5146699oix.0;
        Thu, 24 Feb 2022 13:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6QnJiv1rMIaign9iD0tkUPqz3xHrGrktiGAlyZNFsI=;
        b=B1WcRGmxaOazFS/vbV9s351dGm18Tv2LbOyX9sggrsl30k3pDEhsumjg75TALEzTrg
         9QPNI0foyR4h/usKbz0RQZmfLJ0tysZ7NGGFIlCkIbupLiDin5rN4gl7zQ+0FCTGJ4a7
         Xjz2No4UTsWoXuyUox64dLjsm60M+OVoiaITqAM4UILpoa5+4XQjXge39j+P9PONqnIF
         J25H4XATQYX3enbPk/g1DKT+IzbJCseIU54ZQ6FmXiZp6hAu6X1A4VObFp0Fu/T7kcKW
         7ciLONAfuYvrUO2NtnQSY0D4veN/7LkgVeOULXWlp1JQ0bBZPFx1M3IsIe0srLUHLUfo
         XxwQ==
X-Gm-Message-State: AOAM532Ej0mHphw2FLoYgFufEQvO//OnY+Gkejrjgdj2AZQkhpQJc5iB
        QHPb2WR2dtcZv6kuqHZ9lA==
X-Google-Smtp-Source: ABdhPJzlgmL4Mdb2h4dOX1lcM83XGfZginiIrhciEV3qmI1oyjIGjejhSg9GcmdUZj0IZYs9PECzEg==
X-Received: by 2002:a05:6870:f80d:b0:d3:12c8:d6bf with SMTP id fr13-20020a056870f80d00b000d312c8d6bfmr11660oab.270.1645737581477;
        Thu, 24 Feb 2022 13:19:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g2-20020a9d5f82000000b005af678c9cfdsm254665oti.41.2022.02.24.13.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:19:40 -0800 (PST)
Received: (nullmailer pid 3607370 invoked by uid 1000);
        Thu, 24 Feb 2022 21:19:39 -0000
Date:   Thu, 24 Feb 2022 15:19:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, allen-kh.cheng@mediatek.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
Subject: Re: [v2,4/4] dt-bindings: pwm: Add compatible for MediaTek MT8186
Message-ID: <Yhf2a/h6H1/9sN6b@robh.at.kernel.org>
References: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
 <1645003971-16908-5-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645003971-16908-5-git-send-email-xinlei.lee@mediatek.com>
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

On Wed, Feb 16, 2022 at 05:32:51PM +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8186 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index 768ab04d3764..1f45b1b8c3d4 100755
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -17,6 +17,7 @@ properties:
>        - mediatek,mt6595-disp-pwm
>        - mediatek,mt8173-disp-pwm
>        - mediatek,mt8183-disp-pwm
> +      - mediatek,mt8186-disp-pwm
>        - mediatek,mt8192-disp-pwm
>        - mediatek,mt8195-disp-pwm

It seems unlikely that every SoC has a different version of h/w for 
something as simple as a PWM. There's not an appropriate fallback? The 
first version from an SoC that has all the features and would work with 
existing driver unchanged?

Rob
