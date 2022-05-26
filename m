Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE47553514B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiEZPSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiEZPSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:18:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C31364D1B;
        Thu, 26 May 2022 08:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0C2EB82106;
        Thu, 26 May 2022 15:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C26C385A9;
        Thu, 26 May 2022 15:18:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZvbJDNPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653578315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+XsXmOkFlBmtR7WrdeeAxLJEtfkSiKSScG5xMesbYxA=;
        b=ZvbJDNPgX409NDZc4OHVwjJ8j9BHXozlqhNrLKataO+Ga1kPTyGZ7oQ+nE7M7d3XE/HZsz
        kVMH0Ut7B7MwuzwWF9LXpJBp+Oo/+i1hQPswjnFuwHWXMxzKzKNSJRE+BBQ/cRhSFYW8oD
        2y3J2UKuAcZnHyd3CDcaSiOCPRXgAIk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5c7c87f8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 26 May 2022 15:18:35 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3003cb4e064so18906467b3.3;
        Thu, 26 May 2022 08:18:35 -0700 (PDT)
X-Gm-Message-State: AOAM530I/QaorHRCCD4HI6GZck2P5riPzTTClDho370QwoOmcRcGwgui
        uvos5TA0MrcVIDr2lfxegcgizgn797cHfa51lVw=
X-Google-Smtp-Source: ABdhPJyvt/oh+VB4a3WnFJ2O6HYT1OdHUA68YVAfkvEy6YwxmRCAO7y2zsTtBK/UpXvkVSBCt3lV0V5TtlBQf61/0gc=
X-Received: by 2002:a0d:d7d2:0:b0:301:ed26:c583 with SMTP id
 z201-20020a0dd7d2000000b00301ed26c583mr3337489ywd.499.1653578314889; Thu, 26
 May 2022 08:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <16535762872752@kroah.com> <Yo+YFzs5qMqDFmwO@kroah.com>
In-Reply-To: <Yo+YFzs5qMqDFmwO@kroah.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 26 May 2022 17:18:24 +0200
X-Gmail-Original-Message-ID: <CAHmME9oMcHbvNtTvKO5VRc3pG61wthstYgs5+FBCcS+wdAQ5sA@mail.gmail.com>
Message-ID: <CAHmME9oMcHbvNtTvKO5VRc3pG61wthstYgs5+FBCcS+wdAQ5sA@mail.gmail.com>
Subject: Re: Patch "Subject:random" has been added to the 5.17-stable tree
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, May 26, 2022 at 5:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> Something went wrong here with your scripts?
>
> the subject got confused.

You sure it's not your scripts? Looks fine here:

https://git.zx2c4.com/linux-rng/commit/?h=linux-5.10.y&id=7ba116cba5eb8dbb5aa6224a9d14e0349f01dc9c
https://git.zx2c4.com/linux-rng/commit/?h=linux-5.15.y&id=f5a0eab9988d84cd43fa1ea6606e0764a140b36c
https://git.zx2c4.com/linux-rng/commit/?h=linux-5.17.y&id=4f5bf360ac054410daa468110ff512b8ed8f62e9

Jason
