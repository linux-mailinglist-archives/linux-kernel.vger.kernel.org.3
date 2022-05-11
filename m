Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789B9523720
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbiEKPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbiEKPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:23:20 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ED54EDE2;
        Wed, 11 May 2022 08:23:19 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-edf9ddb312so3190331fac.8;
        Wed, 11 May 2022 08:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5zNISZaXlYvmRc3tMtVlWkswi785e/B+9/uY5oE6YAQ=;
        b=qeMnAmAJokulvB1pYIRpLATzJ+WX2Pr91CYsHYvGhLzKlJG6NdkQ7ukU+DQjRgpv6D
         VzEZlap5B8+B8WzYVvHGE6hHeHZmc+OvQPxhGKTlU0DKrM+6BgoVchGJwyu6ylx9voth
         aCGeMaLEXqddnN9Bi8lQ5Oz1Jy3QvEdO1wYvgjtsffAI0ThmZUBcr2YFxJqKggqJo+Zg
         HAbR7wdHXSBItvK4ZR+XBbvT7Kfh9gKBEjyjqCR2XsN6bBlfLrq9eGpiqBNcOBidvPfp
         7qfepk4foWiJMzpb1W74JUEkbScUHbltHQbPo+faDQrdFNpuQjPM8gnzod9Z3lsEOYwN
         EO9A==
X-Gm-Message-State: AOAM530R2ADdSXA2Cap5lYwhsXKyREpR8+vthQ/sH0E9XxYYlsTUMxI3
        1Rk+xKQhhfRYJMhAaXAAog==
X-Google-Smtp-Source: ABdhPJz8rVBN06gIFVAn3YY+UTbDRGhzGs7/A3hZxVp8AZpNRgriF0sbM0SVBw8RFbySvGxuvEdMuQ==
X-Received: by 2002:a05:6870:61cd:b0:e9:8de7:9c51 with SMTP id b13-20020a05687061cd00b000e98de79c51mr2953718oah.50.1652282598896;
        Wed, 11 May 2022 08:23:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk14-20020a056820190e00b0035ec65ac944sm1036801oob.16.2022.05.11.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:23:18 -0700 (PDT)
Received: (nullmailer pid 337784 invoked by uid 1000);
        Wed, 11 May 2022 15:23:17 -0000
Date:   Wed, 11 May 2022 10:23:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang3@nuvoton.com>
Cc:     linux-kernel@vger.kernel.org, ychuang570808@gmail.com,
        cfli0@nuvoton.com, devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        catalin.marinas@arm.com, sboyd@kernel.org, robh+dt@kernel.org,
        arnd@arndb.de, krzk+dt@kernel.org, will@kernel.org, olof@lixom.net
Subject: Re: [PATCH V4 5/5] dt-bindings: arm: Add initial bindings for
 Nuvoton Platform
Message-ID: <20220511152317.GA337729-robh@kernel.org>
References: <20220510032558.10304-1-ychuang3@nuvoton.com>
 <20220510032558.10304-6-ychuang3@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510032558.10304-6-ychuang3@nuvoton.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 11:25:58 +0800, Jacky Huang wrote:
> Add binding for ARMv8 based Nuvotn SoCs and platform boards.
> Add initial bindings for MA35D1 series development boards.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../devicetree/bindings/arm/nuvoton.yaml      | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/nuvoton.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
