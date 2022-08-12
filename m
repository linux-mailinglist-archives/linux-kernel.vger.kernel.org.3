Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA4590BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiHLGQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbiHLGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:15:48 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18C518B04
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:15:34 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id h125so118791oif.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=TRqABuuclfMQQK8ZnNeTncsAYKbgjRjN4hi1AOvw1Ww=;
        b=mg9rn5aLYypf/O+LZoMJD+FY3YWSJM6dTRCvo3/vH6+1VAebPT65Ch31uzgww8671a
         Rh7c86OLmBnv51xo014btPTWXppPvbul93sDpxilXCYxa79Oy2F0s/jGn+m24DKXaEm0
         GEyt7ri3bLHj/TWA4sguGk7g6wbRZkg8kX8wM5xH7NCg9rEBMlmPc1QYNPmzWuQkls05
         eOm8ymBNymcQQk9dJmT4uvMcc8ytH8K8rr7owzdVHB3g/Y7Y3BLWO+yherQX5f0l+fjO
         HvhW73W4SxzWr0deinL2YGdpt0QwtirgYM1CL3KIXrO8m3BzD8vitPZo7PzrFGVtJ3Cx
         1VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=TRqABuuclfMQQK8ZnNeTncsAYKbgjRjN4hi1AOvw1Ww=;
        b=v9XPreM8b82X8//Etz8qnd4LLn2SjwQUzVGQcroNdaVVNvRsTDPXYLcpvYV36NsBVr
         D8IA89M9BRwCJSAAH54siaXe5buNujuL/AUq0lVaKQ8362tafaPASqJaXgB4zGEd0wDR
         n00xySteiMbnDTWY+qbpibVsriDE/jqhBvqBFJx0JwN7NYUxxdJ3PmQ3tUEIwefYJ6vH
         Y6vTmIPSeMF28llLj4XHWeW7UPmrzYZeZHlPO5xU6dsPskRu5GT7COtD/wyqRdFYJn7n
         LKGD6ZxOGIyBx82jl/BwcvhP8t3EIJBHYivp2O/WVLyflbUixpMWksa9F056cGCTt6GV
         vf6g==
X-Gm-Message-State: ACgBeo0P42+NNE3iXFGNTnjlTZnxU/vM9XpZ4zS0QCoTx0U3eg3f76XB
        dKbM3paAK30aKNXnKnfdt6AVAS9G3JM=
X-Google-Smtp-Source: AA6agR6X+t9NvJ0PMVK2bJhk5yNkk8BUMGDwa6Hv0CbjoSCNlyz9f4piLYDYkm6MduyN92dntoXu8w==
X-Received: by 2002:a05:6808:45:b0:343:657d:4089 with SMTP id v5-20020a056808004500b00343657d4089mr1299598oic.68.1660284933836;
        Thu, 11 Aug 2022 23:15:33 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870348100b0010eaeee89a1sm224243oah.46.2022.08.11.23.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 23:15:33 -0700 (PDT)
Date:   Thu, 11 Aug 2022 23:15:32 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Bitmap patches for v6.0-rc1
Message-ID: <YvXwBOuE8kbRZtY4@yury-laptop>
References: <20220805022940.1637978-1-yury.norov@gmail.com>
 <CAHk-=wiEVFpiC5M1-zo9Q47uwP+XaCv2rVXan51Ot7L=UXMs7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEVFpiC5M1-zo9Q47uwP+XaCv2rVXan51Ot7L=UXMs7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2022 at 05:12:33PM -0700, Linus Torvalds wrote:
> On Thu, Aug 4, 2022 at 7:29 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> >   https://github.com/norov/linux.git/ tags/bitmap-6.0-rc1
> 
> Grr.
> 
> So I delayed this because I was anticipating pain, but it was worse
> than expected.
> 
> I think I've sorted things out, but part of sorting things out was to
> just basically undo this:
> 
> >       lib/bitmap: change type of bitmap_weight to unsigned long
> 
> which just was pointless and the explanation for it didn't match what it did.
> 
> The explanation was "unsigned makes sense". Ok.
> 
> But what it *did* was not to make the return value unsigned, but to
> also expand it from "int" to "long".
> 
> That did *not* make sense, and caused pointless changes to printf strings.
> 
> And - surprise surprise - new users had come in since, so there would
> have been even *more* pointless changes to printf strings just to
> resolve those.

That's true. I checked the generated code for arm64 and x86, and long
is nothing better than int. I was sure that there was a difference, but
it's obviously a false memory.

I wish I could rebase everything on top of origin/master before
sending a pull request. It would help me make sure that everything
will be OK on your side, but it doesn't work for you for other reasons.
 
> So I basically undid almost all of it. I did leave the "unsigned"
> part, but removed the "long" part, so at least the printf strings
> noise didn't happen.
> 
> That still caused the type clash in the 'min()' in the
> mellanox/mlx4/fw.c file, but at least I couldn't find any new cases of
> that pattern, so it seemed acceptable.
> 
> Can bitmap sizes in theory be "unsigned long" bits and thus have
> "weight" not fit in "int"? Yes. But it's not a realistic concern, I
> feel, and I really really didn't want to deal with this pointless
> churn.

Many bitmap functions use int type to store the length, so currently
bitmaps can't be larger than INT_MAX, even in theory.
 
> And honestly, this was enough churn that I seriously just considered
> throwing the whole pull request away.  And I feel like I will have to
> do a few other architecture tests too before I actually push this out,
> so I may end up still doing that if that shows something else wrong.
> 
> So for any future pull requests, please
> 
>  (a) make them more targeted
> 
>  (b) avoids things like that return value change that clearly was just
> churn and affected random files in the tree
> 
> because right now I'm left with a "never again" feeling about this all.

I understand that. I'm not happy as well. I'll be more careful with
pull requests. Sorry again.

Thanks,
Yury
