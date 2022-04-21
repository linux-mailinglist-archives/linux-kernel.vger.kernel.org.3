Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D08509F96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384321AbiDUM3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384650AbiDUM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:29:16 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10B0326C3;
        Thu, 21 Apr 2022 05:26:16 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id x9so1337846ybe.11;
        Thu, 21 Apr 2022 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nsgj5qaghKeF2XHWS+0rsyHkdR0OmiGHDh6c2bZuVsk=;
        b=OdtP1Cr2hmhb7IMyvCgq4gFY76MvKyzo8lN2Xs/fO0shVPFqDWfqlaczCoeMaoqNaV
         sytvMCQ3ZL5VX82elSNJEDwpGwRDexAn3PMI0YjfFsdMASxagDZNYNaPDlyk3iNHOqH/
         2wVoclktZJLRDiNjpJI0lzYNZ3Amnkn1U5IyrBC1pxlfkZbjOj0+fwGwqEWiFI0Ye06t
         rC2Y2HCaZ+WahplcjQGG6ICkBGE9ceDwfxzWWVJ0d3/fvmhP337/4+NbRzNTaxJWbZH6
         +0U6Md1mL9w4YbnNr4oreWDaZ/b445wn2Ri3Gnr4cz1V3h5AOn4DqRd/T/BN1p9zdtFy
         grZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nsgj5qaghKeF2XHWS+0rsyHkdR0OmiGHDh6c2bZuVsk=;
        b=wzgeolBu/5f0lqFCk5SLow0/+jo011uO+p8ybtX6wCiuTooe9R1yAnqJdglR2GySvY
         mgvS5O94WScURuNlrlgU4oiMhrNA3dhMYf9/bk6M8qSqYB0/5rR/oFV2CERjCKNn7Sa6
         97jwVfaFiknqrlAH67HFG3ENA4kz3INQxP1cz15U4SGOUWb+duxScHHJP68WWYVGpOfV
         ewaviiuOFrQvgPsYn8H3kEdFMA2ZRFcqO1MtGwvr1mPYfJU0H9DsXATfbXuNDK60Os0p
         1LsMfaoBAxalTO3q+413WK7ghBYxX1u4GkXcBzG8vva7lXkoyaXKbJK4nkL9lJcs/D/Y
         wfiA==
X-Gm-Message-State: AOAM531BR/tm5VaNcukVGldw3qlNha+KG5o3PK/VhtMqBOddBPWS7F4a
        0FsZ6cPUcdTpln3hW6KS5Jyq8ybbvI904te1uvcGoIq6V8ym1A3r
X-Google-Smtp-Source: ABdhPJx5Iu9QrmzFQknHWLvrDJpVaMuJmsemK3qL6bwrACB6ruJg6TpZl/4HveskdoIawPbTcU3orlYFA2+U+6HNowg=
X-Received: by 2002:a05:6902:1083:b0:633:d1f:2e01 with SMTP id
 v3-20020a056902108300b006330d1f2e01mr25155773ybu.222.1650543976226; Thu, 21
 Apr 2022 05:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1650424016-7225-1-git-send-email-baihaowen@meizu.com>
From:   yanteng si <siyanteng01@gmail.com>
Date:   Thu, 21 Apr 2022 20:26:05 +0800
Message-ID: <CAEensMxtk8zJPAM-u7hvYkaNTBrVdmhKA7YzVsKmTw0TcOE=Pw@mail.gmail.com>
Subject: Re: [PATCH 0/2] sync with original text Documentation/vm/page_owner.rst
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Alex Shi <seakeel@gmail.com>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haowen Bai <baihaowen@meizu.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=B8=89 11:07=E5=86=99=E9=81=93=EF=BC=9A
>
> This patches series will sync the translation of zh_CN as below:
>
> Commit 8bd16bc0a081 ("tools/vm/page_owner_sort.c: support sorting blocks
> by multiple keys") add sorting blocks by multiple keys usage
> description.
>
> Commit 78a0b94f3829 ("tools/vm/page_owner_sort.c: support for multi-value
> selection in single argument") add multi-value selection in single
> argument usage description.
>
> Commit c89b3ad2dea2 ("doc/vm/page_owner.rst: remove content related to -c
> option") remove  -c option usage description.
>
> Commit 9c8a0a8e599f ("tools/vm/page_owner_sort.c: support for user-define=
d
> culling rules") add user-defined culling rules usage description.
>
> Commit 8ea8613a616a ("tools/vm/page_owner_sort.c: support for selecting b=
y
> PID, TGID or task command name") add selecting by PID, TGID or task
> command name usage description.
>
> Commit 194d52d771b8 ("tools/vm/page_owner_sort: support for sorting by
> task command name") add sorting by task command name usage description.
>
> But the original text table which is made of tab will display all
> by one line. so we make a standard table for STANDARD FORMAT SPECIFIERS
> description. I fix it up togeter by this patches series.
>
>
> Haowen Bai (2):
>   docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
>   doc/vm/page_owner.rst: Fix table display confusion
hi haowen,

I'm not sure why, your different versions of the patch are in one
thread and they look like this inside
<https://lore.kernel.org/linux-doc/>=EF=BC=9A

[PATCH V3] docs/zh_CN: sync with original text Documentation/vm/page_owner.=
rst
 2022-04-20 12:46 UTC  (22+ messages)
    ` [PATCH V4] "
            ` [PATCH V5] "
                  ` [PATCH V6] "
                    ` [PATCH V7] "
                      ` [PATCH V8] "
                          ` [PATCH 0/2] "
                            ` [PATCH 1/2] docs/zh_CN: "
                            ` [PATCH 2/2] doc/vm/page_owner.rst: Fix
table display confusion

This will make trouble for the maintainer=EF=BC=8CUsually, they should look=
 like this=EF=BC=9A

[PATCH 0/2] docs/zh_CN: add hmm and numa translation
 2022-04-21 11:59 UTC  (3+ messages)
` [PATCH 1/2] docs/zh_CN: add vm hmm translation
` [PATCH 2/2] docs/zh_CN: add vm numa translation


Thanks,
Yanteng

>
>  Documentation/translations/zh_CN/vm/page_owner.rst | 61 ++++++++++++++++=
+++++-
>  Documentation/vm/page_owner.rst                    | 34 +++++++-----
>  2 files changed, 80 insertions(+), 15 deletions(-)
>
> --
> 2.7.4
>
