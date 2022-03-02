Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B14CACA2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbiCBR5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244241AbiCBR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:57:18 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A72ED0496;
        Wed,  2 Mar 2022 09:56:35 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id z7so2446995oid.4;
        Wed, 02 Mar 2022 09:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E3aLsuOfCBsmhkChGf2s5GrLLwWKZp2uk4wG0Gade0U=;
        b=yLU582GSkc8UzbhxhFRAQ7ey51te5v308y1r+lQdtoQGnY88wsP90J50exFT0YDjwK
         9yahfSl9aPerRdC37cdsPXlZd87S4ukz3U9pMVe6pytN4pC+FfLmD30sW/pyXSLZcPRr
         gWWNofr5dKn443GiHeTBfht9DF7tcbVmikOTs2DKM7AexwHOMY72J2WM4XMH15AIk20R
         pbdR+g60j5kxqpORCcptvA3iYSbIeOBKw+0/GBD0Bs1agtWDZEWlFRafXJnvq0rZEeiZ
         fUY1J24aH8CO4MNwRYNgOslUAxt/+uuovjFHF4AeTj17TXcDYdbw+yAGh5Ow5LDxtQ1+
         7ueA==
X-Gm-Message-State: AOAM530Bjp9TqYwM4eM7RYLb/+HFvStCxd0VMnaoIG5hWKdA7uoPW7xp
        atg2V9tYPDsX22Sj2jV1RQ==
X-Google-Smtp-Source: ABdhPJx5jKaOBRFjXcTFqtVUu1dRgqLuIVrt3JNSatECmDWjNWPB+YHoXUcLyUWMPIRIFGq2lqn0UA==
X-Received: by 2002:a05:6808:179d:b0:2d9:38a3:2eb1 with SMTP id bg29-20020a056808179d00b002d938a32eb1mr952293oib.25.1646243794834;
        Wed, 02 Mar 2022 09:56:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i2-20020a056870c1c200b000d7355852b3sm3753152oad.19.2022.03.02.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:56:34 -0800 (PST)
Received: (nullmailer pid 3962631 invoked by uid 1000);
        Wed, 02 Mar 2022 17:56:33 -0000
Date:   Wed, 2 Mar 2022 11:56:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com, allen-kh.cheng@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH v3,3/6] dt-bindings: pwm: Add compatible for MediaTek
 MT8183
Message-ID: <Yh+v0UaXqdYWLcm3@robh.at.kernel.org>
References: <1646199106-26879-1-git-send-email-xinlei.lee@mediatek.com>
 <1646199106-26879-4-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646199106-26879-4-git-send-email-xinlei.lee@mediatek.com>
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

On Wed, Mar 02, 2022 at 01:31:43PM +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8183 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
