Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061305A2B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344388AbiHZPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiHZPq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:46:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3308775486;
        Fri, 26 Aug 2022 08:46:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 142so1895090pfu.10;
        Fri, 26 Aug 2022 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XLAF4GD1Ll6EGxLanEucHnoexGW6b0Wj5SM8EF5olb0=;
        b=nEIC1LEVXu9HZ9Ap7ma+49wjUxKvnllTvNhxVnJ0iNzG0QjXr4i59oaxYg8LpfNaSc
         qgvAD/y8jZVrs+A3OUSvGAtbc4ORLIbG2n1xdhvc4eW7XQecwerCfJu32Z2kCFnNFX9J
         4Bvq5OvlD9ctCHkgbfanhNXz4Mkqty/ycHMuwLucrfpFX+bEy64EoUDqsr2a6jgIQrj0
         n2vjPod+lqWc6VCgo9YLCsfBfWVM7AGVxKyu72fXQbsx2D89QGNe7SPaMiz4LToj64KO
         L4DnbhBuGNu4C7KsHS1KxHXJWxLYNEq2MgupcOiexoVqxJOwWnDMdpszZO6BJvW6fibC
         6JkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XLAF4GD1Ll6EGxLanEucHnoexGW6b0Wj5SM8EF5olb0=;
        b=uK0EMMu+BwjzrYpGEQbPaDd/dAzXYbrciCjUATq2vl5F05Cx/jzHYSb40DRAufu9qo
         o0kX/Qu9m6tOB7siItxKtPjYWpo0PeOiOzTedPNVVeRWKt1W1TpC6DLZa3WJ5dlTOhx9
         y46ENyNKM9hEqo5Ni2zESBvuUvv0nBjK66+aLw8yMmMNqUp2ZuArM8YUZTgqDgxgJASG
         MUnhpb+/6EcOxZbq9GUO4NgQjTupMCdraU3t3KDxSseE3XHflaso8KtpHbS8jwBAKkXl
         bRdBtyCqZp+eGxJZEgbIeIQcNbDFT3ne08bmfTsuDtT2/RauNmcCaR5xbQU7dQJbepI7
         /dfQ==
X-Gm-Message-State: ACgBeo2GXg89enODuwkCwDLVdsSmfZCEfzzP7g15yWC8bQ0UYxlI+f2l
        eWK/drU7oTqivm5auH5VWlMjG1P71Y5XE6Xv2Cg=
X-Google-Smtp-Source: AA6agR44uTEKqoaF0rchbX3O4hiBo4HvONhKxVeO9PKFeq6MXB4FbWxFpufNFUS38KC9iTDhTauKuAujkFb14pgJBr0=
X-Received: by 2002:a63:fc13:0:b0:42b:890d:5954 with SMTP id
 j19-20020a63fc13000000b0042b890d5954mr903069pgi.200.1661528816704; Fri, 26
 Aug 2022 08:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220826061914.816239-1-imagedong@tencent.com>
 <YwiU4DPEPryi1cMZ@debian.me> <30415bcb-c367-9ee3-a5bb-4c97510f4749@gmail.com>
In-Reply-To: <30415bcb-c367-9ee3-a5bb-4c97510f4749@gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri, 26 Aug 2022 23:46:45 +0800
Message-ID: <CADxym3aYgsEUa-nizq7BRsJHLoHxNcJeqjpiQanaGzpxLw9uwA@mail.gmail.com>
Subject: Re: [PATCH net-next] docs/conf.py: add function attribute
 '__fix_address' to conf.py
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     kuba@kernel.org, sfr@canb.auug.org.au, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
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

On Fri, Aug 26, 2022 at 8:47 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 8/26/22 16:39, Bagas Sanjaya wrote:
> > On Fri, Aug 26, 2022 at 02:19:14PM +0800, menglong8.dong@gmail.com wrote:
> >> From: Menglong Dong <imagedong@tencent.com>
> >>
> >> Stephen Rothwell report that the function attribute '__fix_address'
> >> causes a warning when create html docs with the command:
> >>
> >>   make htmldocs
> >>
> >> Therefor, add this attribute to c_id_attributes in Documentation/conf.py
> >> to clean this warning.
> >>
> >> BTW, I'm not able to reproduce this warning (both ubuntu and centos are
> >> tested). I will appreciate it if anyone can have a test for this
> >> commit.
> >>
> > Hi,
> >
> > The patch description can be improved, like:
> > "Stephen Rothwell reported htmldocs warning when merging net-next:
> >
> > Documentation/networking/kapi:26: net/core/skbuff.c:780: WARNING: Error in declarator or parameters
> > Invalid C declaration: Expecting "(" in parameters. [error at 19]
> >   void __fix_address kfree_skb_reason (struct sk_buff *skb, enum skb_drop_reason reason)
> >   -------------------^
> >
> > Add __fix_address keyword to c_id_attributes array in conf.py to fix the
> > warning."
> >
> > So next time when you spot documentation warnings like above, specify the
> > exact warning in the patch description. This will help reviewers what warning
> > the patch is fixing.
> >
> >> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> >
> > Also, don't forget to add Link tag, like:
> > Link: https://lore.kernel.org/linux-next/20220825154105.534d78ab@canb.auug.org.au/
> >
> > Otherwise, the warning disappeared on my htmldocs build, thanks.
> >
> > Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> >
>
> Oops, ignore my Reviewed-by above (not LGTM until my comments above
> are addressed).

Thanks for your advice and the testing. I'll send a V2 with your
comments addressed, and with your Reviewed-by and Tested-by
tags.

Menglong Dong

>
> --
> An old man doll... just what I always wanted! - Clara
