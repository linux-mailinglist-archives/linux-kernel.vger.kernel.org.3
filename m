Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4086D574007
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiGMX0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGMX0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:26:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BF146D82;
        Wed, 13 Jul 2022 16:26:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso560565pjk.3;
        Wed, 13 Jul 2022 16:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PnsH/rzjlHhH91hBVi1N1J8lv6U1Lk9dQ+G06Dj91pc=;
        b=k8rO8PGtaYTYg3cEA+f5u/w7Rav+orTpIczJ1DQsYtLTfS4OF5+3ByCAP/PVZ/MzpR
         y0ETgXeXrpQVG/0MW+grpKDjpImI23flwTQb066kzUaYsZrYfzhF2SSK8x3DtrTTNY0t
         UXjd28kalMawS+FZ7GgTg83PNL4LbHBkv8mtaUWQflA5wPGEgFWMpyaaDuGbEsWZ7dZn
         lYirkc9W1pB6PYbBHK3rdUBBR8dQJl1VgV2br3hrHUBk4JgQ1Kzy0i55AT7eSgl82m+W
         wHDiXK9C/9VZvt0ctyWRB9rkWwbGXYpoBgBZOyX4sWFGLxIsNTF1WLx/1fzHnorav8jn
         ynMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PnsH/rzjlHhH91hBVi1N1J8lv6U1Lk9dQ+G06Dj91pc=;
        b=PGzmkvyQTKMjbOHkLWbSiYx+Z0xgdaJU2KzZeJ/0A0c1D3d5M71aukfZ4L5JTaMCaI
         3WO6wiJ1zLpnduelISEj1+u9KQEpYrj4TjauGJIiawuk9xlq/Zo/6VfFjGjtiNoWSzQN
         TqrWTfSraNKuAhyevKqaDi/YTGeHtnhCQl+WrvqAcvXDND3wHxjQAZPYEQWdVJ05Qe8O
         VpIJpN5N++9B9EoTIxk38iYwxsHGXKUVBS7Cwc7ccpyyID4VVJFei4a2BXouN/ii6uYG
         WIWpOpX3bJn0r/OcTEEWHAbFtEy5FV4NUtmt4Lt6Iu5PXXG1aA9eh/64Dfu+ghR5VmXi
         DeQA==
X-Gm-Message-State: AJIora+/XhJ0xTpzV5u/2Ve8reMKWpmLxxJKLsmTbqelxipOIvB5fPD/
        VvplbqcW5lsPKswiCfPwkAc=
X-Google-Smtp-Source: AGRyM1tFZ4adlJu3CfLsP7JosSH3B5ELiXwpY8eowsQR36GEWeBo6GYD8IGt8yckPWzB9t8GrlWb6A==
X-Received: by 2002:a17:903:2308:b0:16c:47a6:c026 with SMTP id d8-20020a170903230800b0016c47a6c026mr5439247plh.160.1657754803904;
        Wed, 13 Jul 2022 16:26:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 31-20020a63165f000000b00416073ced8csm5894141pgw.73.2022.07.13.16.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 16:26:43 -0700 (PDT)
Message-ID: <8a37363d-f4d9-669c-9cc6-3e76b9417352@gmail.com>
Date:   Wed, 13 Jul 2022 16:26:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: manual merge of the broadcom tree with the spdx tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Zhang <william.zhang@broadcom.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
References: <20220711095520.4fad4c97@canb.auug.org.au>
 <20220714091321.4ecfe830@canb.auug.org.au>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220714091321.4ecfe830@canb.auug.org.au>
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

On 7/13/22 16:13, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 11 Jul 2022 09:55:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the broadcom tree got a conflict in:
>>
>>    arch/arm/mach-bcm/bcm63xx.c
>>
>> between commit:
>>
>>    52e6676ef56f ("treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_30.RULE (part 1)")
>>
>> from the spdx tree and commit:
>>
>>    889390f83d4e ("arm: bcmbca: Move BCM63138 ARCH_BCM_63XX to ARCH_BCMBCA")
>>
>> from the broadcom tree.
>>
>> I fixed it up (I just removed the file) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.
> 
> This is now a conflict between the arm-soc tree and the spdx tree.

There was a link in the cover letter that I sent to the arm-soc 
maintainers referencing your first email. Not sure what else we could 
have done to prevent that conflict.
-- 
Florian
