Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0E520DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiEJGp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiEJGp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:45:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31FB20F778;
        Mon,  9 May 2022 23:42:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w24so11036686edx.3;
        Mon, 09 May 2022 23:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijmE02y33COTCaxJDE2zIUhDclloDsXzbZ7ZrzXYMaY=;
        b=Bi+Wiwz1hpcsIUJqoFp4l/Hh4HeH9j9PDoB527jj554ziq403CaBJdQGylg8shXt1g
         JtmixsKOXm4VyP9QMMnpazR8F8OTm+zFUW5O9nzReH5iMhixWuFYll4wd5z2/L1v8OEq
         1BwqNhXwNuIyCdTN6QbtkYHRRh/3HSF56glaKhKGV4n5YP/ij8qRQJAlC3q1r3PE5JDL
         Y2B+PGlUY0ZblghFblrrUzvaYiiaacuIFDgHWKv7X2ol/A7yc0D56bnR5j1YRRXdsyPY
         kIxMEsE00VZ24i4Py+Uwzfs3snM5FrVMOkEifgvQZY3vY5QTCuWSDm2MhmRnD52N5OeM
         MhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijmE02y33COTCaxJDE2zIUhDclloDsXzbZ7ZrzXYMaY=;
        b=jYClSH1PJ8afW2WZVE+RTxpEXWiWKoli1QYtgwN5d84DWhPE/4mh43y55tstN+rUGl
         xaq34/FKIvZxpLfxzBTaCcEbC4DbR+Fel+qyHokWXGCL1JZCRxEFU9FIYrxJRMWGDhjp
         se9WT39Lcoev8e38qygU+zN+2MYA6VNDBvZVnc62ykCdflyJ9U15cb1UYjBJJm9KhoaD
         yf5npQ+Tgab9e7ku1I7MHsVSnRo22JNM5hJ2Q7L8B6W+qGZ9Xd/FNY9qWo6t/0Nfrd9F
         r4Fegx+r9bYjPd3ueBJ/Unwe/+sZkatHaU7TEJhNvL/cvxJozIpVh9ZhKj1MCE/c8WjR
         sDYw==
X-Gm-Message-State: AOAM531mL3THuIADWzmMgdWcoTgGkSLlk/7WpwGJU154IPBtdA7G0nYo
        XDfcuOnq1dTRvsaKO/86s3UshPMd2CXnmDFP7fs=
X-Google-Smtp-Source: ABdhPJwQfGM7bva/ZzKADvlRaOaGNyGCe6VVgjRmfC8UG1ox9DT0+2f6Mu2g6x3z64yOWo7kqyT7waHqK2iOn2/BA7o=
X-Received: by 2002:aa7:c656:0:b0:428:3280:a432 with SMTP id
 z22-20020aa7c656000000b004283280a432mr21787374edr.396.1652164919286; Mon, 09
 May 2022 23:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220510145612.502d7930@canb.auug.org.au>
In-Reply-To: <20220510145612.502d7930@canb.auug.org.au>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Mon, 9 May 2022 23:41:47 -0700
Message-ID: <CAJYdmeNW9Ar6v5To4D-tGYb52_OLFs-+R4V728GrboheacLaFw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the fpga tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
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

Ugh..

On Mon, May 9, 2022 at 9:56 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   7269868818a4 ("fpga: fpga-region: fix kernel-doc formatting issues")
>   d73ef1ed7300 ("fpga: Use tab instead of space indentation")
>   154970f89f06 ("fpga: fpga-mgr: fix kernel-doc warnings")
>   d0749c3c95fc ("fpga: fix for coding style issues")
>
> are missing a Signed-off-by from their committer.
>
> (A danger of rebasing omeone else's commits ..)
>
> --
> Cheers,
> Stephen Rothwell

Ok, there are some other issues on the current next branch. We'll clean that up.

Thanks for flagging this,
Moritz
