Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0B54D5333
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbiCJUpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiCJUpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:45:45 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3B013C279;
        Thu, 10 Mar 2022 12:44:44 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id o106-20020a9d2273000000b005b21f46878cso4884073ota.3;
        Thu, 10 Mar 2022 12:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eHD+QEEE7WXDBy+HR8ki9zNPunEiiwpvW7wALZuHn0U=;
        b=cvtiUhpnXEs8YB/ed6MHtKP6vf85hzGsA/3dy28C5m+8Pvpbetkvg9jl5Kawc2j/Cm
         n1CGZmi3RU6oUcJGNx+Phl2qXlBciZ6ixgauZ20oVqhR7KYqOzI1EUJAYAEOVcWgg1Nb
         SLns19Xg16kyFjir1wxgjp7Yu/godpO78KneKcEFFfUifWmllXDfaiYhrJa84NacHLT9
         hPRBeqXsD+tggAwTI1InV4kT8HDaj4Z1KNvFrOz4mgS+2XWWB0nzsi/XG9ewmsy8Uz7t
         gUOQ1AMS1gd6piIwCuxuo2VpNMALfxTcK8cHi5Lu9ZVEl/NpJW4vDt62or7bwOS/aYAu
         sYHA==
X-Gm-Message-State: AOAM533zFjTykbvaF5EbzmmtY3FGvoWBWP4EsAEzDmvnOOkGuaWashZU
        5AD5NiiA969d9g0Zi+mzbQ==
X-Google-Smtp-Source: ABdhPJy3TwiukHGegqsMqO5kZKdbFiV+T89f8ON8hygQNaY6t2GB85ddp3G6Dcem5mUuTRtykYoulQ==
X-Received: by 2002:a05:6830:1ac4:b0:5b2:319a:8c3 with SMTP id r4-20020a0568301ac400b005b2319a08c3mr3511801otc.203.1646945083574;
        Thu, 10 Mar 2022 12:44:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l3-20020a056830268300b005b21c30a3c5sm2975223otu.29.2022.03.10.12.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 12:44:42 -0800 (PST)
Received: (nullmailer pid 2036124 invoked by uid 1000);
        Thu, 10 Mar 2022 20:44:41 -0000
Date:   Thu, 10 Mar 2022 14:44:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Chang <jia-wei.chang@mediatek.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fan.chen@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH 2/4] dt-bindings: cpufreq: mediatek: add mt8186 cpufreq
 dt-bindings
Message-ID: <YipjOXdCNUxdy+ey@robh.at.kernel.org>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
 <20220307122151.11666-3-jia-wei.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307122151.11666-3-jia-wei.chang@mediatek.com>
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

On Mon, Mar 07, 2022 at 08:21:49PM +0800, Tim Chang wrote:
> 1. add cci property.
> 2. add example of MT8186.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek.yaml    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
> index 584946eb3790..d3ce17fd8fcf 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
> @@ -48,6 +48,10 @@ properties:
>        When absent, the voltage scaling flow is handled by hardware, hence no
>        software "voltage tracking" is needed.
>  
> +  cci:
> +    description:
> +      Phandle of the cci to be linked with the phandle of CPU if present.

We already have a binding for this. See cci-control-port.

> +
>    "#cooling-cells":
>      description:
>        For details, please refer to
