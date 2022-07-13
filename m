Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAEA573DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiGMUpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbiGMUpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:45:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE2F2B1BE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:45:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso37187pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hj56zl8YkRtwkNBCOxHuxz3t0X0zHpjNDxMLhJ735rc=;
        b=YucXUkB7+XDbsZA6npj7CpMa32EHucJ7YcQ0989VM2knFEXYCiEdwIL0xXsxltWSay
         FiFsZlkNlGKsCZJMWRpXw4Zu2b6m+iEuJx6LQ6KBJ7h9joXLYlVylYNKlUlE2+yjpJ5e
         7up0vENQBTIYlY+WBp31eP8Hl51NdCfbH2TqDQOuwcEfdkuBSdk8cUbLmvz9F/XJv363
         Mjx9tkRQfkmflKHDBaQDPtHWXHpIGMh/o1OWg98SPmBNQvzFtXaqpASXlMchWQ+MDF0T
         NabQslNJiokAebaO/QXEDhcnwEtHaKiyvhVTC8Dn/4w1TMDqW6KzmQpB84Xw3DEv+XzH
         X8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hj56zl8YkRtwkNBCOxHuxz3t0X0zHpjNDxMLhJ735rc=;
        b=mPJkQozddYqdp6h4G/cFWsUpiho2itW4fmh1PyIyRSmXBpYa+/1ALT6LZrnf1cXG/O
         I7vi8Q790xbd0qR8DdBpqTyWem8Q+jI3JVXn2RPoiAzAlozIj0+SbuTeNpdpJMxrOaBY
         iIS5MZVXxQn0RpI57IdkLH/EOHGVZTFInGcmLL2u9NOq/JUXTHG4RrWhAVP8eM8lkmGe
         wY3insq5DuOLLxzP7X3G6bo1v3ZinpG9f3fA2RtcmeGYJhmWx2BHugPt5CiHOLpbTNkS
         aPVq78lpirJCYC4V8n2ORUw+JLcYi1wOCUqzmHeCiK+apI1evxgz2hFOHCHIKd9TZdGY
         0YuQ==
X-Gm-Message-State: AJIora+BUkwyRq/PuQwoV8qOkBzwrqvAYKONFGC/kVEDp9FnR+Um+HMs
        6LEqZyV2UwkAZAx0VeOYxkNaRYALqesHLQ==
X-Google-Smtp-Source: AGRyM1tk2dgCcN+hf4ypP8CNcErOz5P28HKcTVVtP6C8XYDSU88TKy/IC0YT5iM2VQuAZoyZDVdmwg==
X-Received: by 2002:a17:902:c947:b0:16c:1c97:16ec with SMTP id i7-20020a170902c94700b0016c1c9716ecmr4726986pla.7.1657745131775;
        Wed, 13 Jul 2022 13:45:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902ea0500b0016a058b7547sm9402419plg.294.2022.07.13.13.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 13:45:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d4b80a85-c77b-7568-dc4c-df64fbf9afa4@roeck-us.net>
Date:   Wed, 13 Jul 2022 13:45:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Linux 5.19-rc6
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <CADnq5_Ma2oe-6+WG4ZRAm97G7TyS0Nuhdxt=7oqdNLcMP5nKeg@mail.gmail.com>
 <CAHk-=wgW-g5jAMmKjnG0_mhqtEKzbKxs=Lo8DDv1D2wZvhL-8Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=wgW-g5jAMmKjnG0_mhqtEKzbKxs=Lo8DDv1D2wZvhL-8Q@mail.gmail.com>
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

On 7/13/22 13:22, Linus Torvalds wrote:
> On Wed, Jul 13, 2022 at 12:53 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> Does this patch fix it?
>> https://patchwork.freedesktop.org/patch/493799/
> 
> Guenter? Willing to check this one too for your setup, and we can
> hopefully close down both issues?
> 

No, that fixes a different problem (I tried). We (Google) are trying to run
tests with KCOV enabled images on AMD hardware which requires the new display
engine, and we need that patch to enable it. That is unrelated to the PPC
build problem.

Guenter
