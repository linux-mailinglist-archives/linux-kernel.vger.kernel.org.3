Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D2B5307B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352851AbiEWCaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiEWCaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:30:05 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187643702D;
        Sun, 22 May 2022 19:30:04 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id i186so13601327vsc.9;
        Sun, 22 May 2022 19:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCDfB0gbeqJSiyKGU3STojVeMXIGNpqCQsaldHkSN3Y=;
        b=YHqAnnX58v3Rh45tbrtMJnyYgDu7wXUizSUQUK+okI52BseQyIEKNVTF9ih6MHwYed
         +rWCWa9xIBlDPyy4ftVJX8rswYnIqDeFRt9xWtDYxr2Jq6fesuwgZOQxmRBpiIaMVWVm
         4Qg/pa33biCAmRlygmaQn+bp4OlCmSgyO2Z3KKSCum/cAaxZLsJMs6ClrH6OMnU7gn+u
         5xLS06zaUrGmpZk5eM0v1Z7viCkAzDfon746s7oS0Q7Kqg0LLa/2xc/RcgfIkw3tFQlp
         3u4IteRc5Y5xkNpWBj5tXuT1cD6M/xKjEAM38ctZ2ZixmAXP3oz588VLj2WJPI+Fqevf
         8KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCDfB0gbeqJSiyKGU3STojVeMXIGNpqCQsaldHkSN3Y=;
        b=mD/8ScL2A8rYROY153ZsDaBTFeXXCSXrXuHmIM17U6KuY4DTsBrQve5JnL9jmCJoo/
         YonyOerdPHODt8GYmprSfYZZRG5e7/628HNYOVCk+FfnQtWxI+PIoT2vtzOMGUHNTNCl
         u8oxLRYKPujBSjV0MQKlmA6/+hdn/LhWnj+tF3TCEjn1HhJBDq60QhkhAbC1oo3SBblX
         CDGVteP6aDPv1lHONNtfqjrTyEe7mZUiSBHcoII70YWU+VjvtxeIHA8oKjPX9CmuiQst
         +9acohp5qaZ6mBBMjuSINrJpZkUSp3QNTPZWk7Aq7Z2SGs6R2JZdMJmvguJEThwyoqKV
         VaWg==
X-Gm-Message-State: AOAM531Hvft02LpJh7hu7Xt5rO7FDgdP6SNrzHIT3xLl/lNdljy+Vtuo
        wClEftRP9dSKknlevPYQHW8jDvgsSWxJaKICP1C4B/c0
X-Google-Smtp-Source: ABdhPJxhkK3Kv7kE383vA3MdUVss8dslJvDBzQHHa8J2kT175OvzdocJ1VLYcw2tTU+bPDSDPGibc717CNxhagshITw=
X-Received: by 2002:a05:6102:3a0e:b0:337:ab1f:3a8c with SMTP id
 b14-20020a0561023a0e00b00337ab1f3a8cmr1446856vsu.61.1653273003139; Sun, 22
 May 2022 19:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220523105736.1f42b837@canb.auug.org.au>
In-Reply-To: <20220523105736.1f42b837@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 22 May 2022 21:29:52 -0500
Message-ID: <CAH2r5msr=g=6-cSmmeTXm5x1zrdaeRykow7B=EL30PaRnTm4Jw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Enzo Matsumiya <ematsumiya@suse.de>,
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

Added trivial patch to cifs-2.6.git for-next to fix the warning

On Sun, May 22, 2022 at 7:57 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the cifs tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>
> fs/cifs/connect.c: In function 'is_path_remote':
> fs/cifs/connect.c:3436:14: warning: unused variable 'nodfs' [-Wunused-variable]
>  3436 |         bool nodfs = cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS;
>       |              ^~~~~
>
> Introduced by commit
>
>   421ef3d56513 ("cifs: don't call cifs_dfs_query_info_nonascii_quirk() if nodfs was set")
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
