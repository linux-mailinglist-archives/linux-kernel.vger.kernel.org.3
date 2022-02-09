Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8544B0058
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiBIWaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:30:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiBIWaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:30:05 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059AE024616;
        Wed,  9 Feb 2022 14:29:50 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id y23so4030904oia.13;
        Wed, 09 Feb 2022 14:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LGItSpVyO4E2kjjIY3eLoaT3e1GMgzzef9yeodLXUW4=;
        b=C6DGt6KGHgSMFyNgbNisv9z2P+UjzIH3t8aiRuGi1Njc1qApIGIaxN0P2wcX1HIHTA
         K+Bbf45zdmS/6BfBvsfylj8dxO/twfS7eJBa60qOeV6FWzgdzsSnE8MFH4vKVavnbiHe
         pnQflS8RVuyQm4SaIllIOOiiAofrHnL+LsihijJzBL5kopSah6QZtYKTtM3fh8KZQQqS
         6b8QGgz/GULJAJtLGNbl0LVCNX0mAzLc3VO9Rdb5cHFB4aJygn6fNfFWNoBGXoH/EOje
         uT5p0+pRQaEITr4fog4NOANKDM/uKt9AgJh5dRHMilw6cJNsFp8zvIlUb5vAOLf+/qVP
         yn7Q==
X-Gm-Message-State: AOAM5330pqEoEb00rK6t7ruCszES9sz36l9lMDe+9dE4t8Ps4hiIYiUD
        hn7ZcLvHYAJtjGFtleROKg==
X-Google-Smtp-Source: ABdhPJycLuy7p16aiiS0Lgo2CVfXP5rkqJlHcZTXDXoCeUehiDhWgN3AMjKEs0+1dZEHYtVUAFhSPg==
X-Received: by 2002:aca:1c03:: with SMTP id c3mr2129549oic.94.1644445789467;
        Wed, 09 Feb 2022 14:29:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x19sm7206610otj.59.2022.02.09.14.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:29:48 -0800 (PST)
Received: (nullmailer pid 1056785 invoked by uid 1000);
        Wed, 09 Feb 2022 22:29:47 -0000
Date:   Wed, 9 Feb 2022 16:29:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vinod Koul <vkoul@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 5/8] dt-bindings: phy: samsung,usb2-phy: convert to
 dtschema
Message-ID: <YgRAWzYYrg65Kwg+@robh.at.kernel.org>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
 <20220129193646.372481-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129193646.372481-5-krzysztof.kozlowski@canonical.com>
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

On Sat, 29 Jan 2022 20:36:43 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC USB 2.0 PHY bindings to DT schema format.
> 
> Except the conversion, add also vbus-supply property which was already
> used by the driver and DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/phy/samsung,usb2-phy.yaml        | 102 ++++++++++++++++++
>  .../devicetree/bindings/phy/samsung-phy.txt   |  60 -----------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 103 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
