Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAFF4B90B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiBPSuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:50:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbiBPSuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:50:11 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7092AE061;
        Wed, 16 Feb 2022 10:49:59 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id a12-20020a05683012cc00b005acf7c91097so2091881otq.10;
        Wed, 16 Feb 2022 10:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=3kLfFSE/C06joF3jS7Z0xiZBbMoPWR9flOrS/8xPo3Y=;
        b=UGwIKWndo1i98MKsce/34mpGidnESA3+necSuCey7xSjnyt3JFZBIaWINPukmO62uh
         /n12GlM+8Uj2x8iwsV5dtqznFBb5CmIe9gAA8iUtwI0VOUOga6sJwLJ9xHYzkLVQAI4q
         YuPxnNT0YGFfJG6lGQmlx+Mgz1fdiBBWpMntHNz7tDKdj3c7K88mQN7hC9OVOH5YtHxq
         a8CRd7C0ENmgXd1Od+wFHF/ihliDjwWSFH4ZEdssNhmwquhTbgWnYw83ImbmqCIstd+7
         DrlEldu4lGDg+zboUzFg9MyaRKW6m0LHjUry/inHuhMpqGIjT4MH1YXQoYSmN8vg2gvF
         APvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=3kLfFSE/C06joF3jS7Z0xiZBbMoPWR9flOrS/8xPo3Y=;
        b=HWhsXsVDnSzbxI/8TIDOql+o3OGYd4ZneXdD6zvSr1eTutNQWfYegn4HPgoQNfl74J
         EZsYN1mb8p4f+ymGoH/rXVkaa7eOt95N/W2hx7XUTEnsP3Ri7L7VZS5ZGkRA8igP4RI8
         CtQ4wFB90mnFNj4IFS9fdB5FFEWhg2Aho4U61ehyWvcticMX5MQX1NywZJ1pn0rS7P37
         QEKtycAovI8aOg/iabdRJ1dKWx2pi6ZrHHKACXFwfX23t4B/cghiZF6BTtHNGMNwmdtI
         YCHudh5RUJY6W/k1G9Dmuw8EdrzldiOosK60uPtpVKwJbwPiDvDeOMY0vo3r8bmgt/gg
         neMQ==
X-Gm-Message-State: AOAM531KOXLTz/ShXBJiu4TfTPSYY9nCDzbHN+nmqdqVL2kE3+7plUap
        bXUGtDkNz0CQkNRT5AnXIJjenSYtshTFAg==
X-Google-Smtp-Source: ABdhPJwrTswJ+6WmyZAuaAinv3Q9SzOzN9hFGR1rFu8LQs/67NWsJRHTrkvqI23kXlF5viBk59/U+A==
X-Received: by 2002:a05:6830:410e:b0:5a1:71ec:7277 with SMTP id w14-20020a056830410e00b005a171ec7277mr1325985ott.136.1645037398534;
        Wed, 16 Feb 2022 10:49:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d20sm5861467otu.61.2022.02.16.10.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 10:49:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7f3fc06f-cf4e-2dc6-e68a-917117fe8895@roeck-us.net>
Date:   Wed, 16 Feb 2022 10:49:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220216180822.GA3300192@roeck-us.net>
 <CAB95QASWWMvSSuuwQU=TwZX-QcU=hRPCJVQ0E6Bh29sc4d66Ug@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] hwmon: (asus-ec-sensors) merge setup functions
In-Reply-To: <CAB95QASWWMvSSuuwQU=TwZX-QcU=hRPCJVQ0E6Bh29sc4d66Ug@mail.gmail.com>
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

On 2/16/22 10:23, Eugene Shalygin wrote:
> On Wed, 16 Feb 2022 at 19:08, Guenter Roeck <linux@roeck-us.net> wrote:
>> $ scripts/checkpatch.pl --strict asus-ec
> 
> So, contributors have to use the --strict option?
> 
>> WARNING: braces {} are not necessary for single statement blocks
> 
> The file is full of such braces, because I like them and it is only a
> warning. How should I proceed with them?
> 

Warnings are also seen without --strict; that only adds the CHECK messages.
You should follow Linux kernel coding style when you write kernel code,
not your personal preferences. Also please consider reading
Documentation/hwmon/submitting-patches.rst, which specifically says

* Please run your patch through 'checkpatch --strict'. There should be no
   errors, no warnings, and few if any check messages. If there are any
   messages, please be prepared to explain.

* If your patch generates checkpatch errors, warnings, or check messages,
   please refrain from explanations such as "I prefer that coding style".
   Keep in mind that each unnecessary message helps hiding a real problem,
   and a consistent coding style makes it easier for others to understand
   and review the code.

Thanks,
Guenter
