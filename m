Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A15455D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344501AbiFIUnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFIUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:43:29 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E623B5FD6;
        Thu,  9 Jun 2022 13:43:28 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id r5so2328117iod.5;
        Thu, 09 Jun 2022 13:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4QdkGnXlMNTV/iA2nVuQmtTBo6O4LHEpfmqPEMw61IE=;
        b=EVQ95/gCGzDDdI9jcstX3DcQO9bl6clglIZDJZ9n3Tcs5iFrpUO4jLUYKzaTKEtnVF
         XMJnfsnnbo3ke9R4FRdVI9AMP6V++1RJZvv0IeeQhn3KILP0bAq/PrcgPwslc+0zxQJN
         U52Pk5wp2FS6uLiIoIhwmw1d5+iIVP6818M/wl3EgbtOCc0fFJv+Si3hDZDtVHmulCXs
         c/nmViB21waWBB4zCm36X3tvazUMENfEIyZP4nhp3KACyhcceUQJf8gvdrrJoMA0WnjA
         ILPU48KJmoorR48206Xv39vDyX+vll5DxDRAiuZ03/Mu38h4KwUk9L3jjYJvm7W4PUIq
         z2Jw==
X-Gm-Message-State: AOAM531pRQHG7ktCh9Dad8Dl3c4/ydpkz8uptUzG5h3UAZ2Hin9EKHPy
        sIbK3BNqBXIzvIXAc0XY6qrTnw9qPg==
X-Google-Smtp-Source: ABdhPJyxJ/HuznBArSJKD+jpsjHU64cpq1XFDav0yTOf5ZBIjBue5UZbxavVH/a76BqrcQhDd56AHQ==
X-Received: by 2002:a02:1986:0:b0:331:5c52:5b9b with SMTP id b128-20020a021986000000b003315c525b9bmr22177136jab.69.1654807408230;
        Thu, 09 Jun 2022 13:43:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id m8-20020a927108000000b002d3c93ef865sm10755865ilc.69.2022.06.09.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:43:27 -0700 (PDT)
Received: (nullmailer pid 68193 invoked by uid 1000);
        Thu, 09 Jun 2022 20:43:25 -0000
Date:   Thu, 9 Jun 2022 14:43:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Steven Lee <steven_lee@aspeedtech.com>,
        David Wang <David_Wang6097@jabil.com>,
        devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Ken Chen <chen.kenyy@inventec.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH 1/7] dt-bindings: vendor-prefixes: document several
 vendors for Aspeed BMC boards
Message-ID: <20220609204325.GA66986-robh@kernel.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 29 May 2022 12:49:22 +0200, Krzysztof Kozlowski wrote:
> Add vendor prefixes for manufacturers of Aspeed SoC based BMC boards:
> ASrock, ByteDance, Ingrasys, Inventec and Quanta.  Move also bticino to
> proper alphabetical place.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/vendor-prefixes.yaml     | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 

Applying this one to avoid any conflicts.

Rob
