Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B01A4B94A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiBPXnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:43:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiBPXnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:43:09 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48310A7C1;
        Wed, 16 Feb 2022 15:42:56 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id s1so1702593iob.9;
        Wed, 16 Feb 2022 15:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SLT7wjoW7MpVdOwbORzAiYLz8z90sJKzeMubDOx6fr0=;
        b=1qAkU1RSccB/xE3BaOD/2FZcnGNsBX7XW6Pz60wouzWEXTJ+Nt6YLjWbOwVsfDEIDx
         nLkihcipJUpPtKa/WNEKK5d3S8kTmdTMxPgqhzjz0gwuaI1cQnBMYXiKiWjPFzSn6wZW
         W2I6OsQOYgh0GI/5w5wjj6kEQ2HJEe7ZpgbWcbsCK8bdFGQ1r6yZ2SbkshEsdxegGxnD
         55cljdpSp90K8QON9WCd8bVmLn4d4ne25CiTtmUX6U6Q+/C227jFButAnzFpx5sVm8VB
         owGaHiskqS71LCUg8Fpb4FSXxAv7UnJVoBWjCHHLs1uor2dWYlzGRaqk1wbJqjijAyPs
         SdBQ==
X-Gm-Message-State: AOAM532O0xXZysvqPvWtCnoHlEKhpmZX7RXukFm9wIC++wzymifiWCyW
        GQu+pcakKMYzGSViFSk3iA==
X-Google-Smtp-Source: ABdhPJzP38JJwpaEAEzq0Br3zPh/FVqPDfA7TF5fJ3TbQBFsBQO2njHllz46LEwN3oMWZrOcVeyJ8Q==
X-Received: by 2002:a6b:6209:0:b0:60e:9b3f:52ae with SMTP id f9-20020a6b6209000000b0060e9b3f52aemr117741iog.33.1645054975955;
        Wed, 16 Feb 2022 15:42:55 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z23sm769806iol.11.2022.02.16.15.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 15:42:55 -0800 (PST)
Received: (nullmailer pid 1902047 invoked by uid 1000);
        Wed, 16 Feb 2022 23:42:53 -0000
Date:   Wed, 16 Feb 2022 17:42:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Hao Fang <fanghao11@huawei.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: vendor-prefixes: Add Ctera Networks
Message-ID: <Yg2L/eqJuZuYeub8@robh.at.kernel.org>
References: <20220215163926.894-1-paweldembicki@gmail.com>
 <20220215163926.894-2-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215163926.894-2-paweldembicki@gmail.com>
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

On Tue, 15 Feb 2022 17:39:23 +0100, Pawel Dembicki wrote:
> CTERA Networks Intl. is a company based in Israel.
> They manufacture NASes, network devices and provide software
> products for cloud storage and IT security.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v2: no changes
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

