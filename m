Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464ED56608C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiGEBNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGEBNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:13:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3F0B87A;
        Mon,  4 Jul 2022 18:13:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so6853348pjm.2;
        Mon, 04 Jul 2022 18:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/KsfK/V0d8ToZ+E6OEEqCLi5B5hLJgvh5U23wBizRsg=;
        b=KRmMBSAu9BXPprxpAm5q1f77xbWjG8Isw/3aW9fcpWq4nM4Pw0eKaaC67TYI4oHRb3
         rBfQTftx42v485u+jrEJ/3dOgpMZTOvebwqZpokjsQ/hcv1y7aOaOWwysMFuVBVidxg/
         zfaE3XHyOhU1Q7VapKOpFk4m6KS6ckrwtXHA8KX0L7abAGv9fXJc9lYcFv4Aye+cJ6gD
         GpFAFOq91yD4F+rIg6xMOs2Yh4FuHZMrC3gfaxHLQVNSc8nxLQjsfsfVKVkXLRUWbfGZ
         XmyUHqKby76lpX9L+7SFN5pkBTcNkwAXZujVSx9H6sFCyXgX98dy63fAvKTfxWrqZ4ar
         3QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/KsfK/V0d8ToZ+E6OEEqCLi5B5hLJgvh5U23wBizRsg=;
        b=3SeTKSV7SNZnHHkJJabsyLbFCY/KyZ9IWA/uJaQqj59Hr2caC31ZsjIYmLI/OuvPU6
         6f89AtoBWb89V1+J+02LcGU7b0poYH9MrKukxF1TbwfROE2osqslOZa4aVO6YiAf/Adl
         Cne4TpCn7axvT0EAqXxwYRDmsRGRpt3XaN/3jZEChvUqxkNgXLKijwuGAJ3G4xSXUrrs
         rYnAbLkdmA85lJ83x7psYVy0QLp2XTbIGxE6vbv5hT4Rp934/ByGQcx8Sf0cr5fWtgBz
         C4o7XjwDGo/yy3+SBe0f9TqxtfPlYa/AAWTwbiL6lVKr5r/V3rnmnJmTEk7r8xQ5vaif
         qJqw==
X-Gm-Message-State: AJIora/PtCM3iPl6Qc+aJCLj4MUIwR3bq+jzljwQBeLyupVPi9NI0Ice
        gfZEOlFgaivvQaCKRVKKYy4=
X-Google-Smtp-Source: AGRyM1sgMpaP0Q64qHoUTkXkRGyu9301qytl0nv2YEGI1fDSAssBS1+jo33V7GNKPyoovjjoPztl0Q==
X-Received: by 2002:a17:90a:d3d7:b0:1ef:ebe:d613 with SMTP id d23-20020a17090ad3d700b001ef0ebed613mr38126329pjw.240.1656983618520;
        Mon, 04 Jul 2022 18:13:38 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-11.three.co.id. [180.214.232.11])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0016a38fa3f95sm21874957plk.118.2022.07.04.18.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 18:13:37 -0700 (PDT)
Message-ID: <5418fb0b-47e2-d251-a6c7-a9bacbaf3dc1@gmail.com>
Date:   Tue, 5 Jul 2022 08:13:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] Documentation: bno055: separate SPDX identifier and
 page title
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Documentation List <linux-doc@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YsGVa8KFmdvGY92e@debian.me>
 <20220704034041.15448-1-bagasdotme@gmail.com>
 <CAHp75Vdg=NG9fnd0EQWg5D4WoW9hGJM+MMBRLSacgQUptuGe9Q@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAHp75Vdg=NG9fnd0EQWg5D4WoW9hGJM+MMBRLSacgQUptuGe9Q@mail.gmail.com>
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

On 7/5/22 02:49, Andy Shevchenko wrote:
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrea Merello <andrea.merello@iit.it>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
>> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
>> Cc: jacopo@jmondi.org
>> Cc: linux-iio@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org (open list)
> 
> It's a very noisy Cc list which will go in the git history. Instead,
> use --to and --cc parameters of `git format-patch`. Maintainers
> usually use `b4` tool that adds a Link tag to the patch itself on the
> Lore archive which will keep track on the Cc list anyway.
> 

Hi Andy,

Thanks for reminding me.

I think something like `b4 am -l`, right?

Anyway, should I resend (reroll)?

-- 
An old man doll... just what I always wanted! - Clara
