Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA114F0B6F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359583AbiDCRCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiDCRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:02:10 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41EE33A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 10:00:13 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g24so10096120lja.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9ueE08O4hgLJ/etsVdj1Kl8Il5FNA2+FWPSFvQRrPk=;
        b=U+HajK7vqk1UVA1fsIaKeJKFZd7cfzVEcwM4KyUoZ2V0Ugn+cZGoZLPMP0MtdaBWRS
         alyBTpxOK/kPBbB5H+BZ2edC9isgxq9HwRKLHFEe9+wHKvRCBd8A7EIafe5zLl6VBgX2
         5GpqjuD2PLXR72sXVIlqxmMGocx+ENmc+txeLLXT+WZlzKBAyjzuIo8YHi7KkfMBGPGt
         qmhnXv8IOnuyxamhdlB+PENbk9pErGvYi7b/v7sJ+hZpePT1DkGvMIqoV2gVXkQaQtL4
         u52lNn2EHzCx5x6Bj/vAvxqHRSYdUVp7PhscZGCHsSakft2rgstcYHKmdGc7fwFIzHb7
         75Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9ueE08O4hgLJ/etsVdj1Kl8Il5FNA2+FWPSFvQRrPk=;
        b=Q8LxBn7KCkb/UFCAXYl2F+3qzthwuhy0wXM1YYmnkNdHaVeKC9zjxgPFBihi5vLBww
         3S72CeAQxbvrQs4u8yOx4IvGpQ3HwYwhCaApa7fu4hGBCz1xwLuWEGEs1GhlUbaw/E01
         9mVJPv+X0eiAuK1pLUVri1uoeu89+FMXdlnji5AM6zyM4LgE02CBXpY3rXxtVTseaj5I
         81jWPB1ev5icR72xAKfqId7fkd/AZIVzmasBIY4snpz/4TXerBX+xRxqypN6U16JRfE0
         aOKHMOksHWKmhc+Nu8rIl7QyHiOFl7BDUzUrW1VX2f/ZilknZ0obDmYG+sa6iYv/Rnwj
         sayw==
X-Gm-Message-State: AOAM533FIVfDSYTCuSjWXMDIitvNgM9/d7sXahgFFInfPtCorW6nqVOQ
        f3bfr+w8z6DGiqGCRHe70iirhWcJGYEd1aBON9QzTdfRtZjpowzC
X-Google-Smtp-Source: ABdhPJzVZRAjSxF9zMVc8S+plYKgl7R00N+fdaod9HHbDZuUOJH2tuCfsHYzy+OmwFUTKicp8o9YIqILgdGyfi5wRvM=
X-Received: by 2002:a05:651c:1507:b0:249:83b4:9a27 with SMTP id
 e7-20020a05651c150700b0024983b49a27mr20023362ljf.24.1649005203378; Sun, 03
 Apr 2022 10:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220403155111.GA333187@euclid> <ed0e9f7b-9ba9-b0c8-8261-397bf793b9b9@gmail.com>
 <CAMWRUK6K77KpRkCkruL=RQcmA1opbvapyPJOA-EFpYdXxY8ujQ@mail.gmail.com>
 <4ccc9ac3-c542-cd32-0cbb-7cdabbf0dbf9@gmail.com> <CAMWRUK7g7BqUL1NziBfbc6Epx7G8Xos47sKAtcimDZYmG-hVgA@mail.gmail.com>
 <3e1dfdde-d9f3-9e16-82a6-7b5497981bdd@gmail.com>
In-Reply-To: <3e1dfdde-d9f3-9e16-82a6-7b5497981bdd@gmail.com>
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date:   Sun, 3 Apr 2022 12:59:51 -0400
Message-ID: <CAMWRUK5Ws=QvKvOAQ=iHtTNK8c3zvWJeOWoTEu2CUjrPCFuBEA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: simplify control flow
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
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

On Sun, Apr 3, 2022 at 12:43 PM Michael Straube <straube.linux@gmail.com> wrote:
>
> On 4/3/22 18:29, Sevinj Aghayeva wrote:
> > Ah, I see. You run it on an email file that contains the patch. I
> > could reproduce what you saw when I ran checkpatch without any options
> > on an email file. But my usual workflow is to modify a file, e.g.
> > rtw_mlme.c and then run "checkpatch.pl -f rtw_mlme.c", in which case I
> > cannot see the "Alignment should match" error. So it looks like if you
> > do not specify -f then checkpatch.pl enables --strict option.
> >
>
> Hi Sevinj,
>
> I'm also not a checkpatch expert, but on my system this works without
> --strict too. I applied your patch to my local tree and get:
>
> /scripts/checkpatch.pl -f drivers/staging/r8188eu/core/rtw_mlme.c

Hi Michael,

That's odd. I don't get any CHECK messages if I run exactly the same
command as above:

$ pwd
/home/sevinj/k/staging/drivers/staging/r8188eu/core
$ ~/k/staging/scripts/checkpatch.pl -f rtw_mlme.c | grep 'CHECK:' | wc -l
0

I have to specify --strict to get CHECK messages:

$ ~/k/staging/scripts/checkpatch.pl --strict -f rtw_mlme.c | grep
'CHECK:' | wc -l
167

I don't know why that is. I'm on Ubuntu 20.04 and it looks like I'm
running checkpatch version 0.32:

$ ~/k/staging/scripts/checkpatch.pl -h
Usage: /home/sevinj/k/staging/scripts/checkpatch.pl [OPTION]... [FILE]...
Version: 0.32

<snip>

>
> [snip]
>
> CHECK: Alignment should match open parenthesis
> #1638: FILE: drivers/staging/r8188eu/core/rtw_mlme.c:1638:
> +               if ((p->PMKIDList[i].bUsed) &&
> +                               (!memcmp(p->PMKIDList[i].Bssid, bssid,
> ETH_ALEN)))
>
> [snip]
>
> You can also run checkpatch on the patch files (without -f).
> Then it's easier to see if you introduced new issues.
>
> regards,
> Michael



-- 

Sevinj.Aghayeva
