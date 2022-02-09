Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C7F4AFFBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiBIWAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:00:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiBIV7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:59:49 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0027CE00E157;
        Wed,  9 Feb 2022 13:59:51 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso4124641ooi.1;
        Wed, 09 Feb 2022 13:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u827RA9/WHR5oLSZNgb5BTUDsvTIJNZRmS5owm7+iFs=;
        b=iwMv3KGkQRv5XATsbjxmLfUeRzSawTMwYZXooyAr0EBnvmhUR5aOZHzB/tgBhXNKnh
         oqfGELyCeCmD74dc9II7tiRyAZwbLT3aiXphej/PkC1cExKB1CWe4LurpO7LO8gW8Rlt
         wfGOW0PAbkC4pEEMJ4JSKBm3eAEu2tc7UtA7yiLTRozbLvYF4GE7qiL57kkVXQfhrdxX
         QRBhjBehFn0oRDcSA+0IIBNDuwJnIQSL5Mh+IKcYoyvJ5pc9LkkV2xko+X7EPchOld3P
         bGzPIfmGfJbNsK0kykk3IFc544UHXtpXqhv4Ak9h6ul3X7ix337++UYMuXsjIKtKxwRv
         8aYg==
X-Gm-Message-State: AOAM533e55QUGfvCZgRU7GNnGJ6/nOkspVsn6cNW3cPAYvb1yKEyKIo9
        IirjzfHnS390s1BQP1Bkfg==
X-Google-Smtp-Source: ABdhPJxqRkhn4+EXnsCWMdYQUrm/jUlU7DunZkBrIBbZkSlIKO9WsiQsab0sCGbmFU0xQ0+seXnuHA==
X-Received: by 2002:a05:6870:91c1:: with SMTP id c1mr1626155oaf.121.1644443991316;
        Wed, 09 Feb 2022 13:59:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m14sm7856006ooj.22.2022.02.09.13.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:59:50 -0800 (PST)
Received: (nullmailer pid 1002954 invoked by uid 1000);
        Wed, 09 Feb 2022 21:59:49 -0000
Date:   Wed, 9 Feb 2022 15:59:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: st: Add Silan SC7A20
 accelerometer
Message-ID: <YgQ5VaW1QqrxFfiL@robh.at.kernel.org>
References: <20220202235049.8051-1-samuel@sholland.org>
 <20220202235049.8051-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202235049.8051-3-samuel@sholland.org>
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

On Wed, 02 Feb 2022 17:50:47 -0600, Samuel Holland wrote:
> This chip is not an ST part, but it appears to be register-compatible
> with the LIS2DH, so it can use the same binding.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - Move the new compatible to its own section
> 
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
