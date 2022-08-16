Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FAF595CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiHPNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbiHPNKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:10:55 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8704AB4437;
        Tue, 16 Aug 2022 06:10:50 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 18B5322238;
        Tue, 16 Aug 2022 15:10:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660655447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9LhVacs9F80sepfJM8+uixyHpf2jqhk2p1Fl5zzM5IU=;
        b=cvMxnukhiBlbyuW2swNqXWTgkRqTSISeYg+BkXMlB0pALo5lFoYpupZLBy8vBopaun8QN4
        1FCdDHTmtHVl34NAgBO3vC+lhYKNoFd91P0Qtxc84SOQLBS3dr+poZujjErRteWvo6IsrT
        rUGDHwUdcvRVO0L67yF4RQymFVPgK1g=
From:   Michael Walle <michael@walle.cc>
To:     krzysztof.kozlowski@linaro.org, pratyush@kernel.org
Cc:     devicetree@vger.kernel.org, kishon@ti.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        vkoul@kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] dt-bindings: phy: Drop Pratyush Yadav
Date:   Tue, 16 Aug 2022 15:10:41 +0200
Message-Id: <20220816131041.1771872-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220811063840.7670-1-krzysztof.kozlowski@linaro.org>
References: <20220811063840.7670-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Pratyush ]

> Emails to Pratyush Yadav bounce ("550 Invalid recipient").

FWIW, he updated his entry in MAINTAINERS in commit 92714596cdbe
("MAINTAINERS: Use my kernel.org email"). So I'm not sure if this was
just an oversight.

-michael

>> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml | 2 +-
>  Documentation/devicetree/bindings/phy/cdns,dphy.yaml    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
> index 07be031d82e6..834f65636819 100644
> --- a/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Cadence DPHY Rx Device Tree Bindings
>  
>  maintainers:
> -  - Pratyush Yadav <p.yadav@ti.com>
> +  - Kishon Vijay Abraham I <kishon@ti.com>
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> index f0e9ca8427bb..37bc20493fd0 100644
> --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Cadence DPHY Device Tree Bindings
>  
>  maintainers:
> -  - Pratyush Yadav <p.yadav@ti.com>
> +  - Kishon Vijay Abraham I <kishon@ti.com>
>  
>  properties:
>    compatible:
> -- 
> 2.34.1


