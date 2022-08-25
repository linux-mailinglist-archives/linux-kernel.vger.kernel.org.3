Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3254C5A0AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiHYHxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiHYHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:53:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA179E8B6;
        Thu, 25 Aug 2022 00:53:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so4100415pjn.2;
        Thu, 25 Aug 2022 00:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=NIG+DDYxbCv/iOq7O3NIdMgtBDBXDQDO1rp8o3gnBs8=;
        b=UJ9jj2xfAUv0S7yuC1Sr6lUSqTc8rOcKPZDitVx25eAnl5OB3tQ4zzHXpo032YJN0a
         HzuDLD+REASEDmfM0YkFadWfne1VXffCP87qm+NbnAiTI5tyUBKNNfcKU8LwMkDYGKIj
         TZaAFPmEQJs3BmzAkt4maqhdjMp7uLqfQfM67SgwVqDe00wTlk4SYrqN/waBunmtzZ8f
         1PKuvkdaft4ZqilHcbCJBtcSJmCu+bnVYmpKHEXI9RcZXWGwzVXCBOYrbNKnXnXL5Ire
         zgIzsIjtLq1QpuA8XBX03XtX9ehcigWc6OO5RQhXmPb/wM6QFNFEM1R2Gg39RtPjJbOu
         SXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=NIG+DDYxbCv/iOq7O3NIdMgtBDBXDQDO1rp8o3gnBs8=;
        b=WqmHBa39VkXok/28NJQ/w12ba3upH0FqaMV1H1Eg6nWBJtupPjSqY6lI6RuE5F8xCF
         YiSQ42/zW8KPnIC3jzQ2+Mi6zB1qydVYMwofptidUx9sy6qFWYNY+OSAZLu3nA/p0MJy
         +/DDbI1R3BrrGVYh8RO28WoBYTTa5uJW8/HHOEyrr1BhKkBeFuEoTU6vCRk6IVHzVYJC
         I8y4HZBeA8EQYc1dRjNtEFJiDfMe22p5Ye2MPrrcLKAJd5Cps/o8PnPQ5IBYpsOyNILy
         2NfwtfwpJ3W8VOhNy4GXEaFYsssNv6j4Su4p3G/YO8llaSEtPY+TaTmDNf9TuUhBNn17
         yjKg==
X-Gm-Message-State: ACgBeo1tAvo9NRpDFxNWrJ65Q1qAy6YFuU4WE/yxuv4vI2mlfxM50shJ
        Mmg5BMt6dvsvY7KvM7eqhemocgvXAJk=
X-Google-Smtp-Source: AA6agR7FAFvfkMJpNIJ0NKBrdBxU/+OTHblOZkZyKXUVAqCkSjI3cUE+RVf1N0EaLmLnFT1wxNPUvA==
X-Received: by 2002:a17:90a:1b6e:b0:1f5:1902:af92 with SMTP id q101-20020a17090a1b6e00b001f51902af92mr12698304pjq.238.1661414020436;
        Thu, 25 Aug 2022 00:53:40 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b0016dc2366722sm13068630plg.77.2022.08.25.00.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:53:39 -0700 (PDT)
Message-ID: <76b2dbcf-70cf-aca8-4ccc-b2a73063b8db@gmail.com>
Date:   Thu, 25 Aug 2022 14:53:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
 <d5eca4a6-8a76-02e0-2f22-645341af8c2b@infradead.org>
 <CAKXUXMwLofvhBXqzdoq_q_89jZ8THU0WX=DY+RnCo=PN7QqspA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAKXUXMwLofvhBXqzdoq_q_89jZ8THU0WX=DY+RnCo=PN7QqspA@mail.gmail.com>
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

On 8/25/22 14:35, Lukas Bulwahn wrote:
> Randy, would you know if there are still users out there?
> Would it help to replace this script with a minimal script that only
> reports to "Please use git to obtain a recent repository. Update
> versions and apply patches with git in a controlled way.".
> 
> If someone complains, we revert the patch. If no one complains within
> a year or two, we could consider shutting down the infrastructure
> creating those patch archives as well, and delete the documentation
> referring to that.

As a refresher: besides Linus's tree (mainline), there is also stable
tree, which is maintained by Greg and Sasha. Most users uses the latter.
So, in case we add warning message to scripts/patch-kernel, we should say
"This script is deprecated; please clone stable tree at [1] with git
instead. If you'd like to apply patches, use git am. If you already have
the tree, use git fetch and git merge to update stable branch of your
choosing."

Thanks.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git

-- 
An old man doll... just what I always wanted! - Clara
