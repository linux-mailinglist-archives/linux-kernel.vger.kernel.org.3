Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882E955C3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbiF0WTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiF0WTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:19:12 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C07642;
        Mon, 27 Jun 2022 15:19:11 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id a16so6982247ilr.6;
        Mon, 27 Jun 2022 15:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+QVxwD8yIrWuVJgdKD5xz189GpEN9nJJBt5B6wnzG8k=;
        b=1Q1304slBgs0SQPdiMYQkhzLF71cHa0VEBxDM3BQbO1IRtGF54Uq9/buFgesoQjtTn
         FTGcsl7RMC9A6BsKvKhkldrH1+AGKNos7Pm4zk88yrcfgXruU0KJeDNvWkXb62ZJ4qIr
         fAvoCT/I7DBfOl35O7umq/XIxD2qrqnKDMjDUtM0UYxPKPes2QF1plylsYpJR5HBaPF1
         KsKnBdH6R+lSE2k6Ip/IfdBaLm3CeMcGipbHIDqV11iFf80GFdlxJ8EkRwG3koTyMLCA
         fF/kEFCxeqaPTLK1ur15JeDpa4EtlZduc4glRELOgabf92c3D0361WgiBuvFgvLdphEe
         mDnA==
X-Gm-Message-State: AJIora+tZdvc4M5pr3gojBsSg9JwCGYxLKUIV5eSRphdwbD/864G05ki
        /Bgv7T+V+aY02FckvX3BRA==
X-Google-Smtp-Source: AGRyM1sis2hznTKf4pwNUHK7FSWne1FszuXKZi8mbiSLiHFmJrZBzUnib5ksXyoMiJI9bd7xwEqWDQ==
X-Received: by 2002:a92:d946:0:b0:2d8:e271:79c2 with SMTP id l6-20020a92d946000000b002d8e27179c2mr8570967ilq.240.1656368351207;
        Mon, 27 Jun 2022 15:19:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e17-20020a6b5011000000b00675594df2d3sm564111iob.17.2022.06.27.15.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:19:10 -0700 (PDT)
Received: (nullmailer pid 3067526 invoked by uid 1000);
        Mon, 27 Jun 2022 22:19:09 -0000
Date:   Mon, 27 Jun 2022 16:19:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        shawnguo@kernel.org, aford173@gmail.com, abelvesa@kernel.org,
        linux-imx@nxp.com, djakov@kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-arm-kernel@lists.infradead.org, abailon@baylibre.com,
        marex@denx.de, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, Markus.Niebel@ew.tq-group.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        paul.elder@ideasonboard.com, abel.vesa@nxp.com,
        kernel@pengutronix.de, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 2/9] dt-bindings: interconnect: add fsl,imx8mp.h
Message-ID: <20220627221909.GA3067472-robh@kernel.org>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
 <20220616073320.2203000-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616073320.2203000-3-peng.fan@oss.nxp.com>
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

On Thu, 16 Jun 2022 15:33:13 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add fsl,imx8mp.h for i.MX8MP
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/dt-bindings/interconnect/fsl,imx8mp.h | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/fsl,imx8mp.h
> 

Acked-by: Rob Herring <robh@kernel.org>
