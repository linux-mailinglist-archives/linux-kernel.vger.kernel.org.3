Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF74B004F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbiBIWal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:30:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiBIWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:30:33 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8470C1DF65E;
        Wed,  9 Feb 2022 14:30:35 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id u3so4028078oiv.12;
        Wed, 09 Feb 2022 14:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtgernLkSkewJZUchZChhy/COp4zeAMKNzZo+56/du4=;
        b=JILP2PNhSXxSflGwA8mOeOdaWX6k7XZAglYA40VEv4tavDw9QOJIrdWl8pIpQEVpbS
         8T2l0NMUrTApVj7RAcg7HSHNqDsoYBUXR3GIYGUAuGBERsao29h6D9iDtPE5f3En0TQy
         JbnfWLg9xPHrS7LHsacC1SoWc6EQ4aIKOqvGgLzGQhbD8/pEZrpRjRcU9Ap8sZQhCtF/
         mQIb4L4pCQnH6zYmcIDPgCCfJub7Un0U2TVegJU82HMD/iHDW+XuCYkYG7UmyWtH3MrQ
         FkPKdX8CyCmnXFnFG8UR/cZuJ/5tCLg756KRIA1EnR5LDqcl7gvHRIkeJF+DrAEFXJm+
         FwYg==
X-Gm-Message-State: AOAM533ntjd+w1Jh+BAg3SOJBSPvcY/+WyIOgk2ZwY/K8hKbT6A5VAxR
        GaR11XNMKqkMKPFNz30jbq85yA5bHiGZ
X-Google-Smtp-Source: ABdhPJwOj3Wt+bxOBik7mwIlQJrNQJ5stTptsy5lWVZx2fKxa27UFpKlQuhz8ooAPqNilsmUKR5esQ==
X-Received: by 2002:a05:6808:f0d:: with SMTP id m13mr2057432oiw.9.1644445835172;
        Wed, 09 Feb 2022 14:30:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x1sm7131493oto.38.2022.02.09.14.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:30:34 -0800 (PST)
Received: (nullmailer pid 1058111 invoked by uid 1000);
        Wed, 09 Feb 2022 22:30:33 -0000
Date:   Wed, 9 Feb 2022 16:30:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 6/8] dt-bindings: phy: samsung,exynos5250-sata-phy:
 convert to dtschema
Message-ID: <YgRAif++EOuaIi+Z@robh.at.kernel.org>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
 <20220129193646.372481-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129193646.372481-6-krzysztof.kozlowski@canonical.com>
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

On Sat, 29 Jan 2022 20:36:44 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos5250 SoC SATA PHY bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../phy/samsung,exynos5250-sata-phy.yaml      | 64 +++++++++++++++++++
>  .../devicetree/bindings/phy/samsung-phy.txt   | 26 --------
>  2 files changed, 64 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos5250-sata-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
