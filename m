Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CE6523009
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiEKJ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbiEKJ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:56:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37383E43
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFE3CB82164
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AA9C36AE3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652262937;
        bh=l9dWX9O2a58GzHri2qW/e43VP0ZeB6DdOIYcz3EFWwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OPLKNoiHCVWenEyNerNrmqv3zCWUki0/buJ0HAhRe3awUD2J8ntPjY8ijnwePapeG
         9vQnwWSRWGjrXDlBhFKBmTToI5yonTokbT+pFiuWFkEu1mAmtFX/93EmoYS6Y8De2A
         4Cz3rMaE9YOckQPbHQw5075iZBcWsHHJrXcY0a3hcSeYANAZMkeenhBFGRQ+SnIxZq
         emmxzLSA8CqipAPjsuvvLOH7Nj8IqMraqW4S2/CB3weTxCf4uHz6EgsaedXyRdBdMy
         kxwQMVODcNOyaD9o0LP6JCl+1Lk/+3nrH3Qtn3Us+OfFBgvVHJjDImttrAFiS28AWj
         KLhoOvzJaUVFQ==
Received: by mail-yb1-f174.google.com with SMTP id g28so2925266ybj.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:55:37 -0700 (PDT)
X-Gm-Message-State: AOAM531tMOqsrFyzJdW5rrBXg9W/An1aw1dtIEC6VX8wfhdylMGrB+JS
        BfF6rzEFOAuhiWIeS4lLXkLQkgm3lcFZeEy2h2Q=
X-Google-Smtp-Source: ABdhPJyVyULrMHnRtV89zPjaWF0xz78UHVBPPZHkLwZr+FB+KRKRFiRv8WsvTv65s38vHHGrtfTK7+iMMFYT3H37TcA=
X-Received: by 2002:a25:424f:0:b0:645:7bfc:3293 with SMTP id
 p76-20020a25424f000000b006457bfc3293mr21136885yba.108.1652262936519; Wed, 11
 May 2022 02:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <202205100736.Y0Vi5Fcf-lkp@intel.com>
In-Reply-To: <202205100736.Y0Vi5Fcf-lkp@intel.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 11 May 2022 12:55:10 +0300
X-Gmail-Original-Message-ID: <CAFCwf13OiEtbbca1LXuXaVV7xCxrwLiqv_kAoSc7u5AFhSmjrA@mail.gmail.com>
Message-ID: <CAFCwf13OiEtbbca1LXuXaVV7xCxrwLiqv_kAoSc7u5AFhSmjrA@mail.gmail.com>
Subject: Re: [ogabbay:habanalabs-next 47/47] drivers/misc/habanalabs/common/habanalabs_ioctl.c:135
 events_info() warn: maybe return -EFAULT instead of the bytes remaining?
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Tal Cohen <talcohen@habana.ai>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:41 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
> head:   20c59ac5d71e766235e74f353b74e60facd733c8
> commit: 20c59ac5d71e766235e74f353b74e60facd733c8 [47/47] habanalabs: add support for notification via eventfd
> config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100736.Y0Vi5Fcf-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/misc/habanalabs/common/habanalabs_ioctl.c:135 events_info() warn: maybe return -EFAULT instead of the bytes remaining?
>
> vim +135 drivers/misc/habanalabs/common/habanalabs_ioctl.c
>
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  119  static int events_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  120  {
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  121    int rc;
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  122    u32 max_size = args->return_size;
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  123    u64 events_mask;
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  124    void __user *out = (void __user *) (uintptr_t) args->return_pointer;
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  125
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  126    if ((max_size < sizeof(u64)) || (!out))
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  127            return -EINVAL;
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  128
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  129    mutex_lock(&hpriv->notifier_event.lock);
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  130    events_mask = hpriv->notifier_event.events_mask;
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  131    hpriv->notifier_event.events_mask = 0;
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  132    mutex_unlock(&hpriv->notifier_event.lock);
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  133
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  134    rc = copy_to_user(out, &events_mask, sizeof(u64));
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28 @135    return rc;
>
> copy_to_user() returns the number of bytes remaining (positive).  This
> should be:
>
>         if (copy_to_user(out, &events_mask, sizeof(u64)))
>                 return -EFAULT;
>
>         return 0;
>
> 20c59ac5d71e76 drivers/misc/habanalabs/common/habanalabs_ioctl.c Tal Cohen   2022-04-28  136  }
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>

Correct, thanks, I'll fix it.
Oded
