Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CDF4EB691
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbiC2XPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbiC2XP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:15:27 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D81CB2A;
        Tue, 29 Mar 2022 16:13:43 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 12so20506039oix.12;
        Tue, 29 Mar 2022 16:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IExzvSw3a194l6T1N/gwY3qoCvj4gnDhEAY3Ha2H9NY=;
        b=m771FAU1p7i0yvOBh/ERXgGDRMj9lxc8ZaIVFbsziRKlPzolEqWiuoV2zonqHz0n2i
         HV26q/BcywvK3VtZNUwD1JVMGLGVlI0S0SplnT64xDVJkADyusViZVGhNcPbfAadJ0LA
         WkbvbNkL45Zo0fNxsF1NxjfJMUZojR7OiCOjLOEppop95rUjXvOeIAaQqqKJt6xMly6t
         e7+JDIfVuPv70V2oNFhBU4ZoE3WUTOO3KVdPSmTByopwtXmOZxGY4Dw3962j9AqYS6rL
         YQAc3T9j3Ttbw0ShC03iLqkrYF9yNW5cTCnBCilMAytoHChZI9qrPnHm39NPiYerZMvH
         RGxg==
X-Gm-Message-State: AOAM531zzHLpeh0rbiZig4HwlyGgI4QQmuqptBa/DioOTJTFZs8/ZAz/
        0aECypybv2hJcfwRYMRHI9yJW445qg==
X-Google-Smtp-Source: ABdhPJyWbndVtnhZaOGxEK/6LBjkh8P9MSyR1tz8YaNIP/1OyKH/D8GFHdQieHcEBMcWDY8Iaw2XEw==
X-Received: by 2002:aca:4043:0:b0:2ef:f455:7ac9 with SMTP id n64-20020aca4043000000b002eff4557ac9mr679218oia.71.1648595623047;
        Tue, 29 Mar 2022 16:13:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m16-20020a9d4c90000000b005cb214bef81sm9721558otf.43.2022.03.29.16.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:13:42 -0700 (PDT)
Received: (nullmailer pid 1531833 invoked by uid 1000);
        Tue, 29 Mar 2022 23:13:41 -0000
Date:   Tue, 29 Mar 2022 18:13:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        aaronyu@google.com, linmq006@gmail.com,
        linux-arm-kernel@lists.infradead.org, tzungbi@google.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        trevor.wu@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com, robh+dt@kernel.org
Subject: Re: [v7 1/4] ASoC: dt-bindings: mt8192-mt6359: add new compatible
 and new properties
Message-ID: <YkOSpctgU9w9xhh0@robh.at.kernel.org>
References: <20220324064511.10665-1-jiaxin.yu@mediatek.com>
 <20220324064511.10665-2-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324064511.10665-2-jiaxin.yu@mediatek.com>
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

On Thu, 24 Mar 2022 14:45:08 +0800, Jiaxin Yu wrote:
> 1. Adds new compatible string "mt8192_mt6359_rt1015p_rt5682s" for machine
> with rt1015p and rt5682s.
> 2. Adds new property "headset-codec" for getting headset codec.
> 3. Adds new property "speaker-codecs" for getting speaker codecs.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
