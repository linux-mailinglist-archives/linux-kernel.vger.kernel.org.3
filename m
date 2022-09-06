Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594335AEEDF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbiIFPb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbiIFPba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:31:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0F4C2750
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:42:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k9so15837872wri.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LVG2k9qlZSYSItbUja/vVl+mMsJ0aGC3aC/5Be+/0UQ=;
        b=h8rEHoWVvlpJcptGq63kXtigsLFsKmza5rO1iLMBpD2HflnwMssZ7QsdImgx/a/i1B
         w7jcHVcEOLC7SSRSSWvDxXsFnKrapli7D8ppHMNKI1julqM0XO2gKwxjeqTWm6Kf0cFz
         QJIwVNbDRaLfXr7+Qy4pD7hgmIoXjPzCBfChnJQ5OCAFaaN8wJgivGo0YwLLxyHLywzZ
         sMxfEHyFlBN9AdDRtqPB1VlHk1C8xNv9ozx2IQUNeOesK+jzdVUyfe8PHgNxel4jM3Am
         UDEn/rc3wTb5tDcW69rrkB/gw+DLLOTOxN/kGYJ0MAaxRBXztoUwsXNEh/EAvxPYzIMR
         EGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LVG2k9qlZSYSItbUja/vVl+mMsJ0aGC3aC/5Be+/0UQ=;
        b=k8utYV8v1l+sXLYtsyQCGjBrj1PCtgShqtQm3GOYTx9DP0eDmsISBT6NBLmBUrr5sP
         HLan6bQEOTAijKg4qoqOeOGbhpuXlFPDm5V24a001qSm5fieP8Fr8FVe6kGZo2xgdIis
         YmmfeXvx5WMwWf2ue/62dWAuD1NGlO2Lm+BGa+WB6Yu3wqUZ9rn+UbLqprkYzO0dUJZq
         cxupI73DY2GfkACDZLJ3X5vWOXYCtZKptxMQTtgKh8rd5SXxbYkStkl4u4Tj5f9SIK8+
         0IVfotSrN1Ig4a2xbTePM+M3SdlH5QvZL6pD4JO5AB1fIVp0VdhUZYEQitgVoJhus6im
         rKgg==
X-Gm-Message-State: ACgBeo06fJUS9+PUFEQeZ76mpwGWL8c07boHL2iG/fVTLb0cz59X6bzi
        Ewwk6GT/6xipWfIN1YCbvPgUjg==
X-Google-Smtp-Source: AA6agR5cBBA0LpUBJt1LRkaVH8/J+YOjlb/QmJY6U4nHaLR9ZqVq5E7PKcMTwscp+rC9590EMc7sBA==
X-Received: by 2002:a05:6000:1546:b0:226:ee2c:74bc with SMTP id 6-20020a056000154600b00226ee2c74bcmr16289521wry.152.1662475279112;
        Tue, 06 Sep 2022 07:41:19 -0700 (PDT)
Received: from [192.168.1.69] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b00226f0a00348sm12766211wri.111.2022.09.06.07.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 07:41:18 -0700 (PDT)
Message-ID: <82ec09fd-a940-cae6-f793-1bb903190664@baylibre.com>
Date:   Tue, 6 Sep 2022 16:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC PATCH 2/2] counter: Introduce the COUNTER_COMP_ARRAY_U64
 component type
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        fabien.lahoudere@collabora.com, gwendal@chromium.org,
        enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com
References: <cover.1661785438.git.william.gray@linaro.org>
 <31a35481813ec26949018888253278a634998a92.1661785438.git.william.gray@linaro.org>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <31a35481813ec26949018888253278a634998a92.1661785438.git.william.gray@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/08/2022 17:17, William Breathitt Gray wrote:
> The COUNTER_COMP_ARRAY_U64 Counter component type is introduced to
> enable support for Counter array components. With Counter array
> components, exposure for buffers on counter devices can be defined via
> new Counter array component macros. This should simplify code for driver
> authors who would otherwise need to define individual Counter components
> for each array element.
>
> Three Counter array component macros are introduced::
>
>          COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _length)
>          COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _length)
>          COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _length)

Hi William,

I have 2 comments :

1) What about ENUM ? I guess that it will not be possible to handle 
ARRAY of ENUM ?
     That would be useful for polarity0/1/2/3 in my ECAP driver
     (something like COUNTER_COMP_SIGNAL_ARRAY_ENUM for instance)

2) I made some tests with COUNTER_COMP_COUNT_ARRAY_U64
         COUNTER_COMP_COUNT_ARRAY_U64("capture", ecap_cnt_cap_read, 
NULL, ECAP_NB_CEVT)
     I can get consistent data value when using 'cat captureX' linux 
commands.
     But I get weird values when using watches from userspace 
application code (I will send my test results to you).

Julien Panis
