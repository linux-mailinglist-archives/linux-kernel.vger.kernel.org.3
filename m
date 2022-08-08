Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B794258CBBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiHHQAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbiHHP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:59:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A05F15815;
        Mon,  8 Aug 2022 08:59:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h28so8447576pfq.11;
        Mon, 08 Aug 2022 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=JbzYiMV30iu8zw8Tghw9STeClB50yjw9lFy+lFDjXQk=;
        b=KF+ziXIIUeepZsz2vpxRP9JOJ1zcN0RlZqdMGqKMi+62UJZ2UWsf0++AY3Oen0Ooim
         PUHFDROjotI47cQgMTp3fg78GgXhkOjzHOn/h14lN8euzHFCH8BQDge8bbBIu0jSYukS
         JM/4TghT6zVn98H+f44qfaG7yu1/o/W2v1oGH/QbbUZ5in/sXUz8UKFt33heROzBCFrr
         ENzl2zrB1HkNphdkreh8Ch4Rw7l2Vcpz+0M4vyuwI8wEay8RwD1teZ5Ac8eslILJNdOi
         ndCVLkiQvULULaX/HnxZkgsK4e0+6EnAUC7rFOOwZ6sOS0slPe5IkvqTSwLO3y6FlYRF
         q/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=JbzYiMV30iu8zw8Tghw9STeClB50yjw9lFy+lFDjXQk=;
        b=fdFJaEmOhpItnaozR/RrMHYeU8FKwVkN7ayiHJUAPHTlMpCris0OHfGCzUErBacEZB
         ZoJrzMki0ktWZvVbxPKIEEim53mBtGo2OqqbLN3NXQQhFaME0b5FMfeZkX/rJVAkqCM/
         zwVC9L5i6VfThwyu7HUgJzNhSu9ngTKncdEM1LI5CSNYUh6l5TfYBn/7W4mtaT03NxoW
         aY82aW84mQNKYwnQ6hGr4JOaZMbh1A8ITGjHOB3dHLR9eHrnro1Kw2Ix+gY6Y23GGEzN
         17hbek7u/hUj+RrezkJfUxzUy209+vSepkmk4dthzjLzyYHeEI4Fzl8wMVutbG+wTHgM
         WizQ==
X-Gm-Message-State: ACgBeo0qheGIS/KnFidOlftUSNq2qJG+icV9iso9uhXVo8tioDtbYKTU
        2suzD9VX5dmV4ZQtFmswv8UkDPHQeB8=
X-Google-Smtp-Source: AA6agR7QWtm6tn/DRxjg6mmfWyD5tC8UAbWAogfC7NlLqQZN+r1KKmJhreN/hZ35MHqTyGn+x6vHmg==
X-Received: by 2002:a63:c106:0:b0:419:b303:2343 with SMTP id w6-20020a63c106000000b00419b3032343mr15518586pgf.166.1659974397604;
        Mon, 08 Aug 2022 08:59:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b0016d3935eff0sm8965520ple.176.2022.08.08.08.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 08:59:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bfedd32c-d274-3fb6-7134-9bf09c8e8dba@roeck-us.net>
Date:   Mon, 8 Aug 2022 08:59:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] docs: Fix Typo
Content-Language: en-US
To:     Max Dunbar <mdsurfing4@gmail.com>, jdelvare@suse.com,
        corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220801181038.GA957@DESKTOP-GSR5SR7.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220801181038.GA957@DESKTOP-GSR5SR7.localdomain>
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

On 8/1/22 11:10, Max Dunbar wrote:
> Correcting "wil" to "will" in the hwmon documentation
> 
> Signed-off-by: Max Dunbar <mdsurfing4@gmail.com>

Please at least use a proper subject indicating the affected subsystem
if you really have to make those cosmetic changes.

Guenter

> ---
>   Documentation/hwmon/hwmon-kernel-api.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
> index f3276b3a381a..a4755a5a24af 100644
> --- a/Documentation/hwmon/hwmon-kernel-api.rst
> +++ b/Documentation/hwmon/hwmon-kernel-api.rst
> @@ -57,7 +57,7 @@ register/unregister functions::
>   hwmon_device_register_with_groups registers a hardware monitoring device.
>   The first parameter of this function is a pointer to the parent device.
>   The name parameter is a pointer to the hwmon device name. The registration
> -function wil create a name sysfs attribute pointing to this name.
> +function will create a name sysfs attribute pointing to this name.
>   The drvdata parameter is the pointer to the local driver data.
>   hwmon_device_register_with_groups will attach this pointer to the newly
>   allocated hwmon device. The pointer can be retrieved by the driver using

