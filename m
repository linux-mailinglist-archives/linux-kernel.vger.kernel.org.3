Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A54E4E76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbiCWIqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbiCWIqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:46:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468D47059;
        Wed, 23 Mar 2022 01:44:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a1so1011850wrh.10;
        Wed, 23 Mar 2022 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yd8lBIIY+OCTplD9xN7QKranu7nxJgphIEj/QJt7VGE=;
        b=mWD3roq0Ew81hWemVBov9rSIki2qshuf77Ujov0HM3gDj6ENPwl9wmBUkgLqHiaA2o
         WF4we9A4BW/CKIXgiXKGuSvKz/8Phlfya+Y2oR+/VKcgPLmVzgdUprx13BARVBHuhMwJ
         M5ZNZng3Wt3oXzpYL9hGj8crCk2O/0sTa+rtXtzm38/BzOjCDl4AoAmf1wE3sak8EKRs
         tbmrjSkghAB00MWTYwCo5J193r/mzfYHHxysdNzkKbYtwUcGsjZQxZKFfPhl0F8jb78b
         QB1McctXmRlncKSxM6cfYHGFSmEfp4SMnQlcxyzOIO4RCLvVwfRpFXRJiIOjikW5doDp
         fWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yd8lBIIY+OCTplD9xN7QKranu7nxJgphIEj/QJt7VGE=;
        b=eSFh1zIgsYHHUITkKZWzViNWVKCvu7kzenteOpYae0DOGDQjXkzpkGGIZLGjdOgvpb
         hjfLDq/687C5oN5af1TBkhDU3kkj32YHM8/3drf0zl2HY9qZvISJa3EaH7Apgh4Vrn0n
         UNXLDjRIlburkimpDWH7Rjjk2MMAXPso1vlO2N3KW6DFhQCk2MEA7FRPMTEM2nKUXom0
         MH3vDsc+PuiVa5KWSeAJp4BbE48t/b3sp1vClm3oEhUEcxl8Ke4g+Cy5nl2qAdUPneuG
         pM72dFpAZZ3IRcRe3xm/XckRuwWtTcF3wNjfeQb8K2DuHh7g3xSlGSsuZWRu4sR/yl0W
         0z8Q==
X-Gm-Message-State: AOAM5326NxZwQJISNNAfaNjzxvPNV5i+Py4nySJd3QLt6+jTBUAPn4br
        sXXJ4SF5+5Yk5RexI8uwO+uw/PsoPwoGQ9o7dquYae1z
X-Google-Smtp-Source: ABdhPJxmfiJwgx/MX5UAnMBDybjlp3/AQvqQ0U4Svic+w2t38wKkS2h7Cy5Byp7NYYr3I/l3tFLYT6PNcunPSB3fUc8=
X-Received: by 2002:a05:6000:1184:b0:203:ff46:1d72 with SMTP id
 g4-20020a056000118400b00203ff461d72mr17622682wrx.165.1648025090274; Wed, 23
 Mar 2022 01:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220323054001.17344-1-diego.viola@gmail.com> <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
 <CA+ToGPH+FQ-6QM6MWt6Zoe_pTyL6LTn9-=-694f7xLkSVCCr1Q@mail.gmail.com>
 <641a417b-acac-6b0f-c330-b94b6ed97b99@opensource.wdc.com> <CA+ToGPEAhWDwFLNHqXvtuumvdLQb=kzme7fdrgBfb4zojVvDNQ@mail.gmail.com>
 <a030b9b2-d94f-ed62-60bf-cc629da3e944@opensource.wdc.com>
In-Reply-To: <a030b9b2-d94f-ed62-60bf-cc629da3e944@opensource.wdc.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Wed, 23 Mar 2022 05:44:39 -0300
Message-ID: <CA+ToGPGVdwXgWTZFa24PDMkpXrVrpM48WAxR4U6d4D9t-k=nJQ@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: fix "it's" typos
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
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

On Wed, Mar 23, 2022 at 5:17 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 3/23/22 16:24, Diego Viola wrote:
> > On Wed, Mar 23, 2022 at 2:53 AM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> On 3/23/22 14:52, Diego Viola wrote:
> >>> On Wed, Mar 23, 2022 at 2:45 AM Damien Le Moal
> >>> <damien.lemoal@opensource.wdc.com> wrote:
> >>>>
> >>>> On 3/23/22 14:40, Diego Viola wrote:
> >>>>> Use the contraction "it's" instead of the possessive form "its".
> >>>>
> >>>> Well, while at it, let's use proper formal written English, so:
> >>>> s/it's/it is
> >>>> s/isn't/is not
> >>>
> >>> Fine with me, do you want me to send you another patch with those changes?
> >>
> >> Yes please.
> >
> > I sent a v2 patch changing those things you pointed out, however, the
> > whole comment[0] looks informal "But wait.. there's more" and I don't
> > think replacing "it's" with "it is" achieves a lot in this case.
>
> :)
>
> Indeed. Do you want it in or can I drop it ?

Given that the language is mostly informal, I'd rather see the first
patch applied (if that is OK with you). However, I agree with you that
it would be nice to see formal language used, I just don't think I'm
the right person to change all the comments in that file. :(

Thanks,
Diego
