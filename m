Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B45D4F9F03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbiDHVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiDHVQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:16:23 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C186B1F1A33;
        Fri,  8 Apr 2022 14:14:17 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id e189so10088566oia.8;
        Fri, 08 Apr 2022 14:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Tc3XXM6T26cLJDRJT1w68etcxZftwSAgCt/NjXltQo=;
        b=EjzgUWzG2yU+98dr1fotRjkqnK6qtev/fM9JXWEyO9kWs1yR5rEy0qPjyjqq36oniQ
         991vHMKRUSsppthdJN7KbAiKe6Q04XWG6UKzdPoVT8cL8mgHdP5Ro31C3n2EJ5Cdo4Rs
         emh9eJwph7EakR4CufiAtjC0eRVnOzJSJTIVooQtTu+5CZ/J9rZkfe/cflQp48ifvvA9
         Ux4oaXGEFT0T8FxOaKdjIGQ3vb2eGIoPy2EIm+xl9WFCC/Cq+OFyPBhmnBYe9N8IFLXJ
         KEgRMNaf2GY0wZNRCEx1Q6rwJppFcVcLbA07KaEW0s3AItmnVZ/qh2keBBPdo1Q0fHek
         GbLQ==
X-Gm-Message-State: AOAM530VwZPHLgPE6lDZ90JZ6ZUdMKV9o2h4ws/074QyUtRG6JVbQ3Qr
        NPwlGmE4WMi0+aXZBCcVJg==
X-Google-Smtp-Source: ABdhPJwK4Y7u4p0AFkL1EdbT9D61xaGyiGUvCy1FpfxUCO8XI1IhG3AqBLfxL2vh32v7tLkUDlBO+Q==
X-Received: by 2002:a05:6808:3ad:b0:2d9:fc59:ef0e with SMTP id n13-20020a05680803ad00b002d9fc59ef0emr794994oie.266.1649452457107;
        Fri, 08 Apr 2022 14:14:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm9182221oak.12.2022.04.08.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:14:16 -0700 (PDT)
Received: (nullmailer pid 4077853 invoked by uid 1000);
        Fri, 08 Apr 2022 21:14:16 -0000
Date:   Fri, 8 Apr 2022 16:14:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@st.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 13/14] dt-bindings: reset: st,sti-powerdown: Convert to
 yaml
Message-ID: <YlClqPWJpqypRmnL@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-13-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-13-p.zabel@pengutronix.de>
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

On Thu, 07 Apr 2022 17:43:37 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the STMicroelectronics STi
> Peripheral Powerdown reset controller to YAML schema to allow
> participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
>  .../bindings/reset/st,sti-powerdown.txt       | 45 -----------------
>  .../bindings/reset/st,stih407-powerdown.yaml  | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
