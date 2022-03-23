Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE764E58CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiCWSzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbiCWSzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:55:39 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AEC74B2F;
        Wed, 23 Mar 2022 11:54:08 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-d39f741ba0so2617723fac.13;
        Wed, 23 Mar 2022 11:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cWHIqUb2GLClWkPw5kQ250/Lh0uWw4ugg2e9CkpD9ng=;
        b=8PllPUMdvyabJGo+gc/9yNEkLiGzcDVv/gZIeiFey8LrpiIMWSnpuUC1c4U+gVbpag
         FxNEvI1jsk/o/n99W39O7RaINLMGZw/VCkAh2eB3m/yHDZuXwucOFAPM1+1aQEXo3nNu
         JlhJPTjTqEpa70gtp24jLFVNc8Prpg3YyOLidF78XBoepxYWrMZwC7vxIKRo+YMXlhH4
         oxtbBojbhF6NvVjyyGz1K82aGgoUsTAcrhrVlQIcnIOZz261K51MEFy2nnHzUh4hXeWk
         2bq6zePacb4ctofnaXb7DrGulfDMfgxZqoNT6uN51Yu9yi5eckv5Eh22wgD2KkD09kQh
         d/SQ==
X-Gm-Message-State: AOAM533ls5OK8G/xTjJBZrWHXVr4rl2x7oYDgHxX/SChsZxonTWCoCXU
        4CopKpUiazQgA9DWWcMgdA==
X-Google-Smtp-Source: ABdhPJwb31fwcGvR7p9nqoczWVgSbjevAuJ03XKtuwAPPvfJWOWi+SoELyx+qTikU4J6+3nz2lWBqA==
X-Received: by 2002:a05:6871:5cf:b0:de:3ca3:26a0 with SMTP id v15-20020a05687105cf00b000de3ca326a0mr704806oan.136.1648061648208;
        Wed, 23 Mar 2022 11:54:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x6-20020a9d6d86000000b005cdb017ddcfsm333780otp.41.2022.03.23.11.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:54:07 -0700 (PDT)
Received: (nullmailer pid 252266 invoked by uid 1000);
        Wed, 23 Mar 2022 18:54:06 -0000
Date:   Wed, 23 Mar 2022 13:54:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 4/4] dt-bindings: pinctrl: mt8192: Add gpio-line-names
 property
Message-ID: <YjtszlCtzG+XCzBj@robh.at.kernel.org>
References: <20220315211936.442708-1-nfraprado@collabora.com>
 <20220315211936.442708-5-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315211936.442708-5-nfraprado@collabora.com>
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

On Tue, 15 Mar 2022 17:19:36 -0400, Nícolas F. R. A. Prado wrote:
> Add the gpio-line-names optional property to the pinctrl-mt8192 binding
> to prevent dt_binding_check warnings when it is present in the pinctrl
> node in the Devicetree.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
