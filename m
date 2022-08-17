Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA6596ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiHQMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbiHQMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:53:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0991E7B;
        Wed, 17 Aug 2022 05:53:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gp7so12390931pjb.4;
        Wed, 17 Aug 2022 05:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Ugwi2AvdBLBX3mbLkMcgHP80OzoI1Xftn3PLsCsvLMY=;
        b=O846mNddksFmGfubqjFHA2lDgofSFOcNFT3vLztRNEx3trvZnIH268rTPVJRpJkBWy
         qvb5/PZI3cMpPVai+vJD4bIG+0CSh7ZwRPwx1kZXBfP8y79o8JzLNIBg9hCjekq92WIT
         WKxQCbo/wRGkMMnl2TuTzXhs32YV1OaRttV4S25amb86GV5A8Wu2boNxVMkTkm0uOIV2
         lirhW0Zi2XclhW8f70/oLN5o1/wDLUIxAcquvXkTmwJCgkbK9F+WsDqU6VGvuhCJzo5T
         J38NplgnzryM9gGmkye5Jo437yZQOn15Pj5f3go15uGvtVHOD9nj7ZdV8y6/Yqqk1hQQ
         7eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ugwi2AvdBLBX3mbLkMcgHP80OzoI1Xftn3PLsCsvLMY=;
        b=akl2qLicLVl/eYkxfOtamjSqwQm4d8RONl8Cw9SDHU47Wi84ViAxyhbhWK174DZSVm
         Hd8D2429V7uUI16nyofp5kPNQgP7PK7pIPx+PJQPj89yEpzofIh4lspWauMnakfQQznc
         HCwtEH5vK8kd2yLxqz1DT5mIpcSiMP0/C/WPr+lAppzQDVJXjqpEbrYz82qYqpXd2vtu
         BkgIknLq60WfnAHAS+KU2+QMZoNkuzwP452+2/K2fC5s6rXEqHhTcEKRqBmCFD3/IVgM
         SSGBrNBb+LKRurVylUMFBSO2OnAFc1h0XcnDD0pz9nKD9RmK8OGBLveSRohFYen1lotb
         gm4g==
X-Gm-Message-State: ACgBeo3+pAATE1unk/E7cwGpdXeq1Khtvrafed02zzhSGeBesQi6ClSv
        KgGWdhgtpHlSSNVMAI0vHa8=
X-Google-Smtp-Source: AA6agR77U7uoOIp+8sDOi0hpynhGaACtM5VYBpyfhQRJo/VHMhhV61iSNq3bAYScIkhMLdhvD+bXDg==
X-Received: by 2002:a17:902:c941:b0:16e:fe88:99e5 with SMTP id i1-20020a170902c94100b0016efe8899e5mr26637629pla.38.1660740794503;
        Wed, 17 Aug 2022 05:53:14 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-37.three.co.id. [116.206.28.37])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b0016db7f49cc2sm1437373plc.115.2022.08.17.05.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 05:53:14 -0700 (PDT)
Message-ID: <2c877495-3292-8e45-de22-9f09ac4a7b2d@gmail.com>
Date:   Wed, 17 Aug 2022 19:53:09 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] hwmon: Add the pmbus driver for the TEXAS TPS546D24
 Buck Converter.
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Duke Du <dukedu83@gmail.com>, jdelvare@suse.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fran.hsu@quantatw.com,
        charles.hsu@quantatw.com, george.hung@quantatw.com,
        duke.du@quantatw.com
References: <1660718497-7315-1-git-send-email-Duke.Du@quantatw.com>
 <e9b97ea3-0867-d09f-ca59-362931073c9c@gmail.com>
 <20220817124748.GA397124@roeck-us.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220817124748.GA397124@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 19:47, Guenter Roeck wrote:
>> Seems like the patch description is just the changelog, which
>> should have been put between the dashes and diffstat. I would
>> like to see the proper description.
>>
> Same here. The description doesn't mean anything, should
> be a comment in the code, and, yes, the change log should
> not be part of the description but follow after '---'.
> 

I mean the patch description.

-- 
An old man doll... just what I always wanted! - Clara
