Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5334C49CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiBYP6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbiBYP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:58:02 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803A5AA47;
        Fri, 25 Feb 2022 07:57:30 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so6727157ooi.7;
        Fri, 25 Feb 2022 07:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hK1faAZYddl8pmB2/voy3xPMUXCWPdg9Bm9+NsKrySI=;
        b=F5xkvRTiFnlSlNbGap7H9PRravdXO3m91S4b3HWEx0ZE40OwiqeIC0xsO8EIVFRgTs
         OvNh1tAL5s2AevWcU9WecYti+56kTGQ1hOBrgB3Cr5o3LKX2NUzF1w+9vjWz9tjcStC5
         EWh5Chlo9lMhdB+TV0mZuHLSXWkY1ZUihdHPasiVYfi/vL1WskhV9GkaBbORvuVFZQEJ
         5Ms6KE+tvHgozgc9ILyuGMw3lqnQ1WHs4LSjwXo+RrK+Lu99jsrYDsWDMZg8tA3cV9VL
         JuD3gC+go0cDz9b51VrxYZ+NPHhUizcrVL4xE+KwxKDWU013g8PZdf3DnMrluTp80Q84
         Y/tA==
X-Gm-Message-State: AOAM53141d9P650rMmNI7wbXa0qHdrnF2fKJiTqFzxbj6J5wYSYmicnu
        fu0oKXKNINMdoyqoXA33oA==
X-Google-Smtp-Source: ABdhPJwrgcW8uLcZCNKBfHjc5LV76NJKYvicXJSrUlEvUWVLu2T6GCcj5k/JJKNvhVHwkkmIWmDxYQ==
X-Received: by 2002:a05:6870:91c4:b0:d6:cd13:cac6 with SMTP id c4-20020a05687091c400b000d6cd13cac6mr1488969oaf.301.1645804649824;
        Fri, 25 Feb 2022 07:57:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l34-20020a9d1ca2000000b005acea92e8absm1280869ota.42.2022.02.25.07.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 07:57:29 -0800 (PST)
Received: (nullmailer pid 998780 invoked by uid 1000);
        Fri, 25 Feb 2022 15:57:27 -0000
Date:   Fri, 25 Feb 2022 09:57:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        festevam@gmail.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: watchdog: imx7ulp-wdt: Add imx93 compatible
 string
Message-ID: <Yhj8Z+dtsu8a+VQP@robh.at.kernel.org>
References: <20220215081202.787853-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215081202.787853-1-peng.fan@oss.nxp.com>
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

On Tue, 15 Feb 2022 16:12:02 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The wdog on i.MX93 is modified from i.MX8ULP with some changes,
> it uses one compatible string, so add i.MX93 support.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
