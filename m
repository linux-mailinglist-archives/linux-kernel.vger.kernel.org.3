Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769C65234CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbiEKN44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244345AbiEKN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:56:49 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760473B3C3;
        Wed, 11 May 2022 06:56:48 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so501155otk.1;
        Wed, 11 May 2022 06:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FmFrvxE6312OeOvyzkNliAzUqs60yDfGcYWJC7EnaQw=;
        b=xCnckxXYGjkINDJa8eQzw4mJkX8nW0kKoGiZhT/NGjbTQn4aD6OE5T9bO7eRYYjuIY
         0oLqcTn+D1FJ/zdAyjXAxKhXvulfGcxilTLOH0/VVasbwEO4e598Un5qOCy6wSboAIdd
         TjT0cwlncf8RgncN4XuKe2mZJH2t+1VshBGDQG+WY8tledPPTVEGWEv3t0Hn7111VSCr
         CjuibE/9m0Ksh4rYxj5UN5EBmj9dtcT0QpgUQsykH8MhllcimakKy5bDAzrHf5j5ioRe
         DuBBKTNk36xHn6YGF6dPGtFo/MN3rUCRFQn5HjwaiT3UoovKKJa++FLU0iL4m7KbuewP
         WafA==
X-Gm-Message-State: AOAM531LMrpaS/sAtMPXbTjcC3LHwmy2ABzU7F/RjM5EQDC8NVdX5t8I
        fbabu8+GkRklRjy0G/vGO9iCm9eegg==
X-Google-Smtp-Source: ABdhPJwj+o0HkYjvdeMLQ8/kpoKCvhaXE7BYvxIFSHwmVpC7e1YGvstoLqaZOtoHLCf62AdfOBaMuw==
X-Received: by 2002:a9d:6853:0:b0:606:aa1e:1181 with SMTP id c19-20020a9d6853000000b00606aa1e1181mr3594176oto.192.1652277407566;
        Wed, 11 May 2022 06:56:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w11-20020a4aaf0b000000b0035eb4e5a6c0sm973530oon.22.2022.05.11.06.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:56:47 -0700 (PDT)
Received: (nullmailer pid 212975 invoked by uid 1000);
        Wed, 11 May 2022 13:56:46 -0000
Date:   Wed, 11 May 2022 08:56:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, tomas.melin@vaisala.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 1/5] dt-bindings: iio: accel: sca3300: Document
 murata,scl3300
Message-ID: <20220511135646.GA212868-robh@kernel.org>
References: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220509064928.2352796-2-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509064928.2352796-2-Qing-wu.Li@leica-geosystems.com.cn>
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

On Mon, 09 May 2022 06:49:24 +0000, LI Qingwu wrote:
> Add DT bindings for Murata scl3300 inclinometer.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

