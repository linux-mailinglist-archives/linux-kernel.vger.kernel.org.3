Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD358EF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiHJPmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiHJPme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:42:34 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3132C30F52;
        Wed, 10 Aug 2022 08:42:34 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id o14so8494793ilt.2;
        Wed, 10 Aug 2022 08:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lkS5zvLcljQjnjjOHPAoy1vsRnFJ0Grs3H/nJs4gz4c=;
        b=54e0eO1HSW6vvy1dp3X4UV152ds7hln2adFQxVdUHo0+9NJP27dHbr9u475Mi0dQu1
         L6Oh8DC9gdpU6a8chljF0SoT3CiQe18j7BFzZps/ht26JajZc0DKz0jH7fLaDpsdPnV9
         1Dbb52ryzrcHQO+u3Ovc4UYHvK0Y03wXKGXAkcETeDGLkxrTwqQEm2tQOLGjCtT3+dyx
         4J5Fot0oIwEZL4V0yiVssyhkqbSlmGJ5sVEma74KRIiiHGDIH+3JWdJajiumli3qGOVi
         V1kW2pe85t5OQ6h/d17HuQGtjnbybMPQHUeqpybotHFCN2+pMOQMs1rWYYK6PQNVwpnO
         qHHg==
X-Gm-Message-State: ACgBeo3K/Jwpki22B9mzabwsPsPe62bFcRosuGhKY/EKKeMCdxIjejxl
        d2tC3AUro2G0GsKXkRrSzXQHTA+7Tw==
X-Google-Smtp-Source: AA6agR766L+G/DmfEJHQx2uTOkZHXshafK1MLBI/ihgSqeChJYk2oM42hj/91O0+xfMGZMhZBO1LZg==
X-Received: by 2002:a92:c501:0:b0:2de:69e6:4143 with SMTP id r1-20020a92c501000000b002de69e64143mr13569520ilg.262.1660146153460;
        Wed, 10 Aug 2022 08:42:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p23-20020a02b017000000b003427daba276sm887045jah.129.2022.08.10.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:42:32 -0700 (PDT)
Received: (nullmailer pid 17851 invoked by uid 1000);
        Wed, 10 Aug 2022 15:42:31 -0000
Date:   Wed, 10 Aug 2022 09:42:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        airlied@linux.ie, sam@ravnborg.org, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: panel-simple-dsi: add Tianma
 TL057FVXP01
Message-ID: <20220810154231.GA17369-robh@kernel.org>
References: <20220810041354.691896-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810041354.691896-1-julianbraha@gmail.com>
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

On Wed, 10 Aug 2022 00:13:53 -0400, Julian Braha wrote:
> Adds the bindings for the Tianma TL057FVXP01 DSI panel,
> found on the Motorola Moto G6.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
> v4:
> Fixed makefile entry.
> 
> v3:
> Fixed kconfig dependencies.
> 
> v2:
> Fixed accidental whitespace deletion.
> ---
>  .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

