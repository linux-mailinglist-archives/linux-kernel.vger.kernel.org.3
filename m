Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FDD4F9F01
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbiDHVPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiDHVPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:15:53 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458291DE6E6;
        Fri,  8 Apr 2022 14:13:49 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id v75so10123721oie.1;
        Fri, 08 Apr 2022 14:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bk+YcWe/7mpPb3Za0hGWjpsKnHkX5QFyB+wbrymup78=;
        b=sqW1eJ2hgTuuhv7Y9zDsAGYw7Is2kj/597RwLrER1VqWemWp8Kh+pItV4iW7kBIbxc
         ZokITdl8kdaXk++kgIclMeBsfI98FhGT7EjfqT/2gGqRlmw5NLor5lH1t+cAI0nLGAhm
         tF7tPxIC5lRwQkGz2rH5QdieImYHHN+92NWR8IFha6FnQaUOlTsVbeNuzV0uVXatdm2v
         jt04kSj39u8EeqYBWgd+BNlOojy29A9PG7/RTiVsLMmxsqb6JdemfHCSWtOQ/2NKZlF/
         illxS+4uLCTpfzL1NwXqEzop2Oi+y4n6Z8gRmyPf/KEXQQtnI/wSR2cm0cqMDpDTNHhF
         Tu2A==
X-Gm-Message-State: AOAM530Ez9lXFvRGBulc1RARNBe+ZxHxAuq+C6x2z0NbwC7TaNdl7BTv
        3/FrUsbadt2X7LL7bwf6sQ==
X-Google-Smtp-Source: ABdhPJwYYbSoGZhx3EKYOIzMmRZzcLHxMZxm8Yq2KdwGyZKNsz6L2sZpLyzoNbyP/hqaV0eeN0zohw==
X-Received: by 2002:a05:6808:150e:b0:2ec:ff42:8178 with SMTP id u14-20020a056808150e00b002ecff428178mr743024oiw.88.1649452428317;
        Fri, 08 Apr 2022 14:13:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w36-20020a05687033a400b000d75f1d9b82sm9216929oae.47.2022.04.08.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:13:48 -0700 (PDT)
Received: (nullmailer pid 4077067 invoked by uid 1000);
        Fri, 08 Apr 2022 21:13:47 -0000
Date:   Fri, 8 Apr 2022 16:13:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 12/14] dt-bindings: reset: st,sti-picophyreset: Convert
 to yaml
Message-ID: <YlCli/npVt+6Hd0/@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-12-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-12-p.zabel@pengutronix.de>
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

On Thu, 07 Apr 2022 17:43:36 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the STMicroelectronics STi
> SoftReset controller to YAML schema to allow participating in DT
> validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> ---
>  .../bindings/reset/st,sti-picophyreset.txt    | 42 -----------------
>  .../reset/st,stih407-picophyreset.yaml        | 47 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/st,stih407-picophyreset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
