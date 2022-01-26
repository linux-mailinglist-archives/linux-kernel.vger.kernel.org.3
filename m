Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8019D49C9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbiAZMhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241388AbiAZMhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:37:03 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1CC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:37:03 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id w5so14312796vke.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEe8by3s9ksq7H7R+2e/eg/hw79b4EJ6GjQAEsOoplw=;
        b=UO3r5mlKyFdM5epZpIBys/99FFCpAEOA9LirCzoh21numfIZX+I8SholCplQhdrTua
         l3omy2IHIcnp4FPHs19LWko6r/vM+VcQ9BisSZD2Ttwv1qrVSVV4hNU6i/E9sPbQUvVG
         GtjM0JoKOjWXnyF4qtDFNM3CBuiFc3meEanv896iXeQQ+dvsZiTVb7vF3Twv/r9rcB/H
         TH0S2cEzV+ZY6lkiUDvA10sk47PsyF5KiU83xjv4YixE1LOsCiDDBjL13kmGRGuMh7iY
         PsU0Ob6xKvRBxvZ2xJ2k5Ye6ukEIVsTQ3yG3D0Er8ReFQlPxkZ2Fh8kVlrPg/7EJKgsi
         dsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEe8by3s9ksq7H7R+2e/eg/hw79b4EJ6GjQAEsOoplw=;
        b=7xbF728skrz4m5aD0hGbOBqZXAzlSkugdHprPY8kmhhL/zkO4Kh8A+K80CFXMdFYM9
         N9a0/QHEgnRne3LBPkhlFMueeLAoHsiKVJAtZAgaM66A8jtn631oDIN1rgAU0SkuRTsI
         936YOFb97HIaE1ylcPxugQ3HgTUIbo/igUmei+HgDUOtWz6bXLpsrGDFzFdlBFp7UN9Z
         /DBSBFtrslejIWwD8kzH1tKpBLRs4j00lCmKw5P0t1Z0SYv3eyV7Wbdup1CQrClLg4LL
         GdT8ycSxomXOppJwqhP0rB6h/FKk30YQOMFiyKRkk6OiDi+FIk8hHyXOFWEbt6rnsQfo
         eFpw==
X-Gm-Message-State: AOAM533LGLGyWWAdDBFmqvoqLRXlS63qvwp1VN7CYeIkGVuFOnx6pBLD
        geCw1tgKEFKRDD3EJMwjZ6BkxrFEGw3o369f+HRf9Q==
X-Google-Smtp-Source: ABdhPJz9aQkROn1er0usTHlWN5dkzzcqwlsfWUkI31C5eh3tRJoVWgnRM/2VfrRYbdHEGZO02+uriBp13Xs1fjmj8iQ=
X-Received: by 2002:a05:6102:11f4:: with SMTP id e20mr4200674vsg.21.1643200622423;
 Wed, 26 Jan 2022 04:37:02 -0800 (PST)
MIME-Version: 1.0
References: <0af17d6952b3677dcd413fefa74b086d5ffb474b.camel@rajagiritech.edu.in>
 <YfAKYWOMdGJ0NxjE@kroah.com> <CAG=yYwksvQmEsfRyFiQTbSxUL39WGf7ryHaywtAxgdL1Nt67OQ@mail.gmail.com>
 <YfAk90OPjlpjruV5@kroah.com> <CAG=yYw=BK1gU0UV8g5_ZT5gOe5P2W2rKHWdFyPi4ZHSy4CGMFw@mail.gmail.com>
 <YfEmZiwkdZlQ3DVb@eldamar.lan>
In-Reply-To: <YfEmZiwkdZlQ3DVb@eldamar.lan>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Wed, 26 Jan 2022 18:06:26 +0530
Message-ID: <CAG=yYw==-5tugkdgaA3XeWAOi5ni7waAJ=+qsAecTN=kR8HSnw@mail.gmail.com>
Subject: Re: review for 5.16.3-rc2
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What version of pahole are you using? Are you using Debian
> downstream's 1.22-2? If so please check if it's just the same issue as
> reported in https://bugs.debian.org/1004311
>
> Regards,
> Salvatore
i was using 1.22-2.
i think it is the  debian  issue as you pointed.anyway thanks

-- 
software engineer
rajagiri school of engineering and technology
