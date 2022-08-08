Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4789958CBB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbiHHP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243674AbiHHP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:59:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9769DB1DD;
        Mon,  8 Aug 2022 08:59:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o3so8943686ple.5;
        Mon, 08 Aug 2022 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=NSzsSRoA3x7V34Qf7YygjvmGdHbbkY5XG2e9FxtKRAE=;
        b=jI8e+uPapEGqAUy1JgeqBqOYo63Oo5xJOI7LrTqRx2Ew1gsG+G6C9SS/sBFfToV0mM
         EmlYpmJpoph+iXIGgxNvde9PNyLCarB4smt2lvhH6Vy77uasb1SqgNynFr3TjuBjKvJY
         zOC5cKpRwdSoW36YeTO8A3PvfogtGzG4HVQvjArObQnYv2t2nmbH6CkBEO8Xp8UFT/Kl
         LoULlfG5vlYec387nr8PY6/nb90BUtISfY5ZHv/DbIlOyIN1TMyhoIYwfCOUuWbQjgLI
         HnKgy5TUvOACIEbD4JtI0E1gQ5SvWHWTtGEH7glVWHY1Y1cE8Dw7Kp6NzfzhZb3+qqlI
         Rvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=NSzsSRoA3x7V34Qf7YygjvmGdHbbkY5XG2e9FxtKRAE=;
        b=Yc1LgFFHdA2MYt8yR569FHqte4k40SwpuE5vlYpL1qqHPnGptqetu7zmMoe6XbiJCl
         UbixrZ2EVtuI6gVTJgbpvn+kqMQx+4SgJ5uF7FgVQZypzmribYqFwSnOx9hvqNRqH9Je
         nByF2mRSGHwwwCOgsMJrBzMyc2SCwxKY1kqWUA4kOKKezSIxY4+Bv6b1fPAxcrOsDHWQ
         WFm1uAYZmRLq0wtkYHhLXyPKhcUZk1UufBSGUjw3l+i5BNDvDrn96jiIAauE1Kau+ixp
         CuDG3a587zQPCt+MC1jaJ4HalxC9VGsemUEL1ykhKW/1iEN2UU9tfAC3QKArVxMlnzID
         bevA==
X-Gm-Message-State: ACgBeo11xix6rlQSnM4lejbhTiZVl/RqhacRnUqD+L5h2JoGHPHL4mGK
        yw6CGafXUb4TptbQJmt2t6z+L7//rOM=
X-Google-Smtp-Source: AA6agR6APHb10/imTPvDpI/LuSPi5sY18vx1Tjq0hxCnQNv0tkLpx7v9XkHOUGb5Y00RC43XEagHgg==
X-Received: by 2002:a17:902:7007:b0:170:8d35:bafd with SMTP id y7-20020a170902700700b001708d35bafdmr10930280plk.51.1659974344106;
        Mon, 08 Aug 2022 08:59:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nn16-20020a17090b38d000b001efa35356besm11104120pjb.28.2022.08.08.08.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 08:59:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <120935c3-441b-eea4-4626-a3e322fef1dc@roeck-us.net>
Date:   Mon, 8 Aug 2022 08:59:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] watchdog: Fix typo in comments
Content-Language: en-US
To:     shaomin Deng <dengshaomin@cdjrlc.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220808154457.9879-1-dengshaomin@cdjrlc.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220808154457.9879-1-dengshaomin@cdjrlc.com>
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

On 8/8/22 08:44, shaomin Deng wrote:
> Delete the repeated word "we" in comments.
> 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>

Please at least use a proper subject indicating the affected driver if you really
have to make those cosmetic changes.

Guenter

> ---
>   drivers/watchdog/pc87413_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
> index 9f9a340427fc..14f37b3b903f 100644
> --- a/drivers/watchdog/pc87413_wdt.c
> +++ b/drivers/watchdog/pc87413_wdt.c
> @@ -333,7 +333,7 @@ static int pc87413_status(void)
>    *	@ppos: pointer to the position to write. No seeks allowed
>    *
>    *	A write to a watchdog device is defined as a keepalive signal. Any
> - *	write of data will do, as we we don't define content meaning.
> + *	write of data will do, as we don't define content meaning.
>    */
>   
>   static ssize_t pc87413_write(struct file *file, const char __user *data,

