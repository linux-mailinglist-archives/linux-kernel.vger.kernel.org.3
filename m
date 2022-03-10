Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5254D52B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343752AbiCJT6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244051AbiCJT6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:58:46 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1529CA8;
        Thu, 10 Mar 2022 11:57:43 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso8134992ooi.1;
        Thu, 10 Mar 2022 11:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=587tAXIBt5gJJ3K1jLql4ANpqCMpV8KK/y6s0w17IXk=;
        b=JsDAHx30v2ssSBRtQvd6FStez0D6DmjrytBm9zVTFqXdSOV2aa9xbDgt55iOFXsZm3
         OxcwYUp1wNTUY2OUcvsG/eNb9GrdMyMWvC+6A0/fhAhMvMCAK8t6T6z2YWU5REctlNmV
         lGFMWEeFTZqbDVJkqjozhstcRglURrs8FsosbKXERgNEycOtNfvl/Bc6o0kH1ZlgGAUy
         cWVEFg8reACEAcdLxrwk6zKA0IF25+OMQ4fGou9dc2kiTwyc/v8Vu2cZcGR2TXf9t/A4
         x1arb//I6g9mJStBzSBUyyWsJmyYCopeHtc+Ybv22LRT9F6Bw75dvMh3zazpla+BobVH
         PlPA==
X-Gm-Message-State: AOAM533uziJkecrVcYW15aDGlJF4wspEXBcGMQai4+zY8667OZx5OX8D
        D4haodqBTkxW2YOgwQRWPg==
X-Google-Smtp-Source: ABdhPJy0/xxQ0Sd2U0RGSOepEneFwG4AkAJYPmmeu723uJ6K6quTywusFm1ZrUeCPMvbFjwFZnUV9A==
X-Received: by 2002:a4a:8c61:0:b0:321:435a:a779 with SMTP id v30-20020a4a8c61000000b00321435aa779mr3175656ooj.40.1646942262757;
        Thu, 10 Mar 2022 11:57:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y15-20020a056870b00f00b000d75f1d9b81sm2680733oae.46.2022.03.10.11.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 11:57:42 -0800 (PST)
Received: (nullmailer pid 1960637 invoked by uid 1000);
        Thu, 10 Mar 2022 19:57:41 -0000
Date:   Thu, 10 Mar 2022 13:57:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        p.zabel@pengutronix.de, linux-phy@lists.infradead.org,
        vkoul@kernel.org, wells.lu@sunplus.com, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: phy: Add bindings doc for Sunplus
 USB2 PHY driver
Message-ID: <YipYNWqQwYZUCGTN@robh.at.kernel.org>
References: <1646393418-26421-1-git-send-email-vincent.sunplus@gmail.com>
 <1646393418-26421-3-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646393418-26421-3-git-send-email-vincent.sunplus@gmail.com>
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

On Fri, 04 Mar 2022 19:30:18 +0800, Vincent Shih wrote:
> Add bindings doc for Sunplus USB2 PHY driver
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
>  .../bindings/phy/sunplus,sp7021-usb2-phy.yaml      | 73 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
