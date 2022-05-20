Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B0552F5DB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353963AbiETWr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiETWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:47:25 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E825AFAED;
        Fri, 20 May 2022 15:47:25 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-f233f06563so266113fac.7;
        Fri, 20 May 2022 15:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u4R4HL1CccLMyjJa3KDF9+5IZQqrErKeOe9qyzr40zI=;
        b=Dj6lV1R5Gri9eMa8TyivJNir//yhSHjDqYr3k0ZYc5mt7fVnELnlj95uzxLPXGhwNI
         abqSPjPsWDdnKHmzEMHcK7q5LQoHhwkJCQiclzJLeD3ahjwChNbG/OcU0Ign5F16Sdo1
         3Iavu01oFstRmTfrLqLZl/dvFoPVtNY68cYVUqHT27jJcXc+7KlhtzQ6HDG6snf3CWhl
         0GxSeE2xIvN5hgR2Pd8mNUq6NQkRECjRf3uBGGVCHLYa0rKyJdE9Z27nnnsvqizVWuD3
         y7ABYR4riv6YETDvyhGc4nmCJsg1hPBhkiZOUzQlD1CNmWiir3VAA3EwQ5T/bpopeYNf
         H5Tw==
X-Gm-Message-State: AOAM532irK+SaOZpdNLgME/jkUwugzHwi84VvMLXRzeYCN39pSDUDxkt
        0IgZMWfmdwQmwJ8UR/LDDw==
X-Google-Smtp-Source: ABdhPJwdW+Tdz65h6ry0Oq7eN1HrHtplP8oRV3Q6PNvZ3m9WMfgL/C+eJKxxwfuac94FX1DXNrpTbQ==
X-Received: by 2002:a05:6871:554:b0:f1:7f92:7e67 with SMTP id t20-20020a056871055400b000f17f927e67mr7044878oal.124.1653086844501;
        Fri, 20 May 2022 15:47:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t187-20020aca5fc4000000b00325cda1ffb4sm1575818oib.51.2022.05.20.15.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:47:23 -0700 (PDT)
Received: (nullmailer pid 395300 invoked by uid 1000);
        Fri, 20 May 2022 22:47:22 -0000
Date:   Fri, 20 May 2022 17:47:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de, sre@kernel.org,
        jon.lin@rock-chips.com, zyw@rock-chips.com,
        zhangqing@rock-chips.com, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND 1/4 v7] dt-bindings: Add Rockchip rk817 battery charger
 support
Message-ID: <20220520224722.GA389075-robh@kernel.org>
References: <20220520183037.2566-1-macroalpha82@gmail.com>
 <20220520183037.2566-2-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520183037.2566-2-macroalpha82@gmail.com>
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

On Fri, May 20, 2022 at 01:30:34PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added.
> 
> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
>                                       sample resistor.
> - rockchip,sleep-enter-current-microamp: The value in microamps of the
>                                          sleep enter current.
> - rockchip,sleep-filter-current: The value in microamps of the sleep
>                                  filter current.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Note that this patch requires the following commit (still pending):
> https://lore.kernel.org/linux-rockchip/20220519161731.1168-1-macroalpha82@gmail.com/

And so the checks still won't run... :(

Looks like it should be fine to me though.

Acked-by: Rob Herring <robh@kernel.org>
