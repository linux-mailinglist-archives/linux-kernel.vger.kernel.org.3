Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119F04E9C36
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbiC1Q3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiC1Q3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:29:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117195F260
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:27:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so17569623edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XEFWEPpsTEXkLdyr1Ezg2gVzCPhUwdW/+QiCX/qKU9c=;
        b=riSaaaSmFdboFZxl9sKIysyEp4a0WnJRns30buM8Q75sbJq8FqwsF9ceVR9o84+p8Y
         YiJ9S2SvldTY4O+dOn6tGIZdXJpd0gLhydf9VSYfJ3ewBp7t+W7aQialZtss9h6DU2dq
         WNuBmEuYuwTlJHTyC3cN9iCnND+vGHdAN9IAo/+2zwTQJdukZGJ5uxvASvO0A1Gr+f4O
         EhwBBSvVIGLFGE9pL4ulxksfM6fEXGMift1+HGvv0n960qow3X5jdGcfC6t1M+DBbLB5
         sYptd4mxJiSAy5rzM1Z4Rac4hccehG5c5Qit+fIWbhts1E4VCMlEy0fyH/AAFmhhZXai
         ne9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEFWEPpsTEXkLdyr1Ezg2gVzCPhUwdW/+QiCX/qKU9c=;
        b=fvmDQ3VTAPUdPbYMCeSpxy17UZG3keYntdBUljaSdEwsuzTJl4fE+uEzxj+IyjAuZm
         nfhbMuLqQ/N3oZ3hS8AZBHYfDq1/HQskjXuDs2UqEAR6AXMUGtXxyMuBZYB/CKCc7Y4E
         v9t2MPvjDuOpd6Y7advRwCG/0LlAX/rtOhSJXe8WBhvefC+q4LPRpq+pAJY7rvCY0Wyx
         m6osInNgcfSp6FQdRKF6mIt0Nc+tIA3dMmlOeDN5pNocJuK1ri3eVOFRGy0j5dlsGQWB
         H2WQ+P45BwXe3dXOn/DJPFpguib8+MrSybDBzsdknG4yDQSFrLd1IEcv8mI+jLKazc/a
         4sFA==
X-Gm-Message-State: AOAM53057RJI0das8JICbHiDT4Q7A4p9LIhfl1TXwNhgesCJEz+SS5Mo
        q/uwKa6JjghhCICIXpRwq43Q6WsfIhC5GTuOF/DV9M1w5G1U/Q==
X-Google-Smtp-Source: ABdhPJxJaAYUy3dl/HuZh0tMXNHIVdjIu/Vmo2Lr0lwMqJgEr+0K1JO5Mk2kiy+JmRfLtwMldWDClK8WeTepoFdlkvQ=
X-Received: by 2002:aa7:da90:0:b0:418:d7d3:3ceb with SMTP id
 q16-20020aa7da90000000b00418d7d33cebmr17045906eds.129.1648484852398; Mon, 28
 Mar 2022 09:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220326003356.487828-1-dlatypov@google.com>
In-Reply-To: <20220326003356.487828-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Mar 2022 12:27:21 -0400
Message-ID: <CAFd5g46J2iNYE3T7JFkckh5nnQ9W_75o9ukMSSD=+v+cVGrLFA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: update kconfig options needed for
 UML coverage
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        maxime@cerno.tech
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 8:34 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Recent changes have made it so the current set is not sufficient.
> Namely, CONFIG_DEBUG_INFO is not being set even when explicitly asked.
>
> Specifying a version of the debug info fixes this.
> Pick CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT as an option that's
> hopefully less fragile (esp. given we're tied to GCC 6 and lower).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

I agree with David's comment. Otherwise,

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
