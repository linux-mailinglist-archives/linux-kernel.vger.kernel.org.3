Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B923C570AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiGKTbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGKTbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:31:40 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E870C77A79;
        Mon, 11 Jul 2022 12:31:39 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id l24so5861262ion.13;
        Mon, 11 Jul 2022 12:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BmO0BsTdvSsda0HsVx8sp/2MHsbGgulWtbJmBfZYCos=;
        b=7eUbRE6DA9zIxGET1q5bRu1xrzwYq1+pTOStXARmEYRIEow5xQr3bKSCzY6FRP0SNz
         XWg7xyEuS4AOuAecYycHupOMTMusJwTiBpJCcpvIKUxgmSRMJ2oS32y0G0OgkgdYhlAu
         3x3yfDNcOvU51q2FenovHceTebCfVFUSdicvIikzCxmydG0ywkgLG3AI502MQd9YD2Ks
         znBrI7KMlkZ92BDr2Qi3UXl9qVSNUggOrK3ADsNI9yeJB1iFHOoszwVeO5eIrgqWiHap
         WZ+RBWXU+SNDGeUXxlaLPdO+erhnCNRQC12dAljgLcceH8yRX2dUoHHs7Brg+ytHLtpQ
         U66A==
X-Gm-Message-State: AJIora8FPqTwFAcYWQz5g4lDOg8pTY6PTp5avAJc1Y+/vWwURqE5OOWi
        gRXNLnHqQeODWrfiQ1LpxA==
X-Google-Smtp-Source: AGRyM1uaBO1tHBzdt0QJErXkf+tNW24+2epDd4jDKlZGTHLHkR8AAVFUiLhFAqnnC+iBOsvl0riMLw==
X-Received: by 2002:a5d:9919:0:b0:675:48c7:d959 with SMTP id x25-20020a5d9919000000b0067548c7d959mr10397563iol.27.1657567899184;
        Mon, 11 Jul 2022 12:31:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p133-20020a02298b000000b0033f3e34f3b4sm3257856jap.150.2022.07.11.12.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:31:38 -0700 (PDT)
Received: (nullmailer pid 141681 invoked by uid 1000);
        Mon, 11 Jul 2022 19:31:36 -0000
Date:   Mon, 11 Jul 2022 13:31:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul T R <r-ravikumar@ti.com>
Cc:     airlied@linux.ie, sjakhade@cadence.com,
        dri-devel@lists.freedesktop.org, lee.jones@linaro.org,
        robh+dt@kernel.org, jpawar@cadence.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com, a-bhatia1@ti.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
        tomi.valkeinen@ideasonboard.com, p.zabel@pengutronix.de,
        andrzej.hajda@intel.com, robert.foss@linaro.org,
        mparab@cadence.com, laurent.pinchart@ideasonboard.com,
        daniel@ffwll.ch, vigneshr@ti.com
Subject: Re: [PATCH v6 1/5] dt-bindings: display: bridge: Convert
 cdns,dsi.txt to yaml
Message-ID: <20220711193136.GA141620-robh@kernel.org>
References: <20220707101601.7081-1-r-ravikumar@ti.com>
 <20220707101601.7081-2-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707101601.7081-2-r-ravikumar@ti.com>
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

On Thu, 07 Jul 2022 15:45:57 +0530, Rahul T R wrote:
> Convert cdns,dsi.txt binding to yaml format
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../bindings/display/bridge/cdns,dsi.txt      | 112 -------------
>  .../bindings/display/bridge/cdns,dsi.yaml     | 157 ++++++++++++++++++
>  2 files changed, 157 insertions(+), 112 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
