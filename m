Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90CC50E2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbiDYOJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiDYOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:09:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700822CC8E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:06:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y21so11654754edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=/vpSTQOxMIjkwOKDd/IzLiSQDeYbAvNqMNwYa2oQYqE=;
        b=vKwliupk7ILiPaMFtJEU1aYZmewCgLpvxJGMWMS3r4Dbpq81h3mZ3BAZaHVMvcD3ns
         StiMfxnZzlQckNOWj8dIe4HYZs3aZGY9a8U8qdFXHQp71GID8HhFOU5d0XvmRhaFkcVW
         HFO201/98clZYXhATwcDgZpKJXmhVmQk3OKTnuD+N/1p+DRug4wHUAB6jWh4unugYmSd
         a+8XGjwrg8Kbjm/5Sa2l+w2/9vqIdfXd5yH5aFQXe37QepXmHcLn1FyKxzg379hm5XJJ
         yPxnttZCWa7mTlakwmaQlqxS8gBAv8X0PT9iWJUnkFOAnLyfOp6mw5Ar4s7UmRYeAExp
         F35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=/vpSTQOxMIjkwOKDd/IzLiSQDeYbAvNqMNwYa2oQYqE=;
        b=O5EWnh4ePC3bU2raWZ2TZaXsuzZP11cFg48Y54B2nYkp71l+1LoYbzad4MYckWv6pt
         teLuUCtcglJ3RJ1/fGrzMTZVBNoij7yS0gFnPFrtCOFxFRzXWnsBbXUtnZtqgXE8Yttg
         u/zZE87rISUGJSwGHs708lfnJGbs/c1/EcxJdkfmV/Lk4JK5mTjEgBY/ImY5sRWka/Ie
         yGqYB+oh9TQRD99vve3HDoN/efXMQIhXotyXqw8qbFmUVaOPZKulMhYM9MV4sxV53Ncs
         xnKH0KNuCLPbaDZ0Og1Vnn89Ve+2sGIm3LxWMGM9pDrOhDOdCg0lZhxL3xw4Y3HNAygs
         5Q6Q==
X-Gm-Message-State: AOAM53217T/9zg4RkoBJHLy/WQdbgHaXqhSs+n7b8wArecZSUueqnVj4
        uQxYO9Iv1ydnQpqEGtMM0FGnZQ==
X-Google-Smtp-Source: ABdhPJyZuFxlR17FQ27WvK6hB8uY+2zlu7SUpICQqyinBeK6k2xotFJ+rDD1CGFkKZP1pqSzVmKeQg==
X-Received: by 2002:a05:6402:f1a:b0:425:f303:8b35 with SMTP id i26-20020a0564020f1a00b00425f3038b35mr1901074eda.332.1650895607099;
        Mon, 25 Apr 2022 07:06:47 -0700 (PDT)
Received: from [192.168.0.243] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7c04f000000b004229daeaf37sm4649052edo.40.2022.04.25.07.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 07:06:46 -0700 (PDT)
Message-ID: <5c6ce97d-e31a-6cf9-6da6-8d27f19a53cc@linaro.org>
Date:   Mon, 25 Apr 2022 16:06:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: stm32: Add compatible strings
 for Protonic T1L boards
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20220425132844.866743-1-o.rempel@pengutronix.de>
 <20220425132844.866743-2-o.rempel@pengutronix.de>
 <35648611-cfa9-1df4-7130-7cd1bcf1a69e@linaro.org>
In-Reply-To: <35648611-cfa9-1df4-7130-7cd1bcf1a69e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 15:53, Krzysztof Kozlowski wrote:
> On 25/04/2022 15:28, Oleksij Rempel wrote:
>> This boards are based on STM32MP151AAD3 and use 10BaseT1L for
>> communication.
>>
>> - PRTT1C - 10BaseT1L switch
>> - PRTT1S - 10BaseT1L CO2 sensor board
>> - PRTT1A - 10BaseT1L multi functional controller
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Although the order is still messed up. I through you will move the entry
just slightly up, not to the beginning, so maybe just rebase on top of:
https://lore.kernel.org/all/20220425140436.332467-1-krzysztof.kozlowski@linaro.org/


Best regards,
Krzysztof
