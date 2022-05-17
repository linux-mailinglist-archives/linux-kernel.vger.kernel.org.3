Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCA752AC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbiEQUPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiEQUPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:15:10 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448874BB8F;
        Tue, 17 May 2022 13:15:09 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-f17f1acffeso41438fac.4;
        Tue, 17 May 2022 13:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zVxzIKBldB7H+d2gLC8sHVniZQZdEucrxlMRnxV+Lrw=;
        b=QM2nGwPEFlRCzIXhj51bvoTBBk2N1XllbccsuU4Vt2ELpsX49d+RTBZLj1aV2TOTU1
         4AbS8VJcKuAfEAZ3ldfXldxS2KeV2hmsVbVoOMXhsQf3G55oufbZhMmFYpEeWD5c/4E0
         aPF+QgX5r4/qT6La6Z+Klw/qFDdpBoqaS2O3Hk25LHLV8k4LNfu55Ny2wHEQaWr3Sn6Y
         ATK7BWc/NWOMM/aE7pUE7dzYn9JgRdaMPYKWEg79JFDSfp0QTewV0+Tq+t2RG5ZLuT/o
         HP+ZapJXUvOPWgla751rxXsfBN/RH0TANrsQhA0WqdlwWuo3wzO2J9tyjsVd+zdoTm0p
         Roqg==
X-Gm-Message-State: AOAM530vC9ATCRPMxkfKATswnGe7/SagyPWz7+d2SR7GPvJjSSgKhjmJ
        Oz0WLI3cc9oBV6tQSLN9mg==
X-Google-Smtp-Source: ABdhPJzFUsEA+/8m7Vt2h7qqa08hkS087A/4e01jKJHs+oCPD701NibEd463NoBCEp+WxJgfV6nozw==
X-Received: by 2002:a05:6870:c598:b0:ed:a1c0:f810 with SMTP id ba24-20020a056870c59800b000eda1c0f810mr19702119oab.289.1652818508545;
        Tue, 17 May 2022 13:15:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id em11-20020a0568705b8b00b000e686d13872sm188097oab.12.2022.05.17.13.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:15:07 -0700 (PDT)
Received: (nullmailer pid 1553344 invoked by uid 1000);
        Tue, 17 May 2022 20:15:06 -0000
Date:   Tue, 17 May 2022 15:15:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marcel.ziswiler@toradex.com,
        festevam@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        tglx@linutronix.de, giulio.benetti@benettiengineering.com,
        s.hauer@pengutronix.de, linux@armlinux.org.uk, abel.vesa@nxp.com,
        stefan@agner.ch, soc@kernel.org, linux-gpio@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        sebastian.reichel@collabora.com, mturquette@baylibre.com,
        daniel.lezcano@linaro.org, dev@lynxeye.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linus.walleij@linaro.org, olof@lixom.net, clin@suse.com,
        Mr.Bossman075@gmail.com, cniedermaier@dh-electronics.com,
        aisheng.dong@nxp.com, arnd@arndb.de, sboyd@kernel.org,
        kernel@pengutronix.de, tharvey@gateworks.com
Subject: Re: [PATCH v3 10/15] dt-bindings: imx: Add clock binding for
 i.MXRT1170
Message-ID: <20220517201506.GA1553283-robh@kernel.org>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
 <20220517032802.451743-9-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517032802.451743-9-Mr.Bossman075@gmail.com>
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

On Mon, 16 May 2022 23:27:57 -0400, Jesse Taube wrote:
> Add the clock binding doc for i.MXRT1170.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Change to GPL-2.0-only
> V2 -> V3:
>  - Change to (GPL-2.0-only OR BSD-2-Clause)
> ---
>  include/dt-bindings/clock/imxrt1170-clock.h | 282 ++++++++++++++++++++
>  1 file changed, 282 insertions(+)
>  create mode 100644 include/dt-bindings/clock/imxrt1170-clock.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
