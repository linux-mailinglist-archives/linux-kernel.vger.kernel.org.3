Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E1C4C4AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbiBYQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242974AbiBYQ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:27:12 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA061CF098;
        Fri, 25 Feb 2022 08:26:39 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so6833757oot.11;
        Fri, 25 Feb 2022 08:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X+JqfUsqraXHT66jiXxwdmiSs8aXoZzc7qj34oZ5zw0=;
        b=anUy5naoZFfCvjPIj07QLnMDQq55ZURQjRjWedrUrZZdhYraLoXDaet4FMJvZAVM6P
         CPepwoxeZ26+5yR2iPOhoMguyF995dVjUM+iD6sNkRq3DI14ULgvLs38oKyi1zEcTSCc
         U/ghgefqlE9GNxbpyWi6vjoWmoq+V4ntWKUT+uY8sMTtY9VER5e1+SZbzzzgym+cKVvy
         +qDwOGyMT+srp/ST9bofydPopG+Iyh29WHi1kJMlbC+DjCjBMSBQcH44asGGd2fiYF0m
         2eMUl4oPVCahJI8N85koBEqB1P4ArlvCXS20lKx4Ry2YoeLmfhBz+0qr01Uslxr5s2Cb
         XzBA==
X-Gm-Message-State: AOAM530bgWHwVIrQNnEExjhz2ml8FRqK5XtRUweau/FlfDZ7Sj8siiXw
        ZnCdhJWl55zru/0q4QLdaaH8xz2RJw==
X-Google-Smtp-Source: ABdhPJw/vcrFI/CjF4cimyIVyp6KlPE/kC0dGCY0QDWKVaSEMQmUHALL39y0AM6WyQ4p/4kwWTKUHQ==
X-Received: by 2002:a05:6870:88b:b0:d6:eac9:56d9 with SMTP id fx11-20020a056870088b00b000d6eac956d9mr1000147oab.56.1645806399005;
        Fri, 25 Feb 2022 08:26:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f8-20020a4ab648000000b0031d1cf9aef6sm789502ooo.48.2022.02.25.08.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:26:38 -0800 (PST)
Received: (nullmailer pid 1039466 invoked by uid 1000);
        Fri, 25 Feb 2022 16:26:37 -0000
Date:   Fri, 25 Feb 2022 10:26:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, runyang.chen@mediatek.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [3/4] dt-bindings: reset: mt8186: add DSI reset bit for MMSYS
Message-ID: <YhkDPe3KuaRW6b2Y@robh.at.kernel.org>
References: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
 <20220216014505.28428-4-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216014505.28428-4-rex-bc.chen@mediatek.com>
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

On Wed, Feb 16, 2022 at 09:45:04AM +0800, Rex-BC Chen wrote:
> Add DSI software reset bit which is controlled by MMSYS for MT8186.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8186-resets.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8186-resets.h b/include/dt-bindings/reset/mt8186-resets.h
> index 36e5764e2e6c..5f850370c42c 100644
> --- a/include/dt-bindings/reset/mt8186-resets.h
> +++ b/include/dt-bindings/reset/mt8186-resets.h
> @@ -30,4 +30,7 @@
>  #define MT8186_TOPRGU_IMG2_SW_RST				22
>  #define MT8186_TOPRGU_SW_RST_NUM				23
>  
> +/* MMSYS resets */
> +#define MT8186_MMSYS_SW0_RST_B_DISP_DSI0			19

This can just be squashed into the previous patch.

> +
>  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8186 */
> -- 
> 2.18.0
> 
> 
