Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92B350AA18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392415AbiDUUjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392406AbiDUUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:39:11 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84624DF4C;
        Thu, 21 Apr 2022 13:36:20 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t15so6881987oie.1;
        Thu, 21 Apr 2022 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=pR+ivXQjQ4mpc3bU1lbKrf1OTqhPO5O1eEWuchyFYYM=;
        b=aUgy7ZQPy9VWQ3sdol3HV/TdeP/hqQr5zfOdNWWD6QeduBPQ0/ElwdKLnErBtzgTGb
         WCkwtX3AUMiqG3IWexPlK3SDIJzDzLYBTmKfnxRtfnx4smznqkM6F7j2j8FT+l+dl3Kg
         4/CfCcjq51ubOP/yQEX4ACp6GktE/PUK5na1g0xy+sKXWainyCu3ZdX0NvSbgJXZsG/l
         9iHOqfYrb75TqJwtaHW7ioSsBv0n+ZxKJuHBNGeSDwh1eLKGkob/fGeRCf4CAHmvUc0W
         slDG+J55kEkR6bUrAGBuFfpuKrl40ENcSoT555XLpq8RcN3/aKmA3u6bIV2Yxztp9dAk
         6gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=pR+ivXQjQ4mpc3bU1lbKrf1OTqhPO5O1eEWuchyFYYM=;
        b=uBCwBu3iT40KqqsKhFGqzod4XltxUhrof2LvpCIfk5pYvxsmH6EF1SN1k8e+NSzazs
         XRiCUM0YiKmkIBYClKS0xXLf9g+REpG2IPSTLrAADN3WXrzY6TG6n7bt8bms27qZzzUf
         eUyeV0AVnJSTnxDIwehCqDQ3j6B9sSdQu/WsOZnOQDY1bM7Mjf8nWAbQE0VdAlQkWK4s
         2+PssFXlbKxq164DxqdYdvyvfpjumN+RWQxSgI5dEhjoQtRxnc0h1+y2RqNu6H8f+8d5
         8PnsCm+tkGTic0gsrqP6sPgXoKQT3cXprXvrCk047mRbuJeFWTHfmjkft2OskCdKN3kp
         fa2A==
X-Gm-Message-State: AOAM53234oHqxSBznD/LMGefkO/u2KNcbC5n6Ecpm9k/50HieDWMe0QW
        FJ73SbwgYhvFYK2UUw7ONwWggPoLmmM=
X-Google-Smtp-Source: ABdhPJzvQDBpW8i8W67TKQjDDBb4cpOmkXvirm1Nq4saLvrBEWABE0GZmwKCUokZxD/YPpaqiqgYJA==
X-Received: by 2002:a05:6808:e8d:b0:322:4fbe:8c5f with SMTP id k13-20020a0568080e8d00b003224fbe8c5fmr5198699oil.284.1650573378654;
        Thu, 21 Apr 2022 13:36:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a37-20020a9d2628000000b0060563c52952sm15698otb.8.2022.04.21.13.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 13:36:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <15b38d01-702c-b39e-7053-54c3905a0794@roeck-us.net>
Date:   Thu, 21 Apr 2022 13:36:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-usb@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        heikki.krogerus@linux.intel.com
References: <CA+G9fYvdfYBq+Q=-XUJcKHSYXdubdoqhExRpjrqCgf_N3pPpHQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: drivers/usb/typec/tcpm/tcpm.c:4724:3: error: case label does not
 reduce to an integer constant
In-Reply-To: <CA+G9fYvdfYBq+Q=-XUJcKHSYXdubdoqhExRpjrqCgf_N3pPpHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 12:03, Naresh Kamboju wrote:
> Linux mainline and linux next arm64 builds failed with gcc-7.3.x.
> 
> drivers/usb/typec/tcpm/tcpm.c: In function 'run_state_machine':
> drivers/usb/typec/tcpm/tcpm.c:4724:3: error: case label does not
> reduce to an integer constant
>     case BDO_MODE_TESTDATA:
>     ^~~~
> make[4]: *** [scripts/Makefile.build:288: drivers/usb/typec/tcpm/tcpm.o] Error 1
>                                        ^
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> --

That code is several years old, the define is a constant, and I don't see
a recent change in the code. What am I missing ?

Guenter
