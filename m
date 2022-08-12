Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003B2590E19
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiHLJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiHLJbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:31:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6C911462
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:31:32 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so241751wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=J8tlT7YO8qB4sKSoN7y2Ao83eWRyyP4+ue99CI5WF2c=;
        b=Mj1bqzrYJljq9jpWElDlhgRYBpwuM895f5L3urP7d/Yhb1lJB3+WMCVOOP9snIQ1I1
         fRCJup6PrtoMIQP/p00dYKrbZJJoo6WkeMr99arp0WsK7VrBLBPakclpx59hcC41PgvA
         aY1eFPkMQOS9iuFf1ZX5mU/Ij4iN88zKqQVQoqrWjWbEMNcMsBR54Me6rIqsLOrjPIpC
         s96hxaM0fsy3mEiSnrwRGQDZUCU19iAmQz1o/TyjTc1G5QcjDZK08kRxb/Iaf1ZPW7xC
         9EJG7WLxxtLuTBZRs1vw1eKCyyAFSa/XrvCGN50dE6Fb1GHVE0zCcF9cfaDoEjECrRkl
         dePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=J8tlT7YO8qB4sKSoN7y2Ao83eWRyyP4+ue99CI5WF2c=;
        b=OihuiYYFFdlniKIy7P1sZYd5W+amcRsyn43oYFRthnZpBFlA7m9psiOP+O2luk6Uau
         XN7BLOgmerlitWwjrP+DM0w1GG6aim8DtRfcZNdJw1b0HU7/22M5SMZjyhXjRbbxGRtB
         ws95pRFmQeMZuwk6W5EStdb7rf7/C+CzZPWDPQRBvpSetVc4klTlx0Qo+qd+PK43NFHa
         +2TmKRWO+V8AktdACS5rCInEjYLTlMd4NKhbXH4VgfTk91Wvfl8kYgIJPwJcQaiIHP0K
         7yIYTikO1Rz0WSJhWa0MtOLTnoKWe703iYRr79kuCwtOHAl/bh620BGvpOj1FqIVGHum
         GENw==
X-Gm-Message-State: ACgBeo3r2+h/Vo1nu5cIofvGqx8LCCr/xuUjqP0R36pkVSNranCPsYfl
        Ns4vJEkcB5Dy1UlxwcatFd9HYcNoda3atw==
X-Google-Smtp-Source: AA6agR4svBtdz0KcIJWb67jGlv7KKb+EtZMjysnq9ybCXnrYz2Uujk60Mq4F0rOTL7+QP5Mjb+BzxA==
X-Received: by 2002:a05:600c:1c28:b0:3a5:3e18:3e with SMTP id j40-20020a05600c1c2800b003a53e18003emr8021062wms.203.1660296680528;
        Fri, 12 Aug 2022 02:31:20 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o36-20020a05600c512400b003a5317f07b4sm10016930wms.37.2022.08.12.02.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 02:31:20 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:31:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "zhangwensheng (E)" <zhangwensheng@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: Re: Question: consult patch
Message-ID: <YvYd5hG0RFK4uf6L@google.com>
References: <420a6c4a-e526-4e8b-d5bd-563c40aa94e1@huaweicloud.com>
 <YvXo1uCFA57t89Nv@infradead.org>
 <902a45fe-1117-3f6a-b7b1-9b155e5dd984@huaweicloud.com>
 <YvYAmmaJgvydex4p@google.com>
 <f179ff36-e511-1bad-078f-71b8b19d404e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f179ff36-e511-1bad-078f-71b8b19d404e@huaweicloud.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> thank you very much!

Please refrain from top-posting.

> 在 2022/8/12 15:26, Lee Jones 写道:
> > On Fri, 12 Aug 2022, zhangwensheng (E) wrote:
> > 
> > > Hi
> > > 
> > > In CVE list last week, there is a new cve reported in asop 4.14 like below:
> > > Reference link: https://lore.kernel.org/all/CAODzB9rgMexvLjE=WuTm+SN8SfUggaZgWG-aBcy6cotppju6mw@mail.gmail.com/T/
> > > 
> > > ---
> > > CVE-2022-20158: mm: backing-dev: Take a reference to the bdi in use to
> > > prevent UAF
> > > 
> > > CVSS v3 score is not assigned.
> > > 
> > > AOSP kernel 4.14 contains following 2 patches.
> > > - 69e8f03c5ced3e4e6fb4181f4dac185104e3420b ("mm: backing-dev: Take a
> > > reference to the bdi in use to prevent UAF")
> > > - 80d91b86a199798ee2321a0ab0f09e6e12764678 ("fs: explicitly unregister
> > > per-superblock BDIs")
> > > 
> > > The first commit 69e8f03("mm: backing-dev: Take a reference to the bdi
> > > in use to prevent UAF") is not merged in the mainline and stable
> > > kernels.
> > > Commit 80d91b8 was merged in 5.16-rc1(commit hash is
> > > 0b3ea0926afb8dde70cfab00316ae0a70b93a7cc) which requires commit
> > > c6fd3ac ("mm: export bdi_unregister") that exports symbol of
> > > bdi_unregister().
> > > 
> > > Fixed status
> > > mainline: [0b3ea0926afb8dde70cfab00316ae0a70b93a7cc]
> > > ---
> > > 
> > > As mentioned above, patch 69e8f03c5ced ("mm: backing-dev: Take a
> > > reference to the bdi in use to prevent UAF") in asop 4.14 can fix
> > > a null dereference problem, form my analysis, may like below:
> > > 
> > > blk_cleanup_queue
> > >      blk_put_queue
> > >          kobject_put(&q->kobj)
> > >                  blk_release_queue
> > >                      blk_exit_queue
> > >                          bdi_put
> > >                              release_bdi  // bdi -> null
> > > del_gendisk
> > >      bdi_unregister(disk->queue->backing_dev_info) // null -> reference
> > > 
> > >  From my analysis, In asop 4.14 kernel, in loop_remove function, there is
> > > such a timing that executing "blk_cleanup_queue" first and then
> > > "del_gendisk".
> > > but because of the refcnt of queue will add by hte line
> > > "WARN_ON_ONCE(!blk_get_queue(disk->queue));" in "device_add_disk", which may
> > > not result in "bdi_put" releasing bdi  in "blk_cleanup_queue".
> > > 
> > > I'm not sure where the problem is, so I want to ask Lee Jones who sent this
> > > patch
> > > for clarification.
> > > 
> > > Thanks!
> > > 
> > > Wensheng
> > > 
> > > 在 2022/8/12 13:44, Christoph Hellwig 写道:
> > > > On Fri, Aug 12, 2022 at 11:34:59AM +0800, zhangwensheng (E) wrote:
> > > > > Hi Lee ：
> > > > >       I saw your patch because of CVE-2022-20158, the patch like below:
> > > > > 
> > > > > ---
> > > > >       mm: backing-dev: Take a reference to the bdi in use to prevent UAF
> > > > I can't see that patch anywhere, and I've not seen an bug report for it.
> > > > 
> > > > >       Because of a distinct lack of locking and/or reference taking,
> > > > >       blk_cleanup_queue() puts the final taken reference to the bdi, which
> > > > .. and blk_cleanup_queue also is gone upstream.
> > > > 
> > > > What am I missing?
> > The issue reported in the aforementioned CVE was caused by a commit
> > which was applied to an internal, device specific repository.  One
> > that has never existed in Mainline.  I failed to reproduce the KASAN
> > report in any upstream or stable tree without the offending patch
> > applied.  The issue was fixed in all affected internal trees.
> 
> I'm sorry I didn't fully understand you. did you mean the CVE
> was caused by a commit which was applied to an internal kernel
> version?  What commitment can be displayed? and I know that
> mainline do not have the problem because of some code refactoring,
> But are there any problems with some other stable branches?

Yes, CVE-2022-20158 pertains to an issue on an internal repo.

Mainline and Stable were unaffected.

-- 
DEPRECATED: Please use lee@kernel.org
