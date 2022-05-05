Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254DB51B685
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbiEEDX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiEEDXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:23:21 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA44DF44;
        Wed,  4 May 2022 20:19:44 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id c5-20020a9d75c5000000b00605ff3b9997so2197196otl.0;
        Wed, 04 May 2022 20:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yqvha5JiEOg0BqFJb68cq4K7lvQBkFi6q99HJWKVi7I=;
        b=icSsnMl+MtK2B5fzF/5U9TNqq9Gzsknouk5GYbsqvlkdPEYHLMmC6z+OO7kX08HPiF
         FE4pimbvDo1i+KIGB+ybNJT01LvJ9zEoL3soMQSkwrx9D3qlPPhFIlMdB6x6ljuMDaf8
         fpHsERR195z5lMs4okroaCg0INudxmerxigz6U2wDLMUTqHYY7p+AlA++BmkkjW1VqQA
         QCjioFC45s11bupcnqT1PFZiOADKqj6Mj5bGKCxJF7xPsz4UX5jKsKIL9LMPz1evo7Zv
         wW7KJOboHSoGz/lOxH0sW1Wn8wJV5+X1Ip6tdykcoy3wH3kACJudYMEfSNxMjT3uN1j/
         at6w==
X-Gm-Message-State: AOAM531njWFcrdtCD39wWkpHFt+id/MAKnFxRn7z3KOmDNbMy6rklrvw
        KjvimQItChxBfQjJ1wipQQ==
X-Google-Smtp-Source: ABdhPJznORmirZQGS7vd9EyHowL4V4l2q++7ZFFUosNNbliY0OsyuT1Hz46Ncjg4IYM0YxRGp7esNA==
X-Received: by 2002:a05:6830:33ca:b0:605:e2f6:d39c with SMTP id q10-20020a05683033ca00b00605e2f6d39cmr8367138ott.123.1651720783380;
        Wed, 04 May 2022 20:19:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b00325cda1ffb8sm240936oil.55.2022.05.04.20.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 20:19:42 -0700 (PDT)
Received: (nullmailer pid 2748179 invoked by uid 1000);
        Thu, 05 May 2022 03:19:42 -0000
Date:   Wed, 4 May 2022 22:19:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, festevam@gmail.com
Subject: Re: [PATCH V2 1/3] arm64: dts: freescale: Add i.MX93 dtsi support
Message-ID: <YnNCTlM75jwRiyq2@robh.at.kernel.org>
References: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
 <20220503122951.4147636-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503122951.4147636-2-peng.fan@oss.nxp.com>
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

On Tue, 03 May 2022 20:29:49 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX 93 applications processors are the first in the i.MX portfolio
> to integrate the scalable Arm Cortex-A55 core, bringing performance
> and energy efficiency to Linux-based edge applications and the
> Arm Ethos-U65 microNPU, enabling developers to create more capable,
> cost-effective and energy-efficient ML applications.
> 
> Add the basic dtsi support for i.MX93.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 623 ++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 337 ++++++++++
>  2 files changed, 960 insertions(+)
>  create mode 100755 arch/arm64/boot/dts/freescale/imx93-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93.dtsi
> 

Acked-by: Rob Herring <robh@kernel.org>
