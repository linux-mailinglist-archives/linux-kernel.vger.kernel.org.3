Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85A352A37C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347885AbiEQNd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiEQNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:33:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8A42A09
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:33:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq30so31386830lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jujkXXpL/kb/c7aZAyCjUl23gmXI2y9oErwqfBwIlr0=;
        b=OZEJ/Msp7XM8K+1vhwmBAlOo1ZNIN7ylNxEvoXh+uoCyiSwx/wEqHk0fKd2sW7xOZp
         bNbcNseXOWJ/lELXwKYbllrd9tJwDVpc1OQwUqRbGMSsx9kTxKn9SmLTr0TN+F6y/haw
         dkYskTaivYdRG8MnydOcW1QVMmZHuOZ360Llc6D7qcW9pFQrv4ziIqQ+mwU2xV8cOrIz
         C+THD4t+tyLo22Udr7I9Ff0q9X/7L3pr0AHtQ0BavcH065say7bldIrfJ0isYuWaF/EN
         o4UiyutD0Sp26Bz0HosBnNHEDrdE4KzAaJjRMyGlGi5YNovDdmhBJg2GyScU3Z5D58g7
         oHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jujkXXpL/kb/c7aZAyCjUl23gmXI2y9oErwqfBwIlr0=;
        b=CVBoxVn+KwhWw/bmB9esyaQFp0J/donC8o46raHq9MNmbSj7WzCArQNp14RBOpmGXF
         nUVbCh03/VhIEkEX92KQ1bOunmvS5lnB4F6sdPcykRFYozI9wnDSC3+3wKbYJWqAUqxp
         daquoVbgC54mJP28xocbZ8fz+ijd+KiUflrampxCb78RfpShg1yE/U3BiJLPLeNLK7XD
         qV81qOXWjxHQ+pqy2NnKs7YT0HtjqLTm+1dAAipdEIqIsGOkDjccfGG0Qf9iwvFOKxi7
         JyG9UoRdWiMhf+gDe4pgIc1s1Cov7ZlaY1LXelBo2ua90/mH1VNd/CFwTb4YZkPjGUKt
         qzuw==
X-Gm-Message-State: AOAM532d0okd4R7kr4vtY0QXi+OVvYiMCdinSTdl5XRVAx9BVXfVyBC6
        sCQUrB6M64s4RR9kvOVXs5A35A==
X-Google-Smtp-Source: ABdhPJwvty/7HIe4QthtrDFz9rwI5bwb99VvY5FFuB5Si25wkdLQ00AWYk839j19WtxQgf14jzNdGw==
X-Received: by 2002:a05:6512:b83:b0:44a:9fb7:784b with SMTP id b3-20020a0565120b8300b0044a9fb7784bmr16713124lfv.547.1652794430970;
        Tue, 17 May 2022 06:33:50 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c9-20020ac24149000000b0047255d21108sm1589584lfi.55.2022.05.17.06.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 06:33:49 -0700 (PDT)
Message-ID: <364d25ee-e7e3-96d3-a2ff-9befcce3f0ff@linaro.org>
Date:   Tue, 17 May 2022 15:33:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 03/13] arm64: tegra: Add Host1x and VIC on Tegra234
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220516100213.1536571-1-cyndis@kapsi.fi>
 <20220516100213.1536571-4-cyndis@kapsi.fi>
 <424b02f3-eb53-68d0-bfee-5488dbcefa71@linaro.org>
 <1fccdfe8-d44c-2d56-e572-628998efc985@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1fccdfe8-d44c-2d56-e572-628998efc985@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 10:38, Mikko Perttunen wrote:
>>>   
>>> +		host1x@13e00000 {
>>
>> Generic node names, if that possible. Since the bindings do not exist in
>> the next, I actually cannot figure out what's host1x...
> 
> Host1x is a hardware block that provides programmable DMA channels, HW 
> synchronization primitives, and virtualization support for IP blocks 
> connected to its "host1x bus". So far I haven't found a one or two word 
> way to describe it despite efforts. In any case, considering all the 
> existing documentation and device trees that use this name, I'd prefer 
> not changing it (especially as I don't know what else it could be called).

OK


Best regards,
Krzysztof
