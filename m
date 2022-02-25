Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CA74C49FA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbiBYQDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241291AbiBYQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:02:59 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139F71BE93;
        Fri, 25 Feb 2022 08:02:25 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so6751913oov.3;
        Fri, 25 Feb 2022 08:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ASEIJpWMgZzPUwKo/TaO7NWpJLb+t/kj417W/xfgP4=;
        b=izH6/wf96NgYOVfXpIC99W3BRwnruiN6Sso4QbjGl6k463cTXNtqtx3lZpGWBs4lxN
         +U39whiQ/PeEsnq/3e7K4Z5JTD324n2UN9vLibA7hQ/0PK+BLx3W/AoWuYMo6xI/C3LR
         u7YgrvlBDC4EKMmkrlccPiFQqUpq35bv+3ypIdQPAEY9PEeBd7trwFYypnucH3nnF/CJ
         QrnhafcYmsO6SPoGruOXXDkbdWgU3rOho9QZii36XRgsc1TxX0hXUMykMbU8TgbnplH8
         1Ltnl4kKOYlOw9XsHr6d1AZzzWBv8sS7JGzo+HZ37Lb0w8jWWURO2yUHdFH3aGq0sHf2
         HgFQ==
X-Gm-Message-State: AOAM531XG7PqU3XRyEI1V8Au85+DfPMiJd7H97253AXtP2AQ8Fp+ml9+
        Zpkp8G7edVxTV7o4g95qRD+qA72Xdg==
X-Google-Smtp-Source: ABdhPJwrpMHe59yPa1HMSv7HBHlTdQmKUhoIL6/d6QbUOBN648IRIt8dvgXUIAMk48G0Uk7rK4dE5Q==
X-Received: by 2002:a05:6870:f21f:b0:d4:9de:8ec7 with SMTP id t31-20020a056870f21f00b000d409de8ec7mr1492215oao.319.1645804944306;
        Fri, 25 Feb 2022 08:02:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p16-20020a05680811d000b002d72ec3a921sm1511812oiv.21.2022.02.25.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:02:23 -0800 (PST)
Received: (nullmailer pid 1005305 invoked by uid 1000);
        Fri, 25 Feb 2022 16:02:22 -0000
Date:   Fri, 25 Feb 2022 10:02:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: serial: fsl-lpuart: Add imx93 compatible
 string
Message-ID: <Yhj9joQkgTswMVcs@robh.at.kernel.org>
References: <20220215081334.788419-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215081334.788419-1-peng.fan@oss.nxp.com>
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

On Tue, Feb 15, 2022 at 04:13:34PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The lpuart on i.MX93 is derived from i.MX8ULP with some industrial
> enhancements, it uses three compatible strings, so update the

Looks like it's 2 compatible strings...

> compatible string for i.MX93. But for a few instants,

s/instants/instances/

> DTR_B, DSR_B, DCD_B and RIN_B pins are supported, so use one compatible
> string fsl,imx93-lpuart-v2

If the differences are just what gets pinned out, then I think the 
differences should be handled with separate properties. We probably 
already have some.

Plus, while you may have all the above signals, a board design may still 
only use a subset.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index 6e04e3848261..d7805f31ccc2 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -24,6 +24,8 @@ properties:
>            - fsl,imxrt1050-lpuart
>        - items:
>            - enum:
> +              - fsl,imx93-lpuart
> +              - fsl,imx93-lpuart-v2
>                - fsl,imx8qxp-lpuart
>                - fsl,imx8ulp-lpuart
>            - const: fsl,imx7ulp-lpuart
> -- 
> 2.25.1
> 
> 
