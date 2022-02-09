Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3D94B0043
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiBIWaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:30:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiBIW35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:29:57 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E756E0186FD;
        Wed,  9 Feb 2022 14:29:12 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id v67so4041690oie.9;
        Wed, 09 Feb 2022 14:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y1j55Hi253ENIjk9c8eQJUDKu/kw6HxF3YDkUmKAaFA=;
        b=G0vAC57Dgwk9uvKHGVEozxcUGVggynzVliFXgbipR5s4TMOKL36l4WIGMOfs8IXVQa
         rxv+YTj5KT7Dp8WvOjbp5QxNL1Haa48ONnymSfOfHz/3hKdKQ0VGy5P9iVHnUqO6LZcN
         tZdm+vBpUOTDiqtW8G1XiljFbbJUy8Qow5v3MKqtSbm22pa27SLxkPNLDncKjzb3uqDN
         DrMOYbTbcZQNCatFuxMYsqWWRhRyu9hFd3a1PD76Br+hD5ulncZ9YO2BG/hmg8pB+DF0
         H80gO8qRe9Y6cSNgU3JfGnodpl8otmF61y6CB17/bCw1uyyIt0BHCVlAsMbVuQJwGAZB
         +nOw==
X-Gm-Message-State: AOAM531FXRQyOqN2r1c0SYe+LRuFS8u2vRkTcfuX87PcseF3dH6/GFWc
        QmMXJ5AMnaEfrUeoafboew==
X-Google-Smtp-Source: ABdhPJyWHZDh7iGpE68bYX52cJf57I+WPA/yoHKidBDIJKLnhHEM6X7QjjesMGIyqJ36cy6LVjG3dA==
X-Received: by 2002:aca:aa54:: with SMTP id t81mr1901323oie.126.1644445751859;
        Wed, 09 Feb 2022 14:29:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ep17sm7660740oab.21.2022.02.09.14.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:29:11 -0800 (PST)
Received: (nullmailer pid 1055586 invoked by uid 1000);
        Wed, 09 Feb 2022 22:29:10 -0000
Date:   Wed, 9 Feb 2022 16:29:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vinod Koul <vkoul@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: phy: samsung,dp-video-phy: convert to
 dtschema
Message-ID: <YgRANt0hByXkupTj@robh.at.kernel.org>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
 <20220129193646.372481-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129193646.372481-4-krzysztof.kozlowski@canonical.com>
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

On Sat, 29 Jan 2022 20:36:42 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC DisplayPort PHY bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/phy/samsung,dp-video-phy.yaml    | 41 +++++++++++++++++++
>  .../devicetree/bindings/phy/samsung-phy.txt   | 11 -----
>  2 files changed, 41 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,dp-video-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
