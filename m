Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E853358F025
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiHJQMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiHJQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:12:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6635D0EF;
        Wed, 10 Aug 2022 09:12:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 130so14087720pfv.13;
        Wed, 10 Aug 2022 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=2amLnF7kw0jf315Gwn3wjZctELTRSJzZovauimpYDMY=;
        b=bAnZBr/yVhBmRt1rHL99nE/TJRGF+Ct+cxwYjUBM9rs4kJ0W6Wapq9IiNjAQd9SwM6
         v7T9qO00y9TgilWkBYSCG7nmQ8qFQrwS+j+onmsLB+WTY9e5gxBsXtdSahbAIX43Z9B0
         ZWYhgnYwbEdCf4gixnE+1urQxNZr2mTP3lMWr6tiRvSUuIHU3iDCnWMU+MmoGBcUQeWl
         wDgRvSv5sYEvfrsuwxe08ekxEskPC0/u8MCKuUIvrkNbpvMdomh8J+uVQYp4fQBpOmY9
         7rZF3+tcxKyecUZU8J8rq9RohYVBr8JamTwhkmwV3vDM4HCCI8HXLPzFI5L+fkOiRv/Y
         AaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=2amLnF7kw0jf315Gwn3wjZctELTRSJzZovauimpYDMY=;
        b=of7VQTeHeSB0nRkKlrmWG76r4Qchl7FSk9GzvjVEDF5LjvxZpDP16BXP0yglo/jQ7m
         EIikc0qZ9QmHKSOww18Aq+d7SGeQZWp0aUN8mpKjvQyeFsx0rtQqKpgRW83xhW3w0da9
         HNqiGBV14gLTmDjwaqDWpx24FwLgS62pmNy+/Jkdi1Ev2/jH5iycS8wwLfHKb7ZBZAGC
         ugKw90fb2r/KuNxqBxzXtWxVvRzInPK55TJPFQbHDPFmAmu/fFp5CzcIzPZKAX0yL+kZ
         uk4TRvx8OHwr2QAP/l6WYXPEtzvyEOgQmLNzwaL1NiBLIWavVeziVsENFSFRpAWZ/ED3
         UTlg==
X-Gm-Message-State: ACgBeo3TNABB6D29XqKMBNRJxSD26xRY3PLlVHT5vn0XsFyDzkcQNg4i
        Krw9B7hzVTJqfP0QiOJWuPA+0VOikg8=
X-Google-Smtp-Source: AA6agR5qc53eYzs+sBm4V1Cog4u1n2809ez1ELYQed3ePH7a2IhaCsDWZzJGTdfCYaLUB1j+iFoPlQ==
X-Received: by 2002:a05:6a00:a06:b0:52d:f9fa:8fc9 with SMTP id p6-20020a056a000a0600b0052df9fa8fc9mr28601609pfh.15.1660147929610;
        Wed, 10 Aug 2022 09:12:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o5-20020a170902d4c500b0016ecc7d5297sm13174164plg.292.2022.08.10.09.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 09:12:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d2e09dc8-9bcd-c6e1-eec3-548dbd26b671@roeck-us.net>
Date:   Wed, 10 Aug 2022 09:12:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL] hwmon fixes for hwmon-fixes-for-v6.0-rc1
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220810134533.380417-1-linux@roeck-us.net>
In-Reply-To: <20220810134533.380417-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/10/22 06:45, Guenter Roeck wrote:
> Hi Linus,
> 
> Please pull hwmon fixes for Linux hwmon-fixes-for-v6.0-rc1 from signed tag:
> 

Hmm, I really need to work on the script generating those subject lines
and descriptions. Sorry for that.

Guenter

>      git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-fixes-for-v6.0-rc1
> 
> Thanks,
> Guenter
> ------
> 
> The following changes since commit d4252071b97d2027d246f6a82cbee4d52f618b47:
> 
>    add barriers to buffer_uptodate and set_buffer_uptodate (2022-08-09 15:03:02 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-fixes-for-v6.0-rc1
> 
> for you to fetch changes up to f4e6960f4f16b1ca5da16cec7612ecc86402ac05:
> 
>    hwmon: (nct6775) Fix platform driver suspend regression (2022-08-10 06:37:01 -0700)
> 
> ----------------------------------------------------------------
> hwmon fixes for v6.0-rc1
> 
> Fix two regressions in nct6775 and lm90 drivers
> 
> ----------------------------------------------------------------
> Guenter Roeck (1):
>        hwmon: (lm90) Fix error return value from detect function
> 
> Zev Weiss (1):
>        hwmon: (nct6775) Fix platform driver suspend regression
> 
>   drivers/hwmon/lm90.c             | 2 +-
>   drivers/hwmon/nct6775-core.c     | 3 ++-
>   drivers/hwmon/nct6775-platform.c | 2 +-
>   drivers/hwmon/nct6775.h          | 2 ++
>   4 files changed, 6 insertions(+), 3 deletions(-)

