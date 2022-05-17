Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF7352A5E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349759AbiEQPTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349788AbiEQPTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:19:37 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52BA3BA51;
        Tue, 17 May 2022 08:19:30 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id q10so22639629oia.9;
        Tue, 17 May 2022 08:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sk7To/cnY408tAi0eEPtXkxFL35aqCypY0kkg/jqdLw=;
        b=qXuq+37RMMViL9Fs9LXQM/JJwpqf3Ne9edCD8fuXYrN8jmeXs8TFcj9eukf/dxTuev
         fO4HgOv/QWWAd6or7PUTkUZ1CH0+JNSbeBRI6oLY5YB5L2nmoWOFG1ftZTNDZ211Da6E
         fCJI9aHDOxXnEaldvf4JQLOWljshL5vUjVV4TReTZ2EhJEjr0Btwd8YP2hksoofVzVh8
         1VWWHEDpeMtFjNuNBjqaIQYb/Rt6OhpAvqTMfuw3Vp+juIonL/At7rLEyCJgQMqtwkkB
         84LuGMGF8g5zQaa/RbmGzp5h0w+lB2lPQ77pXLge+nQis+TMOCJ8vjxdwn+mcLR0PFfQ
         tZOA==
X-Gm-Message-State: AOAM533CC2JMG8T8bTaHHFkxLTg9MU9Sl2XCZyBfGndtxFa5mZbP5E1M
        ih58EGPv2XzPdvyz5DZNHg==
X-Google-Smtp-Source: ABdhPJwkcmCqKlXiFmdWk4FKdCcrkh4JqOk5ARujtp8mTS1TQ2XWBLTKQX3OKemV6gUSZmTCnpa9nw==
X-Received: by 2002:a05:6808:1201:b0:325:75e1:25a8 with SMTP id a1-20020a056808120100b0032575e125a8mr16753250oil.18.1652800770085;
        Tue, 17 May 2022 08:19:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h9-20020a056870538900b000edae17a8cesm6801068oan.3.2022.05.17.08.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 08:19:29 -0700 (PDT)
Received: (nullmailer pid 1056432 invoked by uid 1000);
        Tue, 17 May 2022 15:19:28 -0000
Date:   Tue, 17 May 2022 10:19:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, festevam@gmail.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        s.hauer@pengutronix.de, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH V3 1/6] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QXP
Message-ID: <20220517151928.GA1056374-robh@kernel.org>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
 <20220517064937.4033441-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517064937.4033441-2-peng.fan@oss.nxp.com>
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

On Tue, 17 May 2022 14:49:32 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8QXP compatible
> 
> Add a new property fsl,resource-id for SoC which supports SCFW.
> This property is used to check whether remote process is under control
> of Linux or not.
> 
> Add fsl,entry-address to specify the entry address which used by SCFW
> to kick M4.
> 
> To i.MX8QM/QXP, when M4 is in the same hardware partition with Cortex-A
> cores, need power up M4 through SCFW, then M4 could start. So introduce
> power-domains property
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/remoteproc/fsl,imx-rproc.yaml        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
