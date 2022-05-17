Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2552A5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349734AbiEQPMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346572AbiEQPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:12:31 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749C3BFB0;
        Tue, 17 May 2022 08:12:29 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id i66so22584899oia.11;
        Tue, 17 May 2022 08:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dfPBNJl0BkkDm6rR5f4i06anC7912qzGjQ5goLE40g=;
        b=2n/fzMUTSwTKyejr6B4dtfNN8S4TK6C8wkKV/s5VUwqDf8yE0IrKq2+Wxvf2BLJJKM
         DFrxFNljJC8nTGADlY6YiJ8zIp+ZBJ/nULXKP7zRbrzQ5bjlhj93GVEvhrAeQjjyDoIN
         XNr+k8obA0FIxDANq7j5EwIOv36CnfahXEDcQ54zUtH+CiKIFtA/Uxi9s6JLutI2ygv9
         8qre4UgnheUQI21RQ02VdD1hxqnZW6m6rAQGGpYaXtvl/H4UdMsat3ZOtFhfEHFQ71yo
         Tk8Bymi0r6isPuc84+x00M+4n6HE5oEkBgfdFT8kBrsAvFW2MWvYZ7wb5ELwwnj9fbEc
         zTig==
X-Gm-Message-State: AOAM531MQtYBsDKRh70EBjVQho7zDsTzIP5/gxJdu7Rl8vMcLm021GGJ
        +hPiFrGQ8TNmNxM9CLE4rQ==
X-Google-Smtp-Source: ABdhPJzFfTUvwCWIB29bpybZvUCdBP4mQtaARfqBdm4hexGTPcJAiUL22/ZT2iuFmMl1WRl2Y3/ivQ==
X-Received: by 2002:a05:6808:ec2:b0:2f7:34db:691e with SMTP id q2-20020a0568080ec200b002f734db691emr16118754oiv.252.1652800348779;
        Tue, 17 May 2022 08:12:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t15-20020a056830224f00b0060603221235sm3331otd.5.2022.05.17.08.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 08:12:28 -0700 (PDT)
Received: (nullmailer pid 1045233 invoked by uid 1000);
        Tue, 17 May 2022 15:12:26 -0000
Date:   Tue, 17 May 2022 10:12:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     sboyd@kernel.org, tglx@linutronix.de, aisheng.dong@nxp.com,
        linux@armlinux.org.uk, olof@lixom.net, kernel@pengutronix.de,
        festevam@gmail.com, leoyang.li@nxp.com, dev@lynxeye.de,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        tharvey@gateworks.com, cniedermaier@dh-electronics.com,
        linux-gpio@vger.kernel.org, stefan@agner.ch, arnd@arndb.de,
        linux-clk@vger.kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, Mr.Bossman075@gmail.com,
        giulio.benetti@benettiengineering.com, soc@kernel.org,
        abel.vesa@nxp.com, linux-kernel@vger.kernel.org, clin@suse.com,
        marcel.ziswiler@toradex.com, mturquette@baylibre.com,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v3 04/15] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170
 compatible
Message-ID: <20220517151226.GA1045177-robh@kernel.org>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
 <20220517032802.451743-3-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517032802.451743-3-Mr.Bossman075@gmail.com>
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

On Mon, 16 May 2022 23:27:51 -0400, Jesse Taube wrote:
> Add i.MXRT1170 compatible string to Documentation.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - New commit to fix dtbs_check
> V2 -> V3:
>  - Fix typo
>  - Remove unused const
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
