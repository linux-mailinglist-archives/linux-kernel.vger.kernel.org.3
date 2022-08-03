Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC5588C38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiHCMfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiHCMex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:34:53 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6984E58B40
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:34:51 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n133so19824307oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=UWrNvVp7YUZj8MmbTig9VeiLZuSQe+hksBAGZfvUdBo=;
        b=cm2gRhjRwXYwxYHmFwee7XBW4CLtFAV/S07uj1an18jQtRIxgH/xE/vLtH0QFUaHqD
         w+SaMfXgygW/4faReaidGDU+znpMrNPAzjPDCJI5zoc0kftW1rGC5Rk4mwgMbJMYpxKB
         7jX3JfvDSiO1jDWqqe7meCNyLRjmwUgbgkZTAMKStQCPhNjSvZjYccXZoEyTK9wGuS0+
         9qRkhF618vXA6RYKQAp2obZ2F/Dc8aConacM9fnbPHfuTGPa4Ev4xXakycVCqZgWDJ3m
         b/gprF5+J10t/8N4pW9HlsYpABaqF4xSDmbmn4Z4xPj41ypvQoLDHnZap1wCHwbrPr9l
         /k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UWrNvVp7YUZj8MmbTig9VeiLZuSQe+hksBAGZfvUdBo=;
        b=5qBdh3A+UGEhyZiElQn5GdioM9SdQQgLXlnz1WyODcX6wmAhyjPSwpKpycCq8AvuBG
         ex2mV4UdEWvsdPv3JMCEk6cZA281KVm7rC8O/fZnQluKdUGpnILvKBf5t1fpvuhe40+v
         D5SKtQ9lDxZ2O1vn6xUaPMSCqr+3aB6CEinDvXdC8ov20uJ/E34HIB92o4npheR8ldLW
         Pz9YuURZ1HL1i4qT/wkdacp82ZaWkvoYTGcJROchnPjqtxGCOc6+DJTd8Mpl72SpCmlS
         b7IvgUD1rYi0XLoQmOYK8lVblw5MG3oTsSJzWUVcLfJ5cIFhXss8BLw6b7hhDdnIDeLb
         cWBg==
X-Gm-Message-State: ACgBeo1ZhYV12eMtUujawaK1IKM3wbi32kHtYhxxk6+ST10f7Mzuku5h
        TSkqyyMKKN0Cr+DwlZsjPI1Dgg==
X-Google-Smtp-Source: AA6agR6kSpPZVxObp4lEc841dhz2wr+j2UZYAn4pNEJahO/BdOfBHzbHBe425OJvWYB2/g5z0QlgZA==
X-Received: by 2002:a05:6808:2013:b0:33a:921b:33e6 with SMTP id q19-20020a056808201300b0033a921b33e6mr1532318oiw.1.1659530090701;
        Wed, 03 Aug 2022 05:34:50 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id a24-20020a05683012d800b006339b36127dsm1420706otq.3.2022.08.03.05.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 05:34:50 -0700 (PDT)
Message-ID: <a42bb5d5-4783-b755-5479-48c5bcdbbedd@linaro.org>
Date:   Wed, 3 Aug 2022 07:34:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [greybus-dev] Re: [PATCH linux-next] staging: greybus:using the
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     cgel.zte@gmail.com, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220803062258.1650792-1-ye.xingchen@zte.com.cn>
 <YuoWCSQCnNU3DrUL@kroah.com>
 <81d363ba-82ef-d556-2d77-083e3b2d9d02@linaro.org>
 <YupqXVa+RYm4Ul+m@kroah.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <YupqXVa+RYm4Ul+m@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 7:30 AM, Greg KH wrote:
>>
>> Ye Xingchen had nothing to do with your receiving the message twice.
> Ah, ok.  But they did send a number of patches like this while after I
> had sent my first request to not do patches in this format anymore,
> which is what caused my response here.

I didn't realize that.  That explains why your response was
"Please follow researcher-guidelines.rst."  I didn't initially
understand why it was that instead of something more directed
at the content of the patch.

I *thought* it might be because "Zeal Robot" might be something
new, and so considered experimental?

Anyway, I think we're clear now.  Thanks.

					-Alex
