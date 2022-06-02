Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C51453BA1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiFBNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiFBNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:50:21 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B611D9EB8;
        Thu,  2 Jun 2022 06:50:17 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id f5-20020a4aa685000000b0040e7e819183so916124oom.3;
        Thu, 02 Jun 2022 06:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m7Egz3Eq4p4pH7ofqDEwdevk0tSPQ2S3OmzV9Rn7cog=;
        b=idyLCUZqNwtt41GHHuJA3ehdPbn9+NytnkZgE+mlYnIQvgH0chZOeadDM/9WiShbeU
         lFSUUwyBHGScRDEjY5N7JU7hDFWKApzERWO1BcwcAxDx9n/Hq2vdRvhuF0W4yvyvhnCx
         1HINcGhCJf0fKEAJciggjC/tuDxH5g9vhkkl1aBklvl9TUr6vDC0lPkUvFlD6uVPmsSv
         ltGnfYmDIG4m04eWfL7Qi7AX/LlkXVV06EjhuNpACOEAiHQvCllmiLA7FBfP7qzsz5Wi
         ciw3myQG6bQyd5UNt11S3i2Q9Abjk/e6Xy9inu5fNwtNSFNWUq2VLhZKYRjoxTm73h+j
         M58w==
X-Gm-Message-State: AOAM5312ODdMqUe++aZn5yIlCvlxgeOp+tSojQ6ujkqOAQoftVK9nell
        cHqF3QYC7R7IUTJYDL7VUg==
X-Google-Smtp-Source: ABdhPJwJXAd51YLvPJ90VxQRsLC8hBY4/pzwaXaplOTizmH4wxfnS/mGPlNTwMHa0vECJ2olRL5iIQ==
X-Received: by 2002:a4a:ba81:0:b0:40e:7cd9:afa1 with SMTP id d1-20020a4aba81000000b0040e7cd9afa1mr2078469oop.22.1654177816557;
        Thu, 02 Jun 2022 06:50:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t12-20020a056830082c00b0060b39282e7esm2182511ots.35.2022.06.02.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:50:16 -0700 (PDT)
Received: (nullmailer pid 2186777 invoked by uid 1000);
        Thu, 02 Jun 2022 13:50:15 -0000
Date:   Thu, 2 Jun 2022 08:50:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        kernel <kernel@sberdevices.ru>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Message-ID: <20220602135015.GA2186715-robh@kernel.org>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
 <20220525181532.6805-2-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525181532.6805-2-ddrokosov@sberdevices.ru>
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

On Wed, 25 May 2022 18:15:30 +0000, Dmitry Rokosov wrote:
> MEMSensing Microsystems (Suzhou, China) Co., Ltd. operates as a micro
> electromechanical system technology company which produces micro
> electromechanical system microphones and sensors.
> MEMSensing Microsystems (Suzhou, China) Co., Ltd. applies its products
> in consumer electronics, industrial control, medical electronics
> and automotive, and other fields.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
