Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404DF523542
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbiEKOTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiEKOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:19:33 -0400
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1194566221
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:19:30 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Kyxqh0RDQzMqHtD;
        Wed, 11 May 2022 16:19:28 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Kyxqd6C0Lzlj4cK;
        Wed, 11 May 2022 16:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1652278768;
        bh=/n5oEC4CvxILBZQp6ChxximF4mWD7I5QTdFgyCOlYJY=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=h36XxvDcJBu2sTf7wBmxnAMEehwmVxMmhHKFTptP/LIZsqf5FuDGv21jJRbdukTH1
         UjD0Vu6rGibTzYk/3q+3g9c8NVI/S6oNeLJZ08bF9Ks7g+L2BRuDkE9Yk/0kSh2ZCE
         igV3+abVFVmazKYhYyCl8ju9vWlU5ztV3HAtmGLk=
Message-ID: <152da06a-330d-3125-6f41-262e0751f41b@digikod.net>
Date:   Wed, 11 May 2022 16:19:10 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220506160106.522341-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v2 0/5] Fix clang-format configuration according to
 checkpatch.pl
In-Reply-To: <20220506160106.522341-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel, what do you think about this series? Do you plan to take it for 
the next merge window? FYI, I plan to use it for Landlock [1] and send 
it for the next merge window. Could you publish your pending 
clang-format changes so that I can make sure everything is OK?

[1] https://lore.kernel.org/r/20220506160513.523257-1-mic@digikod.net

On 06/05/2022 18:01, Mickaël Salaün wrote:
> Hi,
> 
> This series brings some improvements to the clang-format configuration
> to make it compatible with the checkpatch.pl rules:
> https://lore.kernel.org/r/8b6b252b-47a6-9d52-f0bd-10d3bc4ad244@digikod.net
> 
> I also found that the for_each issue has already been talk about here:
> https://lore.kernel.org/lkml/CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com/
> 
> I use these changes for Landlock.
> 
> This is based on v5.18-rc5.
> 
> Previous version:
> https://lore.kernel.org/r/20220412153906.428179-1-mic@digikod.net
> 
> Regards,
> 
> Mickaël Salaün (5):
>    clang-format: Update and extend the for_each list with tools/
>    clang-format: Update to clang-format >= 6
>    clang-format: Fix goto labels indentation
>    clang-format: Fix empty curly braces
>    clang-format: Fix space after for_each macros
> 
>   .clang-format | 216 +++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 169 insertions(+), 47 deletions(-)
> 
> 
> base-commit: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a
