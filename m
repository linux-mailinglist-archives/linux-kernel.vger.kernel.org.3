Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDFD568950
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiGFNYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiGFNYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:24:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C21A633F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:24:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w24so15246914pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V4tYWS6dWP+j40mx+/UNIOoszj7Dg0+fwwT9LMM38/A=;
        b=BymM1sgLJt0ol6c/OkpKcKga1FfwNzmj7SD3OVhwdIzmeiXka3XMDDYBOZz7N/unqb
         Yc1CQm5KJBp+A9+pGPu7amuQkf2evnu3jhzRx95ns4w6rWRASkpj0aPC7hKBc29GZ5wH
         c2NVSBShJgMbjAtfU5DG9aOnT/nBqEHa6lbVajwOcZqWRhZI9BM6zjbzdA3YFdZ2qi4M
         1E69zM2GkrFzsYjQS7spE6yKbaQgI0zQdjsJwebF8CA35S7tYc0bSruS98u2jqL0sGsV
         ITvfDdOPvZetx38qWdvVpyvqBDg6fYgBqAF0xlYhsdVFYYdafJzdAA/ql23igshpuRNP
         +uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V4tYWS6dWP+j40mx+/UNIOoszj7Dg0+fwwT9LMM38/A=;
        b=GGEj1M5p9f19qbqWOIp7jigENinxeHqkwG0hdTDW32ieBukq2C7o00jofwWHNDoxwV
         dlesaM3XYRzcRaFxKapObmkxstQf9NJFKcSnt5jGWqzEg3WS5DqkbiRxFyjcXU/r6F0A
         KQqU40ijnmDQXdajeyG86QLGEynRZwR6hYpZnQLs50VnG/1eO/vxibeN1/B8507akusd
         iEwMd/qzw7Z5uu0Ll19VZ9U4s79uEizDJhWYYl46wM566pCobodDThVKJw1iIQ0sXsuw
         5qoqr0cax41X6QTpIO2XAOlJ+kKfClpdG5zsxfFk/FQLuvrWKzMnnkb7PCrZ6/vpZT1z
         mVQg==
X-Gm-Message-State: AJIora+1iekt9ejS/sV5W0AnFWd+H3jA/F2tXg/3qNWQusCMqynEIDvf
        ig2xp7ffuZYUwFSc5xJ5uLE=
X-Google-Smtp-Source: AGRyM1v1X0JOuWMSFiehFCvxxt1YfSFIT12ay1QZmQPqS97R0CElAt7P40mDOtgXxuBvfH+b3Bg2bA==
X-Received: by 2002:a17:902:ba8a:b0:16b:988f:9279 with SMTP id k10-20020a170902ba8a00b0016b988f9279mr42995621pls.114.1657113852026;
        Wed, 06 Jul 2022 06:24:12 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id m184-20020a6258c1000000b005289eafbd08sm2432646pfb.18.2022.07.06.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:24:11 -0700 (PDT)
Date:   Wed, 6 Jul 2022 22:24:10 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC fixes for 5.19-rc5
Message-ID: <YsWM+im7pmU8MdeZ@antec>
References: <YsWMXAF3ePlWuxyF@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsWMXAF3ePlWuxyF@antec>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, again with proper subject.

On Wed, Jul 06, 2022 at 10:21:32PM +0900, Stafford Horne wrote:
> Hi Linus,
> 
> Please consider for pull.
> 
> The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:
> 
>   Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)
> 
> are available in the Git repository at:
> 
>   git@github.com:openrisc/linux.git tags/for-linus
> 
> for you to fetch changes up to 48bddb89d59eec27c3305d179b1832d5292e285d:
> 
>   openrisc: unwinder: Fix grammar issue in comment (2022-06-28 17:31:24 +0900)
> 
> ----------------------------------------------------------------
> OpenRISC fixes for 5.19-rc5
> 
> Fixups for OpenRISC found during recent testing:
>  - An OpenRISC irqchip fix to stop acking level interrupts which was
>    causing issues on SMP platforms.
>  - A comment typo fix in our unwinder code.
> 
> ----------------------------------------------------------------
> 
> Note, if you do check this against being in linux-next I dropped one patch from
> the linux next tree before creating this pull request.  The dropped patch was to
> add wireguard selftest support, but we decided against it as there are still
> some qemu bugs to workout before turning on wireguard selftests for OpenRISC.
> 
> Stafford Horne (1):
>       irqchip: or1k-pic: Undefine mask_ack for level triggered hardware
> 
> Xiang wangx (1):
>       openrisc: unwinder: Fix grammar issue in comment
> 
>  arch/openrisc/kernel/unwinder.c | 2 +-
>  drivers/irqchip/irq-or1k-pic.c  | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
