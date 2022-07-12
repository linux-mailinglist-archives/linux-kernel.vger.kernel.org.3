Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA9B571684
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiGLKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiGLKFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:05:16 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F361AAB15;
        Tue, 12 Jul 2022 03:05:15 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h16so4537424ila.2;
        Tue, 12 Jul 2022 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLupDoQBj6uV3nNUJK1hL7CIEfR31No22ly+yjd2Ntc=;
        b=nL77LqPXH1wnE/B4SKmKoOuRCRx+20r3Nmpw60oyF4yuyAk1vkzUgAUTFha8e8kYon
         efZ2nTJFcpLwxd5wy2fTdM0pAvfuLaaEo4IOC7DzPW9ddQvGBhYLnCpTNYGheCF3edW6
         9sA8YoLbLfQwLdxieW7PEXjueZHvJp1A6wfvvyYDVHp2qW+IyF0DYzI12joFZDqVfWS6
         5TuoHemYUq5sdmQPjJ+Ey5/e4YlQRJF4wWd5KkQ4xjOUQe3fjIfuK0VJ6DVa4Z+w5z7X
         qhheVWVH9+zMbgoOk8oHOedlZvmIzBI3ycnmpLyHtDP+Mzg/llKzDV+m5Sj+QEtr7F8W
         nWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLupDoQBj6uV3nNUJK1hL7CIEfR31No22ly+yjd2Ntc=;
        b=LUi7esvVw16RAOGCZd/+v98IUbRhlXnn7VJu0G+Nlsn10bdB5166cuevr4oKRqX2EY
         Tod/xf37f0YLSb9F2M/wKEYxgmsu0xofvyITq/dqwrVHYvWLbreRcwNpw1qlnrHXKefJ
         54eFzRUqi3AJX40uYq7sxlzINkzGUklv9UqDYjd7A2mwI4hxRgnq3gbalt1lOQ87PGE2
         L3KdJp+tGQw57VR+OGh6kLyRhf9NGo5Za9/ThUVhUOBInpP8WBySInWLQxuEyF0Y1UA4
         /mxW09LP+IiOH4h7oNqvx9Y9sKANQSkJCzXcf/EIovEH1FS90RN/fiORxgqE88Nwxylw
         9jWQ==
X-Gm-Message-State: AJIora8RyHeR7nR2fAPVnW8j/tHNfP8RBqbL7Xlk+2T02oUgJbJBU4Ah
        N+80u6XIPRLsj+pWX4DAz7m5MN3XCTkC4IUybz0=
X-Google-Smtp-Source: AGRyM1u5g7vHTNMurvnJt6JfDkx2cQly9AevwaMaG1SU31ZyXON2IFiIlzx41RFx58rgAIwhnEOhfH3ZVKivq1Vdorc=
X-Received: by 2002:a05:6e02:1c2c:b0:2dc:77e6:ae46 with SMTP id
 m12-20020a056e021c2c00b002dc77e6ae46mr5573082ilh.179.1657620314894; Tue, 12
 Jul 2022 03:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220712173956.540d3baa@canb.auug.org.au>
In-Reply-To: <20220712173956.540d3baa@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 12 Jul 2022 12:05:03 +0200
Message-ID: <CANiq72n921-aH+EE4rcykfweNYRDEvPUn6n_JZ=hNTPK9Eyvcg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the block and
 kbuild trees
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

Hi Stephen,

On Tue, Jul 12, 2022 at 9:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the rust tree got a conflict in:
>
>   Makefile

The resolution looks OK to me. Thank you!

The independent-from-C Rust `opt-level` support is going away on our
side too, so this diff will get smaller too.

Cheers,
Miguel
