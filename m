Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB474BBFA9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbiBRSjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:39:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiBRSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:39:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C524089;
        Fri, 18 Feb 2022 10:39:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a8so16999386ejc.8;
        Fri, 18 Feb 2022 10:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XPv9wzgm5eXSDUL7FuIzzc3fU8coeepn/zPu2iCKfKE=;
        b=MQG9PtAMTNn84e/Kw4NUhvpfYiTfAIAmqT1PGJ0wORN2nQScSDWvyiBZhwbSGBHIzq
         RW1yi1QXAVKcL4Bgotb3ErSLUZjmTIPXx6GdnWcwSbVQ7BJ9MvPv0zsyJu5RfG7KPv9U
         oiYEPpB3YydS7XujQSw2pkbc1teoGRWpf2mJJmXfroVuQPyaFCLwhOM1KK8b58hWRYTP
         dVf9Y0Cm9dd3ugcjU4j622YN/KpntKCh+4v14/hEtp1IlZYNet7+zUtsxQWraDl90UFs
         IzrQWkYVmVHGFgjP8+koTbT/XHNfkyQouPYQEjW5HO8xr85UoA+tK1aKuXqkkP7Y5d2H
         4dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XPv9wzgm5eXSDUL7FuIzzc3fU8coeepn/zPu2iCKfKE=;
        b=nRSz6c5FsJjlEyG4+4xoIgAfVv8qqg5l1k9aXA3+Jk1Cc+ZP3A6c0XxEB2CX5J4FuV
         rfdZFuXxabzNhDMuXlHEohBSOWGRzbc9Y+Fwt7syPOuO/SfuXdGHnLC5K3lhfCm/J5IU
         ih9BbXNk2/5LeLnkdWPGJRuKx/k2yOCOipDQA9TOHFJ+dILGNv4Nxx0h4uHUUJJBns7v
         LGtQA+TF9QoMcj/UZD6zO5dK8UyRqzF1xpKHZ1tMESWZorcJcPUT/R1Ie2vepan4dSKW
         rQ/vVbrwz/APD/VMRo20Rh6SpcjFNQyjTcINTlavI9djToUoy2s3Wo4HnZVVz2vSxnUw
         iD7A==
X-Gm-Message-State: AOAM532soU9U9U8rrCFfKhRW3YVAUJcDrbL6HFWDKze8jvdh62cy3/ux
        spDor5Ai1wQoiGDUvZuN8HhWLWygD67vzg==
X-Google-Smtp-Source: ABdhPJw84HaIb839BtmITA2w3xH5gEkODoWbn6CWobM0f3YrOlMC8w5JIUmCdf5QqzA/Svg6BVlnKA==
X-Received: by 2002:a17:906:2846:b0:6ce:21cd:5398 with SMTP id s6-20020a170906284600b006ce21cd5398mr7714653ejc.49.1645209567050;
        Fri, 18 Feb 2022 10:39:27 -0800 (PST)
Received: from ?IPV6:2a00:a040:197:458f:c93a:90a3:1c34:c6d2? ([2a00:a040:197:458f:c93a:90a3:1c34:c6d2])
        by smtp.gmail.com with ESMTPSA id i5sm5068089edc.94.2022.02.18.10.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 10:39:26 -0800 (PST)
Message-ID: <26d74eaa-5c6a-4103-cf77-1356173a3978@gmail.com>
Date:   Fri, 18 Feb 2022 20:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] kconfig: Show menuconfigs as menus in the .config
 file
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211213100043.45645-1-arielmarcovitch@gmail.com>
 <20211213100043.45645-2-arielmarcovitch@gmail.com>
 <CAK7LNAS+Df_V-B9Qy_39hgUZF1b6UeiHQ5m-25JekiVYSQ67dQ@mail.gmail.com>
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
In-Reply-To: <CAK7LNAS+Df_V-B9Qy_39hgUZF1b6UeiHQ5m-25JekiVYSQ67dQ@mail.gmail.com>
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

Hello!

On 18/01/2022 20:20, Masahiro Yamada wrote:
> On Mon, Dec 13, 2021 at 7:01 PM Ariel Marcovitch
> <arielmarcovitch@gmail.com> wrote:
>> Until now, menuconfigs were considered configs because they had non-zero
>> sym attribute. This meant that instead of having the nice menu comment
>> block in the .config output file, they were merely shown as single
>> configs.
>>
>> For example:
>> ```Kconfig
>> menu "Foo"
>> endmenu
>>
>> menuconfig BAR
>>          bool "Bar"
>>
>> config OTHER
>>          bool "Other"
>>          depends on BAR
>> ```
>>
>> Will be shown as:
>> ```.config
>>   #
>>   # Foo
>>   #
>>   # end of Foo
>
> I am OK with this patch.
>
> Just a nit.
>
> As far as I tested your sample code (without applying this patch),
> I did not see the line "# end of Foo".
>
> The line "# end of ..." is printed when the last child gets back to
> its parent, but the "Foo" menu has no child menu here.
>
> This is out of scope of this patch, but can you update the
> commit log so it matches the current behavior?

I saw you added a patch to change that, so now the code sample here is 
less of a lie :)

I learned my message of never adding code samples to commit messages 
without testing these as well :)

So is it ready now to be applied on top of your change?

> (or add one config into the "Foo" menu)
>
>
>
>
>
>
>
>>   CONFIG_BAR=y
>>   CONFIG_OTHER=y
>> ```
>>
>> Instead of using the sym attribute to decide whether or not to print the
>> menu block comment, check menu->prompt->type explicitly (after checking
>> that menu_is_visible(menu) which means menu->prompt is not none). The
>> only prompt types we actually show as menus are P_MENU and P_COMMENT. At
>> the end of the menu we need to show the end of block only for P_MENU
>> (although P_COMMENT prompts will not get to this flow because they don't
>> have children).
>>
>> Signed-off-by: Ariel Marcovitch <arielmarcovitch@gmail.com>
>> ---
>>   scripts/kconfig/confdata.c | 28 +++++++++++++++++-----------
>>   1 file changed, 17 insertions(+), 11 deletions(-)
>>
>> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
>> index 42bc56ee238c..9f2c22f46ee0 100644
>> --- a/scripts/kconfig/confdata.c
>> +++ b/scripts/kconfig/confdata.c
>> @@ -874,16 +874,21 @@ int conf_write(const char *name)
>>          menu = rootmenu.list;
>>          while (menu) {
>>                  sym = menu->sym;
>> -               if (!sym) {
>> -                       if (!menu_is_visible(menu))
>> -                               goto next;
>> -                       str = menu_get_prompt(menu);
>> -                       fprintf(out, "\n"
>> -                                    "#\n"
>> -                                    "# %s\n"
>> -                                    "#\n", str);
>> -                       need_newline = false;
>> -               } else if (!(sym->flags & SYMBOL_CHOICE) &&
>> +
>> +               if (menu_is_visible(menu)) {
>> +                       enum prop_type type = menu->prompt->type;
>> +
>> +                       if (type == P_MENU || type == P_COMMENT) {
>> +                               str = menu_get_prompt(menu);
>> +                               fprintf(out, "\n"
>> +                                       "#\n"
>> +                                       "# %s\n"
>> +                                       "#\n", str);
>> +                               need_newline = false;
>> +                       }
>> +               }
>> +
>> +               if (sym && !(sym->flags & SYMBOL_CHOICE) &&
>>                             !(sym->flags & SYMBOL_WRITTEN)) {
>>                          sym_calc_value(sym);
>>                          if (!(sym->flags & SYMBOL_WRITE))
>> @@ -904,7 +909,8 @@ int conf_write(const char *name)
>>                  if (menu->next)
>>                          menu = menu->next;
>>                  else while ((menu = menu->parent)) {
>> -                       if (!menu->sym && menu_is_visible(menu) &&
>> +                       if (menu_is_visible(menu) &&
>> +                           menu->prompt->type == P_MENU &&
>>                              menu != &rootmenu) {
>>                                  str = menu_get_prompt(menu);
>>                                  fprintf(out, "# end of %s\n", str);
>> --
>> 2.25.1
>>
