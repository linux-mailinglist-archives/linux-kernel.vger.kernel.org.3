Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB34E58BF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbiCWSxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344160AbiCWSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:53:10 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F2D8A325;
        Wed, 23 Mar 2022 11:51:40 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-de48295467so2645574fac.2;
        Wed, 23 Mar 2022 11:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=URlJ3E8xdDXj7dvw0DzJiLOBO/QAL/39or9/uTvUAn0=;
        b=666bENRmcQtD3IJRGv5PxRAntyiwaZYpjgOs4UoS12pAUYuDKloqP6UmUSJQo5fX94
         nn4ti3Aj+4UWgBY75GfamwbUCIhvF0IpVzmr2Wm1IN4dDx5vs1/JkQTNhJq8fUlq9N6C
         xrafViwH/tUq+bYqZNtiYEVBlzS7v9PmhhRJOBZxBGeCN49KtBug1Lkh2uFbjTqFvblO
         tuQJfDsYeNsh/NwTVq6jYfyLyksEY60O+xQB25viExxwHKVwG/0fl1W3y8/S9xWAZbu7
         0Vrc1ELAe7l6RIj8LCMoeeVgoRyDNn0QS67SCg7olQCy2VrPJtuy9XA4VVtWztAf3bqG
         ceWQ==
X-Gm-Message-State: AOAM5304r5lWYqM7I4mm6PwVwCHlzIby+nixCv9VCYQdgYOm4ZyzdnRB
        b2q5KqNedFTA9tFKeolPVQ==
X-Google-Smtp-Source: ABdhPJw4+Tq2t4g8zBMrR+Ku2UlqZCF8QO1eFhQoEn6G2CpRhH7aqluYozKt2G5xJeOuOB067OTvYQ==
X-Received: by 2002:a05:6870:316:b0:de:2141:932c with SMTP id m22-20020a056870031600b000de2141932cmr711855oaf.172.1648061500075;
        Wed, 23 Mar 2022 11:51:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870831600b000ccfbea4f23sm391083oae.33.2022.03.23.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:51:39 -0700 (PDT)
Received: (nullmailer pid 247860 invoked by uid 1000);
        Wed, 23 Mar 2022 18:51:38 -0000
Date:   Wed, 23 Mar 2022 13:51:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: pinctrl: mt8192: Add wrapping node
 for pin configurations
Message-ID: <YjtsOs5ALNhbdUN+@robh.at.kernel.org>
References: <20220315211936.442708-1-nfraprado@collabora.com>
 <20220315211936.442708-2-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315211936.442708-2-nfraprado@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 17:19:33 -0400, Nícolas F. R. A. Prado wrote:
> On mt8192, the pinctrl node has pinctrl groups to group pin
> configurations. Each pinctrl group contains one or more pinmux subnodes
> to list needed pins and their configurations. By supporting multiple
> subnodes, we can configure different pin characteristics
> (driving/pull-up/pull-down/etc.) in a pinctrl group.
> 
> Update the mt8192 pinctrl dt-binding to add the missing pinctrl group
> node that wraps the pinmux subnodes and update the example at the end.
> While at it, also remove the example embedded in the description since
> it is redundant to the already supplied example at the end.
> 
> This same change was done for mt8195 in commit 79dcd4e840cc ("dt-bindings:
> pinctrl: mt8195: add wrapping node of pin configurations").
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  .../bindings/pinctrl/pinctrl-mt8192.yaml      | 92 ++++++++++---------
>  1 file changed, 47 insertions(+), 45 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
