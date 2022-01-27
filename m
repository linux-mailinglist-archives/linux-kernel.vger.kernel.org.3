Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4FF49ED57
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243949AbiA0VWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbiA0VWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:22:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A8DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:22:18 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id om4-20020a17090b3a8400b001b633bebd2dso1026201pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTPRRsgugmzf/THQn+bJVywd3QC27Vdizt4KZMMDQYo=;
        b=NuUca3TpKHa+/WJgEQ+Q3lAf/ABT4f2qTCoFefqLr1TRQftjYNVPJYd5Kb6wm8EvIY
         PiuiHV0+7ksboHD5Tc4yWjw04ZQ/VSzQubrXFj3C2PFT8CE56ID4s3WmuLa68SAb9iQW
         5c14Z5pQ0Kg6j2Mny/8p4CFKTXrMHBOM9g+FPHIw8g+CvgVtNXyNzr03vys9/Q/U4J7S
         NXUQELg3WGvlulTvkRYx6i7nZRXdpGfNuwQvqzeMI45+z0dGJW+ApDXJQHOjxLIZcq0K
         yepg4XuDKBCmYxRaJTF1ygtcSTm2k/gK9K4sp6eMYB2l72hwHd3TZFTRS33FJDc0oMkv
         4RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTPRRsgugmzf/THQn+bJVywd3QC27Vdizt4KZMMDQYo=;
        b=kfg3wqzsug9eWLYhTEHrRoqmoJnIdi2J1PAclUIKX7BUn+mf8ZWa8SzCn34i/DqO0P
         Epnhelbbai9PpXQuNMYXJEdwsFh3evtmOxZ6Ywsu32917W+9bdxUrt0qXqJeoeSYD+yl
         2PAZjQwgHF/TdfxmKCGuwEIVxpIzTNC0bPK/fJBSTtQanWmib/a2yN9bcVXOgA17RY9T
         owhh8eEy4x25Mk2IKsF49cfb3rsgmxxkVrW4K8GuFgafPt+bLZbzgJ1TzDBgqLxHuX30
         VwcVtY2tUi5FGtBaTdhyU7rUD+VVLp9GjuUkhZlWR2AWIDLoeo4Grm9IFg42u3cgb8kS
         weqQ==
X-Gm-Message-State: AOAM5318Cjl2IP7ENFmSEUr7LjlBCGz1MRbmk5tfFh9a2Romp7i4uGYa
        NZrDPIxYKeAoFS8MpcbebTgd8fV2SqRYBNlyQedvRE3mr8wP8LlR
X-Google-Smtp-Source: ABdhPJyrEfXh6IwQ2pWZe5a5gakX7KhAPijNMHSCnoa4kgrf/JmDkmxbkBzPzdfr7ujetYE8UJgJClA4vPUu9HFSD7k=
X-Received: by 2002:a17:90b:17c4:: with SMTP id me4mr16229311pjb.198.1643318537602;
 Thu, 27 Jan 2022 13:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com> <20220125210011.3817742-2-dlatypov@google.com>
In-Reply-To: <20220125210011.3817742-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Jan 2022 16:22:06 -0500
Message-ID: <CAFd5g46hoFZcKHXvfe1S5WyRX6gbj-CrtXcKjrixSyHwV+vp_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: remove va_format from kunit_assert
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 4:00 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The concern is that having a lot of redundant fields in kunit_assert can
> blow up stack usage if the compiler doesn't optimize them away [1].
>
> The comment on this field implies that it was meant to be initialized
> when the expect/assert was declared, but this only happens when we run
> kunit_do_failed_assertion().
>
> We don't need to access it outside of that function, so move it out of
> the struct and make it a local variable there.
>
> This change also takes the chance to reduce the number of macros by
> inlining the now simplified KUNIT_INIT_ASSERT_STRUCT() macro.
>
> [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
