Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0165E58E0F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbiHIUVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345388AbiHIUUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:20:44 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900427B1C;
        Tue,  9 Aug 2022 13:20:41 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id t15so7156850ilm.7;
        Tue, 09 Aug 2022 13:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=i8fLGMiVtuza7jt0uHgJRZ2ISnpXL3HFiXjjuGSh5DI=;
        b=udvQLNXIdqjyyVeasMAVXxYM+m8BBoo46nhRSP+/K3WScowvh25LOzQWMJ5vv3AXmM
         jXxY1cDU0n8yjH4dM5PF1mWhGeWsOk7e7ZaIs13IX+GYoUwUa1lX4ZE8keV6jiPhNvBz
         5sRqNVT6N9iSrOW9ZKDGWTzNLEuRvh5PTdJ7EwCKi8qtnB/t0YjrHIZ9UXByPy2n+/dw
         aFDQ/+/JSFob/yZDma5vEdiSClkH6mErU4FyuxTtmvgOEdYBgJN3Ng4b5tchoD42bOcU
         ar+aKFAMIGLQwayrI/nY3GigjGSRP2NWqe6tHpyBt3GF7Q9F9Wn7svTrnOIg19KV7XF2
         IYxQ==
X-Gm-Message-State: ACgBeo3Rm7pPIBuCnsMS81YQy5/TNipZPPK2ee98qQAcXiIud0P51Zii
        0ZpceU7+ztwy6Lv+HSsi1g==
X-Google-Smtp-Source: AA6agR77Fjf8hjr8S8p/hEDdFDs8WlVvIGS5ALi31059dRoIxCAB8E+e02SA/ATgkv5OqsLL3MA3Zw==
X-Received: by 2002:a92:c501:0:b0:2de:69e6:4143 with SMTP id r1-20020a92c501000000b002de69e64143mr11738240ilg.262.1660076441170;
        Tue, 09 Aug 2022 13:20:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h5-20020a92c265000000b002dd0ba40abdsm1413532ild.18.2022.08.09.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:20:40 -0700 (PDT)
Received: (nullmailer pid 2327658 invoked by uid 1000);
        Tue, 09 Aug 2022 20:20:38 -0000
Date:   Tue, 9 Aug 2022 14:20:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     devicetree@vger.kernel.org, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        sam@ravnborg.org, thierry.reding@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: panel-simple-dsi: add Tianma
 TL057FVXP01
Message-ID: <20220809202038.GA2327602-robh@kernel.org>
References: <20220808213726.883003-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808213726.883003-1-julianbraha@gmail.com>
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

On Mon, 08 Aug 2022 17:37:25 -0400, Julian Braha wrote:
> Adds the bindings for the Tianma TL057FVXP01 DSI panel,
> found on the Motorola Moto G6.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
> v3:
> Fixed kconfig dependencies.
> 
> v2:
> Fixed accidental whitespace deletion.
> ---
>  .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
