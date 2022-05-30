Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EEC5378A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiE3Jf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiE3JfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:35:09 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E27036E;
        Mon, 30 May 2022 02:35:07 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9so7244984ilq.6;
        Mon, 30 May 2022 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Ile+n5/oD24523FT7keERdyg7jh4V5MLaTqin4EMOlQ=;
        b=CEsKwR201VIXFDzMy199lrAPK7xgqOTrcsp+z5ZkCxFHDuEP//rYFOfRQF3cPmQ31W
         z6HXzecFlQjj5bo6RLc4ps3oTNhbSRzetiUC3YazhB55VQyg6maxNwi7gvpbC3BLzPtM
         DNzSyT4Aql54wMMpXxz1kJjIXSWpKe6HIiYtrG45STFmwxnsebhzvtFRTqcaHJT4hEMa
         80VoOKBjZwJkqBRhZTtw7rj+mPzC6lKLKrhdpmyRaekOoRtXa0CeU1p9fQNxqR5ABuv6
         82LoBgiA1vO3Jslpu9Yvvwtt5DU4V4lEsaxLHPppSl6DPpZ2Xk6wIaC6gxGVEaW4ncN0
         OZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Ile+n5/oD24523FT7keERdyg7jh4V5MLaTqin4EMOlQ=;
        b=KILgYdaj+DiSF2HflPDmoVEbLDUMRVeav10N6B+qGWhtMspA5YuHXjf6BucCtIpsei
         wx/vixpl1uB3wdqLRqOlC4RaDtu1/KZ7as/yA5Gpk5F7h3sNX19bqqyRt2Eq9BQEdQqo
         nOBrj7uaMygtFNiaEfB4qHe4N3jPXAYwCSDTFX7w4eqVmBHzW2SzJ9y+7omnN3XHG9Q8
         pyW4W/Cdwaqn/z26UDEq5FIM7lHxsXJXaLBrKrpfz+K1uJVSvEV4IgglybGy+zZ4TV5n
         5idt42YckPBDJ1aTV42E3XciNUdXH/biUozQP9EmCsBy361bchyhcj/9wGJzgFyxdO+y
         E+5A==
X-Gm-Message-State: AOAM532CNzXM3ikbWW6qIwwzRRIdfNnpjl49SqMv1gaOINJRNdSLjRCU
        Bd3LthwJttSbsvRW0/oXwNNwTcINFiMXkGdx6Kw=
X-Google-Smtp-Source: ABdhPJy4QZErwr4yprLC9VjV8B4k69/InpcgDH4sY5REE1KapQMaKsXLm8Yl9b1Ht07KVz6KW/tGd9+0BJhIZkK0cA0=
X-Received: by 2002:a05:6e02:1aa8:b0:2d1:7099:67ba with SMTP id
 l8-20020a056e021aa800b002d1709967bamr26003035ilv.1.1653903307188; Mon, 30 May
 2022 02:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220528154704.2576290-1-masahiroy@kernel.org>
 <20220528154704.2576290-2-masahiroy@kernel.org> <CA+icZUX2k6eB_JfRJ3X3te44nV0CZycpWX5cT1YMPGR1_VrXjg@mail.gmail.com>
 <CAK7LNARQMx8ACUK6xTQrCtscTECZhM2zZhLSGaL5F6x304T77A@mail.gmail.com>
In-Reply-To: <CAK7LNARQMx8ACUK6xTQrCtscTECZhM2zZhLSGaL5F6x304T77A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 30 May 2022 11:34:31 +0200
Message-ID: <CA+icZUVKZB=DiX7t2rC5jbhYp32uRKxmiJ_uU77NeZmyCKFvaQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] kbuild: clean .tmp_* pattern by make clean
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>
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

On Sun, May 29, 2022 at 7:33 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
...
> > When does someone see .objdiff file(s)?
>
> It is created when you run scripts/objdiff
>

Never used this - thanks for the info.
-sed@-
