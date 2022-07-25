Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7EE580836
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiGYX3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiGYX3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:29:09 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8726561;
        Mon, 25 Jul 2022 16:29:08 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-10d83692d5aso16780769fac.1;
        Mon, 25 Jul 2022 16:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pDBC+SN3XUz1fTYobGbOcnhMg9/j1jmuI+TaTt4V2s4=;
        b=Cx+hcnIUwkOwPaoOqZs3CbO0ZmAtr32CV0ELOUsBuXLfUmWYNzIVT9VUaOiHLzbsxS
         WMZEGawOTd43BhzexPz4KGjpaSXKhUOORuILbHG12pBGumkH3aOKLHDRwSZPHLuatlYn
         n2s+/5ZKTesuD8ulsMh91doz7cFmeUwLaVym+iJevZr7NnuWNnvSYJmgzfX7ZLAVCmYr
         cWPt5unLK//3P1RbL6dMnvVlb6qqpLrr8A3jZL+bmWK/VIyVSj319BjK2LKivIffcWyL
         ENOXiWiyCCex2Ax9JtGX9ljTlSiDBOHKQ3YGuWcZ6kZKN9cgIlclEGGydAJblAJYSU1v
         Whpg==
X-Gm-Message-State: AJIora8BomaHSch+DMX5dMnmv8Co7MDZgV5YOSWnDwKRWzNkfpS7mP52
        yIt/z7K5UFqOGUITAP1O8b5vcqMUtg==
X-Google-Smtp-Source: AGRyM1vhB7LzTu9o9WY8Ius1OoEy/Rlrf2xb4cPbrShtSbpFTMzuhLhU5dx5+8rVg+znEScMELoZkw==
X-Received: by 2002:a05:6871:b22:b0:10d:c30a:c096 with SMTP id fq34-20020a0568710b2200b0010dc30ac096mr8436424oab.75.1658791748050;
        Mon, 25 Jul 2022 16:29:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i22-20020a056870221600b000f325409614sm6724959oaf.13.2022.07.25.16.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:29:07 -0700 (PDT)
Received: (nullmailer pid 2957827 invoked by uid 1000);
        Mon, 25 Jul 2022 23:29:05 -0000
Date:   Mon, 25 Jul 2022 17:29:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dt-bindings: timer: allwinner,sun4i-a10-timer: Add D1
 compatible
Message-ID: <20220725232905.GA2957766-robh@kernel.org>
References: <20220725051715.56427-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725051715.56427-1-samuel@sholland.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 00:17:14 -0500, Samuel Holland wrote:
> Allwinner D1 contains the usual sun4i MMIO timer device. It contains two
> timers like other recent SoCs, so it is compatible with the A23 variant.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
