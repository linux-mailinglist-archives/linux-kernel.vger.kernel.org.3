Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2397252F3B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350165AbiETTL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbiETTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:11:25 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D985A9D065
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:11:23 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o16so6148900ilq.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wptJPrd9ShEK3CQfYj5PR/gt1bv2ny3OuBRfAu5sXS0=;
        b=GOg/uDohocVj9i9MP1sIPXrrla5HSXP6WCujXrvSGuDdPmwkVbHpvqaJ5qVncsdRJb
         BKGCM4g/sti+fEQs3lpcf3/rU5JER024GOHkT3Q+DO8KI3Y/j1ALYhTP5TFR8iTILbsu
         uOEL4r1G217uCwRZl71Fxls80sei0ZtXUFIE2LkgM/Eq0r4htk7vpZWkPlT3U4lymObd
         TzxX3OX7ZLIf+kihPema3anBffoM0zAwXQcvn/sbFKPKbwaHSHUtwuL79CqBpFEuReKW
         FjPaVr+ohUi7bD3MWRhPle8fWPTL9TdY+CCMwBcjV/+sicfvMMe8S3t7jmWrL5xf/PQW
         jPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wptJPrd9ShEK3CQfYj5PR/gt1bv2ny3OuBRfAu5sXS0=;
        b=RLhnQKbTww5FpSBNGaLgE37RW+Y8anqJV8EdAfqFU7mGP960KN0PLWiYGxYbAqKjF/
         yeNq8cIlKkzOZq1rjjkvCG/VxLRT4V3FpTE3S2Mvqj50VozP7R+5thPvFt4hb5pzmLkj
         RXcZUAwhxTqh+RvGlKdL996wOGjyLyVnsEF0rjrU1xmO1f5JK6LuDYh+2g4ZU+oxDp+2
         saR7LYaleanAFLR6Q1I6IPHfOUsGTURFwYh5k6qNzHfTJSHJxQhwn8+8EdHn0B4eWEnX
         aAN8eOl4TTVyrGKDRLq5I9JD9tYgxROahEPlBryDSvqbDpRMDgGEcl7uMTWkVlM150br
         KRKw==
X-Gm-Message-State: AOAM531/zWxjIaBNMz3pyibTmahS0oUuC9bRrhMt3GvEiMr/UN3oqkco
        DSa01OZnx02bm8VxrjtCQBMMcJBvQD/KEOXZxWo=
X-Google-Smtp-Source: ABdhPJz0hkN3Jsa0b6iL+Jci3ARkkJmJ6TPKvhUwrFcX11MbRumXs2OBTPindZlxqMklv4JxHlOM4D22C2kOhCxK4Lg=
X-Received: by 2002:a05:6e02:1c88:b0:2d1:87ea:18c with SMTP id
 w8-20020a056e021c8800b002d187ea018cmr1119297ill.321.1653073883338; Fri, 20
 May 2022 12:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160106.522341-1-mic@digikod.net>
In-Reply-To: <20220506160106.522341-1-mic@digikod.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 20 May 2022 21:11:12 +0200
Message-ID: <CANiq72kaKhkcrTrOXiVZ_NA_FktJZhCqib-Fj0jWYztuiKPAQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Fix clang-format configuration according to checkpatch.pl
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
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

On Fri, May 6, 2022 at 6:00 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
>   clang-format: Update and extend the for_each list with tools/
>   clang-format: Update to clang-format >=3D 6
>   clang-format: Fix goto labels indentation
>   clang-format: Fix space after for_each macros

These 4 applied (with the mentioned changes, and on top of a few
cleanups to simplify the first patch etc.) in -next.

After -rc1, I will submit an RFC series with other clang-format 6..11
features that we can now enable but that merit more discussion.

Let's get the ball rolling! :)

Cheers,
Miguel
