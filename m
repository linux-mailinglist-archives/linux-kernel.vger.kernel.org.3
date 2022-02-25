Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37984C4B14
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbiBYQnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiBYQns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:43:48 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97967DA92;
        Fri, 25 Feb 2022 08:43:15 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so6905659oos.9;
        Fri, 25 Feb 2022 08:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Si+iJ2zhKvF5YLvRPOXET3hV1fppMjzs+UaFXFDwI3Y=;
        b=D0bAqZSwVXMuunDHkum0DleVjb9PUZDB7vC0CBE3dCwcTlg5kp0sCs2gaYJNdNw80Z
         nkG8kv3toQLtL+oN6QKmxsrsXQpfVtIe2/Hxz3/OqI9ZhKZZ8sQ9qI1krGDZXjfCIg1P
         vvQWYlbv5BG5PcgMFkMYdLzDS5eXVuVuqKDYRTYsPP72ddDPsaRZqBe9YjTwTlsUXq+l
         U1yaje2zxPUhHXkgMPYxneC5fQ1rG3alTCd9Q5BQeYFf9D/lGCTMBtQX3WeT4pp2RXkq
         pxSNkQ0o3gBi15x7JXx3V18Y/wGLPKBcxXadcMz+nxdJfKJfK7p7uzILoLEDQro25bca
         w4/w==
X-Gm-Message-State: AOAM530eROO+qLOG/4eD5Ap6fMaJecZhgoE//2HS16UGcBay2BGdRZs1
        xUsFd3s0BH/ZeERfnLFfuw==
X-Google-Smtp-Source: ABdhPJyVL64erAPpA8+nT5f7+kdz/RH/QaYjqSDhpt4WRNkeN4cGTxKxp8BLy29TQl4zF7yzzWSTlg==
X-Received: by 2002:a05:6870:b402:b0:d3:3712:efa7 with SMTP id x2-20020a056870b40200b000d33712efa7mr1652745oap.88.1645807395186;
        Fri, 25 Feb 2022 08:43:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a7-20020a4aae47000000b0031d17643eaasm1198927oon.22.2022.02.25.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:43:14 -0800 (PST)
Received: (nullmailer pid 1063989 invoked by uid 1000);
        Fri, 25 Feb 2022 16:43:10 -0000
Date:   Fri, 25 Feb 2022 10:43:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        tiwai@suse.com, devicetree@vger.kernel.org, perex@perex.cz,
        aaronyu@google.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, zhangqilong3@huawei.com, tzungbi@google.com,
        trevor.wu@mediatek.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be
Subject: Re: [v2 13/17] dt-bindings: mediatek: mt8186: add audio afe document
Message-ID: <YhkHHl8u02MY348o@robh.at.kernel.org>
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
 <20220217134205.15400-14-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217134205.15400-14-jiaxin.yu@mediatek.com>
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

On Thu, 17 Feb 2022 21:42:01 +0800, Jiaxin Yu wrote:
> This patch adds mt8186 audio afe document.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../bindings/sound/mt8186-afe-pcm.yaml        | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
