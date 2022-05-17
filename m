Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731A45296F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiEQBxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiEQBxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:53:41 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A2439174
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:53:40 -0700 (PDT)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6CC1C3FE02
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652752416;
        bh=0IJeGuY5tYKvN9axhAJnVrgVgRACxJYzXE/eYjk+nos=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IpuQr5fTBtNkIoXTS+mr+yt8mixkfmYsXfCzGrGINQ8dnGNf5mWrDgsx7BpApLjLS
         fZQlV6M6PTEgWaTn2IpbqOVGiGqRGwP5RMZLUX0MiJHM0/r3frTfUrsaDDmbNZBOvB
         KRRhLbBY2Ti1QDCLMSzQVNUTEHC/GUB6zP1ZiTfO+W4tTNgfiwnlHvuZTynvA1BXJ8
         NZyOoR61czGm3epwA1jXT7cRtH4Gy29lnuUiDMTO9r+gQs6VJL8E2zalYTH7LAaPWL
         /0caV6ZR8CofHePsB6bx4Pz6NCe+kHQ2ov4hOg+FhOQaFO9U6oPSX6kFpat4ziqjU7
         rUHTGq+ubeldA==
Received: by mail-oi1-f199.google.com with SMTP id w205-20020acaadd6000000b0032637f774d0so6034965oie.20
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IJeGuY5tYKvN9axhAJnVrgVgRACxJYzXE/eYjk+nos=;
        b=ScJHclTJL5hoMES0rPKzYYk+sUBNC2OM57bxu4X3Hr61bgcxndEJdy88lFEbj8tolw
         r+5f8VTC9wdZW2zGAPf8o3EOVTKx1QLFOVPYttWxCBeEifI76eHt4ENrhBL4NERJ+A/w
         uHgcPhtrjZsbuihF03GMdocF7AO7vb9dQVOs0342PCVPNIsbODzme0aK5HN2BzAGkCO4
         hjMA9Z5OLRN2xnWxxRqwhX3Ba4QbeMMI8afqm7f+T0ES5Sy1xBYIv7BsYTl2O/3R0s+D
         Af9l6h9yKSNwnJ7+QWYzYA0LRQyyY0e5dymkJO+M0nT10K1xGLbK2xAzRM/MkL9ovkSh
         kqKA==
X-Gm-Message-State: AOAM532faCyhGuRhpAJzW+/H4ASNzJ4osTK8I6T+gLMM6Yfskh9Om6y/
        EAsrN447637HXtIzQq2txct0nRbWB02y86uhSnrR/LS0WSsmsw4A3Wh589rj87appFaJYY+vnZL
        /c2eQcZIO0tp0TJEEPTGcpp1QD2T0op5nhHfEEOCIn/o7dk8C8KSf4XQy5w==
X-Received: by 2002:a05:6830:33cf:b0:5af:4018:fc2a with SMTP id q15-20020a05683033cf00b005af4018fc2amr7287427ott.161.1652752415162;
        Mon, 16 May 2022 18:53:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQKaMjm+HGo56tEW8iIAzIfXbZpXdSSZ5jTkEIdP2Cq6Z/yGa2ufblWkAi6dIjmMf/A7vt0doEce2wz99pDv4=
X-Received: by 2002:a05:6830:33cf:b0:5af:4018:fc2a with SMTP id
 q15-20020a05683033cf00b005af4018fc2amr7287417ott.161.1652752414886; Mon, 16
 May 2022 18:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220516130047.3887590-1-trix@redhat.com> <YoJ0I/XPoj1B/+mm@dev-arch.thelio-3990X>
 <d34498ad-0230-7c73-8f1f-9ca59fbf930f@redhat.com>
In-Reply-To: <d34498ad-0230-7c73-8f1f-9ca59fbf930f@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 17 May 2022 09:53:23 +0800
Message-ID: <CAAd53p57APcectWW-NN_=HE6JkTQRk717cWNZ5iJcP+MtEYjog@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Set setting_reg2 before use.
To:     Tom Rix <trix@redhat.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, arnd@arndb.de,
        gregkh@linuxfoundation.org, ndesaulniers@google.com,
        ricky_wu@realtek.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 1:06 AM Tom Rix <trix@redhat.com> wrote:
>
>
> On 5/16/22 8:56 AM, Nathan Chancellor wrote:
> > On Mon, May 16, 2022 at 09:00:47AM -0400, Tom Rix wrote:
> >> The clang build fails with
> >> rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> >>          } else if (efuse_valid == 0) {
> >>                     ^~~~~~~~~~~~~~~~
> >>
> >> setting_reg2 is set in this block
> >>    if (efuse_valid == 2 || efuse_valid == 3) {
> >> ..
> >>    } else if (efuse_valid == 0) {
> >>      // default
> >> ..
> >>    }
> >> But efuse_valid can also have a value of 1.
> >> Change the 'else if' to 'else' to make the second block the default.
> >>
> >> Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
> >> Signed-off-by: Tom Rix <trix@redhat.com>
> > I am not sure if this fix is correct from a functional standpoint (i.e.
> > is treating efuse_valid == 1 the same as efuse_valid == 0 correct?) but
> > it is better than not handling this value altogether. For what it's
> > worth:
>
> I looked at how the code used to work, this seemed better than
> initializing to NULL.

Or maybe use a single if block?

u16 setting_reg1 =PCR_SETTING_REG1 , setting_reg2 = PCR_SETTING_REG2;
...
if ((efuse_valid == 2 || efuse_valid == 3) && (valid != 3) {
    setting_reg1 = PCR_SETTING_REG4;
    setting_reg2 = PCR_SETTING_REG5;
}

Kai-Heng

>
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >
> > As a side note, it is unfortunate that this change made it into -next
> > when there was an outstanding report about this warning:
>
>  From the clang side, this is a build break and my static analysis infra
> goes down.
>
> These build breaks seem to happening every week, is there a precommit
> clang gating test that could be done for -next ?
>
> Tom
>
> >
> > https://lore.kernel.org/202205100220.WyAyhKap-lkp@intel.com/
> >
> >> ---
> >>   drivers/misc/cardreader/rts5261.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> >> index 749cc5a46d13..f22634b14dc8 100644
> >> --- a/drivers/misc/cardreader/rts5261.c
> >> +++ b/drivers/misc/cardreader/rts5261.c
> >> @@ -403,7 +403,7 @@ static void rts5261_init_from_hw(struct rtsx_pcr *pcr)
> >>                      setting_reg1 = PCR_SETTING_REG4;
> >>                      setting_reg2 = PCR_SETTING_REG5;
> >>              }
> >> -    } else if (efuse_valid == 0) {
> >> +    } else {
> >>              // default
> >>              setting_reg1 = PCR_SETTING_REG1;
> >>              setting_reg2 = PCR_SETTING_REG2;
> >> --
> >> 2.27.0
> >>
> > Cheers,
> > Nathan
> >
>
