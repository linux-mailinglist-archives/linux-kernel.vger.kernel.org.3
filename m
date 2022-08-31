Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61F5A782A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiHaHxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiHaHwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:52:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7AD27FD5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:52:41 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx38so13727246ljb.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Lckl7K+XuyktEVYPye4vGCDmH7688b5CS8zBA9Y9oIE=;
        b=PIg8+3d6PEsrGdo3r1QYFHSWChCwHGdEWlOiDvnIf+PiQBBAwBUXtWJkNksAnTUOdx
         siSmwzup/w6GIG11wuc4CA7s8hiwImPIJykM8qSfVmDS9ItqvvqqLv0cJ/0gI2lKJjYb
         fyvxf0Qg0bju9AN0WlDrOi3qP/EcVIDl2DBn0NVFLLfdSYA2bYmSWlqQcKy8ere2Vun0
         8igzsOczmuT6N7Gy6Jj7C71jU46qL8y+NWRgTfDUUPNPROIPD/g9BXvHaul7iU1v7czs
         c18I48wi3FALMEmLjq+PdfCUAJK/vSBnms332fshTtUvaJyQvqGjV4ydxrRtiFRBXfpF
         wrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Lckl7K+XuyktEVYPye4vGCDmH7688b5CS8zBA9Y9oIE=;
        b=wLj6SwyWYD/oJSTiErYua0n3rROXeVyLtDGIkdU37SCOpHsQM1sv5APHtWvEUW7GTW
         xYcLi+WdFUHMZrKqL79PGkfhlSMel4Edfmz0m8iNrjC6Kr6x51WVAHCJOnyD2Tgq4fZr
         pkN1b/bXL4ZhaMw/vJV4rWpwtLqrkRjZf8AZJ/zDhQ7DaXjHB8fcQvZ/5C5oTxJtQ6ce
         erbqbD6VHqBxp+7ppO2rSJRFe1cT9nAnik10uX3iCxRsLX2brNJVTu7JGJotUQJvda2E
         SLh2N28ggu2hYqO9R6BAsHb3D8Y2zbUVWsdvvE+Hl3GcawVgYpzObKdPaYU77DY8MQOl
         9SDQ==
X-Gm-Message-State: ACgBeo0Zcm9GNVsp4TrX8mlxUAroEhCFOefd3UAsseJ8UCW9/dIuP6wS
        CqJSYlEuwsL/5EaUdXUNCHJfNg==
X-Google-Smtp-Source: AA6agR7kerViFsEYIJs3B2EKamdow9afs0StxBSpkQBm+SKgwDA2fKkd5vv/1r6NG1EAam5/yvWDDQ==
X-Received: by 2002:a2e:5002:0:b0:264:2b08:9a3d with SMTP id e2-20020a2e5002000000b002642b089a3dmr4494279ljb.286.1661932360265;
        Wed, 31 Aug 2022 00:52:40 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id p17-20020a2ea4d1000000b002688844741bsm125809ljm.126.2022.08.31.00.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 00:52:39 -0700 (PDT)
Message-ID: <dcd25b00-f2e6-311c-fc1d-6175158f32b3@linaro.org>
Date:   Wed, 31 Aug 2022 10:52:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
 <20220830230012.9429-1-pali@kernel.org>
 <373fdedb-447e-b552-df83-737267068296@linaro.org>
 <20220831073622.5bp3ftf3fkea5rdk@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831073622.5bp3ftf3fkea5rdk@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 10:36, Pali Rohár wrote:
> On Wednesday 31 August 2022 10:31:22 Krzysztof Kozlowski wrote:
>> On 31/08/2022 02:00, Pali Rohár wrote:
>>> This new optional priority property allows to specify custom priority level
>>> of reset device. Default level was always 192.
>>
>> You still did not explain why do we need this. You only explained what
>> you did here, which is obvious and visible from the diff. What you
>> should explain is why you are doing it, what problem you are solving.
>>
>> Best regards,
>> Krzysztof
> 
> Look at patch 3/3, thanks.

This commit should explain it why you add new property. Some other
commits going via different trees/branches and ending up in entirely
different time/place in history do not really count.

Best regards,
Krzysztof
