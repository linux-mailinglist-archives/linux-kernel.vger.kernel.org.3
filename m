Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB4556F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiFVXos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiFVXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:44:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3427A42A1F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:44:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a17so14729730pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xiuf6zzvbLG03UYs0C2KLwj/eVIRqceMt7/BlzFnYGs=;
        b=xg+bSaA4gWWCgUv2DixZs6U6w9neQ3CWRdkRAs7h7X8ylApaGxfOBVIYZHibDzA0BO
         qwwctctan+VZXqN+VpninBE7FM0Mwa2fmYOmg+GDLRWiVGXjWktKj6Nk5DMvSg3R3FBJ
         uueM3ZRs+Y6MptlF/jEk4fOA/lpGOYb+HNjx3210xZu0FDVkMYI8iNyUAbPapoSas5WO
         5JiQd0jeov/ucQRwrOIToeDPpZQQ0kqZt2pqelfTChiW0Pnwg8sAL2AissCoyUljQwfF
         cEdS+6rx95FbvJwSetOHDT3zgMtj3djbS5bDsL9R2MPXQy8DVnr64Wf1ZsqccpxpGb2P
         62tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xiuf6zzvbLG03UYs0C2KLwj/eVIRqceMt7/BlzFnYGs=;
        b=zFMLsxbfLYvhq6o3ZxA1egDavNO38SiPb9P6fdNKokNI620TaPiJl9z7mi3BNbJr8D
         A2XWIOJcmpmDmW3YUXiLdN0w32xl5XaccivGSzcCHrZezC9GkyxPEDNYapUr9I82JN0T
         dFpq96XsjhHEV2Ii0m9KYNXxN7+lH2/I7+on57kQnGXSu5/wmyc+3Ztuet8COqeqZUoQ
         yGyJq338L/ZN+djIgZYkb87Fv7vEXxouwGfpn48MbudUPxOxBmyf91d3MQYDANr5syIh
         oFCUhIIXHrZuBj+Mwc2+uOk56OwoEWIyC8GSaV+EKlwEsMQMDNAQA3VeOkvahoc7nufr
         JRsg==
X-Gm-Message-State: AJIora/wHMkaHc6e4H2323kUfbgyI58+gMH5npU8KPXZ+PSF4HW+eRwz
        RmM9mTbt2L/2Pje2/VaQQIXd4SYsHa8a8A==
X-Google-Smtp-Source: AGRyM1uilk/Jr0x+syRpFZ/nF+4NI/OGSgvao9e50J8tXM/WSqNrc24QNGuHDvCaqAtgKFS0vAZM3w==
X-Received: by 2002:a17:90b:354c:b0:1ec:9ef2:8a0e with SMTP id lt12-20020a17090b354c00b001ec9ef28a0emr936394pjb.72.1655941485638;
        Wed, 22 Jun 2022 16:44:45 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id md17-20020a17090b23d100b001e2f383110bsm357045pjb.11.2022.06.22.16.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 16:44:45 -0700 (PDT)
Message-ID: <fb6f3d33-2d56-cf3b-25e8-85c24dcbb3d8@kernel.dk>
Date:   Wed, 22 Jun 2022 17:44:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dylan Yudaken <dylany@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220623092143.2b9d2e7e@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220623092143.2b9d2e7e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/22 5:21 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   1da6baa4e4c2 ("io_uring: move io_uring_get_opcode out of TP_printk")
> 
> Fixes tag
> 
>   Fixes: 033b87d2 ("io_uring: use the text representation of ops in trace")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").

I'll rebase on -rc4 anyway, I'll fix thie one up.

Dylan, here's what I use for adding Fixes tags:

[pretty]
        fixes = Fixes: %h (\"%s\")

and then I just do:

git fixes 033b87d2
Fixes: 033b87d24f72 ("io_uring: use the text representation of ops in trace")

to generate it.

-- 
Jens Axboe

