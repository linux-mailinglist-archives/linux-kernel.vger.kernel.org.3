Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615AE4D5C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347178AbiCKH0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242146AbiCKHZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:25:52 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358141B65E9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:24:49 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id y20so449424vsy.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXGaQdBpuvPjjktH43u4Da1nLJOL+0Xh+KFVna4/Bow=;
        b=bzTMnisFFmryCgrj+eTq5YX98qEedUP2VMX0YmA1V5EEenhRgyE4UKuS/+fnJMmp+L
         sXMxwXSwJ7OFKUonSlmoUW6EcmyDQHZi2dKecscK521Z8nvvKS+W6WnLG5cqeIohGl/+
         8FP2ABjuNctSybdVNv+tNxkttPG+dbQUfc+6M+qE4j6FxWoCltHOfgjYB69I8vpL+Ay5
         YvAdyz6kiuCmEwLeixAOIRJATES+Z7bogzJTrqYGw3BVVeQeeII3Ppoz6kHnXxuugLii
         tL+MeJtWqxPg5RWbyLj87UyYUWq3UG+hGoYUkDHSeTYi4bT1X1FC+26feqyUD0j5iGpb
         aw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXGaQdBpuvPjjktH43u4Da1nLJOL+0Xh+KFVna4/Bow=;
        b=5FpiFDhcFrjuNzosShdR5msW/tkmVO9aBa0A8cJUUZlgfsTcwj6f/+Hf8Yat7WLP7v
         ChH2/g1W9h2Fert+qilC2wZsJg9MSBvhS1esofFz9Z+WwSGh+a/w6B+GRMrOtnuhhz6V
         Mi+MEQgsfPJO+bCOHnLNtuiQfwLvXorIvv1RRkwdpVK90ztXhCVwTmicaDpI8xFx0GGY
         fIDyrZwbJFkZyqMDW2voTlzkQqXC1xciePVWa8afxpsbUKN7VMl24zMXs33qUodHhi4X
         yVCz9bwinT90h3NJ5A70e8TCXKxnTNsXVVpQjvOByZrTfYlESWEtzID36Ace4e4gmnWo
         +xWw==
X-Gm-Message-State: AOAM530tkESkH4S9slRkqJ+JSIEquEJvjWVWrRmpnFQfj0bC4FlcaCa6
        JCnMt6bty7pxahrn0eg5HKP4IyxcX/O1brN2PUo=
X-Google-Smtp-Source: ABdhPJx/sJ1EbfPU3xKUnnJUKNIsQJxwWw+03k/VM/J12oLcgnr29Z5Cc8gobJKYBRGrj0FvYnVZX360hDP9htWKLho=
X-Received: by 2002:a67:af05:0:b0:320:bfb5:e63b with SMTP id
 v5-20020a67af05000000b00320bfb5e63bmr4517191vsl.9.1646983488149; Thu, 10 Mar
 2022 23:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20220310055922.459460-1-yusisamerican@gmail.com>
 <3c0422d9-8ce9-64d8-f332-e07bc8e207c4@infradead.org> <CAJoG2+8OcL=5RRptaNMhXkFeDragq46_WpHpuN8XEP+jNbdZ0w@mail.gmail.com>
 <YirxlzkYxl3MIjoR@kroah.com>
In-Reply-To: <YirxlzkYxl3MIjoR@kroah.com>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Thu, 10 Mar 2022 23:24:38 -0800
Message-ID: <CAJoG2+_NN2n64G+ROm5B_c_LGrvRGdU=DE=jk5VVe1T7aKNDEw@mail.gmail.com>
Subject: Re: [PATCH v4] drivers: ddcci: upstream DDCCI driver
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, javier@javigon.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fine

On Thu, Mar 10, 2022 at 10:52 PM gregkh <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 10, 2022 at 05:19:47PM -0800, Yusuf Khan wrote:
> > I (hopefully) fulfilled those requests in my subsequent patch,
> > turns out I forgot to git add some of my changes. I did not
> > remove the unlikely()s  as I think they look good and point
> > to where error checking is that many may miss.
>
> Never use a unlikely() or likely() macro unless you can prove, with a
> benchmark, that it makes the code go faster.  If not, just remove them
> as the compiler and CPU will always do a better job at this (we have
> proof of it in the past.)
>
> thanks,
>
> greg k-h
