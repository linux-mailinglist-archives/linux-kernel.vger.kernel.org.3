Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE6E4F0B3E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359412AbiDCQb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiDCQbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:31:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E7D1ADAA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:29:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p15so13144207lfk.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d2J0F/M8DIzyhTgGvxfaytAbecsNZqv35sEaJSm/sx0=;
        b=ENlukbJM0kdQRUlborIRKBAU/dBCcX4b5oHma468C8us8C0JDA2lFRaQxUZhIhjonM
         SvxkMaT0cbi3hgQMiwRZqUZfrlq/FJLqap1YiFqat0sr6bG3vDdDEPMveflyjsfcIgOK
         w4/ETqdK1k8ck1sA3WeABKSNILWWh6f+y/5KiERlMT2Q7CvRmL9i4FsTB0AE+KJg/iTw
         /vLm49MG6E7T0DcX5fLmQ7MljtweLCAF1XAAxqnpETTIRqELy1PGliA22pOPhCV5CO+S
         fUD/rBAiPojxhaFdZTlsc4Y+rpx90JfkSGVd7VZ+9hxjWeVIdvkjj/r7lZuopDeG+5Vq
         qzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d2J0F/M8DIzyhTgGvxfaytAbecsNZqv35sEaJSm/sx0=;
        b=kB4LpYtlWu5yOLhrfLc+7jVhX1Qu1Hxu5OnvTQHwmbReGQU8vvOpeiigzmjRzO7cqA
         hunuASmQWYVVaAS0guXwQ9Pz7rXHgJTCjFWJB2nHqI3V3viTSbwxcnHeYCCz2ZPR1Xgp
         Bb7qV1p5Inf132lUxexdwJBnvmlmVZMaTqnoxYynJkGsFUPwiG60FAabh+WbPZGcSUqh
         ze4Lcw0nBN8UXgCUAMU5gECdcjRjzgx/xrrM9RNqO1AFGTnaBBDZkor3N5SHgWBcn8I/
         /Hvcrd9b5LcDOV6Qzeq2qO01A6CBpqPCwBEG691aHZXtnzUA64jboIBj3yukt3GBiL9p
         2kDw==
X-Gm-Message-State: AOAM533l9ztCw9+kuLKoq55cr2hHjXqOV72zlGMTcAjWqIINB78igav4
        6d7ZG+1lNrKl2XSBuFATSU498SbuefH0TjVLlfE=
X-Google-Smtp-Source: ABdhPJzspbTWjthhK4DIGjLuINz97YrCBTm+yb0x56rItHjeruKN086joJ/vE7j+WHekkwUciZrHG4Jv+4PJ7eN69oM=
X-Received: by 2002:a19:7501:0:b0:44a:2f6f:3ae8 with SMTP id
 y1-20020a197501000000b0044a2f6f3ae8mr19313960lfe.143.1649003368137; Sun, 03
 Apr 2022 09:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220403155111.GA333187@euclid> <ed0e9f7b-9ba9-b0c8-8261-397bf793b9b9@gmail.com>
 <CAMWRUK6K77KpRkCkruL=RQcmA1opbvapyPJOA-EFpYdXxY8ujQ@mail.gmail.com> <4ccc9ac3-c542-cd32-0cbb-7cdabbf0dbf9@gmail.com>
In-Reply-To: <4ccc9ac3-c542-cd32-0cbb-7cdabbf0dbf9@gmail.com>
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date:   Sun, 3 Apr 2022 12:29:16 -0400
Message-ID: <CAMWRUK7g7BqUL1NziBfbc6Epx7G8Xos47sKAtcimDZYmG-hVgA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: simplify control flow
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 3, 2022 at 12:16 PM Pavel Skripkin <paskripkin@gmail.com> wrote=
:
>
> Hi Sevinj,
>
> On 4/3/22 19:12, Sevinj Aghayeva wrote:
> >>
> >> Looks good, but let's not introduce new checkpatch issue:
> >>
> >> CHECK: Alignment should match open parenthesis
> >> #62: FILE: drivers/staging/r8188eu/core/rtw_mlme.c:1645:
> >> +               if ((p->PMKIDList[i].bUsed) &&
> >> +                               (!memcmp(p->PMKIDList[i].Bssid, bssid,=
 ETH_ALEN)))
> >
> > Thanks for catching this. I wasn't seeing this in my checkpatch
> > output, and after some digging, I could reproduce it with --strict
> > option. I think the tutorial at
> > https://kernelnewbies.org/PatchPhilosophy doesn't mention this option,
> > so perhaps we should update it?!
> >
>
> To be honest, I am not checkpatch expert, but checkpatch on my PC shows
> this warning w/o any additional options:
>
> =E2=94=94=E2=94=80=E2=94=80$ ./scripts/checkpatch.pl
> ./20220403_sevinj_aghayeva_staging_r8188eu_simplify_control_flow.mbx |
> rg Alignment
> CHECK: Alignment should match open parenthesis

Ah, I see. You run it on an email file that contains the patch. I
could reproduce what you saw when I ran checkpatch without any options
on an email file. But my usual workflow is to modify a file, e.g.
rtw_mlme.c and then run "checkpatch.pl -f rtw_mlme.c", in which case I
cannot see the "Alignment should match" error. So it looks like if you
do not specify -f then checkpatch.pl enables --strict option.

>
>
>
>
>
> With regards,
> Pavel Skripkin



--=20

Sevinj.Aghayeva
