Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1728853DEC6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348567AbiFEWwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiFEWwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:52:42 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E262E0B1;
        Sun,  5 Jun 2022 15:52:40 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-f16a3e0529so17290789fac.2;
        Sun, 05 Jun 2022 15:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L0qapDpvbigPCdBKYhit9dBZgXUpXm3QP/6LJGeOID4=;
        b=sSYy2nspHGX6gLTyVd56qEUEOrC+dRNSXAksMgvZ0v7rs2VC9KuLa57p2I/xGKHXHr
         1cKcvLMkQsgXOV+RiWOTJRpnEReWg4H70Jdc4h7P5JLTuTdI5nAM5uRXf/olultPQobu
         vHRJ/M5JxlTYLigCts5y14tnaA8WpleD1W6xkT12JFnR3JPa66qOXxIBQDZjwldsTWIb
         fmUIr2XdOwqkl1aebh5TddT58JKCx5mWQAs6Y2PzdqPrmIanIOazGCylNL+miqabN28K
         1eG75NSPbcuBwZTy/HaS/YDDQwxo9tLp69+ecjuAYeTmg8wphKRhOpWwLr39UDV9bAN1
         wZeA==
X-Gm-Message-State: AOAM533sNuudFS4A2E7ivTBLa+B4eMuvi53ZQtsUTsBdBI5WjxAR4Zyi
        gr3DSlF/THHQZVXt84oYGw==
X-Google-Smtp-Source: ABdhPJyEJ0K5CCi30LkRm8PnFm3qOAhGVhFSEuj726/H+FfucKmX7tTqnBUzkquObJF9ZB8+wrmWDg==
X-Received: by 2002:a05:6870:46a6:b0:f5:ecd6:befb with SMTP id a38-20020a05687046a600b000f5ecd6befbmr12687026oap.57.1654469560025;
        Sun, 05 Jun 2022 15:52:40 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id q8-20020a056830440800b0060aeccf6b44sm7364242otv.41.2022.06.05.15.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:52:39 -0700 (PDT)
Received: (nullmailer pid 3675710 invoked by uid 1000);
        Sun, 05 Jun 2022 22:50:33 -0000
Date:   Sun, 5 Jun 2022 17:50:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lars@metafoo.de, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, sre@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org, wens@csie.org,
        rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jic23@kernel.org, brgl@bgdev.pl, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH 03/10] dt-bindings: iio: adc: axp209: Add AXP192
 compatible
Message-ID: <20220605225033.GA3675655-robh@kernel.org>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-4-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603135714.12007-4-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jun 2022 14:57:07 +0100, Aidan MacDonald wrote:
> The AXP192 is identical to the AXP20x, except for two additional
> GPIO ADC channels.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/iio/adc/x-powers,axp209-adc.yaml  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
