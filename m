Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22895A0A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiHYH22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiHYH2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:28:20 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1FD7EFEE;
        Thu, 25 Aug 2022 00:28:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-33da3a391d8so106014157b3.2;
        Thu, 25 Aug 2022 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GiSxPUjCChLoc63LSHV/o8b4juLqAxHo3RYUzXaLyrk=;
        b=ohYs48exS7UMohrqSzvttoJbIaH6DAodhcgeffYDTLr3GBFUDG9G5qgYXqpDK6YB+y
         omIO+yntWgxdCiJgs4AhhJtxafYtFAvAHEVllKER0U3/ovzTn7IkDJoxDLAnKIwxVAfp
         B/0YZJQz1sWOif76I++6PSDYRt4uyzENT9ALqC6WywLbX/uZ6KcGJKMyyX3mF0y2PKsr
         5vQLesxpmFSyE6i495UtJgc5zR89UQ47yW4fZbCR9byK75R9zQ7QPxRunMM9gIynRwop
         PmXOqUeHiI/kw2X43DGwt9pYJFtzT5dX2Gxau1LtIj1YVVHoM6UIroY60gjHUuRFCkpk
         UPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GiSxPUjCChLoc63LSHV/o8b4juLqAxHo3RYUzXaLyrk=;
        b=F6pHv30MTG16kDb8acJU7D6Y6btArCddhrF9wpUv+SvxRknWGbO/Y3YYk+iNCzNL2/
         PDhxCtYmVxxtackG8u7dQhjr7xiB9/d3jqO63LL2/Sn2tzd2coxqZigAtp2zjB1PpXoX
         zkQiBMRYFi6jW599zyCOXdORaNZcdCAm7zbJnVF4iqMnQZGMSdXFlxE76t0CImJhyEQU
         zSnXbUtdOlJLD/wzotKwElVfLm61lmnld6OGGvgKS50B4UoCa8AOG7zm2wllLQHOoZCd
         uXX+Zkt9ONLwOzQ7QiKls0YzIy5BNwRZGXdU8o+qf/3P4WpDeyzNjjlf+34qUbddW8EE
         ZKbg==
X-Gm-Message-State: ACgBeo2LVCaYI0gP61Mif98z+N1tEjhbYexiYHptIFHxnWGWhH9qpwgw
        p5SxBAyXMGCoHAKkfD3+DmnWuD48i8Y9Ag3Jm1o=
X-Google-Smtp-Source: AA6agR4UlgfgxCtmrqI8ZiwXW2DqeQfj6QeHG41MSZnS00Ntx+yCaaILSlNvLwlhfdSeRhQjgpFgtb8oU/hOCtSkGfA=
X-Received: by 2002:a05:6902:10c:b0:671:68b7:ab41 with SMTP id
 o12-20020a056902010c00b0067168b7ab41mr2142758ybh.608.1661412482433; Thu, 25
 Aug 2022 00:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com> <df8c22fb-878a-3d98-4a9d-9000b4a2ffa7@gmail.com>
In-Reply-To: <df8c22fb-878a-3d98-4a9d-9000b4a2ffa7@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 25 Aug 2022 09:27:51 +0200
Message-ID: <CAKXUXMwTP1KMq1HEoNyR-vRzQYYoTHEumZBu3-urEM8P9r=iWA@mail.gmail.com>
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
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

On Thu, Aug 25, 2022 at 5:08 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 8/24/22 15:08, Lukas Bulwahn wrote:
> > The description in 2.Process.rst is just a description of recent kernel
> > releases, it was last updated in the beginning of 2020, and can be
> > revisited at any time on a regular basis, independent of changing the
> > version number from 5 to 6. So, there is no need to update this document
> > now when transitioning from 5.x to 6.x numbering.
> >
> The drawback of having quick list of recent kernel releases in 2.Process.rst
> is that the list can be quickly outdated with newer releases, unless the list
> is updated for every upcoming merge window.
>
> There are two options:
>
>   1. Programmatically generate the list, using last 5 mainline releases
>      from Linus's tree, or
>   2. Simply point to kernel.org frontpage
>

As the commit message says, this patch here only touches the README.rst.
The commit message of course also explains why the rest was not
touched, and sure, we can discuss if and how to improve those parts,
but I would like to get an ack on the actual patch first and get that
merged.

So to 2.Process.rst, writing a script to generate the list is
possible, but it is already quite clear that just says "recent", which
is vague anyway. In a software project that is older than 30 years,
"recent" is certainly a bit more relaxed than some other SW project
that just started yesterday.

As it is documentation to convince a new developer, it might be better
to just describe how a new developer can check that the releases are
done very predictable. So, we explain the commands for the reader to
check if he/she/they want to convince themselves.

Lukas
