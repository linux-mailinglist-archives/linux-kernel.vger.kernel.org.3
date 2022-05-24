Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B48532FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbiEXRrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbiEXRr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:47:27 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69FC5D668
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:47:26 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3003cb4e064so17259277b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e6VPETmeyZX5JOF6lrU6bxZMJd0n0GPwABfSqTucdjs=;
        b=bZjveAEaUMpvjHfz1Cch8bK+pwqo5wReSl7Ni1ySDkX7vgB+ELyVHAsXpIXDy/NzwQ
         F/baQeyilKuLVyVSZ3e3AFkWzCGjLP/qgdKtUY8I6Yt9r3cYFnDW2ohFYoNsEKr6MYS5
         lTj9Ai76LjkVrc+uNTqmiubbz+0pmokn7RIRVfhrsz/Hy9byfa+AQQHsnVEgdDlwIs+L
         /MVtlD/qzhhotKGBMHeGk5luHST+bgqa6sQdqklFRiQXgo7W6TChKNkAQk57YkYZePEG
         mNoW/y/qBqR0twFm26Kyrx/dG4oRQ86aObRbtuGaU8bvLjKWJQHgSKYtBQFQLNzrfScW
         bbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e6VPETmeyZX5JOF6lrU6bxZMJd0n0GPwABfSqTucdjs=;
        b=4q8nGeTcGwIAvAvmdh/aObYuNG5zas+AjT71YzAUif5P51Efto4fPPWwgePCOhbUse
         ErDPbrgrCSzBilXarwB5vZpYBLJTlR4qXtidWoNontIPFLZjPcMAps6D+z2SXzCqm9cs
         ojE+XZFeh2EtBVWl+V6jDpUHiOqZusjywV1BQRwOtOtZ9o3nF8tX85OLf0BeJxPEINQM
         GW1ywdQfiy7c/ntzV3RFm6KfGl7xMFzqgfl/TJzTNoYCb1Q4Q/CgGYiIQaVrm/nsWutQ
         Pqz8q/W9UVw89rVv3fZGVOxaMQcKw539BU/FN8dMBzPLtum1xXe9uMSu+Vj7mtW0qytc
         tIlQ==
X-Gm-Message-State: AOAM531/7yydttzSMxDR4z+k4rpkEsH7VZhKZdsSglpBNbqO47kreSKW
        z9o+Sn5+O1t+a3R524yDEHQ/UnctrC5e4T6FRcfPug==
X-Google-Smtp-Source: ABdhPJywyPDKCAP33MtzxfXuYMCC6HltN18smuTT+NiEjrolMWs5gH6m5KLHG22tADmM3eKx+ae1gKCOsi42FnXISCA=
X-Received: by 2002:a0d:e903:0:b0:2ff:43a3:90c8 with SMTP id
 s3-20020a0de903000000b002ff43a390c8mr29118839ywe.455.1653414445758; Tue, 24
 May 2022 10:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
 <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X> <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X> <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X> <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X> <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
 <Yo0KyWx+3oX3cMCS@linutronix.de>
In-Reply-To: <Yo0KyWx+3oX3cMCS@linutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 May 2022 10:46:49 -0700
Message-ID: <CAGETcx_qTLwbjzMruLThLYV+MZD5W2Ox-QwLFQeW=eQgxzq-Hw@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver registration
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 24, 2022 at 9:41 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-05-23 20:43:06 [-0700], Saravana Kannan wrote:
> =E2=80=A6
> > Thanks for all the help. I think I know what's going on.
>
> I, too got here because my boot recently was extended by 10 seconds and
> bisected to that commit in question.
>
> > If you revert the following commit, then you'll see that your device
> > no longer hangs with my changes.
> > 35a672363ab3 driver core: Ensure wait_for_device_probe() waits until
> > the deferred_probe_timeout fires
>
> Removing probe_timeout_waitqueue (as suggested) or setting the timeout
> to 0 avoids the delay.

In your case, I think it might be working as intended? Curious, what
was the call stack in your case where it was blocked?

-Saravana
