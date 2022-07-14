Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE03574546
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiGNGuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiGNGuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:50:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF127FED
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:50:06 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o12so1067360ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kAMorpNPpq8Kl7mIQPaFEYYx6iRT5mkDQv6ldaOiuso=;
        b=mCtgy7WJTcIR5VvYFE1mQpSdwHFub/JxquNNbGjOEDG5kerZcvfIWuR/Q4SfMdeLCM
         LKPbhc4nez83WRVbxrYgZnSGGOfCShXYSZVg1nlUWSu3Nkz5eoiwG9GJ9dxxk8GZCVMj
         0VGmzNW+39nIVWiAdU11NFp9Pqt0bKUKDpVd30O2rLoijaUPWKYITYSu52p4vyn1YxLK
         itzn4rLQSdioMpwWIsLTXSl5Rm0aib09E33je8nhM053J2+ni+JPbwJds70N7qPumteu
         aiRHfv0M8e3NXr0lJCxtybrL33+/GUf9upn7Agyqg7bvEbG8rpodGLO0VwrYap7piiPI
         DA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kAMorpNPpq8Kl7mIQPaFEYYx6iRT5mkDQv6ldaOiuso=;
        b=ZsxPbbFBUutfq+I6oBu4rS44Z8E0FV2L+HUFv1zoIVmz2vCUYUYQdoS0n1M1XnLqdX
         LszuQag/tBIH9Xzle4Z0DWL46A25Zrn0yQUf/UnwkH5jg0+wiW73niVX50yRwjWDLoVP
         lXcZd9nsdPbqHz0PcAlmjctcE7IpBcgqr1EOnyLaPchA11CNHU3FEGXD0VUr/6omki5W
         xXNKzYSp7CNK8xhNss7v7vh1oRfsnYc83U9riFG13YXXQb93GLC1uUo3PTu7UfIa+i/k
         b1JbmtBu6lgG1U7S3ag+wKxgGTzeVEtZTeFIWI07pt+9Rm5dZLnhX7mi/DCyyBsZ7egT
         r2/A==
X-Gm-Message-State: AJIora+WdCt11z9Me+jK2suHJupmdkULV48mrTP0mkXlpwVyWMnNvVtv
        6YZ2V9UgZclbssVvoHH3bnBMeA==
X-Google-Smtp-Source: AGRyM1uugxfr8VnRrNRyLEftcuT/EW3N+W2M709baxf4ALu+7XKMmiU/fc1xj1s3byOkIhsLkTeYbw==
X-Received: by 2002:a2e:968b:0:b0:25d:67ce:134c with SMTP id q11-20020a2e968b000000b0025d67ce134cmr3861590lji.277.1657781405298;
        Wed, 13 Jul 2022 23:50:05 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512114100b00489fdc9ac15sm195626lfg.42.2022.07.13.23.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 23:50:04 -0700 (PDT)
Message-ID: <32b30b60-26f7-50e9-7dca-c25bc3f4014d@linaro.org>
Date:   Thu, 14 Jul 2022 08:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 1/2] thermal: Add thermal driver for Sunplus
Content-Language: en-US
To:     =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1654660009.git.lhjeff911@gmail.com>
 <b114b6f8ea51054561a61dc4982715bb73633ec5.1654660009.git.lhjeff911@gmail.com>
 <be752ee1-3732-bcbd-4d31-6d6fe0bd251f@linaro.org>
 <a510b35f89034f60a05d6dbe7245e789@sphcmbx01.sunplus.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a510b35f89034f60a05d6dbe7245e789@sphcmbx01.sunplus.com.tw>
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

On 14/07/2022 07:32, Lh Kuo 郭力豪 wrote:
>>> +}
>>> +
>>> +static int sunplus_thermal_remove(struct platform_device *pdev) {
>>> +	struct sp_thermal_data *sp_data = platform_get_drvdata(pdev);
>>> +
>>> +	thermal_zone_of_sensor_unregister(&pdev->dev, sp_data->pcb_tz);
>>
>> You used devm to register, so this looks wrong and will lead to double free.
>>
>>
> 
> You mean the remove function is not needed.  ??

At least this call but after its removal the entire function would be
empty, I think.


Best regards,
Krzysztof
