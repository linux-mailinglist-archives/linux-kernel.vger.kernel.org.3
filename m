Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A5F53109E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiEWMgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiEWMfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:35:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA8C4B40B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:35:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v71so25115125ybi.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZl/fl0qeIvUdvyZE0jXdpw2d7CYxFND/Aqlck8hL7Y=;
        b=g3QNKrPTU1y3Hrxty3WEbBcbkZxQCGaVdrI1t7cV6FoIHEh9ApyTyjigXadNjRuARd
         WBsyRpJpm6CvGeg1/msOeMA1GJYcN27fAsKFCV4xQO/fRhTP2iDjT8bYzY93h8B+Nkib
         JBFdE0ll5yFBll//1q9Be7OjXIdJe0O6nC8fDo1eIINQWobSNLsforLswaDJNel/hmwD
         Xxsc/+qAQBGThqbn8YkDwke51gsJsgLlfeZCIUnuT3kh9WjLDs6WokwERf93TXAelLDt
         q3Wjw0yC1wU1SCETaIoppFY5Mcn/wYzsfVrKegm6WRuj5DoO4cSBLYLOlXX6z/jtENFg
         +g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZl/fl0qeIvUdvyZE0jXdpw2d7CYxFND/Aqlck8hL7Y=;
        b=gojsrwQwNAecZjj0DNP2zCElQrYpI6AiXUFmdh6O/WtsYLnuQPdP2V/PqS1e2gYtjE
         yWmFPYNV8LKoALGR+1tRb5qu7MeeRnKR6g4djC2vf6SdAwmZA3xxtMNBSRcqVADohlPs
         2kMDS2UUIgOeEl76BcXKPltp+BnHXMQSjdZxKB7MiU/LLN0DWgxNzGHcNKtoeaB+hmxZ
         QM1+FOoE6mUtzzcGb6OpolL8fMf+EMgaDD4ZRXxqNHWDx4t6ONyTEqxFNUT6+5KeaOGT
         2/jUtzDzPPSyO2qBTauaKOiVfWDn693NPNk3IFpeph3ZeEmo1GjIea0mtOQ5ewMQm9Q6
         vjRQ==
X-Gm-Message-State: AOAM533J7KZUKIKGXLeWHsQPl9wD7Jf+6CrayqmPnSNNE2LQ1YyL/XhP
        FnKdQ7sUh+4QAAORDKzgb2g+HpZLKvY+LDNBYMdwp3sG8k073A==
X-Google-Smtp-Source: ABdhPJxe/lvuePKCeGxuB9+ABxg16S0q/9rDILB02Ubcpk7fvZjoqmGGH2zyZ9//gkOuI4bTXW0IMEtSpS2nkzeORqg=
X-Received: by 2002:a05:6902:2c6:b0:64f:5b77:6869 with SMTP id
 w6-20020a05690202c600b0064f5b776869mr15492879ybh.494.1653309332081; Mon, 23
 May 2022 05:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt4+47GzfEYT1nV3dqbGa1YCwFm9XwC668D4PkK4BHFgQ@mail.gmail.com>
 <55d49dea-1a67-d857-218e-ef2343251361@i2se.com>
In-Reply-To: <55d49dea-1a67-d857-218e-ef2343251361@i2se.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 23 May 2022 18:05:20 +0530
Message-ID: <CA+G9fYvF7HGmJQtk7ktmakwQNjjraK3EoBeiMr+3NuEvsixi6Q@mail.gmail.com>
Subject: Re: WARNING: CPU: 2 PID: 3331 at drivers/firmware/raspberrypi.c:63 rpi_firmware_property_list
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 at 16:43, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Naresh,
>
> Am 23.05.22 um 11:04 schrieb Naresh Kamboju:
> > The following kernel warning was noticed on raspberrypi4 device while
> > running LTP controllers with Linus mainline kernel tree.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > metadata:
> >    git_ref: master
> >    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >    git_sha: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
> >    git_describe: v5.18
> >    kernel_version: 5.18.0
> >    kernel-config: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/config
> >    artifact-location: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu
> >    toolchain: gcc-11
> >    System.map: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/System.map
> >    vmlinux.xz: https://builds.tuxbuild.com/29XDpgnCMxtWJ6lVJ9M0x3hTNWu/vmlinux.xz
>
> thanks for your report.
>
> Do you know this worked before (e.g. 5.17)?

Yes. it worked before.

> Am I correct that you are using GPU firmware 2021-02-25T12:10:40?

Correct.

- Naresh
