Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E7B504DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiDRI32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiDRI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:29:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9487193CF;
        Mon, 18 Apr 2022 01:26:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so16669770pjb.4;
        Mon, 18 Apr 2022 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NYm2dHPEUrvAGMtgFQGnTUtM0H/SBiXaCe0LWOvNDbc=;
        b=PXfz+oVMikvzKIHWp6uEthN5Ee+J8G++tuCZohorOaSm7KXWaTQFnPytewACDAi49k
         FwsGJUWVuU1p4QATh9o+Hi9GBClA1ogVQEEoIOjGbgd3joLUnWEVvoRSFXruvatQbhWD
         x2XtO3cAQRojbJXIEXqUXd89ELxqmQGqMjnr+ZJEcAg3Ne1y2rUwWsBYNhrrkiv/QaH8
         qVGEuzlMHgS16t3RlpvRDwAMEPlxD2PRSyxU0yjQ2F4ULqfRjip/jGRQTAMNBdQljP11
         xzDnFETHk5lrg9WtHSs91HT2NYhpCHydDcIP4/P4mU1bgX04OvIQwI5Z4JHYA5BFu39f
         Vpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NYm2dHPEUrvAGMtgFQGnTUtM0H/SBiXaCe0LWOvNDbc=;
        b=2Bz9FZ8BYiAbs/teeNlfWx08BjBzleCqT6eQRiUcjmk5sba3mrBiSehMu6unG9s9y3
         tsaF0N3de36qigbEEmRtSwssk2laO43cuVpA/VSBlJEBuLCwq0CwWfSgz1ea1MEB7isa
         NXaNQg/TSR4E91KgwDlFDGMNaiOgLSdiRp9y4mNSldmUpmjvixOhi3QtkwxZGuH6ptTG
         QtvahHGhrfH/64sZVvwrapIPldWV9hHKS/Ty+VYR8UIJUZO0g42R23muRBx2JNP7Zaix
         VzAIXQyS3rcRIspJvSiYsMC3kcjyO0NLuLrnf9RaEiWVNXs5xqqzL8Z9VKXEtRj757gI
         roCw==
X-Gm-Message-State: AOAM5334HN4OFeSNXEzrJn/CL8SRIjIs2WQTmJymdGKqaMr4iTECq4Cn
        9YkdynQZHt8hJFzqCjTLdh8=
X-Google-Smtp-Source: ABdhPJybTr2UBzpmzWMtdVYYTaA5z1tdFKBLpjNfDbvdevxT0cL6HL5O3tENgdPZIaTdNIHeiVQT9Q==
X-Received: by 2002:a17:902:eb46:b0:158:341d:93a3 with SMTP id i6-20020a170902eb4600b00158341d93a3mr9869201pli.1.1650270408408;
        Mon, 18 Apr 2022 01:26:48 -0700 (PDT)
Received: from smtpclient.apple ([240b:12:16e1:e200:b07f:6d92:6172:b431])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a00cd00b001d297df6725sm2467455pjd.22.2022.04.18.01.26.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Apr 2022 01:26:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] docs/trans/ja_JP/howto: Don't mention specific kernel
 versions
From:   Kosuke Fujimoto <fujimotokosuke0@gmail.com>
In-Reply-To: <40b763ab-d35d-03de-9d27-bca2af56dd34@gmail.com>
Date:   Mon, 18 Apr 2022 17:26:45 +0900
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF4F34EC-47AD-4E6F-8A36-1EE295AE31BE@gmail.com>
References: <20220417070451.19736-1-fujimotokosuke0@gmail.com>
 <40b763ab-d35d-03de-9d27-bca2af56dd34@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yokosawa-san,=20

> On Apr 18, 2022, at 15:44, Akira Yokosawa <akiyks@gmail.com> wrote:
>=20
> Hi Fujimoto-san,
>=20
> This looks mostly good to me.
> Please find inline comments below on a couple of conventions expected =
in
> this community.
>=20
> On Sun, 17 Apr 2022 16:04:51 +0900,
> Kosuke Fujimoto wrote:
>> [PATCH] docs/trans/ja_JP/howto: Don't mention specific kernel =
versions
>=20
> It looks like patches to Chinese docs carry a simpler "docs/zh_CN:" =
prefix [1].
> So "docs/ja_JP/howto:" should suffice.

Okay, I intentionally added =E2=80=9Ctrans=E2=80=9D there, but if it=E2=80=
=99s not needed, I won=E2=80=99t add it for future commitment.

>=20
> [1]: example: =
https://lore.kernel.org/r/2fc8a76e1308e15823eebf614f35f36f322a55d3.1649384=
633.git.siyanteng@loongson.cn/
>=20
>> This change is based on commit d2b008f134b7 =
(Documentation/process/howto: Update for 4.x -> 5.x versioning)
>=20
> In changelog explanation, lines should not exceed 75 chars unless you
> have a good reason.
> The rule is stricter than the contents of documents because some of =
git
> commands auto indent changelogs by 4 spaces, and the result should fit
> in an 80-column wide terminal.
> Also, the title of the referenced commit should be enclosed in a pair
> of double quotation marks.  So this should be:
>=20
>   This change is based on commit d2b008f134b7
>   ("Documentation/process/howto: Update for 4.x -> 5.x versioning").
>=20
> [with a punctuation fix]
>=20
>> Replace "4.x kernel version" with generic term such as "mainline =
tree"
>>=20
>> Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
>> Cc: Akira Yokosawa <akiyks@gmail.com>
>> Cc: linux-doc@vger.kernel.org
> Please note that the above mentioned width limit does not apply to
> tags.  E.g., Fixes: and Link: tags should not wrap.
>=20
> These conventions are covered in the latter part of Section "Describe
> your changes" and Section "The canonical patch format" of
> Documentation/process/submitting-patches.rst.
>=20
> So I'd suggest that you post a v2 with the subject and changelog
> fixed.
> But please wait a few days for comments from someone else.
>=20
> With the above addressed, feel free to add:
>=20
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
>=20
>        Thanks, Akira
>=20
>> ---
>> Documentation/translations/ja_JP/howto.rst | 43 =
++++++++++------------
>> 1 file changed, 20 insertions(+), 23 deletions(-)
>>=20
> [=E2=80=A6]
>=20

Thank you for your detail explanation, I will apply these comments and =
send v2.

Best regards,
Kosuke





