Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D8515897
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381595AbiD2Wn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381584AbiD2WnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:43:23 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B408FEF;
        Fri, 29 Apr 2022 15:40:04 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id y63so9983970oia.7;
        Fri, 29 Apr 2022 15:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m/Rs86VVXCF4b61KU23mR8u0brfO067mz0n4mQYK8uM=;
        b=7EPZxGWsQX2RmGvd0oaU/Lu2dKJC9gm3gof7M4U79x8aA3Gk43DM6B+XbUPZhQxgcN
         dtPxS+iFOXUsAEQJRdBdTVAVZ+WSV5bo+uWsmenLgGNCG/N/jHJrmPsVG+D7tRR/Z/Tz
         HiM78+8fnUHx+IOTu6j1h104TwhBi7CvPmdckJsa+WnyJBtDnDmvgigWjuchN7E+fijF
         cvqCy7KncNXGGp+HS4qIABy3BzcdNgD2gYMnl/wgzoDcUa/5mjDCEbyHgXX3wCfj8txC
         s6fISqwHyn8qvMBMy/YzASgXVkxgSv0H3Qk7nCtXyPw9xf9Ee5YKqqOg/SiZ07XvBL91
         MmGA==
X-Gm-Message-State: AOAM530zJCEENmKk5nP41w2ZrmA7Q91MTcOdBL84WHwxuTzea27W6hF0
        SynXNIFCohf3s5eiOxk25Q==
X-Google-Smtp-Source: ABdhPJzyPaMeTEhRAE3mMh9OBwh/+3e5SrP7sZvmDtK2Up0lhc3Y5SarSooP70XVdQ41q/n7t5hzmA==
X-Received: by 2002:a05:6808:148e:b0:325:592f:84a1 with SMTP id e14-20020a056808148e00b00325592f84a1mr2673147oiw.118.1651272003516;
        Fri, 29 Apr 2022 15:40:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r23-20020a4aea97000000b0035eb4e5a6b1sm1289822ooh.7.2022.04.29.15.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:40:03 -0700 (PDT)
Received: (nullmailer pid 3033802 invoked by uid 1000);
        Fri, 29 Apr 2022 22:40:01 -0000
Date:   Fri, 29 Apr 2022 17:40:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     mturquette@baylibre.com, stefan@agner.ch, tglx@linutronix.de,
        giulio.benetti@benettiengineering.com,
        linux-arm-kernel@lists.infradead.org, tharvey@gateworks.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        olof@lixom.net, linux@armlinux.org.uk, kernel@pengutronix.de,
        aisheng.dong@nxp.com, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        linux-imx@nxp.com, s.hauer@pengutronix.de, leoyang.li@nxp.com,
        dev@lynxeye.de, robh+dt@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, Mr.Bossman075@gmail.com, devicetree@vger.kernel.org,
        cniedermaier@dh-electronics.com, soc@kernel.org,
        linux-clk@vger.kernel.org, marcel.ziswiler@toradex.com,
        clin@suse.com, abel.vesa@nxp.com, sebastian.reichel@collabora.com,
        sboyd@kernel.org
Subject: Re: [PATCH v2 05/15] dt-bindings: serial: fsl-lpuart: add i.MXRT1170
 compatible
Message-ID: <YmxpQedWAbaRK/uF@robh.at.kernel.org>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
 <20220428214838.1040278-6-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428214838.1040278-6-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 17:48:28 -0400, Jesse Taube wrote:
> Add i.MXRT1170 compatible string to Documentation.
> 
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - New commit to fix dtbs_check
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
