Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D751F919
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiEIJel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiEIJKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:10:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099637BE6;
        Mon,  9 May 2022 02:06:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id c125so14585402iof.9;
        Mon, 09 May 2022 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8n+UZz9zrRIKwTdPcPWk2HfhPy3k0sFBqqr8zGSJSl4=;
        b=UN/WwazTyvjfSXpC3RwEF1N+VP/O30WhKkOKb/5LmJ6iNs+PfRuSL1S9SAeNkwyATc
         0lF9TZtIQ1wLZqHRlJd93GfJxYODd84iC9HffRl+2D/n/EScTq0WbFp0wMauRSiuLG8O
         wqnPWMrZiYbclXdn/SkV2VpCXS7s1Xc+GF3obEOM9Kymlf97+PolnAjK/3suIYDtOA0P
         6tjbdbaqii30neRcN1Id0ItDqF0ADcmgAt06EyCG8EFSXWw6ou0mRuoEQKBMU1qBDIqO
         k4l/hJ5btvnzkAqVjDnHtKhzs73PXu54DKB2NpJgJMrlJYUa7uZlKgFFChpDebXsuyKc
         ivgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8n+UZz9zrRIKwTdPcPWk2HfhPy3k0sFBqqr8zGSJSl4=;
        b=01RC78xp0RVLDm8UkE/Dkl1IpqHb/RqofBNWrCgfXk8YhGBIQWkBGzhf+7+q4dKKV7
         sw92edi7g1WoCKlYZR2SG0UxVrzhyTT9a558cuAjRxkpk13tMFN8Rpjr4Er9A036xebh
         yVWtxmsYPB75D3Py/0zvRhyUJu4WrUdoFCqFpaB7mzUvNijuUS/QyCtUEL0/XN4RTDXi
         aJslWCs4m7hQJ+XCY1CZ1hQ8cLebYLICgPIbUe3Nj7DIMZ62qb7+Lxh9QsUHoXT14Evv
         BsZIYE/hmPc/7U6OwrYr+ibokQ2hQF1eXWT9pb+zVXnfmcA9bhjc1bwplk7yAWmtqT3A
         vygg==
X-Gm-Message-State: AOAM5314Ql+E6VaJOWHhI0D8T/4vye9IqdYTV1Xd84RyDEDhGqpgdcQ1
        9uvSLJyZhsKfXzy/QPC9prkP/CcZueOJvyUAGW7bQ/uRfaA=
X-Google-Smtp-Source: ABdhPJwWLNtuNKAMqgJzLLlmJTNRSjpeugL9SrdzC+W672o06pMtBK1/kujW6Pcx0SJH9uJEyA8SDUBW3rhXJDjh5JI=
X-Received: by 2002:a05:6638:16d2:b0:32b:ebfe:8672 with SMTP id
 g18-20020a05663816d200b0032bebfe8672mr3066459jat.199.1652087209496; Mon, 09
 May 2022 02:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160513.523257-1-mic@digikod.net>
In-Reply-To: <20220506160513.523257-1-mic@digikod.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 May 2022 11:06:38 +0200
Message-ID: <CANiq72=SWen7sJxvQGD5N=ur-gpOiFGeHHfjegHxjaHfN_i95Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Landlock: Clean up coding style with clang-format
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
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

Hi Micka=C3=ABl,

(Answering in v1 since I want to quote something in this cover letter)

On Fri, May 6, 2022 at 6:03 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
> I used a simple coding style for the initial Landlock code.  However,
> this may be subject to different interpretations.  To avoid relying
> on tacit knowledge or text editors for these kind of rules, let's
> automate it as much as possible thanks to clang-format.  This makes the
> code formatting simple, consistent and impersonal.

Thanks for moving your subsystem to `clang-format`. I am glad you
found it useful.

> Several versions of clang-format can be use but they may have (small)
> different behaviors for undefined/new configuration parts.  After
> testing different versions, I picked clang-format-14 which is relatively
> new and fixes a bug present in version 11 to 13 (visible in the Landlock
> formatted code).

Which was the bug?

Cheers,
Miguel
