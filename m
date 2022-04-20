Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB095083B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376867AbiDTIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376848AbiDTIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:45:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AE43B3C8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:42:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 21so1361374edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a0iMNTEwMUTyoU7qHOTCB94CJKN7vHy3TmetHRHL5ng=;
        b=StdJRvjuM6AflS16vjrcj5/EC/1KJhQtwNpSp/MuPm4qP37p8vvEkWy5q95gG0j6TI
         wsdoRQTNYTNRurlY7iySdgYzdOVW8czJ8BJZAZwVnAwSV5OI97D1PqXAZxR3zGVbUyPP
         IwKUHP8tWtmX8ti/PxneQe/5QCn52zfVovUphd+ULtRo+pDcinmJ4L73Px5R1URV65UK
         nid2JfQoJUkE2fUQJ3FpLBlO8wbOHXnNan70pW+JVn3mcx/lL3Gz4r/ELkQuA+1rhuNK
         UA4F3AQjcIVC3pwz6VOa3e0q8PPqbnYJ2e0mhx8zS5rcIxDNuXQH0Yr/KmXLfoJ/r5LS
         VIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a0iMNTEwMUTyoU7qHOTCB94CJKN7vHy3TmetHRHL5ng=;
        b=QlxwQArI7OGgLfPbGNDPfK4YhObopX0RNcW2YkbrpKtYylx8QWp3B3JEukj4sg7Sed
         jx5eC5V+5/kJc/nBXApp40nKFu9DSdlOLBdhHMsMHMYZ0DMpmzjwPUwFZ2DVEQ8zj7h3
         vEK5j3qQGMgzZd+x37d6Kww52An5E/KHjurPAtX0CngyLgKf8DZ9cF03/xAWjZohUtGS
         lErSuWH4UljB60glcgV7CK2YphdnqYpZE9y+DCQg/upnRPFmBE/m6x9ab8HGcwUrfnT8
         khxMSB1Zin9TlfedixaQgckmfCBXGeON2us6oRVqZBwFZbv3K3fWCGgFZ/nNh4xMFZQ2
         L2+w==
X-Gm-Message-State: AOAM533OJU+b81InCOiMp3k7oUwEIO2n6a88rGW8jJ4PibCq2w0zeTqH
        Epoej1xUXz5jJEo6PXNmevFWJ61Udi8ByA==
X-Google-Smtp-Source: ABdhPJzHS7GNTqk2YusE9WZsjDe4804XYd4DEyi3+GRrX9yuUe3nI6KauVtP8hgH0pZZ+KXP7CODSw==
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id ds1-20020a0564021cc100b004132b12fc49mr21810423edb.118.1650444171397;
        Wed, 20 Apr 2022 01:42:51 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id mv12-20020a170907838c00b006e87c0247f4sm6427819ejc.186.2022.04.20.01.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 01:42:50 -0700 (PDT)
Message-ID: <a3edf0e1-644a-38b2-b23d-30cc01005786@linaro.org>
Date:   Wed, 20 Apr 2022 10:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: qcom-ipcc: simplify the example
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, netdev@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Alex Elder <elder@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
References: <20220402155551.16509-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402155551.16509-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 17:55, Krzysztof Kozlowski wrote:
> Consumer examples in the bindings of resource providers are trivial,
> useless and duplicating code.  Additionally the incomplete qcom,smp2p
> example triggers DT schema warnings.
> 
> Cleanup the example by removing the consumer part and fixing the
> indentation to DT schema convention.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Jassi,
Do you plan to pick this mailbox patch?

Best regards,
Krzysztof
