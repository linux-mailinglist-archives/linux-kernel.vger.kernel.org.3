Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97A58278C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiG0NVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiG0NVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:21:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D725EA0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:21:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s9so2140094edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULYmlOXVqjXX7HeVd/2r6q13ryXvzeR5lMbaFhgz/dI=;
        b=mwJ5B/HanHs1g0oM8012VvvpHaBBGlXaJYcB2wtZ36mI+qNCuIL1anCeCBSe5+p9IU
         aBGaEoWYq1KAFgSempzhxd8fhPGzFyeQuJFmqDmKMU4Tb95FH9XUtWbxXzoQmtgIrRw+
         YJxymUcGXKjzOWyZO1heoPXOIuS6zyNQprt9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULYmlOXVqjXX7HeVd/2r6q13ryXvzeR5lMbaFhgz/dI=;
        b=TtUlRg3zNlcThXDajCq1GzzTqnhlld3gLlAspkDS1QJwbv/SaEAy2YuYPv0PFxbXVW
         8i/v3269yuv9zINbQcOZwwDAkCmlFkpwqSy3AW9GQERk9f/b97HIH5JW39oFfbp9m1ql
         xSgHt2xsIC8g/8/3znTI6SEVahs6pzB8AmnXExwGKrj1AakOC22IVoZigsloJZEIxRZl
         RBzn8KSVaFs8dftkQw32m6xZBtCz5Sj5CUiezVhVr/Mzmp8YFhHnusSKtsD2MjyZmLVy
         92anzwTj6Z+f4YLoXO9NbSUKH/9A/UBccROfIfB8crzIeSRLxtSeu0P6W/pUSSwgRevN
         kq8Q==
X-Gm-Message-State: AJIora9qhlMvsh86gGT1zaSazAuwIjQxgb4yZRaGAawhHOKdNp4yam2w
        huVzhK/iBwvetvMpArbRiD0JlIQs9mXykzpPy0d49A==
X-Google-Smtp-Source: AGRyM1tqatOAwaiQnQ7oka4nkE+hxhpH+krVc2LxP7Ze9nRUK5KkGXnmKmssDISH1n2ItG/Q7j/mdwhNc9WwVQH/Doc=
X-Received: by 2002:a05:6402:e96:b0:43a:f21f:42a0 with SMTP id
 h22-20020a0564020e9600b0043af21f42a0mr23692787eda.382.1658928091268; Wed, 27
 Jul 2022 06:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220601022814.122620-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220601022814.122620-1-yang.lee@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Jul 2022 15:21:20 +0200
Message-ID: <CAJfpegtQqECU=-M8KomeG_6ba5OT2rPhkGXaQ9LMdjv2+PeKAw@mail.gmail.com>
Subject: Re: [PATCH -next] ovl: Fix some kernel-doc comments
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 at 04:28, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> fs/overlayfs/super.c:311: warning: Function parameter or member 'dentry'
> not described in 'ovl_statfs'
> fs/overlayfs/super.c:311: warning: Excess function parameter 'sb'
> description in 'ovl_statfs'
> fs/overlayfs/super.c:357: warning: Function parameter or member 'm' not
> described in 'ovl_show_options'
> fs/overlayfs/super.c:357: warning: Function parameter or member 'dentry'
> not described in 'ovl_show_options'
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied, thanks.

Miklos
