Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761B454551B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbiFITlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiFITlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:41:37 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E34C2AE16;
        Thu,  9 Jun 2022 12:41:36 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r3so19502566ilt.8;
        Thu, 09 Jun 2022 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=71iYptaNG07P3/tG5EFj3K6ZS83KYPVTGHrVS45OcC4=;
        b=GuQsZ7dvXODnYAR/bmBMt8/tZNxCdof97wut3zR7nPYHowAPDcqJOsnjwGrpNwEn7d
         MXVClq5HHTZz4BmAfiGCLNHhjR0XLk2YRteJQprCni8NiibClLSe2O+vhmgvZQozOaEE
         9L35Rs3PAciO6AVy1cz+z3Zo42qAY5/Cjem9f5YFFayqBBoA+865LKyXVEds4nLZGWbw
         Zp8QaIVw9dtdAQXPCZ/ZSxXf62nH0V7tmWPwMtHggcvnbMVoxPx5J/5SUSza8M6/dyl+
         DMk10ULjBSQXQdC7/m8I9Fpr2gTnj+TXNT2/OvJKJuS/PSgHlgE+hwFRkq/4yw8ihkSY
         atYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=71iYptaNG07P3/tG5EFj3K6ZS83KYPVTGHrVS45OcC4=;
        b=tK8faTKIhOhGjCPGwfPAAfaq4EaebcVOfp1LsBTOr//kLnwrzlQhDEwx6n+F3WQZtQ
         hYbX/x9P9xVNRv1QIOXD2l/KDjjmAG69sNfTuqIx9tkKDD7lMEt5wXq8ixVhdi1fQsdz
         /ZR6RWZ/nTb/eqL1u5ZzTi2qQ1oO5KqKF9MpY/3tSMHZukugTpL7+lV11FmdxB2yEjJi
         bbZ58MJGQDjBXGL4Xpmu4Gs/GEAT6VZhIrP3DBCd4g0m9RGkY4+V1klUcZw73zTisHz+
         WQ54ibPfb5wasHhgr1O7NOTDhelcB6kMxNLFkSWbuFlc6rcPL1cBbJEqjjNKTW8T13yM
         rztA==
X-Gm-Message-State: AOAM532tx8EvUjSVqeugy4Usmg9X2OALQ0pZTEmAA+JjOZqbaHwPVBJ7
        GP5HUzvyNaPE8oOaeh6wacvhuvAJ+EevBmk8kNI=
X-Google-Smtp-Source: ABdhPJxvWX610D95EXqepdWY33Gdrfy6HLe9BtybsWcWQ8xt3jVG0cSU+jSbbH4K2Av8MS9p2dA5TH9aDLdtgCQXYRY=
X-Received: by 2002:a05:6e02:16ce:b0:2d3:edec:17a5 with SMTP id
 14-20020a056e0216ce00b002d3edec17a5mr21537349ilx.4.1654803695998; Thu, 09 Jun
 2022 12:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
 <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
 <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
 <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
 <CA+icZUUma1B8KFWF-ed9sjXH4QpCRZ+B2pON3uAFkTUs77tMzw@mail.gmail.com>
 <20220609192308.GB10732@1wt.eu> <CAHk-=wimC_B+nCJrXwuvWULz6ycFFmRMT1Uc+PeM5wJdma_VFw@mail.gmail.com>
 <20220609193238.GD10732@1wt.eu> <CAHk-=wg8t3S3kWjzTywO5RTv4QrTSYYapEw10kFgD-dRLt08ug@mail.gmail.com>
In-Reply-To: <CAHk-=wg8t3S3kWjzTywO5RTv4QrTSYYapEw10kFgD-dRLt08ug@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 9 Jun 2022 21:41:00 +0200
Message-ID: <CA+icZUUo1PYQ6EjwsK=meBrXnxyxrC_PtY2qe4L3BM2MdO6=Gg@mail.gmail.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
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

On Thu, Jun 9, 2022 at 9:34 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jun 9, 2022 at 12:32 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > Finally we did better and disabled engines completely!
>
> Some day that fix will make it to me, and I can remove that ugly pragma.
>

For the part scripts/sign-file.c - you looked at...?

https://lore.kernel.org/lkml/20220518215129.264872-1-keescook@chromium.org/

-Sedat-
