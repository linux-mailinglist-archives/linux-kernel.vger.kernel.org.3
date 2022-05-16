Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D244528739
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242368AbiEPOiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiEPOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:37:59 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ECD2C11E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:37:57 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f863469afbso156101427b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTB0WxbI7pNKziLAOm0Rj4onIqJzYX3pDVUnNfUI1io=;
        b=f2noysl2zQeqrEgraTrbm5eIDW9y7aF4He2L+WhdMWL3Jed6jjFrGT5Z7TR9vRbBOi
         Nq9r+fbYtjXvN+13e+UP7dAUDCPan7jRMMp7+Xk+ssS7cIIf9gRVKKmMxkddMUq+BYTA
         srFAOGlacayVNCmaEBD+GPMTrRuN+D2r1CYdIY2+4FdOauuGGeVeTupX+TWgGZD4jO9a
         /u6GQ/x16tfcv8GEUHVmZ7vY9oRHY4fqgc4u+Z50SpGqAbnzw8nUh79MVOPdoPD2CHab
         /ph5+GQw4CQagic4Js86pIR468L9yuQqnrtFnWF2o3gMCTRufY2w56Vg5p0vpdiGxWX5
         NN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTB0WxbI7pNKziLAOm0Rj4onIqJzYX3pDVUnNfUI1io=;
        b=sDIszf+mJmQow3ylSIn/nVNHDyHtdWv6Y8x1FTAdow5Nkd8qysUzd5PZAuKol9ZTAW
         JGzUNl9huz+wryZIKrzlns/WGtwZAvelR6Z8u0vZcrX8Vq30oVa0JyVCF/mKi4X2FzHm
         D/116WbVSQN2r1YdTorMnleA81d8s/23Xl34KV+DFJ0unSfBChsM5xZr7clT21YcqQlU
         tsili4q2rP8vYF/WJYLJHSOSNgP0vgvkc9rtLR+CaJPwQ74XAvJd1N7BWH+rGgy16vV2
         MDO5ncMN734uwG02a9CX6/pmGMO76u3Wjhgu6HJdYudiVKYVThnK7VYZg1ieU7vUCSWN
         jyBg==
X-Gm-Message-State: AOAM530tWgns8L0QA8n1TJ7kN/cFdwQPTqE7OcIivmlKwiDJLxOxB8GP
        cgmvAEVWc9sTjQ/RmP60gTN/v2otQ8proY/S/op61g==
X-Google-Smtp-Source: ABdhPJwv43CtwkpKD1bPIxvSd/VT/IBz3YSs4otXb88oEdQFyDBVIq5Q8MhVJ5VPRySQku9SwyVn/AAVGsWYUp8h7bE=
X-Received: by 2002:a81:478b:0:b0:2ea:da8c:5c21 with SMTP id
 u133-20020a81478b000000b002eada8c5c21mr20894327ywa.189.1652711876582; Mon, 16
 May 2022 07:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtsp-1pi6d4J71BPYh-msjzbVt_-v3YrUu12dXPeyqTDg@mail.gmail.com>
 <87o7zylztd.wl-maz@kernel.org> <CA+G9fYtLP1Kf1Ck-33XrLFQ5uc_p1z1S5Sr1x=9ZRGi=D851PQ@mail.gmail.com>
In-Reply-To: <CA+G9fYtLP1Kf1Ck-33XrLFQ5uc_p1z1S5Sr1x=9ZRGi=D851PQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 May 2022 20:07:45 +0530
Message-ID: <CA+G9fYtW58D057A=gdA2JCk5QTHwXywpEeRfLXBELouUzBsugw@mail.gmail.com>
Subject: Re: Unexpected kernel BRK exception at EL1 - Internal error: BRK
 handler: f20003e8 - gic_dist_config
To:     Marc Zyngier <maz@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, pali@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

FYI,

On Mon, 16 May 2022 at 19:28, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Marc,
>
> Thanks for looking into this report.
>
> On Mon, 16 May 2022 at 12:38, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Mon, 16 May 2022 07:16:22 +0100,
> > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > The kernel crash reported on arm64 juno-r2 device with kselftest-merge config
> > > while booting Linux next-20220513 kernel  [1].

This is happening only with the gcc-7.3.x built kernel on arm64 juno-r2 device.

- Naresh
