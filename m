Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB26053ECF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiFFRU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiFFRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:19:24 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED882BD;
        Mon,  6 Jun 2022 10:18:59 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id y16so12390639ili.13;
        Mon, 06 Jun 2022 10:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oUB1RtAxwcnRE2CEYiw/IkNM/uWyKljTbcTDvBqQ/Ms=;
        b=GtmxG5HcoFnpvZeANxEFtLL+gyzcKyepunxK/d4Rilj9vxQbVv9OSQnKHavOWFpT+/
         jF8qo21QrkJwMLdOEj/e8a/sM3XD4n9q6jGoo1VccoKDTU4Jt/Lc4lv9cbnsRXCUsJsm
         OMjUShSm/Hir+yMGg7Hf4dPtiOOiJB3fbbTHD0mOyKpQnAtFd/ttHeWh6nOPnqVWQOfC
         sI0MFPugWSPLB9owhpY3zIPqYhMdvgQQLa/604I3U7AIkrv/fSeTyIIrL9DGj1dtXM8r
         qA1c0Vb9y3KOEN5ReL1vlEDVzd6AMBsddgYc4XkRzdKH+jhImsHYz86VsVEgkYFL9mdD
         2N7w==
X-Gm-Message-State: AOAM531febv+2RUWUhSNQEzmN3/9kv/6qtonv5ihg/qo/fcWoUN7tqMu
        ZF4ff38nI6BdClf6Fm0jWQ==
X-Google-Smtp-Source: ABdhPJwwqIpJPlfuz1tpdxBnIscqptcD/jrSI7SGTP9v7AyxAyS8obOg7qY7NyGvzBbBtOYBzZmBUg==
X-Received: by 2002:a05:6e02:1523:b0:2d3:cb16:2d03 with SMTP id i3-20020a056e02152300b002d3cb162d03mr14157340ilu.198.1654535938816;
        Mon, 06 Jun 2022 10:18:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e1-20020a022101000000b0032b3a78179csm5823216jaa.96.2022.06.06.10.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 10:18:58 -0700 (PDT)
Received: (nullmailer pid 912769 invoked by uid 1000);
        Mon, 06 Jun 2022 17:18:55 -0000
Date:   Mon, 6 Jun 2022 12:18:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, malidp@foss.arm.com,
        Liviu Dudau <liviu.dudau@arm.com>,
        kernel-janitors@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        James Wang <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] MAINTAINERS: rectify entries for ARM DRM DRIVERS after
 dt conversion
Message-ID: <20220606171855.GA912412-robh@kernel.org>
References: <20220601041746.22986-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601041746.22986-1-lukas.bulwahn@gmail.com>
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

On Wed, 01 Jun 2022 06:17:46 +0200, Lukas Bulwahn wrote:
> The three commits:
> 
>   36fd2a65bcaf ("dt-bindings: display: convert Arm HDLCD to DT schema")
>   0f6983509ea1 ("dt-bindings: display: convert Arm Komeda to DT schema")
>   2c8b082a3ab1 ("dt-bindings: display: convert Arm Mali-DP to DT schema")
> 
> convert the arm display dt-bindings, arm,*.txt to arm,*.yaml, but miss to
> adjust its reference in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> broken references.
> 
> Repair these file references in ARM HDLCD DRM DRIVER, ARM KOMEDA DRM-KMS
> DRIVER and ARM MALI-DP DRM DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Andre, please ack.
> Rob, Krzysztof, please pick this minor non-urgent clean-up patch in
> your -next dt tree.
> 
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!
