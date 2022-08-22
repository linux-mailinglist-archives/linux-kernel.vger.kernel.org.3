Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA19159C5D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiHVSLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiHVSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:11:49 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2B2A258;
        Mon, 22 Aug 2022 11:11:49 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 53-20020a9d0838000000b006371d896343so8226850oty.10;
        Mon, 22 Aug 2022 11:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5VV3NoN7IqKqs9MOuS8FFToE6oCYmjPHLHIHLkHZ/PY=;
        b=W2PaEQs4w6DiHW6FSUJHHnQn807+FLjCBZL6Uu28bAkuIc+v1lHkAgraCj3zf/3Mm3
         UEFMhYRJZChC3LX1IJD6G7wPR5iKmCvPtT8DCWS69JwEMwEfpSHdrrPjvbIDdFd7SqOt
         sso06eCo8GtXyKVis07IuesJTIJGqKx7NmvHcwcnilFDsZZzbTc+zaQmK4urS7c1oh+E
         5Cn11A6u9XjKJMQjhFoeuqtw63LVs41KCyq5cU7WAdTnRChBE5MZIajDCsMiPsR15bgB
         raodEK21KCBMjYZzV0WxRlGn5Z6IrFCLT2xqmpQijnYaZMxJT2F8Jr/ERAyigpu3Tz8y
         EG7A==
X-Gm-Message-State: ACgBeo2zqAKhIjzn0wkZ2PzSPQIFc+hfQI3kT7G3Ami2pD1kmBOSiMC8
        9+uCizef5udG/wZrqRFDIw==
X-Google-Smtp-Source: AA6agR7AulYdsRcGkCfdZggL0pjoN8rkWxX70QJmpzdyLYWvudLpE4cy1rAGFt+SddpfS+xDc++QuA==
X-Received: by 2002:a05:6830:1e85:b0:638:c371:a00d with SMTP id n5-20020a0568301e8500b00638c371a00dmr8098866otr.177.1661191908314;
        Mon, 22 Aug 2022 11:11:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p39-20020a05687056a700b0010d5d5c3fc3sm3106713oao.8.2022.08.22.11.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:11:47 -0700 (PDT)
Received: (nullmailer pid 87879 invoked by uid 1000);
        Mon, 22 Aug 2022 18:11:46 -0000
Date:   Mon, 22 Aug 2022 13:11:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org, mchehab@kernel.org,
        vkoul@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        robh+dt@kernel.org, hverkuil@xs4all.nl, jacopo@jmondi.org,
        linux-media@vger.kernel.org, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, sakari.ailus@linux.intel.com
Subject: Re: [PATCH 3/4] media: dt-bindings: add bindings for Toshiba TC358746
Message-ID: <20220822181146.GA87822-robh@kernel.org>
References: <20220818143307.967150-1-m.felsch@pengutronix.de>
 <20220818143307.967150-4-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818143307.967150-4-m.felsch@pengutronix.de>
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

On Thu, 18 Aug 2022 16:33:06 +0200, Marco Felsch wrote:
> Add the bindings for the Toshiba TC358746 Parallel <-> MIPI-CSI bridge
> driver.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../bindings/media/i2c/toshiba,tc358746.yaml  | 157 ++++++++++++++++++
>  1 file changed, 157 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
