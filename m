Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4447F4CC08B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiCCPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiCCPBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:01:39 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088A912B75E;
        Thu,  3 Mar 2022 07:00:54 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so6038379oos.9;
        Thu, 03 Mar 2022 07:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=10OK83BK3wd/+Jzs3VqES1HpsZ+99tSuosXReiZfY9U=;
        b=Zsl2FR1Rt89oDXt0jx/pKoR5NO1lTPdG3XtfNI2tuYwp7igpfwGVubLOrNW+p5ZwOe
         DEhaZuAVzsAMX4EVokCYFxEBwBSf1rl5Lq/8//TAlc7D2JoV+DY3HYL3hHhJW3V44kAu
         AN2I426wxsBGMizMtmNNWjjjzUkWxKx303SEGOrsVaF6YZjEyStrY9+zMrFHozcy4aLS
         Ms2AwzxwkK+TNnOcbs5+09iRq7Od88TjoDfk6qZsluztUimQIrbUUJL1H6DK7MBHq0GM
         3BtaXrupnBx0uwgpusq3RMdXJDcBVaT0ZuLxh+OBetpfSG0AOCgpmM/9QP902qc9MOaP
         Uftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=10OK83BK3wd/+Jzs3VqES1HpsZ+99tSuosXReiZfY9U=;
        b=Th6LKKgVVjlpHIviR90Bk7igkRqRSXUDrErNVBmRO53s6hGqPjMtyQH91X3bqZ7SdT
         eSAhcykHJFTSABQrUNZt/WKqWAZNa8yVJ+gg528i+yATNCexIffApNBqi4714A9BaoPg
         ekOZxviKJOtLqH0zJj6CCU+l4XQ3q7ph9aBD0HWdYAanzHt8/pjm6YZ0bZwgF2oujQYe
         ZLExlaBo8cTL5nGajSDk8y6Z7uHo2Twy3DLQNCs/kN8PmGhjyWPznl3KJtFBpObb+edA
         hjc/76vt56g5A9RWUs6SzSZzoW3I10gqiPVTu8itelGZwZOBehQCVk/c9Q7uqAvt4nwY
         rxwA==
X-Gm-Message-State: AOAM532JDbCSZJsnlU/7cblDbytuIzNeELFmB9WTD33iZ8iP+DUt8pmk
        7LXr+BOcYEU9F/257P7peCw=
X-Google-Smtp-Source: ABdhPJxHvgTQlffRki4jCveE/mEGrwH/EKqAPG0vUlGiDM4sw9IB2wT/h8Ws1fR8mOvykyPEnbM11g==
X-Received: by 2002:a05:6870:d69b:b0:d9:a353:c12f with SMTP id z27-20020a056870d69b00b000d9a353c12fmr4408004oap.118.1646319653274;
        Thu, 03 Mar 2022 07:00:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r14-20020a056870e98e00b000d43a8c3065sm1126598oao.28.2022.03.03.07.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 07:00:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <abde8dce-810b-fd39-b0aa-4f1b2ec8f8d7@roeck-us.net>
Date:   Thu, 3 Mar 2022 07:00:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 2/2] hwmon: Add driver for Texas Instruments TMP464 and
 TMP468
Content-Language: en-US
To:     Agathe Porte <agathe.porte@nokia.com>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
References: <20220222223610.23098-1-linux@roeck-us.net>
 <20220222223610.23098-2-linux@roeck-us.net>
 <20220302175941.GA2523098@roeck-us.net>
 <9e868438-c0ad-464f-358c-5ee77bfb7f4f@nokia.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <9e868438-c0ad-464f-358c-5ee77bfb7f4f@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 00:57, Agathe Porte wrote:
> Hi Guenter,
> 
> Le 02/03/2022 à 18:59, Guenter Roeck a écrit :
>> Any review / test feedback on this patch ? I would like to apply it
>> before the commit window opens, but the time is getting short.
> 
> I thought that you did receive the TMP464 samples and had the opportunity to test on it. I will test v7 on our hardware equipped with TMP464, verify that DT support works fine, and will reply to this email with my findings.
> 

Yes, I did, and thanks a lot for it! I even wrote a qemu emulation
for the chip to be able to test the devicetree code.

Still, I need to have someone else confirm that I didn't mess up.

Thanks,
Guenter
