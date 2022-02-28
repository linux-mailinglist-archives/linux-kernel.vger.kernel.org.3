Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC9A4C716D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiB1QNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbiB1QNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:13:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F812637
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:12:29 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bg10so25824204ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7YxRKyreH48dZQ9Yk60m9yefrarInHQlSucfyX1K2c=;
        b=dytKXHw+tT3Dhd0aDmsdHtTQ6xXuj/mNxJogs8WbLKzqOu4qsyvH0GyZ4xkWtWw8gH
         dPejxY/E3QgnqEiCvNufipZss0cvtgzkPSCLR+i6luHumAwcDeOqAhtCRMg/aJPIdR6w
         9jS98MbQg4oI3x5yQ3RgLZHxhtWvyWv47ZuVix5koe5qTYoPi9hItK1fpfK+Kpeq2FbS
         YOnGG8E/v5J88ghaG0S/BIbvFE5aukRhLxBesUdOYDjf7z4Costh80kY8EY5xinm3WIG
         /5KFSLpnxXUa3lsMwFKNq6SJcca5swmpGpTS7vhNJKGN9r7MJdJI4/E36IM+u6hLNg+z
         q8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7YxRKyreH48dZQ9Yk60m9yefrarInHQlSucfyX1K2c=;
        b=J/BZmJcrMgnkM79MfnB+IqWtGl57J/eU9USmJw1lgn4vY+AYYWFatyskrPl/XIfzIk
         Yz3qOYMkP7qB35vlKHOcbb11qN9omPauVsqzoAjZ6k7eUlW9kUZSfU9sKxWpuummH+o5
         SjFYKxZpVb9WhRO5d/5qS6rryYbIOsW81b+AZgQVOgY81vO2F7tOwXXFcF8fUGWptabm
         MwpN9K6bXZ4hN89qhpuGsasP30shAQknIXL3Xxf61+hpvLTByU4c10nfw6hmg3Qbedmi
         GDo/Qhm+5PkWupHwmKAXAUj5An13gPCLX7KNoDCkGECR53k3eLGHkV5I+AuuNA/XcNcJ
         mz1A==
X-Gm-Message-State: AOAM533AUfpF92oHl0EHmXYoya6N9PB5Hubj/Rtcz+XObjnFT6oK2Ana
        4YB7rhTGDq3R3m2+y3rS6/2RZO96Q1+bexv5G0A3
X-Google-Smtp-Source: ABdhPJwmNFw9jVOzTMa+rnTNBvLLbYSTrhnzeA8q7epUUzrGh/oXw1/rmJAMVcVzlFpgDwpFXk216nyT5GA8CYCzPbg=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr15832693ejb.517.1646064748150; Mon, 28
 Feb 2022 08:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20220228025646.1665265-1-wanjiabing@vivo.com>
In-Reply-To: <20220228025646.1665265-1-wanjiabing@vivo.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Feb 2022 11:12:17 -0500
Message-ID: <CAHC9VhTjKyfn5AJAOx6ZxDsFk7e8JTkV48JAk6PbHRyx=uy4HQ@mail.gmail.com>
Subject: Re: [PATCH] docs: fix 'make htmldocs' warning in SCTP.rst
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiabing.wan@qq.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 9:57 PM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Fix following 'make htmldocs' warnings:
> ./Documentation/security/SCTP.rst:123: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./Documentation/security/SCTP.rst:123: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./Documentation/security/SCTP.rst:273: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./Documentation/security/SCTP.rst:273: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 5e50f5d4ff31 ("security: add sctp_assoc_established hook")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  Documentation/security/SCTP.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks for the patch!

-- 
paul-moore.com
