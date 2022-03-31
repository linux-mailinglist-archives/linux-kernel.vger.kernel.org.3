Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE524EDFD0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiCaRmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiCaRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:42:41 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED2B17A594
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:40:54 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id x9so309803ilc.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyGHrtWUT2Fics+gVqtcmwsLpUDfu48pACTmB8yx1t8=;
        b=Y+2Qeep8CJL31pD+UDsvHcRdkZq5dTqoTzcYBK/kU0l2pOVe0yIkOd0zkAOBmIEdvz
         YsJDI6i9EMPHBuTRI8FxIs33CMn1p4HJHc0riKdHCx0KhRn/Dwqd337YJuEvy4MALqHB
         Ca/LQgSe0wG6FkliXJ/fPDP0ynsKazQSGW4pWz3lL6PAJkBPqlwd4R98p/OuUDgyOA3i
         0JzMPlXl0496qMdpSHUf+OxEWLq71TrhzYsj4XWo0778uS4oVQ6vNDTwS60QoeqIItix
         FvH9x1fef/D5QK+6isICwKQLRIkNMiN3zqmz5Ih3LHTG141PCMmQx1IOeWyNJ1kGDAvs
         6GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyGHrtWUT2Fics+gVqtcmwsLpUDfu48pACTmB8yx1t8=;
        b=IpGuiSiYWtSQp0bO3ptj3T8LzMBYdMTbTaAqgWqj4AsfwUNwSSXVQCiHA77PcwmNAZ
         A4k2m7ePC+sDPygNFChqLElwDBtQPgMtgc23qTKPLN0L61zZhAVY9B1igSWXA5aPqb+J
         KeRIB0Dif7joOUMd3z6j/IBAew+LyQr2M1dxneF4Xd/0ewQbpGM0IUnL23PkkRudskmP
         Qiy2bexRHWaLqIRrscTClOn0CgNZ83CE/6de7e6WbiAAs0qsiJ315RJz2XfvYC9tlE2P
         C5GTmvvwcDYgIvGwNM4LA6nW5+A85exO7VxuzbWM6tAbpzXLoST72sUfNqfKSDr4C8y2
         G9/g==
X-Gm-Message-State: AOAM531VtuqQ0B/+8PdvOx+CMjXPswn9aOlQpJdn2DSybeRyHrHx6kUS
        LiKpyvMnVSCiiy1BsGATN3++x6uMZdc2ksIdzRGE7A==
X-Google-Smtp-Source: ABdhPJxYhTs4+s1jh5yCfY9ZXSqoPOeAI+WRsxV81sHUy8RK+dwLIGYcYEXBl53Khry6sclnu4sUkwNABtaJalzXlqw=
X-Received: by 2002:a05:6e02:20c6:b0:2c9:d552:20de with SMTP id
 6-20020a056e0220c600b002c9d55220demr6870949ilq.137.1648748453774; Thu, 31 Mar
 2022 10:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <202204010033.oeIla4qb-lkp@intel.com> <YkXc0RjJYQoGZZ8A@57de4820519d>
In-Reply-To: <YkXc0RjJYQoGZZ8A@57de4820519d>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 31 Mar 2022 10:40:18 -0700
Message-ID: <CAJHvVchTGDbr0dUhDOs8iJHcNCmp8V_LYfLoVcBWYQmvJBPQMQ@mail.gmail.com>
Subject: Re: [RFC PATCH linux-next] mm/secretmem: secretmem_iops can be static
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks kernel test robot, it should indeed be static. I'll send a v2
with this fix.

On Thu, Mar 31, 2022 at 9:55 AM kernel test robot <lkp@intel.com> wrote:
>
> mm/secretmem.c:173:31: warning: symbol 'secretmem_iops' was not declared. Should it be static?
>
> Fixes: 24209f2f4d62 ("mm/secretmem: fix panic when growing a memfd_secret")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
>  mm/secretmem.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index a83e98aa3a7b3..ddf45c0435be7 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -170,7 +170,7 @@ static int secretmem_setattr(struct user_namespace *mnt_userns,
>         return simple_setattr(mnt_userns, dentry, iattr);
>  }
>
> -const struct inode_operations secretmem_iops = {
> +static const struct inode_operations secretmem_iops = {
>         .setattr = secretmem_setattr,
>  };
>
