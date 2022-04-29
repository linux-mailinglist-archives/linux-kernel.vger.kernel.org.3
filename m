Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5E51588D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381542AbiD2Wkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbiD2Wkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:40:39 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE401996BB;
        Fri, 29 Apr 2022 15:37:20 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id c5-20020a9d75c5000000b00605ff3b9997so849939otl.0;
        Fri, 29 Apr 2022 15:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cECeERhvUI5B2Nya2PZFr4hXbWHDmZxUWHyaVMrMdOM=;
        b=n7zQ6t42q/HLy/I56pd+mslpvPvM4tAT8AvTzewJpBSjffFjlBeU0Y4VCV/vSAEs0T
         rZgk3BAyRf2C8oxjcIHeobJI/HRwLLOUQU1JhDtpwbc0GB/ou7UGAuw9JGC7ISgQNAzn
         YfVekApeLcyH90cv95ciy1hpx88nhETO/8u/aF5pcExQvNPCXlFuZe9IxqvDfYYOD144
         8dkYEH8erashvsriG+V7txMtSzBbz8WnX38+DUav+XcG8bWPiTfnr46STfCG7W6tomHO
         ldS/8xylZ9N/z0UprEL5geLTIQszi9oAUcv3W5KqrQw8mAzmUuDU8nxMEPXfMgtvE6JO
         5k9g==
X-Gm-Message-State: AOAM531Eh2qRDE7x4kLvLKYCxG0958KkKhoP6vgssZS9aSfaW8x/0/c3
        SEqkzdiEVZ5MrdBokLaiVA==
X-Google-Smtp-Source: ABdhPJyRAmQ8+XOfTHvj7UZzS2Ges1j2q3irvixYxfrcbLWzrJA+bVtMu1axF6/4PRoI3OhLfPzLBQ==
X-Received: by 2002:a05:6830:3155:b0:605:57e8:c8de with SMTP id c21-20020a056830315500b0060557e8c8demr577896ots.170.1651271840073;
        Fri, 29 Apr 2022 15:37:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t3-20020a05687044c300b000e686d13892sm3485854oai.44.2022.04.29.15.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:37:19 -0700 (PDT)
Received: (nullmailer pid 3029410 invoked by uid 1000);
        Fri, 29 Apr 2022 22:37:18 -0000
Date:   Fri, 29 Apr 2022 17:37:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        clin@suse.com, linus.walleij@linaro.org, festevam@gmail.com,
        mturquette@baylibre.com, marcel.ziswiler@toradex.com,
        soc@kernel.org, sboyd@kernel.org, shawnguo@kernel.org,
        Mr.Bossman075@gmail.com, linux-imx@nxp.com,
        daniel.lezcano@linaro.org, tharvey@gateworks.com,
        linux-gpio@vger.kernel.org, dev@lynxeye.de,
        giulio.benetti@benettiengineering.com, stefan@agner.ch,
        devicetree@vger.kernel.org, tglx@linutronix.de, abel.vesa@nxp.com,
        s.hauer@pengutronix.de, olof@lixom.net, linux-clk@vger.kernel.org,
        sebastian.reichel@collabora.com, aisheng.dong@nxp.com,
        robh+dt@kernel.org, arnd@arndb.de, leoyang.li@nxp.com,
        cniedermaier@dh-electronics.com
Subject: Re: [PATCH v2 01/15] dt-bindings: arm: imx: Add i.MXRT compatible
 Documentation
Message-ID: <YmxonpKvcmoKVXmT@robh.at.kernel.org>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
 <20220428214838.1040278-2-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428214838.1040278-2-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 17:48:24 -0400, Jesse Taube wrote:
> Recently the imxrt1050 was added but the cpu compatible node wasn't
> added. Add both i.MXRT1170 and 1050 compatibles to fsl.yaml.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Swap order of soc's
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
