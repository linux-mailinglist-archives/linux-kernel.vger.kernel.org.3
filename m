Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094F855A24E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiFXT6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiFXT6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:58:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3B794E1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:58:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd6so4907668edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYJrl/wB0ad9MyDM8wwvji/ZDuZftUz6c3QWw/c+yls=;
        b=Mu4aeU7G2lpQOAQQALgKApY2YNyyfwEim9iUgpMOsdAl20+ZMNrMNqs0Crqn5x1xQ5
         cJVd276kM+uTsWqBkWgEyU+NTmQ2JyrwepHIrXIlG87uc0ivdULhX8P2B/XJjZ9xvXR+
         VaKXl1xl6qnbNJRImCqY5AL7onNMSYPWaxEZywP1YHq3rPWuWaF8WzlAcaW8Rtc+rvFw
         Bu6byZ7S/5eXN9B47BgDM9ghOH2/aQIR33EdOUNGTHnIKWhQ30XNf3MZYvoJTMaACC3b
         Yne5oYE4/MzUwxEpZMpps5E0eFVMhTIZu9r9kqbgjlLLM0PF44aszFeHcCQ0+3pX5D/I
         JKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYJrl/wB0ad9MyDM8wwvji/ZDuZftUz6c3QWw/c+yls=;
        b=MOi+qLJsOt90TzIuHL4mcEm2nR7tctESSVdslru3gzuUVT9b3vfN+L5dz7n7ykbqqd
         i0tD2Koh0mxu3rKEyYGeYCE763uirp1as8XQYDUlP0mGp3hovjPc1wIaH9U7HWwTjEk+
         tATEC7kn4MIGdG1hI0kbyfSkeJDBKrNH1AuUCYaouAZJ1foiYLyDcskwN8HyYtMdBblZ
         nJ67X360fXCwT/aqsMZs8TSqGS0Zf0LBNC4ntUaH3Z+DpVagv8J4dpppJ/ANzaJLwZ8a
         mF3AqB1DPZmKWRSSmZVImKXin9wBghDkYO0fxdLZ48+eOUDpWMCWUfsvarvZ9MfKU7I4
         sNQg==
X-Gm-Message-State: AJIora+lEGhh4wDcj68YqD82+fnKMrptz4KHZrRw9wRgn9J62veFGqmQ
        9yWBIjnMoLKWhzVw7SqTeUuMAkkrhvAbpT0cX7nBAQ==
X-Google-Smtp-Source: AGRyM1vMzUWJmQCrglTjFheFdJbmfy02e1iBg6c4g/gixoMi/cMSAyDijx+4ELbZ/YQ5KVXE686/xx+qFt4WhiSVHRQ=
X-Received: by 2002:a05:6402:5188:b0:437:618c:c124 with SMTP id
 q8-20020a056402518800b00437618cc124mr946758edd.233.1656100727779; Fri, 24 Jun
 2022 12:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220603195626.121922-1-dlatypov@google.com> <87pmix3ktq.fsf@meer.lwn.net>
In-Reply-To: <87pmix3ktq.fsf@meer.lwn.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 24 Jun 2022 12:58:36 -0700
Message-ID: <CAGS_qxqOZBr7Ti_pS20Qw3RLH+VjnhR5mDhJ2hyezKSo9Du-ew@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation: kunit: remove duplicate kunit-tool.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
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

On Fri, Jun 24, 2022 at 12:47 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Daniel Latypov <dlatypov@google.com> writes:
>
> > The information is duplicated now in run_wrapper.rst, which was added in
> > commit 46201d47d6c4 ("Documentation: kunit: Reorganize documentation
> > related to running tests").
> >
> > You cna compare these pages here:
> > https://www.kernel.org/doc/html/v5.18/dev-tools/kunit/run_wrapper.html
> > https://www.kernel.org/doc/html/v5.18/dev-tools/kunit/kunit-tool.html
> >
> > We should have deleted it in then but it got overlooked.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> So not that long ago these patches were going through Shuah...it seems
> that's not happening anymore?  I can pick up kunit docs patches,
> certainly.  I've taken the silence on these as assent and applied them.

Thanks!

Tbh, I'm not really sure what the status is either.
I saw that 46201d47d6c4 (which added the duplication) went through the
docs tree, so I followed suit for this.

I've been guilty of sending purely doc patches through
Shuah/-kselftest tree before, but that was mostly when there were code
change dependencies.

If it makes it simpler, we could try and agree that all kunit doc
patches go through Shuah going forward?
Shuah, Bredan: thoughts/opinions?

Daniel
