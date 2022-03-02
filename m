Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F84CAC57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbiCBRo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244178AbiCBRo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:44:56 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E95CE926;
        Wed,  2 Mar 2022 09:44:12 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso2716114ooc.12;
        Wed, 02 Mar 2022 09:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NaGiNGbuhPv36bcxSC61InozAJyKj+sMziQgYlBPwso=;
        b=oy1AccwiOuv6Tke0G9LKf07y+0EB8auo3OPkHWr0s+rD06ITlL5gB1UxovQzhPHHWy
         /6i8hHGeOWRsPKpA1B9dXFEhKw6RaXdvzcrV4NYqbGLQ6fH8XbhutTtN9AkZ9t/SvaHn
         vo1COKkMT+T7dxE5harOv9eVL2jO9Odi/35aty2mEeDShvJfFkPuRSg70i4a7JYb1R/+
         Xp/e3NkNQyJZm+Nn49xzvfX0HyUPKjYH0umUG1GivrZUJrbVym0uoAvUjcyg6bwA71yg
         05yPUSzDDb345y7vgFJODkvB7//kC9vuLWES44T9lVR0TEy+j+oP8rg73kBWljMomrjm
         ScIw==
X-Gm-Message-State: AOAM533HbkpQKYmfKOg6DULiNFNY/s0sNgo1RrxQb2Bxvz2Z5l7qdNXO
        zLUtmlcKg+Ltdp92crLZOQ==
X-Google-Smtp-Source: ABdhPJxGvTFCUheMgvJRxWJfrx6CTJdeQJJvZMGRp6tHjLz5GXnN9bxP7C2rcTHm3K9HWVzLFVhBMA==
X-Received: by 2002:a05:6871:720:b0:d9:a14c:7ca6 with SMTP id f32-20020a056871072000b000d9a14c7ca6mr786532oap.70.1646243051311;
        Wed, 02 Mar 2022 09:44:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j9-20020a4aa649000000b0031ca80c6e60sm7887973oom.24.2022.03.02.09.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:44:10 -0800 (PST)
Received: (nullmailer pid 3944112 invoked by uid 1000);
        Wed, 02 Mar 2022 17:44:09 -0000
Date:   Wed, 2 Mar 2022 11:44:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Williams <patrick@stwcx.xyz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
Message-ID: <Yh+s6TME/NJw1GDM@robh.at.kernel.org>
References: <20220302123817.27025-1-potin.lai@quantatw.com>
 <20220302123817.27025-3-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302123817.27025-3-potin.lai@quantatw.com>
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

On Wed, Mar 02, 2022 at 08:38:17PM +0800, Potin Lai wrote:
> Add documentation of new properties for sample averaging in PMON_CONFIG
> register.
> 
> New properties:
> - adi,volt-curr-sample-average
> - adi,power-sample-average
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  .../bindings/hwmon/adi,adm1275.yaml           | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
