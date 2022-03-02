Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6334CA24A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiCBKfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiCBKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:35:10 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B95BECC7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:34:27 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u7so1560376ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 02:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNE5Fuk1S7VXvQWbBVtfenLyBK3DknXKrcGn5hcrC6I=;
        b=SRlP8dzJ0rC/EvoM4tj7g6i/4vbgCbZIyewg7h8zVcIb2lmEwGdvnZcP8pWUGiYDCp
         Etcac9xOik3FU78hmVWyTqvbHSl9EwWfZrnE9irY3NYFYfjdESKx1h619SVLYlfwb/Kt
         LNIc91aCRs6r2aI+4VCV4d0ooPE5dpzxe/f2cwQ0hVULcWdVehAeboiKH6elxoDi2iqi
         OSon0gGaZBKrtdIHLGRmMyEmWRiMGjrrMUwIXZVMsRL1cqtnbb2/KpmFddMLGqhOLxuq
         s127+/dG0TQ0mCDQ3UNtAhPKEEqkbv8QTT2FOf72w5/Pm/RPHyU1CLBqNem4Y8Z3oHFo
         p6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNE5Fuk1S7VXvQWbBVtfenLyBK3DknXKrcGn5hcrC6I=;
        b=AOF6NGGWxTpuszB5IxzsVndMUqW+KsvxY/GRobe2yTtInKE6Bq+YhHUJnqNLa8iU4+
         SLzcnse3bwQcYoS12iJL3R2ZsjxbqGW/40RIlwq8SQ/dSrsG39Qc2jssyP8CpUDzRM2N
         SUTBkUxA/nmFM2CDZxp/pVqpNxIUYVn0j1Yvg/9Td7P5Y2IpnNhAkEWbO2kg+rc5fLc9
         aU9A4H1ptD335WJJ/KrmXp3v6kcbKVpKxaAl8IUBO5a6lOmPdcpolLXfjOEqRISTm4Dj
         5aQ6aWvlPhO8T4nhq/vzWIBrM3uk+kVGZRp4OJhZROEJLeATgUZH1p7hcLvULXT0yJz7
         t3OQ==
X-Gm-Message-State: AOAM530REXV7To3DVz8RPaD9NZho6H7+E2lQQlwM8+r8pgnwCwJRqkAv
        lrqrnCkKZ9MfyikeD/piDtc9yBsTsMo123bIdCQZ3sFfhJ8=
X-Google-Smtp-Source: ABdhPJxy/8lfE+WWmK9cypiL6fx/Xc5LX8PSSehEJwhnWoXNJqHnm6TstUokNOEm6UeTIjZ2qTAxSuM7EQsHKF1Vq7I=
X-Received: by 2002:a05:651c:201b:b0:246:34b5:155e with SMTP id
 s27-20020a05651c201b00b0024634b5155emr18829620ljo.273.1646217265345; Wed, 02
 Mar 2022 02:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20220301115300.64332-1-ulf.hansson@linaro.org> <Yh6PjZ9/HAiyZ09M@kroah.com>
In-Reply-To: <Yh6PjZ9/HAiyZ09M@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Mar 2022 11:33:49 +0100
Message-ID: <CAPDyKFrWHvK2+o8vg27v2NWRe0JZ3vTk111djpM2fJ8X3Oqgtg@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Fix build errors/warnings for unused variable
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
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

On Tue, 1 Mar 2022 at 22:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 01, 2022 at 12:53:00PM +0100, Ulf Hansson wrote:
> > The struct device *dev, is no longer needed at various functions, let's
> > therefore drop it to fix the build errors/warnings.
> >
> > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Fixes: 7570fb41e450 ("mmc: rtsx: Let MMC core handle runtime PM"
>
> Forgot the trailing ')' character :(

Ohh, checkpatch should have spotted that, I thought.

Anyway, sorry and thanks for fixing!

>
> I've fixed this up and ignored the obviously incorrect kbuild
> warnings...
>
> thanks,
>
> greg k-h

Kind regards
Uffe
