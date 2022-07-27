Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB7582906
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiG0Ov5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiG0Ovu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:51:50 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232FD42AE9;
        Wed, 27 Jul 2022 07:51:50 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id v185so13704330ioe.11;
        Wed, 27 Jul 2022 07:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xCokfXhPR4KTF41sdrZm+RqhxEGMWVkr/Hg5KMBHFR8=;
        b=H7KppZWnYL7txUh3Yivu8Z8ktrMODqMaki4KRP3lqpqZoGRZE0C25ZCDF5VE4zX14/
         ujLlFL7993L/tnIIopWsa9aMRyei6SEG/266ztE5r256SlRK5c3hJyGTCNV2mi6+1yJH
         s1esC8a9O7gj7cAXb7JrtGfZxVxMDSkGZrt16HLuim5xolnS00SzIinb6o9KxZ/Org9P
         xr4WAqRQr/srv8u91w0bPghV43MyURbv8R95Ezh/tdpQV8xtd5Rxuyy/3sJxfVSAgyr/
         zQBQCpaVSjbl/rd5D/OGgFeK5803nY/dwyGmICnCVtmzcaEGkObVNntreRmVWLnPrphh
         oH6Q==
X-Gm-Message-State: AJIora+ot8LpXgio4Ho2vExDE3fYcUMGC63N+MdboeaeULOhdeubCe62
        2b6na9G1ePFISUVH9AA0Rr6YS4+kYg==
X-Google-Smtp-Source: AGRyM1sdrzFHIbGmxlbzQsvgmhTb+u6PlXR7h1s1EkyZ/uFrpL41TeK9mHOW3wo0afjLUrYDMRJkHQ==
X-Received: by 2002:a05:6638:250d:b0:340:4915:263 with SMTP id v13-20020a056638250d00b0034049150263mr9036435jat.17.1658933509322;
        Wed, 27 Jul 2022 07:51:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b11-20020a026f4b000000b0033158c4a312sm7921935jae.55.2022.07.27.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 07:51:49 -0700 (PDT)
Received: (nullmailer pid 2644092 invoked by uid 1000);
        Wed, 27 Jul 2022 14:51:47 -0000
Date:   Wed, 27 Jul 2022 08:51:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Cristian Pop <cristian.pop@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio/dac: adi,ad5766: Add missing type to
 'output-range-microvolts'
Message-ID: <20220727145147.GA2644033-robh@kernel.org>
References: <20220719215152.1877776-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719215152.1877776-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 15:51:52 -0600, Rob Herring wrote:
> 'output-range-microvolts' is missing a type definition. '-microvolts' is
> not a standard unit (should be '-microvolt'). As the property is already
> in use, add a type reference.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
