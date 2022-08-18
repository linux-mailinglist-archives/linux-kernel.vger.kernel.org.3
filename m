Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B6E59868B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbiHROya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343768AbiHROy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:54:29 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138D58B7B;
        Thu, 18 Aug 2022 07:54:27 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id l18so1327547qvt.13;
        Thu, 18 Aug 2022 07:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=JkecDsfYlo0YgMi8yeSWcaslyjq9cwlOmGZBX8S/ZBU=;
        b=01gcGjl0WPEWyqE0m9CBtPHyG/7JfQ5kILh3fzlmrqjsBbbpVURoWQPl6Ok3sy/4NU
         kj3yu9o/F1b8k5Pbl4j9IAZNyTgn80ClKfM2hyoPnGtHI1OLpZfEvBnNyOa1Gsg4VFj6
         yIMtjIHJ1mODcepDbpTu9EmqLIpEE4RjAsn7vGW/3l70IRPINJCoYj/lZYn1E3cChAHX
         11/yFHh7+7lsEgRrju+WyKXaZMkfUzapl1OEU1LRDTFDvg9DSOLIYA2gchwjTM2g4bS6
         A6SMzwc9ejr5UirAUBLOU4CWM5qEVCQGxUzeaNzPreiVIiogp5dVyv57BE2uK2CHaaKi
         niqQ==
X-Gm-Message-State: ACgBeo1EPMD0js1PbNN+QdRwrw4EOGNpeSDQZaNLZ6X4J8SU44KaU0OB
        1N3Pyev0rblEA6l6zobC/lbRfSKZfJZ5
X-Google-Smtp-Source: AA6agR5lFPEpOOp7frn6UzeXdUvG6LJGGZ2KjOh7ET3kWtMg8h1ry7GZ4Zjw9a0c7qel4q55iy577A==
X-Received: by 2002:a05:6214:2522:b0:476:6d51:d42 with SMTP id gg2-20020a056214252200b004766d510d42mr2917445qvb.35.1660834467016;
        Thu, 18 Aug 2022 07:54:27 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c63:5705:782e:33fb:22e5:50bd])
        by smtp.gmail.com with ESMTPSA id i3-20020a05622a08c300b0031ef0081d77sm1117466qte.79.2022.08.18.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:54:26 -0700 (PDT)
Received: (nullmailer pid 1853163 invoked by uid 1000);
        Thu, 18 Aug 2022 14:54:24 -0000
Date:   Thu, 18 Aug 2022 08:54:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: Drop Patrick Vasseur
Message-ID: <20220818145424.GF1829017-robh@kernel.org>
References: <20220816125401.70317-1-krzysztof.kozlowski@linaro.org>
 <20220816125401.70317-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816125401.70317-3-krzysztof.kozlowski@linaro.org>
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

On Tue, Aug 16, 2022 at 03:54:01PM +0300, Krzysztof Kozlowski wrote:
> Emails to Patrick Vasseur bounce ("Unknown To address").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
