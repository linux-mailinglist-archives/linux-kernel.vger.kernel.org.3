Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A365C4E2C22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350138AbiCUP0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350144AbiCUPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:25:59 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B2BC1CA1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:24:33 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s207so16516960oie.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8vnMa7QJYto3rUp2CNI3IroLa5v/hp5jnq+SU6YeAQo=;
        b=oBP78Y9N08jETzPolQznEBXq3Uxd/XEb+yye2TG3+vbyfT33AK6uFhZBpLcMNe16q+
         GglCnu2CKG73eZYghuFy0so04d+mdzcjU4Kv7QkEYidzH2H96h1AqO0/PuZcGuO9JgCG
         MVd1c1MtN3Iv0PTPLiV04LcCTyMka/zZ5EpJiiYj3z5I1gjmK12qqV2XMduawUMO1aD5
         E9gGv/7O75vqxHKpn8fCSuzHGwi4kEL6wFPLCo9m8Qmd1HbJNPvFV2qZVJhc+F3HvV/W
         JSHonH18vIa6TjPsEEedwXC0LWVYt7ujBKv2NH3EiZmk3zXqoxznTth8WWXqk5IVrOCU
         NQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8vnMa7QJYto3rUp2CNI3IroLa5v/hp5jnq+SU6YeAQo=;
        b=SE5yhh2YdD9OUisFCtWz+V+mz+CYVht0f9aC7o99miyeOVT7N0mbPKAKQ/5Tz6jzSd
         hbC5ct9Vreoe8LYeBmlOd85q699pousHtNa9VOhvfq0XqXjQHB4E3eZ9qUo1qf7qISER
         SIzBpCCrH1HK6Md1S2J03yjIJHnpcpxnV8nqyhyLJCpGcHgwssRXr/7GpuWsMTAMWBt/
         2oIjNqU2vUaXkgVOBgBCF3LyAQa2J8CFuK+HkPAhL8TKpqzkCRlrM/xmQRCH+D8JczZ1
         fRdI8dgXI/VqIPJv4V2aFoPsRMtbV/eZ8SBQE4uD0lviLqsyHoOarxSg2bWyT1ItQSgK
         mQ+A==
X-Gm-Message-State: AOAM533sotkGy4qiooT9A83+JScXgr0fD7qdGeHfxNWYl1wDwU5/Q6XJ
        tNwpma2xEDED/n+LbG2K/exPig==
X-Google-Smtp-Source: ABdhPJxC6uT/rBzoCI8ifUy4cm0zSLKXkk2t+HK66PziQB2HByEqlpYQCCLQuHduP3ICCzWspKkvIA==
X-Received: by 2002:a05:6808:3db:b0:2ec:cfe1:dfa0 with SMTP id o27-20020a05680803db00b002eccfe1dfa0mr13048421oie.127.1647876272900;
        Mon, 21 Mar 2022 08:24:32 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id v8-20020a05683018c800b005cb39fc3e15sm5544170ote.13.2022.03.21.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:24:31 -0700 (PDT)
Date:   Mon, 21 Mar 2022 10:24:30 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] soc: qcom: smem: use correct format characters
Message-ID: <YjiYrj5euvidRKHM@builder.lan>
References: <20220316213118.2352683-1-morbo@google.com>
 <YjTJRqlFOsXz7Ss7@dev-arch.thelio-3990X>
 <CAGG=3QUXDj1Bp1kDY2F0dqw=6f8iRqE4nRDyticUrWx-nTb-=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QUXDj1Bp1kDY2F0dqw=6f8iRqE4nRDyticUrWx-nTb-=A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Mar 13:27 CDT 2022, Bill Wendling wrote:

> On Fri, Mar 18, 2022 at 11:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Wed, Mar 16, 2022 at 02:31:18PM -0700, Bill Wendling wrote:
> > > When compiling with -Wformat, clang emits the following warnings:
> > >
> > > drivers/soc/qcom/smem.c:847:41: warning: format specifies type 'unsigned
> > > short' but the argument has type 'unsigned int' [-Wformat]
> > >                         dev_err(smem->dev, "bad host %hu\n", remote_host);
> > >                                                      ~~~     ^~~~~~~~~~~
> > >                                                      %u
> > > ./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
> > >         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >                                                                ~~~     ^~~~~~~~~~~
> > > ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
> > >                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
> > >                              ~~~    ^~~~~~~~~~~
> > > drivers/soc/qcom/smem.c:852:47: warning: format specifies type 'unsigned
> > > short' but the argument has type 'unsigned int' [-Wformat]
> > >                         dev_err(smem->dev, "duplicate host %hu\n", remote_host);
> > >                                                            ~~~     ^~~~~~~~~~~
> > >                                                            %u
> > > ./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
> > >         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >                                                                ~~~     ^~~~~~~~~~~
> > > ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
> > >                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
> > >                              ~~~    ^~~~~~~~~~~
> > >
> > > The types of these arguments are unconditionally defined, so this patch
> > > updates the format character to the correct ones for ints and unsigned
> > > ints.
> >
> > Right. Alternatively, remote_host could be turned into a u16 to match
> > host0 and host1, as those are the only values that will ever be assigned
> > to it, which should have been done in commit 13a920ae7898 ("soc: qcom:
> > smem: a few last cleanups") to avoid introducing this warning in the
> > first place.
> >
> I'll be happy to redo the patch if the maintainers wish. :-)
> 

Forgive me, but I think that not mixing the unsigned int and u16 would
look better. So if you're willing to respin this to change the type of
remote_host, I'd be happy to merge that.

Thanks,
Bjorn

> > Probably does not matter though, unless the maintainers feel that is a
> > better fix.
> >
> > > Link: ClangBuiltLinux/linux#378
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/378
> >
> > as discussed on other patches :)
> >
> Thanks! Copy-and-paste strikes again...
> 
> -bw
> 
> > > Signed-off-by: Bill Wendling <morbo@google.com>
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >
> > > ---
> > >  drivers/soc/qcom/smem.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> > > index e2057d8f1eff..a98b5f395d15 100644
> > > --- a/drivers/soc/qcom/smem.c
> > > +++ b/drivers/soc/qcom/smem.c
> > > @@ -844,12 +844,12 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
> > >                       continue;
> > >
> > >               if (remote_host >= SMEM_HOST_COUNT) {
> > > -                     dev_err(smem->dev, "bad host %hu\n", remote_host);
> > > +                     dev_err(smem->dev, "bad host %u\n", remote_host);
> > >                       return -EINVAL;
> > >               }
> > >
> > >               if (smem->partitions[remote_host]) {
> > > -                     dev_err(smem->dev, "duplicate host %hu\n", remote_host);
> > > +                     dev_err(smem->dev, "duplicate host %u\n", remote_host);
> > >                       return -EINVAL;
> > >               }
> > >
> > > --
> > > 2.35.1.723.g4982287a31-goog
> > >
> > >
