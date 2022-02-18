Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2DC4BB0F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiBRExA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:53:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiBREw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:52:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60AA2A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:52:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z22so13395050edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oq0pHI88XRcgmRgUmJQw3hpIZLFUj9jjieH+c9ZOuP0=;
        b=RzCo/jKO4PKJ1Xk8wAmQuvTbeXLkca1zPO6952Z2oOxjLha+Vm8zCp38s1hRCiq5uX
         OyeP7XEoQ3yiNpXR2Y6m5VCWzzZhGh7eK/uaKX7/uTgATffvAXjsEQnAOxR2q0pq8wmH
         xPVFaHAA2gM3IANGWSHLPxZz7t/C0o7aTC1gVOMrDwKpsGQ1Y/ulI4QOpfFb9xc4ALB6
         Vv5vpgQxmxZnj78+drvX2+X0VR6Yf59zJUAQ+SI/+2NEiZ1tWTS0EoCXaUe7nhqG4oO1
         XVnkApELTIkiV6YNg42P3X+n20i37YTBjfsgabu7HpiRSoX4TmOE0ckn9daVlTjYGbTA
         pgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oq0pHI88XRcgmRgUmJQw3hpIZLFUj9jjieH+c9ZOuP0=;
        b=HysJuT2cTsaxyZok2fPh7y4zr+hQpFiNqcifOHf6LcdzbrSbWzH5DfnJyNmuD7Okuz
         XgAyJvP/TzVISdB7p3gkxyKP4jS9SorxW2crDjw+bIuGFSVEykEnbukdINTvmPWw/Ru7
         MC8SCJz3FtlkRoWnirvlpe9qNdUBhKJ5m0oX5FMHaVaPcIMGTkwv6s/XAMlFpnyEYI8l
         j2mdDvDRylp2zSOuuqLKHGIocV/kkMb8vmu2Ah5AFmosZ/++aCSPap2qO8vhFSVKq3Qf
         2BNESrF01WJFRBzW/PnAmUWplI72WITObS5Bd2nSgKmzvYDkMaiVNSy5pERPsNUxN4K7
         go3w==
X-Gm-Message-State: AOAM532b8og0bv5uz4dwFI1v+e593occtwd2cuOkQynRVjmjkkPEgONo
        nSFdwNcUayXK3zMb3KCTmz4J2Zj8xt0DqLs6gjmFf8I3jSAb/A9Y
X-Google-Smtp-Source: ABdhPJxxyobdGRxK8+05/itVXLz+PQK+3ZCQRM16d0rQt8CTvvdfF2KGK3dPDZJHlWi6RGCoUS5i4pwRQ/xShj/pqUc=
X-Received: by 2002:a05:6402:34d4:b0:412:b228:868b with SMTP id
 w20-20020a05640234d400b00412b228868bmr4372649edc.444.1645159960189; Thu, 17
 Feb 2022 20:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20220217190722.44894-1-ahamedhusni73@gmail.com> <Yg6hcX6XK4Eu0KOR@kroah.com>
In-Reply-To: <Yg6hcX6XK4Eu0KOR@kroah.com>
From:   Ahamed Husni <ahamedhusni73@gmail.com>
Date:   Fri, 18 Feb 2022 10:22:28 +0530
Message-ID: <CAFjpAKqy908scQTRJPkMhEz8OyNiR3-N8XD2hiGa+VBLhUf0VA@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: loopback: Fix Coding Style Error
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Feb 18, 2022 at 12:56 AM Greg KH <gregkh@linuxfoundation.org> wrote=
:
> Did you try to build this change?

I am a newbie kernel dev and trying to understand how things work.
I did not build this change by the time I sent you this, thinking this
is just a style change.
I should have tested the build. I am sorry.

Now I built the changes by setting the following configurations.
CONFIG_GREYBUS
CONFIG_STAGING
CONFIG_GREYBUS_LOOPBACK

My change introduces the following error.
''''
drivers/staging/greybus/loopback.c:166:2: error: expected identifier
or =E2=80=98(=E2=80=99 before =E2=80=98do=E2=80=99
  166 |  do {            \
      |  ^~
''''
I could not fix or find the reason for this error. Please guide me in
this regard.

Thanks,
Husni.
