Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905F14D9E31
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349486AbiCOO4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349485AbiCOO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:56:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA98A55BC3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:55:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t5so20100258pfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IT33os/gyb9Nj6BK4xBMhU9JHD8wbptBn+Fc9O72IfI=;
        b=WDkdh6/uuZbR03IvsRgdosgxWLPfMuOGlI9Vd0GA+e9SR6lM0095MrEXhQ2dNddQH7
         wXeWCs4KYAhbPFE6aXXfzwJSq9fCy8f1Um98oYu1ESDfy+d67egbllH7+1DX7I1COYjU
         nj54/h23VZRdwYMHUuRHAp717T3Oa5opsdJibfWK92s1djCvjgGGNcS/3pkFxl33y+mu
         FuYOUTlrAz1jG+ciIp7Lq7NI7w9mY8wyD3wUcARcN0xZVP4pQ/++7Njq78Q0drhUi+87
         2JUJx9l5cqtaT5fOcqojWrkpiyTUBwvso0Ww3/3l6ZVhtT2YnMZdOfOOD4DGaaTcUsbn
         Qw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IT33os/gyb9Nj6BK4xBMhU9JHD8wbptBn+Fc9O72IfI=;
        b=dHOjC8wLBxjyFUXEKoFzfxJIn/motHZlYTWII6o67yss0Gz+O9aNcuUQCYEgya0mXp
         uXR9bEIC7Xrh9CsTZmsF21hl3SU4qq3adBB9HABNC+lXtnWdOtDmy5jgzkN1f0ay8vx4
         0Ix+JE0nqtYruXKAOwDItUh877owVDa0SEacuk82KYyPjFa+eU8qv0igx+wpJel1JXR5
         3EcL9XRXoiR5lbRKSa8K1DMpZzlzaGnErChdy/aBPuol3BsuSFlgSlCH/fCMBgxOA8dD
         mVh91fA7Cg+bFHKMZ/JggP6buPaWhdTworbu59lNfJqo/emfVGuurK5u+JnaV5tuwGR0
         0IGg==
X-Gm-Message-State: AOAM530OMel/QDj2/THcibZfDoIVywGSL/bkDjYVnV2nOr5YqYyqIu9Q
        b1F1JSyfvjn+CtWrIM8L3BPAe41OORhdJtCMK1dXl+jZJWjxDA==
X-Google-Smtp-Source: ABdhPJzsFumlcq15TCtF1YTtFB4Y4vrUXRcgHz7PWWvEXTL+3AOPgjaRLecQdnP2aC/H+oHbQaXXeN4ZePk9MLzQ3pY=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr24341197pgb.74.1647356131234; Tue, 15
 Mar 2022 07:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220315191538.323eefbb@canb.auug.org.au> <874k3z4guj.fsf@mpe.ellerman.id.au>
In-Reply-To: <874k3z4guj.fsf@mpe.ellerman.id.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Mar 2022 07:55:20 -0700
Message-ID: <CAPcyv4hAGXWD0OS_yB3uc-fk7ami65q1zB4BuxqkhWggn1cNEQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the nvdimm tree with the powerpc tree
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 4:21 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > Hi all,
> >
> > Today's linux-next merge of the nvdimm tree got a conflict in:
> >
> >   arch/powerpc/platforms/pseries/papr_scm.c
> >
> > between commit:
> >
> >   bbbca72352bb ("powerpc/papr_scm: Implement initial support for injecting smart errors")
> >
> > from the powerpc tree and commit:
> >
> >   4c08d4bbc089 ("powerpc/papr_scm: Add perf interface support")
> >
> > from the nvdimm tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
>
> Thanks, resolution looks obviously correct.
>
> Dan, this seems benign to me, I don't think any further action is
> required other than mentioning it to Linus.

Yes, it looks ok to me.
