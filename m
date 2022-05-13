Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A6D526836
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382918AbiEMRW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376461AbiEMRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:22:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0327353A60;
        Fri, 13 May 2022 10:22:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e29so2655276wrc.11;
        Fri, 13 May 2022 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+LOWkoJXSytHTfBQnWN914FgUImEgUUdPt98UH8jYVc=;
        b=TYrRoZ6F+jkhXKlmjdbTwmztBTA/BFE85DaZyQILoWeh1pVuk/tfDBaYhBRMxIC6kn
         PV24CaC+3tNZQvyNooVT/RK0DdHpS3lHQx2YJ3I0swnAwvtVsZc0eZzfjG7igJ4PSSPV
         +RoRQEUDC8Ktiz5ifSYMrUjcwAtjIKVis0Nu/pk2OUdrTmdnaDvjfSsLXXUQx21eW3KL
         I7loTsAIad68xXLDbAz+wG8EmEyHWeii4q30Nk6eo98Cw+63nHPKyLLJ8bGjBdHHySCM
         P8VjluXHLPQxxkQ6Lsb9RpnzSjJTpa4grmFRUSdkc4EZiUzi2AFNQVWb+F/Apd+1T40L
         6efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+LOWkoJXSytHTfBQnWN914FgUImEgUUdPt98UH8jYVc=;
        b=Cpxn1t9ZJwasGg1P/NmmA8WIsjGqseGsdfriFqfahYE3jV4b9E9ntr8QEWy2GKJTP4
         6tKtc6+rjRO1IM/5WoNQyRay33SrHlL0Q5lIcK3RkdjcQTeXdk5FkKQTCjRK//q4ZyNp
         cfE3RwTFQPPd6FywcrgrksNRs7LGXZZXIw5MKCKR7dGTnehWAbYiyU5u0wnmBy9jRM6p
         oELFwG36IhEFVUJlta3QQtcvRGR4jnhmyynQhaoyktW+uToyU5bSTNpjnAtl9Fj9cf8Q
         TTbJIh9YVWa+rThil48OvbOAu6CUt0lZbYKoU2pu+rXo4eoTaHRE6K4Aw7BZvXx5CW1o
         nUBg==
X-Gm-Message-State: AOAM5330Stm1DpN6cSEpws0wjUl5wciS9rdE1jUlTKCK4y3rOBG00r1X
        8MIAfWAY2i2lwT5NnjXHopn12LP3i/XPhg==
X-Google-Smtp-Source: ABdhPJyeSM6QpjOuCSfyx8huX8cogZ8hpvudnty2twMOAxHtdbt/WUN6N3Yn+o04S8AxuSQHWI/Vbg==
X-Received: by 2002:a5d:504e:0:b0:20a:dba2:6fb3 with SMTP id h14-20020a5d504e000000b0020adba26fb3mr4884727wrt.541.1652462571640;
        Fri, 13 May 2022 10:22:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:6d40:29d:ba85:78f8:3d80:548? ([2a02:810d:6d40:29d:ba85:78f8:3d80:548])
        by smtp.gmail.com with ESMTPSA id e15-20020adfa74f000000b0020c5253d8e5sm2571722wrd.49.2022.05.13.10.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 10:22:51 -0700 (PDT)
Message-ID: <ebb6d627-4974-beed-1dc6-60634ab2f034@gmail.com>
Date:   Fri, 13 May 2022 19:22:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Status on hid xppen patch
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <941a793a-d2f7-9c2c-59be-b3930e1acfec@gmail.com>
 <20220423172330.32585-1-jose.exposito89@gmail.com>
 <95576534-1f5e-c2e3-4f73-c1b0a8300b56@gmail.com>
 <20220424093239.GA4380@elementary> <20220512205952.GA8936@elementary>
From:   Stefan Berzl <stefanberzl@gmail.com>
In-Reply-To: <20220512205952.GA8936@elementary>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello José,

> The tablets are the Deco Mini 4 and the Deco L, both of them are UGEE
> tablets. I already had a UGEE Parblo A610 Pro tablet and after having a
> look to the Windows driver traffic, I found out that after sending a
> chunk of magic data to enable the tablet, it requests a string
> descriptor ("uclogic_params_get_str_desc" can be used here) and the
> tablets respond with their parameters.
> 
> The information is encoded, in bytes, as:
> 
>  02 + 03 - UCLOGIC_RDESC_PEN_PH_ID_X_LM
>  04 + 05 - UCLOGIC_RDESC_PEN_PH_ID_Y_LM
>  06      - Number of buttons
>  07      - Dial present or not
>  08 + 09 - UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM
>  10 + 11 - Resolution
> 
> Bytes 12 and 13 are present but set to 0, probably indicating my
> tablets are lacking some feature.
> 
> Could you confirm that your tablet returns similar information, please?

yes, you can haz string descriptor:
0e 03 0b 8b cb 56 08 00 ff 1f d8 13

Byte 12 are 13 are set and zero, as in your case.

> In case you want to have a look to the implementation, I'm working on
> this branch:
> https://github.com/JoseExposito/linux/commits/patch-xppen-deco-l
> 
> I had to introduce new functionalities to the templating system of the
> driver, that's the reason for the KUnit tests.
> The last patch is work in progress (hopefully I'll have time to finish
> it this weekend), only the HID descriptors are missing.

I hope you make it, but otherwise you can always use mine, as it's quite
the same as yours. Only the logical minimum and maximum are -60 and 60.

> I'll cc you when in the patchset so you can add your IDs :)

Is that all you want me to do?

Kind regards,
Stefan Berzl
