Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707FF4B8512
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiBPKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:00:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiBPKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:00:06 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7CE2B623B;
        Wed, 16 Feb 2022 01:59:55 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id bs32so1270272qkb.1;
        Wed, 16 Feb 2022 01:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C76jbT5fLtK7mnPN0788Is6uC9EFS638zMWrNg3x0FI=;
        b=Q52kIAR+jY8bAEZKyyg6SmUHa697hLuCWv4gKQeOjDH6lEf5keypJAgOF2sapK6Uml
         0miGCpNomfcuoFzRM2kWQWQcmpRmvQKz4tNywYN7fWHPK78ektKsoP4FtA33y96CcnOR
         mnYUSgRR65YHIjcCuaKbaasHXnuU6pDCjQkYRQ0evduxJ7MKWClu1ek/o8JNeO4zohcP
         xHuO6Bm5ylLy2ExAWinVckyHrbke9nMhTwXMUP7G6bLWb3Df1n9i/P1kL4e+pZLA5Odm
         jGKiW+Gn/wDMa9kQFKppB0xLDNHeJZkKV7P4r2d9NIGsswFfJDMhmjp1M90QVgnFjn8U
         1wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C76jbT5fLtK7mnPN0788Is6uC9EFS638zMWrNg3x0FI=;
        b=fB1LlB6SIH+qeg3hAmPy9jIV4ZBOfosyY9SxxR+X13uIHVb4vv3dTR5/yNkYpA6rm6
         4ECulLmjx5Bjvkg1Ok5M7+hs6vp3htTst0amflCFXESpWpTnqltmqy3zJGJMlFGERSds
         CmN1LvoeG5f5JCDXe4OoEVMCP1c8ii2wZHpXxV9hgIlHjtkKgsIiM6ebyF8AsVAW92nC
         9JSd+E1z0vo2zBWWtkP4cvYHrj8I0CgbPvwR5w+moh51nIoRuyDWrIio/tZsi68rq9Mv
         djIYSpkfFcCb0+9UNpyfvxB4djc8GoNVdyFQtW0quseLauxNJ+ysNQNRKKRk0ONsezQF
         hYoQ==
X-Gm-Message-State: AOAM531tJTQggBKUzExD/CmrXdelD8oPhE+XmOD3tjdNQamd4IEmBGsZ
        t0n468rbdHPAz1D4dXaZcVSGFy/IN3lIpLK2kRU=
X-Google-Smtp-Source: ABdhPJzs5q5L00qr68Kor/GBTEogted3eS1x7qznJHlftfNjefeKR+AQf/75lvTL2FVUeq59lkQb5xhb5rwjTD4YxoE=
X-Received: by 2002:a37:af45:0:b0:47c:ddbb:b63b with SMTP id
 y66-20020a37af45000000b0047cddbbb63bmr874780qke.42.1645005594050; Wed, 16 Feb
 2022 01:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20220213213935.2c5ef8c2@canb.auug.org.au> <CAOX2RU5NzOK+d-QEMsOiSPX85M2_B44SeJUteZepsyZny7fgnQ@mail.gmail.com>
 <YgngMN+lKaW3fYp5@ripper>
In-Reply-To: <YgngMN+lKaW3fYp5@ripper>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 16 Feb 2022 10:59:43 +0100
Message-ID: <CAOX2RU5dVVb86JPc1pGkF3yDs4QejOd1rguDZz=p6FA3kacN7A@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the qcom tree
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Mon, 14 Feb 2022 at 05:50, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Sun 13 Feb 03:52 PST 2022, Robert Marko wrote:
>
> > On Sun, 13 Feb 2022 at 11:39, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > In commit
> > >
> > >   bf8f5182b8f5 ("clk: qcom: ipq8074: fix PCI-E clock oops")
> > >
> > > Fixes tag
> > >
> > >   Fixes: f0cfcf1a ("clk: qcom: ipq8074: Add missing clocks for pcie")
> > >
> > > has these problem(s):
> > >
> > >   - SHA1 should be at least 12 digits long
> > >     Can be fixed for the future by setting core.abbrev to 12 (or more)
> > >     or (for git v2.11 or later) just making sure it is not set (or set to
> > >     "auto").
> >
> > Hi Stephen,
> >
> > Sorry for the short hash, don't know how this happened.
> > Do you want me to send a v3 with the fixed hash?
> >
>
> No need, I could update the commit as is. But given that I would have to
> rebase 20 other patches I'm hesitant to fix it.

Thanks,

I will make sure not for this not to happen again.

Regards
>
> Given that checkpatch catches this issue in commit references in the
> message and other issues in Fixes I was expecting it to catch this one
> as well... Will make sure to look for this going forward (or perhaps
> figure out how to improve checkpatch...)
>
> Thanks,
> Bjorn
