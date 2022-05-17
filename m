Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F104752A5E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349827AbiEQPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349805AbiEQPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:19:40 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0204D3BA44;
        Tue, 17 May 2022 08:19:40 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id s18-20020a056830149200b006063fef3e17so12384167otq.12;
        Tue, 17 May 2022 08:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UN6I2B54I9z2D5ug0Y8P8AWH5uDCDUlHTLzIM4COgx0=;
        b=KHNHVwB1Peyw65JFlzH6dSwSxWzpVqW2+dWf6yvMwIxZOaGHoPlTIMemUOjJIDzDu+
         klfOkXZc4LugfcbIwNM1dNP7Ks5Ou2utrnBWDcqM+zpaVwAeMALsGInN/ycA77eGBYKn
         HCD1P1v0g0CcIm9YaGBNZxksqYMXoTHCy/ABV3+V/F24867IfoR3S3fOfxjKQloMGJKl
         FqjFeTCS4e49XLfL9+rcFrJoR+IN3ZwNpJAMvMdeW32BWXSzIZ9TmuPL7DmZ5vfoUGEU
         EuKvw3h52k9NLSGj7J+R5ih2nXUZcJTzTN80walYR4636g3SIV+hPr8YIDJosw0AIURD
         93FQ==
X-Gm-Message-State: AOAM533mzDBXZo5Ht98Pc/yowhMQP5J6O15b112lJjdrsKWam+WqjBDL
        hgGv91dVM/ieUa132AjgOA==
X-Google-Smtp-Source: ABdhPJwd1/qQ13wUfaEwF2PFlvVzLH6lZjtPLUqjYrhz0krfm/UkIcRBI+cHHLiFupZ/j6FwuI318A==
X-Received: by 2002:a9d:68cd:0:b0:606:13c7:97c4 with SMTP id i13-20020a9d68cd000000b0060613c797c4mr8633782oto.312.1652800779338;
        Tue, 17 May 2022 08:19:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a056870e30e00b000e686d13889sm7018263oad.35.2022.05.17.08.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 08:19:38 -0700 (PDT)
Received: (nullmailer pid 1056805 invoked by uid 1000);
        Tue, 17 May 2022 15:19:37 -0000
Date:   Tue, 17 May 2022 10:19:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, mathieu.poirier@linaro.org,
        kernel@pengutronix.de, festevam@gmail.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-imx@nxp.com,
        bjorn.andersson@linaro.org, Peng Fan <peng.fan@nxp.com>,
        robh+dt@kernel.org
Subject: Re: [PATCH V3 2/6] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QM
Message-ID: <20220517151937.GA1056761-robh@kernel.org>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
 <20220517064937.4033441-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517064937.4033441-3-peng.fan@oss.nxp.com>
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

On Tue, 17 May 2022 14:49:33 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8QM compatible
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
