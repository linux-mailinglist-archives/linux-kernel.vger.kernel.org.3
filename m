Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03002500361
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbiDNBFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiDNBFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:05:19 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF9D4EF70;
        Wed, 13 Apr 2022 18:02:56 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e2afb80550so3833492fac.1;
        Wed, 13 Apr 2022 18:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h6QfWYe0L/R6LmSe0XRfjKt0AATaB1wV6Th611NeW5g=;
        b=inuKCzKFbxF3SxYmg2JnGj3MeU2NrViqRGJRvnjxmtVG6fmvnYxN8q3rFhvqLjuMJ5
         J0hU4ZzpZ1k6JQb8aVrmi5ujFPFMfNBLDra5+EBInthofWg4GCk0Bi/gk023VIdJiLer
         F1pcywcxKPSKwzSzqFowz3l3YdRn5wzrNQkORr4BmDGycE9CGFRb1yQoHz3Fk2S7AoVW
         v1zFpuQAkY5c0o8lc9VO12vulPVPzXVVMinXrnQM0UtKS72nSgG/ZXtM0GI7sPFUHexB
         SFZNbX/HIxzOh6sRHlBPZPRbfA0gNlevN81lJbjcbLLhbPdwilgx+MXRyQ03mCM6SGmN
         j7xA==
X-Gm-Message-State: AOAM533oBmPNg7w+v+fDqyKOKYwQBkggnQtAfpR/BZAS7KoyAZdbJ0sk
        3Ar0HsHemqJbYaxQgtZ5nXWMLF2jEg==
X-Google-Smtp-Source: ABdhPJz4MKNSCFMKbR30Yh3D5kcNkXHL+Bpl0ws/EYlphVQ7bxh2WwxtMDznmpWbuS7xHXyqBjYhOA==
X-Received: by 2002:a05:6870:32d6:b0:e3:6e1a:e56b with SMTP id r22-20020a05687032d600b000e36e1ae56bmr354954oac.206.1649898175797;
        Wed, 13 Apr 2022 18:02:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k14-20020a4a2a0e000000b0032ec90bf156sm195974oof.25.2022.04.13.18.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:02:55 -0700 (PDT)
Received: (nullmailer pid 91005 invoked by uid 1000);
        Thu, 14 Apr 2022 01:02:54 -0000
Date:   Wed, 13 Apr 2022 20:02:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     sboyd@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v14 1/5] dt-bindings: add documentation of xilinx
 clocking wizard
Message-ID: <YldyvmGMjODs6nL3@robh.at.kernel.org>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
 <20220411100443.15132-2-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411100443.15132-2-shubhrajyoti.datta@xilinx.com>
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

On Mon, 11 Apr 2022 15:34:39 +0530, Shubhrajyoti Datta wrote:
> Add the devicetree binding for the xilinx clocking wizard.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  .../bindings/clock/xlnx,clocking-wizard.yaml  | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
