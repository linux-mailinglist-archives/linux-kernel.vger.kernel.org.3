Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554654CE116
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiCDXmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiCDXmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:42:04 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1A56D4C9;
        Fri,  4 Mar 2022 15:41:15 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id z7so9470319oid.4;
        Fri, 04 Mar 2022 15:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M5iwGSDdY2W1QgyJNAYWoPTA/ZIrFOgrco9BAm31DxA=;
        b=AL1smD3zN3sMFhx9SAZQ+bIcm9Ih0hinQyHxGLJ+F1hvdnvcAaOhf+AQXjMwZJuiOg
         452DBmWRZE9eZ1x+ELCgo02e/KvqEcMHQHAtGm8HPXQCjE8tGrfopXEbp9GLTttcuVbM
         7+FNettAUyMx2jJt6gjydZz96H+hd0IEcjhKlfh5rROLtcsimhBw7BvtuPCBTDe/r0By
         r1rJKMQBrIcK5yex+Sl7/2064SLr4iDebqHBELuXGk4T7McNn9ZfgBKHkry9yym9+Zsg
         L4BeY0xNV/+OVLIBq1iO4Cgt9LwZUnsF+OvlPKksfhV+skaed6KUpUBjzMtNbPELURZD
         5vVA==
X-Gm-Message-State: AOAM531AfRGj0JZMR/lzUynxh7QeDKGLzIKSpZ/nDAp9Tmdw/a/pWBsy
        M4Ob9CkJli2j3UjZOwWkmA==
X-Google-Smtp-Source: ABdhPJw6s9xCimPh++z5LAJxShkHR1sFTlm6l83hbiYcKPIoPpOoIsougYSB45a8VTpMUYmxD3z/Sw==
X-Received: by 2002:a05:6808:1287:b0:2d9:a01a:4bb1 with SMTP id a7-20020a056808128700b002d9a01a4bb1mr552647oiw.216.1646437275206;
        Fri, 04 Mar 2022 15:41:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a4-20020a9d6e84000000b005afe328af91sm2804581otr.54.2022.03.04.15.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:41:14 -0800 (PST)
Received: (nullmailer pid 689808 invoked by uid 1000);
        Fri, 04 Mar 2022 23:41:13 -0000
Date:   Fri, 4 Mar 2022 17:41:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, shawnguo@kernel.org, linux-imx@nxp.com,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        linux-arm-kernel@lists.infradead.org, stefan@agner.ch,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        festevam@gmail.com
Subject: Re: [PATCH V2 1/2] dt-bindings: pinctrl: imx93: Add pinctrl binding
Message-ID: <YiKjmZIO38X+5VRL@robh.at.kernel.org>
References: <20220228010103.2725893-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228010103.2725893-1-peng.fan@oss.nxp.com>
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

On Mon, 28 Feb 2022 09:01:02 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add pinctrl binding doc for i.MX93
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Licence update
>  Move allOf above properties
> 
>  .../bindings/pinctrl/fsl,imx93-pinctrl.yaml   | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
