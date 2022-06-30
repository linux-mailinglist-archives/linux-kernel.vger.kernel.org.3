Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416A9562698
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiF3XNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiF3XNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:13:38 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4C922B33;
        Thu, 30 Jun 2022 16:13:15 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id v185so659724ioe.11;
        Thu, 30 Jun 2022 16:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8mU7qq1xT9xP4AkHkk9ztlC+s1KHGpH2/AR1TP7Q5AU=;
        b=Nec7cJj6+pkbrR3PoOoB+Zs/eF/5mt2uCKXJ/NTYYkFpyKFce5U16Wqw+2ABFeC26Q
         z6unKNhu6JXnlmbPCOutIrMjip4/JlcaPxAa/bN3Ai8v2WQjWWqKX81Lc76qQxD0Fr9h
         7A9V/78YSCLAsccsxW8jMzMd8SIubXaSYF+YOSNwKe2pZ3zScluY+sSYQAZgDOL9nQas
         yB1Xo/g3cJ10fWL37qABCW3gRwG5gvwy+sECGBuBTeFYeoNVyTqHnj1bb7BUk+mLxD17
         WaXZ21v42k7tZ2zohiaTbm4dIJRoY0dayUhvq1F8gIFyhjCdCH4AY8zX1okpOzthYRRD
         T/Dg==
X-Gm-Message-State: AJIora8c0SxUQhEUkE9JOW3XDrnVPiHHdjkY3SwORuek7UqPpzNSdgpv
        v9tEjM9PZrLZliDK0jbqnA==
X-Google-Smtp-Source: AGRyM1tH4HtQwEQklQC5StD8tG8HSFDW3U9bg3qVFD5iYWgjqigY+f6NDhBsU0FoXSsPKDeApCefIA==
X-Received: by 2002:a5d:9758:0:b0:669:7d33:c556 with SMTP id c24-20020a5d9758000000b006697d33c556mr5613843ioo.2.1656630794249;
        Thu, 30 Jun 2022 16:13:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s21-20020a6bdc15000000b0067533ab9404sm6237051ioc.16.2022.06.30.16.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:13:13 -0700 (PDT)
Received: (nullmailer pid 3508147 invoked by uid 1000);
        Thu, 30 Jun 2022 23:13:11 -0000
Date:   Thu, 30 Jun 2022 17:13:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-gpio@vger.kernel.org, stefan@agner.ch, shawnguo@kernel.org,
        abel.vesa@nxp.com, linux@armlinux.org.uk, linus.walleij@linaro.org,
        tglx@linutronix.de, devicetree@vger.kernel.org, linux-imx@nxp.com,
        cniedermaier@dh-electronics.com, kernel@pengutronix.de,
        tharvey@gateworks.com, festevam@gmail.com, clin@suse.com,
        robh+dt@kernel.org, sebastian.reichel@collabora.com,
        leoyang.li@nxp.com, dev@lynxeye.de, olof@lixom.net,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        aisheng.dong@nxp.com, Mr.Bossman075@gmail.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        s.hauer@pengutronix.de, sboyd@kernel.org,
        giulio.benetti@benettiengineering.com
Subject: Re: [PATCH v4 06/13] dt-bindings: clock: imx: Add documentation for
 i.MXRT1170 clock
Message-ID: <20220630231311.GA3508108-robh@kernel.org>
References: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
 <20220626064523.3683775-7-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626064523.3683775-7-Mr.Bossman075@gmail.com>
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

On Sun, 26 Jun 2022 02:45:16 -0400, Jesse Taube wrote:
> Add DT binding documentation for i.MXRT1170 clock driver.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Change title to Clock Controller
>  - Rename to add fsl
> V2 -> V3:
>  - Remove unused include causing error
> V3 -> V4:
>  - Add fsl to schema id
> ---
>  .../bindings/clock/fsl,imxrt1170-clock.yaml   | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
