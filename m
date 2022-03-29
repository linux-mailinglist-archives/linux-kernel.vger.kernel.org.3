Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A234EB6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiC2X2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbiC2X2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:28:22 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CD919CCD6;
        Tue, 29 Mar 2022 16:26:38 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso13801074otj.7;
        Tue, 29 Mar 2022 16:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Onx8whWtYNziaSOWeikFCxBSNS52wmmziZDYwpwSOs0=;
        b=tOEP9uEz2GH5PsSAqDupyOI5TxOy6wGK1pEYeN67WfbryD7pxP9oYVcc2s7ChCWgyJ
         lNLqaFyLDe8nduQ1nDtb2/dmwqseMwl8wlIy0Jd3HWDC3GSUyWeXuFDa0fUVjRhssrgv
         M7UExso35iHa2VYp8PuMV0rJZEkcWIs1xbzC8/a0hXgfYkS+GScwfuQ8tMI8u5XjQkrV
         l+XuRtyJ5NjTZW1AVZzPqG5sENR4Z6LQ2ZwOyAu7O/unfiM66xk06xwhr8nSf5JfOol+
         S/o5WXdSejDm/RrAm1W31i0eawv9+VSmmUnERakh4UoN2INOYaurQBovf0qkwv8xKhFo
         WlLw==
X-Gm-Message-State: AOAM531iONOylcpS0QM84fdmV+vUAR8f+JQGYR2DLXYTWqBPH+uli/OL
        OnJUi0j0S2Bz0s0CRpVZesAbyJR6og==
X-Google-Smtp-Source: ABdhPJwgMeIuk1f9wBngw9sMNVUFDANIzQF6qRJJfG+W5rTEJltAFjng0HItLceLMRGMH3tlj1E5wg==
X-Received: by 2002:a05:6830:82a:b0:5b2:36d5:1603 with SMTP id t10-20020a056830082a00b005b236d51603mr2173120ots.240.1648596397558;
        Tue, 29 Mar 2022 16:26:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q12-20020a4ad54c000000b003245ac0a745sm9268545oos.22.2022.03.29.16.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:26:36 -0700 (PDT)
Received: (nullmailer pid 1552943 invoked by uid 1000);
        Tue, 29 Mar 2022 23:26:35 -0000
Date:   Tue, 29 Mar 2022 18:26:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     yc.hung@mediatek.com, broonie@kernel.org, miles.chen@mediatek.com,
        alsa-devel@alsa-project.org, aaronyu@google.com, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, tzungbi@google.com
Subject: Re: [PATCH v4 6/6] ASoC: dt-bindings: mediatek: mt8195: support
 mt8195-mt6359-max98390-rt5682
Message-ID: <YkOVq9XA9VGSNqzc@robh.at.kernel.org>
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
 <20220324053851.27350-7-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324053851.27350-7-trevor.wu@mediatek.com>
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

On Thu, 24 Mar 2022 13:38:51 +0800, Trevor Wu wrote:
> This patch adds compatible string "mediatek,mt8195-mt6359-max98390-rt5682"
> to support mt8195 board with mt6359, max98390 and rt5682.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/sound/mt8195-mt6359.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
