Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661C34AE817
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbiBIEHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346785AbiBIDhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:37:04 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72BEC0401C7;
        Tue,  8 Feb 2022 19:37:02 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id v67so1206708oie.9;
        Tue, 08 Feb 2022 19:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PiWGXtCZf6jHvbjLvH0S4Utkq0oSJnTn1oI17eYDlPA=;
        b=YfoGh26FyQ2h9ZJjBFXbsrzEqUvriOOCW80PHJWEvgi/HWeOn3s2krXE9iVMLPCi2m
         PvII2LGwt36+6ApcRtHjnJJyXq0pDogk8xdAgwF7wwyQ6K8lbKO2W6ZT0rk+uysu4gMe
         itQ4LTvzRoo6IiWoiBIT1Kzxr0DoKmLpWmGCdWPlRn4fdpNizaCZQOmLvDpirOeVgDjK
         dP3ozybmNs/sSr0Eim5p4cL2FvWFh2DZnvOqa4rDzJPCxHV9cygusXJH1kXCb1H9qnms
         lLi0ShUGtMjehoLjFK8BbZz4Qt1poZC0qutJsCI2Z1Lj5TacIn8UymI/fcJ/lYsGvj0x
         s2lg==
X-Gm-Message-State: AOAM532VxyfYE50FtwWsHpknAF72bIu9WHIbsgmQB/3fQEtduuED5eX/
        B0tuTBmPbCAuo2E1EpZ/4g==
X-Google-Smtp-Source: ABdhPJz5JSHGakgqDrzzMkBT7+qYmtrJotBgtCWjYNQ7GaH6SI9soulRyXn6GmzWegEw8zkO2plndg==
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr522987oib.292.1644377822192;
        Tue, 08 Feb 2022 19:37:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x1sm6060033oto.38.2022.02.08.19.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:37:01 -0800 (PST)
Received: (nullmailer pid 3593740 invoked by uid 1000);
        Wed, 09 Feb 2022 03:37:00 -0000
Date:   Tue, 8 Feb 2022 21:37:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nick.hawkins@hpe.com, verdun@hpe.com
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: clarify HP prefix
Message-ID: <YgM23FfhJKIMwu0U@robh.at.kernel.org>
References: <20220127075229.10299-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127075229.10299-1-krzysztof.kozlowski@canonical.com>
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

On Thu, 27 Jan 2022 08:52:29 +0100, Krzysztof Kozlowski wrote:
> There are two independent companies: "HP Inc." and "Hewlett Packard
> Enterprise". Clarify that "hp" prefix is about the first one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Cc: nick.hawkins@hpe.com
> Cc: verdun@hpe.com
> 
> Optionally please squash it with a new patch adding "hpe" prefix.
> See: https://lore.kernel.org/all/20220125194609.32314-1-nick.hawkins@hpe.com/
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
