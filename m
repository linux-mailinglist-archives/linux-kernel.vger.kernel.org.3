Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9DE573499
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiGMKuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiGMKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:50:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BFAF54D1;
        Wed, 13 Jul 2022 03:50:16 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y3so10459706iof.4;
        Wed, 13 Jul 2022 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RqjFJExuIYZwBX8Yxs9/9nbKJpcdKItijbRYCGkX2s=;
        b=dnoDadG8MXcw9eHxsc3hJ9Qg7TVGOlZpaqIGW7EjMfC5YAySdk8Sfsy+BCTZvZfHZF
         6F5R3PUs6xVBMX8U4fOF+ehi7Oa0jipiRTmN4z2NJdOM0S6oEt0QJLGbKF9hkzdm1RTi
         Jtnl9M19+rpFpUB+7C6VN8qgoKXjP/whBMnjyeMZSVhCNNxv2aTRfAfS38W/eiQ8HF/9
         82/mvP1xm5qOgigqfCQDtyQnUAyh1ErBP8A4lBYeqR3nwtYEubEYIuukvkjnMOw+r51p
         8A+iV6isn/7vbJzCkCcB2w33+5OX+ZHgphMXBnEnsZn9M4Li6b8YgmNMwu6fplvljF8j
         lu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RqjFJExuIYZwBX8Yxs9/9nbKJpcdKItijbRYCGkX2s=;
        b=npP6UU2jgwGqPh/vIyeAkUTJNjmB4zKwkNf2nei/qfxzCRw0lQLYOkxPq02NUi9vwu
         vbmHy+rLqEHc1DgZL4y7LbziCSaOFh2TyAdbagdjUGLwbcRdLxUw0+d4toT5Pl5Hkc3k
         FCwp1uMhYJgaVw/8vmMjwDMzer8j9oUunAN9axlMqMtv4R7Y+tjb0rfB7zTGR+jxMjo+
         szZM52DR8rGr47KKlALk/oVT881aT7c03nNQPj82+8r2cAPh4wJU53uGHabGeSjt3kn0
         eCwkyy5knucTgJibCiOipXwObItsYhCqKSNjJo+8ccFrCAupTA2pYKVNOEUDowgM2IIp
         NmvQ==
X-Gm-Message-State: AJIora+DvrOaZmjsripjbWC57oPplBRHjoMRC7eBwC3t7cp7nyi5xrZd
        SWqLedL6mjh4uozG2dIeQQfRHr5yNKhTYytUI1c=
X-Google-Smtp-Source: AGRyM1sF37Py8y1nJDd5RhUQ4GVwZ7NBf4NQmFJl+cV2BICHgfELgLuTa4XQ32p3GSml8jKytJUg0LflnFPRWfpBWM4=
X-Received: by 2002:a05:6638:25d3:b0:33f:3c9b:24fb with SMTP id
 u19-20020a05663825d300b0033f3c9b24fbmr1546316jat.308.1657709416265; Wed, 13
 Jul 2022 03:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220713203409.559c5464@canb.auug.org.au>
In-Reply-To: <20220713203409.559c5464@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 13 Jul 2022 12:50:05 +0200
Message-ID: <CANiq72kGpadW4o8QPc9khGiGmJgirT6BgzTKoF=px9YQQN-ojw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Borislav Petkov <bp@suse.de>, Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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

On Wed, Jul 13, 2022 at 12:34 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the rust tree got a conflict in:
>
>   arch/x86/Makefile

Thank you, looks good to me.

Cheers,
Miguel
