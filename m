Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181B35252C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356584AbiELQjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356573AbiELQjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:39:20 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E9A25BA63;
        Thu, 12 May 2022 09:39:19 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e3so5958658ios.6;
        Thu, 12 May 2022 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUUUj1y74Ts6z0ggwPE80glXrfxyzYtZy0EaDwtm30M=;
        b=KNwGo5WQC+QM23k6KpFzT9+xdkeCcvMAXvQ4j/1WaWYrh6FJcUGQVrDucdM5MJtpQl
         n13K9+H3pVcpNceuMg8vT/r9Q7mXXATIrab2YRDcg/myXBpPmobYSMlXRZ9259/iqG8L
         FiQp8uqXntvCbRU4Qi/n2A/bqcXHFvXw9L3EkvVhIhwi24qxOl9rUctAZkT7AZnbIw8u
         m92g1uAeDkJZ7W7kUhPHfyJSa6GM2r7WXypBJuqf3VnCUcHW0ij1kjgLhnkUHQy1Kgja
         hJx8Ofn8+YGHAzDMCKh5sL6o7p46Os0w9oo4hLsFAwE97mh21cP7s7lmQBQsVs0mWMTb
         faNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUUUj1y74Ts6z0ggwPE80glXrfxyzYtZy0EaDwtm30M=;
        b=UYe0Ph3kyGmiuRTTN4Mg4f775hGdCwgOQAl2np/2jixs/R4DNehUb4AQpqnSVUDyuG
         P1Ve6XXO/HbqAOXMHCVW718Zrltpc9bxCteKP6xqWHUxJBUru8Um9y0RBLFHHF+lt+TL
         Gboqb0kpgQBln4RLTbj+KvNfbsb0mCM0qpJv5yID6VKz0zDRnLZK08Q+NwZZy/fS8c7N
         4/NxMfdg2cJ4gR0DhkbS1G2vNKybIYDqKdg5UjG3qgLDbwaScUeYbGewXUCoJOpgwOV9
         h2K9ULZOkArR11t0zGpIkXcl0gwk7h4zeknMK/YPxbncfpS0q5nS7I8Q8f2O/9d3uqIC
         VEbw==
X-Gm-Message-State: AOAM533Z4pED1q3YyUknUsNK0SfCWJbDcfJvsUv/BpwT9+dLCT5/6buf
        JydtATvF9vST8uUbsjhNfpVFYu/Wdwu2h6C4HPQ=
X-Google-Smtp-Source: ABdhPJyWY+O694Z/yQU4QnYgU/qjwIAD3uuAlcyt4rA9PLWbtlbtx9UehZcVQGf1ZYwCL+PWL1eIeUN1cxOCxD0L+44=
X-Received: by 2002:a05:6638:d56:b0:32b:62e4:39be with SMTP id
 d22-20020a0566380d5600b0032b62e439bemr441230jak.308.1652373559064; Thu, 12
 May 2022 09:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220510172530.29704-1-ojeda@kernel.org> <87r14y4v9c.fsf@meer.lwn.net>
In-Reply-To: <87r14y4v9c.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 12 May 2022 18:39:07 +0200
Message-ID: <CANiq72nbaSxBwMegiPZwDg2MLW_SA46EV6g11C6xQyYSnbM8dw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] docs: move Linux logo into a new `images` folder
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Garrett LeSage <garrett@lesage.us>,
        IFo Hancroft <contact@ifohancroft.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, May 12, 2022 at 5:37 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> This will break scripts/spdxcheck-test.sh - which somebody might
> actually try to run one of these years.  So this patch really needs to
> update that script to follow the move.

Ah, yes, my bad, will fix.

> As far as I can tell, that's the only reference to logo.gif in the
> entire tree.  It makes me wonder if we need it at all.  Digging through
> the history suggests it was added in 2.1.15, but never really used for
> anything.  It's only role would appear to be to serve as testing
> material for the SPDX checker..:)

If you mean removing the GIF one to replace it with the vector one, I
can send it that way too.

If you mean removing the logo from the tree, then I think it would be
useful to have it available in some other stable URL (so that people
can still fetch it for other purposes), e.g. at kernel.org (not sure
if there is such a place; in both kernel.org and LF's pages there is
just a mention). One potential use case for the logo is to use it
instead of the Rust logo in the Rust docs if the Rust support gets
merged (i.e. instead of the custom one).

At least I hope the Tasmanian devil got a bit of help thanks to the logo! :)

Cheers,
Miguel
