Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3144C044E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbiBVWEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiBVWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:04:33 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECEB27CD6;
        Tue, 22 Feb 2022 14:04:07 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id s5so16160912oic.10;
        Tue, 22 Feb 2022 14:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZJIgkPazYMVFLLiCayOvQBp4dxbbz1/q0+2SKBUnq7o=;
        b=agzZR1OZBjjrdZuUSb7BOmZCtHKlsHFQJryN5EifRM1fEF7qnRumt6TlQL6BDyd0VC
         BIFeATm6CmMXLo52oQTpNNy7RhtshI381P8UKmzqGMTgWP1GAsMc6jr8HC3ZgCGit6q9
         J8AQozEANDHFSqmR38R073diuLiyoQJgAK+89x7WZ04tNcG/PW2v4v6iEIsak/b7C8aH
         F0+oziG/d4YrVYSqh78Xsw/S6+9k3ckPmx2gOOkqI7KNQ9yJMSk3nDRt4ffw6LswCvua
         whij8lF6VLFNmurudlyGK1beW3ZE5jLZiuxZKX9C9NIZ0A1t+rMMy2Ya1r+GYo+doM5A
         Gpbg==
X-Gm-Message-State: AOAM533/AaSFa1M9Ippuw8J+cntS6FVZAywdVu0hZrFoJBA21j7MiDNj
        Ttd69eDXP8xeMb8pEyzILw==
X-Google-Smtp-Source: ABdhPJwf7/R5yUDTpF7lQ3A5JN4EudZmrZdxSkEYSXPIW6Turzd6Ou9niX+/eo46eJ+rqdMRs2APdQ==
X-Received: by 2002:aca:744:0:b0:2ce:ffcf:e794 with SMTP id 65-20020aca0744000000b002ceffcfe794mr2976975oih.221.1645567447283;
        Tue, 22 Feb 2022 14:04:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u3sm30791518oao.25.2022.02.22.14.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:04:06 -0800 (PST)
Received: (nullmailer pid 3671561 invoked by uid 1000);
        Tue, 22 Feb 2022 22:04:05 -0000
Date:   Tue, 22 Feb 2022 16:04:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] dt-bindings: update Roger Quadros email
Message-ID: <YhVd1e8cGidb/T6P@robh.at.kernel.org>
References: <20220221100701.48593-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221100701.48593-1-krzysztof.kozlowski@canonical.com>
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

On Mon, 21 Feb 2022 11:07:01 +0100, Krzysztof Kozlowski wrote:
> Emails to Roger Quadros TI account bounce with:
>   550 Invalid recipient <rogerq@ti.com> (#5.1.1)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Roger,
> You should also add a mailmap entry for your inactive emails.
> 
> Best regards,
> Krzysztof
> ---
>  .../devicetree/bindings/mfd/ti,j721e-system-controller.yaml     | 2 +-
>  Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml         | 2 +-
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml         | 2 +-
>  Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks!
