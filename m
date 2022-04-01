Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE70B4EED2F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbiDAMeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbiDAMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:34:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E7185968
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:32:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c10so5458181ejs.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ag8WvDE5i+v4AIyc8d66eNfPUw+5fXLkkIoPop5k2gw=;
        b=lqIepgVeQQ97BBh0z4xpMJesT3keS7gShEa4cvee1YLq8FXh22EG4iYtS+BVfJt3BD
         is75XxOmyXtxjEKKSFqlbinwbqBxkNPIQLjJzGjQcd0i4432DKpzwQ20FaxAOtEZVL89
         Cqn23WFahO68mkw4C0OtakOXOFp0jPwPobZnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ag8WvDE5i+v4AIyc8d66eNfPUw+5fXLkkIoPop5k2gw=;
        b=gFZ1i3quMTWgEg6trxiOp7LBraMIMC5fy7rqNdUoTGYVm7bVCJwHwUMJDNF6EzWufQ
         uQmJWx5q0gjQ33gqFhtVJlpCCoy/rAxpNmHVw5KiNaHQ5p51ET+KJPKAmdOPgG7zY2t0
         pX3AsGqHCZbBKc43gAuPuZOoEDFupNuPXEDosk0YLxoCGwhnGKR+YIuQriqNnN2AUapE
         QnQBguIeETRoWsDFhR7NTXtJ2yQ19l9+swbqEhyeCGXotFZImxiTUotp72Z7ZNs1RiHM
         HLhIXC3ZA0fbsRFfUS5HYekU3M5UtwSyQLUu5YBWoCkHk1bv8PZtAtQHwLUxWNhH7ejA
         RSlg==
X-Gm-Message-State: AOAM532Tm2PNsxNqZRckKrp4zo2y8+RuV9m+FC1Hqz81SYkvBapzt47s
        uDp9OACWqqDsHK4A5MLvqKlB9g==
X-Google-Smtp-Source: ABdhPJy9gg8WFi3gHSowl44VmwQm0/Ef8b9ygcFmgMO5A91Y0yqckKi6nIWNS1Gw67Qv+Sujg29NyA==
X-Received: by 2002:a17:907:7daa:b0:6e0:c04f:be44 with SMTP id oz42-20020a1709077daa00b006e0c04fbe44mr9201767ejc.375.1648816372434;
        Fri, 01 Apr 2022 05:32:52 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:16a5])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm979093ejb.220.2022.04.01.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 05:32:51 -0700 (PDT)
Date:   Fri, 1 Apr 2022 13:32:51 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] MAINTAINERS: Add printk indexing maintainers on mention
 of printk_index
Message-ID: <Ykbw82LY7fvJD/mI@chrisdown.name>
References: <YkRp9IhToTmTnkl7@chrisdown.name>
 <YkbuovatudROyl4b@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YkbuovatudROyl4b@alley>
User-Agent: Mutt/2.2.2 (aa28abe8) (2022-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>On Wed 2022-03-30 15:32:20, Chris Down wrote:
>> This will primarily catch new and changed printk_index_subsys_emit
>> calls, but it's also worth catching changes to other printk indexing
>> infrastructure outside of kernel/printk/index.c.
>>
>> This avoids churn due to missing ccs when adding new printk indexes, as
>> was the case recently for the first round of the XFS printk indexing
>> patches.
>>
>> Signed-off-by: Chris Down <chris@chrisdown.name>
>> Cc: Petr Mladek <pmladek@suse.com>
>
>Nice trick. I was not aware of that K: entries.
>
>I have pushed the patch into printk/linux.git, branch for-5.19.
>
>We missed the direct 5.18 train. I will add the commit into
>a printk pull request for 5.18-rcX if there is any. But I think
>that it is not worth creating a pull request just with this change.
>
>I am going to make sure that you are added into CC in the meantime.
>I hope that they will add me at least ;-)

Sounds good, thank you! :-)
