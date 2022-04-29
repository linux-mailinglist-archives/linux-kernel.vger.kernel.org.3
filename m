Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F52B5141D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352790AbiD2Fll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiD2Flh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:41:37 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90904D247;
        Thu, 28 Apr 2022 22:38:20 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g11-20020a9d648b000000b00605e4278793so3537758otl.7;
        Thu, 28 Apr 2022 22:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XlUmO362806X4JBQXMzY9UYbekCUk7hEemiyL4iife8=;
        b=TejRD1+JMro6/90xzcTh0/qeeD2QME1ak7NGOi/2zhikolSIkNJqo4Y0umvsyuNZAL
         oLLscPcOs463dmYq2Juql/9JQSyGU/xj4Y0nRZvjsy00agrvfg8w1ZILGGeY+lZpCYIl
         67SPiV0jSkZ0wEBlEng8qjnrtqLqIhZgFVg2Y48sL+9+VywMKXGXtC4etxZhhDu3fVcs
         F/+sSfkZxRDVQsETdYf9svmEvlM1aeqjvhTgkYY9yLhEKYf0ztcU/So/SBn0SKkI7wjo
         WHPsk7LgIZiPSEYCsWnJiNbNkVdxik+0AWzd8buL88T3LB6WrRbSdM8HKhnz3Ub86PQJ
         ft0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XlUmO362806X4JBQXMzY9UYbekCUk7hEemiyL4iife8=;
        b=G8eMYiWK+6s3XO2epadpUoWjFWjdjoW7TElrsmo9xp/CSAoGJEvX/ByJV+dXdRkgGQ
         ysdquqXgDbSFLlyshM3Gn5/JJ00Xurd74/1WChsKxmdCp7Kiasv8SAMrd8VqtNIr2ToY
         BLzYvGcC2Hyh/fsPP0OEKwQ45/Y3q1BzSKkuqK2wxAE2LQqC0eMQWNZfRMZJca//Cogg
         WeFYAIwOa+zCN2ilOakPqZZEJA+yseTyuXIxTpI9v/ZJXrslvjwKC8caTjLp/kexHMjj
         jB2jd2vIguRoXo423Qv+zu7w4yygyeaEvWIDHr75nPAxowDPN9wENOxkKuxUch9HiNp9
         XaOw==
X-Gm-Message-State: AOAM531jgXLtDF5UaspgK1SlWOpNHTfcvykuRrREgIseg5k9SSX40nYW
        6GMZr0Jgy1FYuo43ZBIiOlMteILJwTg=
X-Google-Smtp-Source: ABdhPJy8QawfDhd80gr7+cpvv0WYD3gSFz/22dlhAjs30yip1ifF7oxyO8+2uW5lcOG8M/ypvGCC9A==
X-Received: by 2002:a05:6830:314f:b0:605:84df:bb5d with SMTP id c15-20020a056830314f00b0060584dfbb5dmr12548315ots.346.1651210700253;
        Thu, 28 Apr 2022 22:38:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o64-20020acad743000000b002ef3b249b9esm789432oig.58.2022.04.28.22.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 22:38:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <85bb3cde-2b62-c15a-46f6-251eb06daeb1@roeck-us.net>
Date:   Thu, 28 Apr 2022 22:38:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hwmon: (pmbus) add missing definitions of pmbus registers
Content-Language: en-US
To:     wujek dev <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220428134634.1610241-1-dev_public@wujek.eu>
 <f8ba6a46-bbdb-b8ba-7b27-d43f2e05426d@roeck-us.net>
 <hGgSY5dLHFlYeXpEkcTTRThFR76Eevb391giqk_CiNorL3WfRpH44if4pfaOu1jMc2GuB0T51wfbHj0Aiawd28p6HvuWN9t1bzY2S_D1_fM=@wujek.eu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <hGgSY5dLHFlYeXpEkcTTRThFR76Eevb391giqk_CiNorL3WfRpH44if4pfaOu1jMc2GuB0T51wfbHj0Aiawd28p6HvuWN9t1bzY2S_D1_fM=@wujek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 18:04, wujek dev wrote:
> 
>>
>>
>> On 4/28/22 06:46, Adam Wujek wrote:
>>
>>> Definitions are taken from the table 31 of the PMBUS specification
>>> revision 1.3.1, 13 March 2015.
>>
>>
>> Do you plan to do anything with those registers, or a subset of it ?
> yes, some of PMBUS_MFR_SPECIFIC_*, but in a driver that will not be published in the near future.
> 

Adding defines just to add defines without using them only increases
source code size and compile time. Let's not do that. We can add
missing defines as they are needed.

Guenter
