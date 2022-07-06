Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D935568B95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiGFOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiGFOpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:45:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA9025594
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:45:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r9so18731233ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fqggrorsOMK1/Q3LUERXKOHSnzzVH9VjKHdlcLxDeU8=;
        b=UfNLXzs0clDz1kFDTuFHM401TPlWx0oEXl4Zy45Pkg6e8i4u2He8PpJj1gbdHcWXTH
         ITrRZ7pdfMEe2ucnr8u7TZlIYGuHU9BoOF4WquKu00uCRsscYv2rMr9U/UUXt39tvZB4
         Ath1M8cJJAa3bjfz+DLhUuYZZm1Zal6rwQwQFhfqTkRrJD/cXMnHmDZHKcMC7v8kWrVl
         OJtUgTqPEe+OslFWI0usaktZOVwUfG1mnZ++TW468AHCgqhnz2Ld4xBSfgYnDCgZGW81
         lUpdNAKH3j1Wv21f+8N0rZZrI7UbEF0TrrWq4DBHliqjNxVDytprutNVJK/xXu8zmCrt
         zHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fqggrorsOMK1/Q3LUERXKOHSnzzVH9VjKHdlcLxDeU8=;
        b=qZbScb3Spb9msDzz5msbEyScPO+pHjtEguJT8X53N0k05Sz5wEwGNkhnkaJbE41FI7
         /vvfdahbJp3GBWCLqerpBLXFeYHH6y6hd6hLXtXekROsZsC87xIV3845JyEJGridLSi0
         VvmMlpz+wpJgo6oV6swfO5spWeOApu8EHJNvmUgH8IpAdopyf+tijzW/GyIunjRDGQ/3
         7i3IG+DtzHwruFOzlbypVBtBK4iBm09r6rITMmgAWRC1BnsurmHGASL2u5rcPOoeoNS+
         i58OokNLHV2f7RYqh25Uh6sHdyKG7VfTkotdM6zOTJxVn4EEVv4fsjlsF+F3PlG3qpWX
         dMzg==
X-Gm-Message-State: AJIora936CH6y1dVZgvEBN7pI/7eR0Ye2WaxQ/ArS0VQk6vr3LlPyGh1
        y5ciVrmcsN/aicLuwhfZZrOdSQ==
X-Google-Smtp-Source: AGRyM1tFs7JadmbYZAM8ur0wEsMyO4m9qic6SDkHuwKo06yaUIEjfU7a5sI+qBgJGUo1SzK9Os5xYw==
X-Received: by 2002:a05:651c:a0c:b0:25b:ba85:6db5 with SMTP id k12-20020a05651c0a0c00b0025bba856db5mr24652786ljq.351.1657118713236;
        Wed, 06 Jul 2022 07:45:13 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id m10-20020a056512358a00b0047255d21129sm6337867lfr.88.2022.07.06.07.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:45:12 -0700 (PDT)
Message-ID: <58371fc0-ef6e-dbb4-88bf-221e8e1c93e5@linaro.org>
Date:   Wed, 6 Jul 2022 16:45:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 08/13] ARM: dts: qcom: fix dtc warning for missing
 #address-cells for ipq8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-9-ansuelsmth@gmail.com>
 <7c3ef50a-2a4d-4b75-3aab-3bfbf12e06c4@linaro.org>
 <62c563dc.1c69fb81.e405a.e7c0@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <62c563dc.1c69fb81.e405a.e7c0@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 12:12, Christian Marangi wrote:
> On Wed, Jul 06, 2022 at 10:37:47AM +0200, Krzysztof Kozlowski wrote:
>> On 05/07/2022 15:39, Christian Marangi wrote:
>>> Fix dtc warning for missing #address-cells for ipq8064.
>>
>> Paste the applicable part of warning in the commit log.
>>
>>>
>>
>>
>> Best regards,
>> Krzysztof
> 
> Can I squash here the warning from the smb patch?

Do you fix the same stuff in both commits?

Best regards,
Krzysztof
