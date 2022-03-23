Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611574E58C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbiCWSzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiCWSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:54:59 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A0E6E295;
        Wed, 23 Mar 2022 11:53:28 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-de3eda6b5dso2685934fac.0;
        Wed, 23 Mar 2022 11:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R1GZjbdP4HW0QI4qXMYmlwaAcLv4Ffj0a/tHCi9+vpk=;
        b=X0NEDqaFoQyqKFezsmfPQOZi25xnWdv/x299AGOPX1bMuUCX1n00+nEQxu30qa4Y6s
         hjQ3WayY1hJUsY3aEbTsyMsGp2UKFjLObn1iAElMrNxpJQYZ/eKuA4H/E+yLMBDc+ByZ
         AmdxunbG9h8zhBORAcPbvXqEvKSU3YQTkAKS3soKkcA6DLzCDxmhBYHu7Z8t929b7/1/
         2jcRsmHReTC/z3I1nzFFF616rmUWZ5Ep1aAyLOReLQTTdQOJwANRe72qdNFl6uQXY/OR
         DF81jHNxeXGiTGBuHfpl1YFWps820viqcPDNruh1mgXYVlxS23md8znotajo4IDPkwnZ
         AJig==
X-Gm-Message-State: AOAM530HvU/g106kjDy6QECzHXgHPeQuh7L3jivjL2hVZx5BOLLVPzyI
        rTfoQu21NMNNMXTuJHedOg==
X-Google-Smtp-Source: ABdhPJx6M40jr2JUgXyCZ3VQt0vR6pvpdOhQdzF8sAxQ3kx3PhG36yMGKu53XUo7jDiXv5MIVHT3kQ==
X-Received: by 2002:a05:6870:3294:b0:dd:b834:50d7 with SMTP id q20-20020a056870329400b000ddb83450d7mr5059098oac.279.1648061607630;
        Wed, 23 Mar 2022 11:53:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z26-20020a9d62da000000b005b23f5488cdsm311698otk.52.2022.03.23.11.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:53:26 -0700 (PDT)
Received: (nullmailer pid 250878 invoked by uid 1000);
        Wed, 23 Mar 2022 18:53:25 -0000
Date:   Wed, 23 Mar 2022 13:53:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: pinctrl: mt8192: Add
 mediatek,drive-strength-adv property
Message-ID: <Yjtspa6OGRpSKsvm@robh.at.kernel.org>
References: <20220315211936.442708-1-nfraprado@collabora.com>
 <20220315211936.442708-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315211936.442708-3-nfraprado@collabora.com>
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

On Tue, 15 Mar 2022 17:19:34 -0400, Nícolas F. R. A. Prado wrote:
> Add the mediatek,drive-strength-adv property to the pinctrl-mt8192
> dt-binding to allow further drive current adjustments for I2C nodes on
> MT8192. It is the same as in mt8183-pinctrl.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>  .../bindings/pinctrl/pinctrl-mt8192.yaml      | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
