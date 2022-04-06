Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B4B4F666A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiDFQ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiDFQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:57:01 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B543834330A;
        Wed,  6 Apr 2022 07:54:42 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 236EsSMg017012;
        Wed, 6 Apr 2022 23:54:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 236EsSMg017012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649256869;
        bh=dXve7En2M5e4xXh5b7jtfh9BPqAH3MYvfHqMc5jc6Ao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QGd26goSRGemW9yxN71egfjPrhtbmiN00TYVX0qVeyVjmWL1ZWPVHDBnXVQpDCWUd
         yt/yApzYSktVEfQ41rwccIAF9vgcPZbDHBoGKL0yqEotBBKpOi+5zVE9WDwC66ewk5
         mHw1x+2VhZQJMjaLnSUVneBoT5+OJpjHU156IlH0HkNqW7Qfc/PxKz7Do12f33IKh4
         hZ86f4J+n9GqU1lLVL/hlC2dcCzc4LKSa3F6gB81igQHvRvpKE8hSYtl/ntrFSC8XQ
         KWR/pfVEtaj8DFfMsihc2EqKLCKuGAwhZF6BYoJ6NCmkIJSgGTLqljkIMPQsuyZc1r
         CMNGEhfAPRDEw==
X-Nifty-SrcIP: [209.85.214.170]
Received: by mail-pl1-f170.google.com with SMTP id o10so2158815ple.7;
        Wed, 06 Apr 2022 07:54:28 -0700 (PDT)
X-Gm-Message-State: AOAM531EHFtU5f47MVob2b/6rAj/H8a2MRiLkMMieC9vGndU0M1YiUT9
        F/3xV1xCP1b07RCUIVzKAjGBWrId2FfD5Knr+/0=
X-Google-Smtp-Source: ABdhPJyWembw7UB5FHXQ3/iYGzaCekp69tkkqZgrhPUh5j729qxNH8iii8K8VCAnxAkKzsMkl6zOQkbluDZMQftpnnk=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr8890545plp.162.1649256868141; Wed, 06
 Apr 2022 07:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220405043350.12599-1-fazilyildiran@gmail.com>
In-Reply-To: <20220405043350.12599-1-fazilyildiran@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 6 Apr 2022 23:53:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=7=kPQP3+Nf0gyRZGbXE19=wSu3NOanrzuM2gLHE1Rw@mail.gmail.com>
Message-ID: <CAK7LNAT=7=kPQP3+Nf0gyRZGbXE19=wSu3NOanrzuM2gLHE1Rw@mail.gmail.com>
Subject: Re: [PATCH] docs: kbuild: add references on Kconfig semantics
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        paul@pgazz.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 1:34 PM Necip Fazil Yildiran
<fazilyildiran@gmail.com> wrote:
>
> Add references to 1) a research paper which provides a definition of
> Kconfig semantics, 2) the kismet tool, which checks for unmet direct
> dependency bugs in Kconfig specifications.
>
> Signed-off-by: Paul Gazzillo <paul@pgazz.com>
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
> ---

Applied to linux-kbuild. Thanks.


>  Documentation/kbuild/kconfig-language.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
> index 93a5b6e1fabd..a7173843a294 100644
> --- a/Documentation/kbuild/kconfig-language.rst
> +++ b/Documentation/kbuild/kconfig-language.rst
> @@ -693,6 +693,8 @@ in documenting basic Kconfig syntax a more precise definition of Kconfig
>  semantics is welcomed. One project deduced Kconfig semantics through
>  the use of the xconfig configurator [1]_. Work should be done to confirm if
>  the deduced semantics matches our intended Kconfig design goals.
> +Another project formalized a denotational semantics of a core subset of
> +the Kconfig language [10]_.
>
>  Having well defined semantics can be useful for tools for practical
>  evaluation of dependencies, for instance one such case was work to
> @@ -700,6 +702,8 @@ express in boolean abstraction of the inferred semantics of Kconfig to
>  translate Kconfig logic into boolean formulas and run a SAT solver on this to
>  find dead code / features (always inactive), 114 dead features were found in
>  Linux using this methodology [1]_ (Section 8: Threats to validity).
> +The kismet tool, based on the semantics in [10]_, finds abuses of reverse
> +dependencies and has led to dozens of committed fixes to Linux Kconfig files [11]_.
>
>  Confirming this could prove useful as Kconfig stands as one of the leading
>  industrial variability modeling languages [1]_ [2]_. Its study would help
> @@ -738,3 +742,5 @@ https://kernelnewbies.org/KernelProjects/kconfig-sat
>  .. [7] https://vamos.cs.fau.de
>  .. [8] https://undertaker.cs.fau.de
>  .. [9] https://www4.cs.fau.de/Publications/2011/tartler_11_eurosys.pdf
> +.. [10] https://paulgazzillo.com/papers/esecfse21.pdf
> +.. [11] https://github.com/paulgazz/kmax
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
