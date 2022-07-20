Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855A857BFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiGTVkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGTVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:40:32 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5599F25FE;
        Wed, 20 Jul 2022 14:40:31 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id e69so7856694iof.5;
        Wed, 20 Jul 2022 14:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sTRXKW7WJjs8cRNyD/i/qX7X/AexXfKNhBbS5lei3OM=;
        b=MCi06CnPJ//C5lh8JNoJ+XpAjWg/ixqFJkD74Qoqjy6Nc9BTKuxgk0eIP+mC4iZRMl
         SqB4nMcTmll+4xBXAcG+QhgSJO3b5PFCHNHkpGg0pLAJk7PsEXm1K/ZHjtNpuGNaC/UW
         RxyHz3d2cTh2w629o8ApVTtfPAFXo8Vdg2jGhAEqet0qTeaeAFNooS3IfBSZPBfyLCr2
         GLDLGhiqj8qQyjNUE/X1EeXWjvU7Jswch0SXrbDrzlBtum+pka8TXhpy2rVqQeYetDAG
         Bun5GoarHD9HkebV5CwJr9z8RL4ZLz2BTMZ2DasJ4CZADBJQ4Swf1JRs4yjz5nQuSgfi
         TFMw==
X-Gm-Message-State: AJIora+nivXp6TGw7uwb6u3pZtWYO8FqeHTND3AHMrRG5jeH85Igionw
        uDSKyGZ7f6fZe7wSU/UZjw==
X-Google-Smtp-Source: AGRyM1vu7icyNUFtGE75hG8YQv/cg7UeKnhQndGbZt3aVFtNTW+x0IYYWPMCXN4Xvhz67TlXmBsrsw==
X-Received: by 2002:a5d:8ad1:0:b0:67c:4aa8:8e1d with SMTP id e17-20020a5d8ad1000000b0067c4aa88e1dmr1593310iot.95.1658353230608;
        Wed, 20 Jul 2022 14:40:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i9-20020a056e021b0900b002dd074ed4a4sm59279ilv.47.2022.07.20.14.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:40:30 -0700 (PDT)
Received: (nullmailer pid 4029689 invoked by uid 1000);
        Wed, 20 Jul 2022 21:40:28 -0000
Date:   Wed, 20 Jul 2022 15:40:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     dmitry.osipenko@collabora.com, devicetree@vger.kernel.org,
        kernel@collabora.com, robh+dt@kernel.org, jic23@kernel.org,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com,
        lars@metafoo.de, Zhigang.Shi@liteon.com, krisman@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: Document ltrf216a light sensor
 bindings
Message-ID: <20220720214028.GA4029656-robh@kernel.org>
References: <20220715111626.1066513-1-shreeya.patel@collabora.com>
 <20220715111626.1066513-2-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715111626.1066513-2-shreeya.patel@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 16:46:25 +0530, Shreeya Patel wrote:
> Add devicetree bindings for ltrf216a ambient light sensor.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> 
> Changes in v7
>   - Fix the error reported by kernel test robot.
> 
> Changes in v5
>   - Remove deprecated string 'ltr' from the bindings.
> 
> Changes in v3
>   - Fix indentation in the example section
> 
> Changes in v2
>   - Take over the maintainership for the bindings
>   - Add interrupt and power supply property in DT bindings
> 
>  .../bindings/iio/light/liteon,ltrf216a.yaml   | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
