Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A1B4BC002
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiBRS4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:56:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiBRS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:56:10 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F5A24CCDB;
        Fri, 18 Feb 2022 10:55:53 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p9so17083855ejd.6;
        Fri, 18 Feb 2022 10:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C9S0KAwxEIvtCrO/D15JVJx6Fz48S13//eFCQ5KdSr0=;
        b=NS/nptB6vvX3DFxuXH9LAFzvvi4/H8pVOKKqtn4f5wNhQga6rHX2+X3s55OZLRrpfq
         yN7v3mxQbQpypnDoSc1sD9HQ6x+0HGNZbkmHyZtJf1rJtG+6dIAbHcXB2kwJhSDHb/Fz
         AA9a4xSmgjdOy0qQnZt3nOySCBGQgfBc1aFV/a5q71Et1YgCmX4An9g9vmxTnWh16QLf
         Z0xFgY9M7VwxtypQx1L5ifJjncao1/tgIBpCHa2DBIcx0MlExaunT0hvqBX1YHpsCr3N
         ZyB+njDi/fAAus9aC2m2UPIYJbzmPJgLQrAUO6cG/IdIrPtPD5sEuP6x+Lg9B5q3dMVX
         u+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C9S0KAwxEIvtCrO/D15JVJx6Fz48S13//eFCQ5KdSr0=;
        b=Zo6HVwslfVeEQbqqOdST9+v9qHR6QSMHdtZnmi5wTxltxU9cpxL131GFDfu9vsMMRk
         Yf0ONbcADrM/H7av5fWoXRa8wZKecyK4QlbKzxACN1BJYy2afwpS+b23k8jBoSSUUxIh
         /wH2l7PAL557TvkkUAL2z4CQ9SHRKpROzMvbJZh1qeLfEXmZygdXEwZ4FTLjmKshabgU
         YFmEgKtQFgDAdHPwZJJzHzSJRO5f31yO6Bqz3/Y5SWPkuh/LYWCOp+2r89kkhjZsAx26
         kybrIsDEzqJ/lQtpt+OFWSBRrPTgcOJrPWaR49ZRMpoyM3ZnjMPc3hqw6QcgrYgtqa10
         YrVQ==
X-Gm-Message-State: AOAM530v4h+lFg2kt9ayj2LWppDt21gpvSlcQClTnDclaJ4CT5P717YL
        qNNGcXP2SCmdnfgVQOzzdwYBQKKr/e+29g==
X-Google-Smtp-Source: ABdhPJyRPIAYWOPFd4ap77k/xfQrHQpF4DUegJjYDzq7KACI5ECN8r4efiiJzDyUzZ3HgTwwLgoChQ==
X-Received: by 2002:a17:906:3bc9:b0:6d0:8d78:e7e6 with SMTP id v9-20020a1709063bc900b006d08d78e7e6mr5254159ejf.222.1645210551746;
        Fri, 18 Feb 2022 10:55:51 -0800 (PST)
Received: from ?IPV6:2a00:a040:197:458f:c93a:90a3:1c34:c6d2? ([2a00:a040:197:458f:c93a:90a3:1c34:c6d2])
        by smtp.gmail.com with ESMTPSA id y22sm5373205edc.41.2022.02.18.10.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 10:55:51 -0800 (PST)
Message-ID: <8043765d-2aa5-16ad-cc03-127398451e93@gmail.com>
Date:   Fri, 18 Feb 2022 20:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] kconfig: Make comments look different than menus in
 .config
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211213100043.45645-1-arielmarcovitch@gmail.com>
 <20211213100043.45645-3-arielmarcovitch@gmail.com>
 <CAK7LNAQb8ivsQX-0YDNx6B_ZTBUq9v7SSG+m8=e1GsGL-DuBsg@mail.gmail.com>
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
In-Reply-To: <CAK7LNAQb8ivsQX-0YDNx6B_ZTBUq9v7SSG+m8=e1GsGL-DuBsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 20:25, Masahiro Yamada wrote:
> On Mon, Dec 13, 2021 at 7:01 PM Ariel Marcovitch
> <arielmarcovitch@gmail.com> wrote:
>> Currently, the same code that handles menus in the write to .config
>> handles comments as well. That's why comments look exactly like menus in
>> the .config except for the 'end of menu' comments that appear only for
>> menus. This makes sense because sometimes comments are used as sort of
>> submenus. However for the other cases, it looks kinda weird because one
>> might attempt to look for the 'end of menu' for comments as well and be
>> very confused.
>>
>> Make comments look different than menus. For the following:
>> ```kconfig
>> menu "Stuff"
>>
>> config FOO
>>          def_bool y
>>
>> comment "Some comment"
>>
>> config BAR
>>          def_bool n
>>
>> endmenu
>> ```
>>
>> The .config will look like this:
>> ```
>>   #
>>   # Stuff
>>   #
>>   CONFIG_FOO=y
>>
>>   ### Some comment
>>   # CONFIG_BAR is not defined
>>   # end of Stuff
>>
>> ```
>>
>> Signed-off-by: Ariel Marcovitch <arielmarcovitch@gmail.com>
>> ---
>>   scripts/kconfig/confdata.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
>> index 9f2c22f46ee0..d3ec1ad67d92 100644
>> --- a/scripts/kconfig/confdata.c
>> +++ b/scripts/kconfig/confdata.c
>> @@ -880,10 +880,16 @@ int conf_write(const char *name)
>>
>>                          if (type == P_MENU || type == P_COMMENT) {
>>                                  str = menu_get_prompt(menu);
>> -                               fprintf(out, "\n"
>> -                                       "#\n"
>> -                                       "# %s\n"
>> -                                       "#\n", str);
>> +
>> +                               if (type == P_MENU)
>> +                                       fprintf(out, "\n"
>> +                                               "#\n"
>> +                                               "# %s\n"
>> +                                               "#\n", str);
>> +                               else
>> +                                       fprintf(out, "\n"
>> +                                               "### %s\n", str);
>> +
>>                                  need_newline = false;
>>                          }
>>                  }
>> --
>> 2.25.1
>>
>
> Since "# CONFIG... is not set" looks like a comment,
> I am not sure if this improves the visibility.

I agree that adding another '#' signs to the real comments doesn't solve 
the real
problem here, being that kconfig uses comments to save actual information

I guess this is for being able to check for a config in shell script 
with [[ -n $CONFIG_FOO ]]?

Although if that's the case, leaving the config empty has the same 
effect, no? And then
we can add a comment to the end of the definition stating that the 
config is unset.
Something like this:

CONFIG_FOO=y
CONFIG_BAR= # is not set

It may break scripts doing something like this:

: ${CONFIG_FOO=?Config FOO must be defined}

But they can be changed to use ':?' instead (which checks for non-zero 
length string
rather than whether the variable is defined or not)

Actually, now that I think of it, it might even be an improvement for 
scripts to be able to tell whether a config isn't defined or whether it 
has an 'n' value

Anyway, I'm absolutely fine with delaying this patch until we find a 
solution

>
> I will not pick up this until I find out what a really good format is.
Thanks!
