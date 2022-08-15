Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5405928C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiHOE2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiHOE2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:28:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8335512772;
        Sun, 14 Aug 2022 21:28:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gj1so6048364pjb.0;
        Sun, 14 Aug 2022 21:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=AxntZ5boEdqFqlgnkvj7nx9yV31SjrqxErxj02VUkgI=;
        b=EiZ46NWgWvaPrWGZpEefUGH8iyYRrNyxPcZFIYYXH1N8zjQloB6tCImzZpIVPLxywV
         vvyyCkK9dDeDt7iSwYZs5PMf3Bp037GUBrBFN01bWAJ72NpP06EtdZlV1FKXm653cwX1
         wo8o5GLfryMyJ+1ZnsFNTEeTf+sdzRGnYhiiFAJbNzKyCg7cKOTj46KZPv9lhejF+hys
         +f0JYi+/ciwR5SdnaOiW3IGj7nqdcuHuml0Nonjl2N2YXx4U61l5YaMx4ic3xRYZWWQO
         0F+OC0HTjyGxpiJOuxcqqEGO1U3lt/938nOLcJ09iB5MjBqOQuLp7rZmVVIdZOKk/eEe
         m0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=AxntZ5boEdqFqlgnkvj7nx9yV31SjrqxErxj02VUkgI=;
        b=g/fcRF4hGHBbIe2wP0x+Am+GHCkgqdtghjvSdJk4/pKMfitHXsUfrZM9TII2DEIvhd
         L/k8V5sNGaxKSUx3uXImTgR+Yw4EqCUWgtqUSBho/k0FhO9lI5tRsI+zCUR6/rk6Uyml
         3rcuARDEUIfmrbuxX2yxTnY/D/9gVxoujKIJJZMCUMiJQHQY1gborxoAzoMEfLf/phO7
         ggeNaPUKylWqKbpYekODw310vLB9Bcr3qiA9KANb0VUw0d07XcwqqwfAJ/0Sm+ZIAAvN
         NEgCNxbBhcwp5Q4q2/O5yqJfPT2T1SXJb27MyiMeqNHcTxVNndwOsvfOs4ZjY0F19fEe
         pJRQ==
X-Gm-Message-State: ACgBeo1A2zgoAHipwCKRf3x+qpUvHhsPGDLfuySZ3OknxqU2kaXWLVNN
        dszM3bWKDj3H60S8jNPidBg=
X-Google-Smtp-Source: AA6agR6MAp7+b/8FUDKU99TCqhom1gNdLqL4D9vAA6/sxWFPfnKjoyXgKgGz0y5SYQ1WL0Q+KddeKA==
X-Received: by 2002:a17:90b:4b91:b0:1f4:e116:8f1 with SMTP id lr17-20020a17090b4b9100b001f4e11608f1mr16664416pjb.121.1660537693908;
        Sun, 14 Aug 2022 21:28:13 -0700 (PDT)
Received: from [192.168.0.110] ([103.159.189.148])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b001709b9d292esm6118545pld.268.2022.08.14.21.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 21:28:13 -0700 (PDT)
Message-ID: <54dd86bd-416b-3048-9bd0-368afa3aaf2f@gmail.com>
Date:   Mon, 15 Aug 2022 10:28:05 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH] Soundwire: Initialize multi_link with fwnode props
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220814080416.7531-1-khalid.masum.92@gmail.com>
 <CAHp75Ve4UaLsUknGKm14_-f5=qsq1s_Ws+j6h0kAY5_XMkSmQw@mail.gmail.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
In-Reply-To: <CAHp75Ve4UaLsUknGKm14_-f5=qsq1s_Ws+j6h0kAY5_XMkSmQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 00:46, Andy Shevchenko wrote:
> On Sun, Aug 14, 2022 at 11:31 AM Khalid Masum <khalid.masum.92@gmail.com> wrote:
>>
>> According to the TODO, In sw_bus_master_add, bus->multi_link is to be
>> populated with properties from FW node props. Make this happen by
>> creating a new fwnode_handle flag FWNODE_FLAG_MULTI_LINKED and use
>> the flag to store the multi_link value from intel_link_startup. Use
>> this flag to initialize bus->multi_link.
> 
> ...
> 
>>          /*
>>           * Initialize multi_link flag
>> -        * TODO: populate this flag by reading property from FW node
>>           */
>> -       bus->multi_link = false;
>> +       bus->multi_link = (fwnode->flags & FWNODE_FLAG_MULTI_LINKED)
>> +               == FWNODE_FLAG_MULTI_LINKED;
> 
> NAK (as far as I understood the context of the comment and the change itself).
> 
> These flags are for devlink, we do not mix FW properties with those
> internal flags anyhow. The comment suggests that this should be az
> property. Also commit message doesn't explain the relation to devlink.
> 
That is a good information to know. Thanks.

I shall try to find out if I can somehow get multi_link's value from 
fwnode in any other way and look into devlink in the process.

If you have any suggestions regarding this TODO, please let me know.

Thanks,
   -- Khalid Masum
