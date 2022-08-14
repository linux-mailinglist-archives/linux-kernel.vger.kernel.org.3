Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8A759260B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbiHNSvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNSvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:51:47 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B865B4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 11:51:46 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cr9so4242874qtb.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=e9VYnJpbj1NCWPv7EEYV3p5rCWOY6BC7xPjoWQJp86k=;
        b=n1Cdi/PsnLng2yBPej1jpfcM6wk4dX4YEUboQcUBRXL2/vvNVbzkA4TyoLMrgC/eVn
         VuQyTizqCJRIOX9cxHLwdeaOcmem0uTQDvmvM2ZFzD6pP9kMuHmZvBGzey5Q2iO00drV
         uKrPBTlkaBk7qGaF1dBKnLf51GD4DTPBMkLRAimtFPzOT9J6BjokCdGDpFxBCpOE8xUK
         Wb3okSC43xgfoF+40MFKRkxv2cnDZzrucJ58e5C2l0zyT7LnPz62ZmHR+l3uippr46Zc
         opNm9XGE+z0D87wiWFoP6mJlP7exfjHqdBej/b/9mcbmr2IrF9cnTA7WyLqhG95FgZOr
         6zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=e9VYnJpbj1NCWPv7EEYV3p5rCWOY6BC7xPjoWQJp86k=;
        b=wFH9UOl0j7HVubheLwWNN7S5g2B55nt+3CZvwwNs8dDqTlGfU1P7NrechLYmi8RhKy
         yINJL9rnLJcRb460aopXYrnB4inpePvycGQr/JG37j48Svg4CsSjC0jD4JeSS5Ykm9BM
         0PvNUjv1BXGEh7UGnvSGVAR4JebMTJKArYzNLacCHpgeoJGiurb5SsXYD/wPBJNd9/xm
         9Lo/q+yetUkJtlq0UfG02dGVX/4AdSffVgKaODlT0E1gMBznOgJwuiCtSONvG/QKQZBj
         fOWk3fAW9BH9f4OJgzNp5hmJn01JDGrPuFJaqGvnMSnVQCvAh2xaiY9VN6JZEXbrS9XA
         d9tg==
X-Gm-Message-State: ACgBeo3zJrICRn7Ujz3WeLRqtjsXlcPvI8X8dQFiEqcuK0W3b1k1RvyT
        +1FzghEzsQsfSJXB9iTA58QPsK86G0C29ngfiH4=
X-Google-Smtp-Source: AA6agR65Hk5i7cAYwiZ/PEojJaVaXtFr9jnqVZqC0J4pSftyCN8+3qH8S3yZAqy9H0i5xowSX2urkaUxUmIvNRKUUw8=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr11274967qta.429.1660503105450; Sun, 14
 Aug 2022 11:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220711044711.466822-1-yury.norov@gmail.com> <20220711044711.466822-6-yury.norov@gmail.com>
 <20220729034638.GA2276915@roeck-us.net> <20220813131523.GA2787704@roeck-us.net>
 <CAAH8bW8n+6-4fGYp-g_vXe3XKwC5AV_hCCyzj=h2Wx1XFBK5dQ@mail.gmail.com> <CAHp75VemqDc3E88k45bMiaLuBpGmgh81C+pGLD1Ey+V1=AS2cA@mail.gmail.com>
In-Reply-To: <CAHp75VemqDc3E88k45bMiaLuBpGmgh81C+pGLD1Ey+V1=AS2cA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Aug 2022 21:51:09 +0300
Message-ID: <CAHp75Vd1F9fUNE5X=XpOo-4hqw9g+Lcp3s22kkfW9+K3_dDtHg@mail.gmail.com>
Subject: Re: [PATCH 5/5] lib/nodemask: inline next_node_in() and node_random()
To:     Yury Norov <yury.norov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Sun, Aug 14, 2022 at 9:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Aug 13, 2022 at 4:55 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> > I submitted the patch:
> > https://www.spinics.net/lists/kernel/msg4468633.html
>
>
> Just side note: Use lore.kernel.org for reference to the submissions
> in the past.

Perhaps Linus can take it directly if it's not in Andrew's Git tree yet.

https://lore.kernel.org/lkml/20220812053425.2499799-1-yury.norov@gmail.com/

-- 
With Best Regards,
Andy Shevchenko
