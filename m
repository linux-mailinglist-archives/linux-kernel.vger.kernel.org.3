Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B734DE10C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiCRS3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbiCRS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:29:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211AEF3FB5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:27:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so9015063pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WHZT3KUAUavQ2A5bNmWb6pugFG7NKtgrHEyxCZZQ8c=;
        b=qP+/lGqOusJSmXBH2pFdYcQR7H5jOG0HFGpltgeJyfNI0jM8PAdfiPbKr/9Ld1gKAK
         h0SsmaOTqiUFmSARNB6ofnZ8v8LZ5K9t1/GhJxxR0pwRZlv8xG3QUxx2brTiHvR6dOhh
         r6DaxzpPjmXWbvtHvaoqrkG1f2T8as7yPVtXwjSRKFf6O3OWJS8YDPEaWGGYPJR0whn6
         lSPsfUmyo/Kr26jfsR7/X/efuZfu1ulZaG/9FrbjAokxmMxWMRAZdPbxizbtqeyvXjNA
         3h8Eeyv7dGnPhAeCHPZXy29FhhsOx4dXzav2mYe9nXl6jKLdqGp7uW1n5xbXOP9ACfug
         pHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WHZT3KUAUavQ2A5bNmWb6pugFG7NKtgrHEyxCZZQ8c=;
        b=7kRfe+TG+txEP96ltWl1EVO1j2y4rw0CDBXNoYhT5iNhlGGzNW4rTTym1NTariTEjk
         zeQryeEW22OrtuFHOaKjMxuiRrHooKEx1dnuv0bTJHZa32FZwaKjzNa9+CXRcqpQEV1q
         aLAKeXatdb1Wi9ZMGHNT16XNPpSnyykKY+c3mzBa2qZCguIvupOJjaYwzBQn51tXs+qT
         uF2GrOzly7RHTjS2N7mGHw/PnS8dQWd9u4KeZ/mn0MyiqgXvM0iguEq1ESBe//tOkN6S
         GQd3fZe/vJTBkCNutpYlmOcLsm9jraRmV6Fbmphb7gpQ/CgHNhn8vN3vskOxoeoOHURm
         BJUQ==
X-Gm-Message-State: AOAM531w9hGppaQQXrTB6yw6NrvXxDSy4w3eCnqLOCi6+NHjDKpRerRN
        b8Nq5ATqEzCatEBTFl8JYeRUz6BVuqwhg7LczTR6
X-Google-Smtp-Source: ABdhPJz8GTTEdQwG1r8ZON2uALVE+nUmtz2skm8YDqsbiVuGxiBsbB3me/uylxMnq3s5A9QqbXTG8Sg7u7HHajGT1aM=
X-Received: by 2002:a17:90a:c252:b0:1bc:52a8:cac8 with SMTP id
 d18-20020a17090ac25200b001bc52a8cac8mr22917783pjx.61.1647628067346; Fri, 18
 Mar 2022 11:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213118.2352683-1-morbo@google.com> <YjTJRqlFOsXz7Ss7@dev-arch.thelio-3990X>
In-Reply-To: <YjTJRqlFOsXz7Ss7@dev-arch.thelio-3990X>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 18 Mar 2022 11:27:36 -0700
Message-ID: <CAGG=3QUXDj1Bp1kDY2F0dqw=6f8iRqE4nRDyticUrWx-nTb-=A@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: smem: use correct format characters
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Mar 16, 2022 at 02:31:18PM -0700, Bill Wendling wrote:
> > When compiling with -Wformat, clang emits the following warnings:
> >
> > drivers/soc/qcom/smem.c:847:41: warning: format specifies type 'unsigned
> > short' but the argument has type 'unsigned int' [-Wformat]
> >                         dev_err(smem->dev, "bad host %hu\n", remote_host);
> >                                                      ~~~     ^~~~~~~~~~~
> >                                                      %u
> > ./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
> >         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
> >                                                                ~~~     ^~~~~~~~~~~
> > ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
> >                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
> >                              ~~~    ^~~~~~~~~~~
> > drivers/soc/qcom/smem.c:852:47: warning: format specifies type 'unsigned
> > short' but the argument has type 'unsigned int' [-Wformat]
> >                         dev_err(smem->dev, "duplicate host %hu\n", remote_host);
> >                                                            ~~~     ^~~~~~~~~~~
> >                                                            %u
> > ./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
> >         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
> >                                                                ~~~     ^~~~~~~~~~~
> > ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
> >                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
> >                              ~~~    ^~~~~~~~~~~
> >
> > The types of these arguments are unconditionally defined, so this patch
> > updates the format character to the correct ones for ints and unsigned
> > ints.
>
> Right. Alternatively, remote_host could be turned into a u16 to match
> host0 and host1, as those are the only values that will ever be assigned
> to it, which should have been done in commit 13a920ae7898 ("soc: qcom:
> smem: a few last cleanups") to avoid introducing this warning in the
> first place.
>
I'll be happy to redo the patch if the maintainers wish. :-)

> Probably does not matter though, unless the maintainers feel that is a
> better fix.
>
> > Link: ClangBuiltLinux/linux#378
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
>
> as discussed on other patches :)
>
Thanks! Copy-and-paste strikes again...

-bw

> > Signed-off-by: Bill Wendling <morbo@google.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >  drivers/soc/qcom/smem.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> > index e2057d8f1eff..a98b5f395d15 100644
> > --- a/drivers/soc/qcom/smem.c
> > +++ b/drivers/soc/qcom/smem.c
> > @@ -844,12 +844,12 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
> >                       continue;
> >
> >               if (remote_host >= SMEM_HOST_COUNT) {
> > -                     dev_err(smem->dev, "bad host %hu\n", remote_host);
> > +                     dev_err(smem->dev, "bad host %u\n", remote_host);
> >                       return -EINVAL;
> >               }
> >
> >               if (smem->partitions[remote_host]) {
> > -                     dev_err(smem->dev, "duplicate host %hu\n", remote_host);
> > +                     dev_err(smem->dev, "duplicate host %u\n", remote_host);
> >                       return -EINVAL;
> >               }
> >
> > --
> > 2.35.1.723.g4982287a31-goog
> >
> >
