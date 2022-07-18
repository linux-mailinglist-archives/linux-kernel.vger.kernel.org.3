Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AD9578980
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiGRSZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGRSZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:25:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981AFDF4E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:25:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id oy13so22810166ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kscGEigI+tjGeP5TvJ/S+GJp6i5Qbl+gYFuhTnzJi/Q=;
        b=jNLpuo60nBYj/0Icdd2hZbpUSg8sfsZ9aIyS3We5Dc4g3pT0DOnYHtz8yuOy7UpHLT
         eWraK350sP4poSMGQ7pY1JsK5dQgkWgOuHZiBy1m/IwnzGvaN2vSVYrI6zP3u5GMI4cg
         DBrd0Fz99DFS1vgIghLS/5DpS6BaB85bVbcU8AGZ8Jgow9oHtaaDpksygHLqZDRMlHDm
         7Xx2iKMopnIHqGYuxQ8baCVApmHSNzTR7viE3s1jG5KPEdG2kskLnK+CyuX9UOnHzC+Q
         3+EUIWSO9WCvSrx/7ZYzfu7Q38diEa+2lTj+p4tlqBMsIYzbmwhzIn5Zw5EXO2pc88K9
         knUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kscGEigI+tjGeP5TvJ/S+GJp6i5Qbl+gYFuhTnzJi/Q=;
        b=B4hmeSsegd2D5egj4116EKbGMVhJOgBMSmwBpbWQOfyvv8FE1QD3mYAraoiRDPwokU
         Ci5crVD9c8o6ZospfJB4oY7IQz2FcET05/slLP1IJkCm5Dmf4h5I6G0hsxr+YKfyarhX
         m1CUAmCqNhSect7PHdglwFeIbgnxZMZRrb2IpT7819VjLnU7ns4Q2c9jX5a5rJN1BMBC
         IOqHN38VCyoic0JDWkJULypJZ7d0Exuoqddcqn7/3Dti21fo0/m01tR5gUxelFjAvXjM
         JDan8BrQdTLDcdwMhjIuN/NeStAtaSn4QmnciekMZsSup1TIN9MEQwqM9F55bAkEvUYd
         h55A==
X-Gm-Message-State: AJIora+s6qj0hIAIc4FIupmQHxnQ5BI84F9yvkbY2dh8PmEYh3P9tOqO
        R3J/OXg00Y+2jzymKXYsMh2o7GV5NvcKp3vnNMeTzg==
X-Google-Smtp-Source: AGRyM1tYPDFFiijC4Z9MdcmK3xOLLmCzQ2arChf8L8dWUQufhw6ny+XMjSmMxYJS1dMP/PsvJqboKG2stxB30MOWryg=
X-Received: by 2002:a17:906:5a67:b0:72b:610d:4aa4 with SMTP id
 my39-20020a1709065a6700b0072b610d4aa4mr27598952ejc.294.1658168739084; Mon, 18
 Jul 2022 11:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220608223539.470472-1-justinstitt@google.com>
 <YqJYrImC3Bk40H1H@dev-arch.thelio-3990X> <CAFhGd8qTc-=Fjw2LZW4HYJtVyizkLhYRyv-TYLd1ji-9oR9EdA@mail.gmail.com>
 <YtWk1abYruK6DIoL@dev-arch.thelio-3990X>
In-Reply-To: <YtWk1abYruK6DIoL@dev-arch.thelio-3990X>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 18 Jul 2022 11:25:27 -0700
Message-ID: <CAFhGd8oTs1gM8C8zZvcZw0pxzRJc1ogvp3jg6TSGPVegsXCNsg@mail.gmail.com>
Subject: Re: [PATCH v3] include/uapi/linux/swab.h: move explicit cast outside ternary
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Justin Stitt <jstitt007@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 11:22 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Jul 18, 2022 at 11:12:25AM -0700, Justin Stitt wrote:
> > Any chance a maintainer could take a look at this patch? I am trying
> > to get it through this cycle and we are so close to enabling the
> > -Wformat option for Clang. This patch fixes over 50 warnings and
> > there's only a handful of patches remaining until we can enable
> > -Wformat.
>
> I think this change is already picked up? It's in -next.

Oh, awesome!

> https://git.kernel.org/akpm/mm/c/d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
> https://git.kernel.org/next/linux-next/c/d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7

How did you track this down? I wasn't able to find any references to
my patch in -next through kernel.org.

> Cheers,
> Nathan
