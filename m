Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F000F5235B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbiEKOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241866AbiEKOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:37:59 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500664EA0B;
        Wed, 11 May 2022 07:37:55 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-edeb6c3642so3061527fac.3;
        Wed, 11 May 2022 07:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9BCuf6md1fXzU+TlOHk5VXDJaJ6H3g0zAe1qyFY7QIk=;
        b=dZh1WxBEeGQKumtPUYfMFuH1dY5rrfiGaIDc4bcJaP49VAK9u+uU5Qe/wwNRGmwDK2
         FvOO+N+OQBSOJOrSyjfDpKjS3F6jxhGPCNd0D9a0xjahUg6V2LHHhV7Rzg3jgoaSJARE
         lsraAq4IcARRKLVaS8h0yZX0nvA59llEnUvJE4Qnn0+doxujYHl30iBRhspYPdr1HW/X
         AV1chRXfl9gx+LHGthJCi1iuo87AxfVtKu3y5WyGZ2wRLhCk/X9m/v8bDtUYxtnP5Iy7
         SfbFFeW5B/vk4ac5QvzcIFKQDTjdQT4vey2ZsfzsoefEet/ZtSQaR8UcABcxc//za5Bp
         JVJw==
X-Gm-Message-State: AOAM533G7NFAS/wH82ykn3B75uUHtup1eX73Jjfdi9LAER50sZJp5KMH
        X1lT9QTJZTspvy0D7KvDYA==
X-Google-Smtp-Source: ABdhPJzV7lHSAaPCIpfLtDq3OLUgefj/X2KavadZ2NnmpnbPgLsOcT7C0+3CfdxjsheCNj3k9xF1Cw==
X-Received: by 2002:a05:6870:65a0:b0:ed:a635:eee9 with SMTP id fp32-20020a05687065a000b000eda635eee9mr2795975oab.48.1652279874613;
        Wed, 11 May 2022 07:37:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t2-20020a056871020200b000e686d1388esm600266oad.40.2022.05.11.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:37:54 -0700 (PDT)
Received: (nullmailer pid 272781 invoked by uid 1000);
        Wed, 11 May 2022 14:37:53 -0000
Date:   Wed, 11 May 2022 09:37:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, roger.lu@mediatek.com, krzk+dt@kernel.org,
        robh+dt@kernel.org, hsinyi@google.com,
        angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com,
        jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v6 01/10] dt-bindings: cpufreq: mediatek: Add MediaTek
 CCI property
Message-ID: <20220511143753.GA272748-robh@kernel.org>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
 <20220505115226.20130-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505115226.20130-2-rex-bc.chen@mediatek.com>
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

On Thu, 05 May 2022 19:52:17 +0800, Rex-BC Chen wrote:
> MediaTek Cache Coherent Interconnect (CCI) uses software devfreq module
> for scaling clock frequency and adjust voltage.
> The phandle could be linked between CPU and MediaTek CCI for some
> MediaTek SoCs, like MT8183 and MT8186.
> 
> The reason we need the link status between cpufreq and MediaTek cci is
> cpufreq and mediatek cci could share the same regulator in some MediaTek
> SoCs. Therefore, to prevent the issue of high frequency and low voltage,
> we need to use this to make sure mediatek cci is ready.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-mediatek.txt       | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
