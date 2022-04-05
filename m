Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C21D4F5001
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383538AbiDFBIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457536AbiDEQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:07:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541D21B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:05:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 5so24120309lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxSv5eyrtE6/qWHKkufe6DV14I2zyM0F7tIcd5vnzO8=;
        b=LeSkYYoDEJNjK8zq0EOP89Hkk3DbuFfJjbUe5+KLYHcUT4m19pDvjujdRTwJ+6G4vB
         8p1DyoVoOyCzKK3e/fxJLLSuxoeIJ8iil2Mcxo3v7StseqwcNFxnHznLz2EhZ1OEYZk9
         /bao3mzDfMSstuCORSfk6Ns0RNTJK0oI9xZbHSil0JJNNqKPU5oidmvsCRPfhXYRRWNj
         ++/rV4cmjyMXE9sqTGedA+0gd2DWodeIB/5zBK/deEpCSPnil+9uYYZi0kVhrhEC3lTn
         eeA/dRf2fw8q6xdthG821zr9lo/+J4Mh/ioMv5Wz6HlDvhXTCgLhQJpWTPo5Aqs4xtts
         k/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxSv5eyrtE6/qWHKkufe6DV14I2zyM0F7tIcd5vnzO8=;
        b=ngWxlhl+REhN1ypsFGL6y4WPlRvRzRAfR+lUkPccfnsXzLZdU9rwOmW5lykSr5somB
         or3QMaOT876qa7zbpARevkqJdbTYznjEx45GhA5a6Xjj85XJvyZTREzPQEUrXuxO3dIA
         k7t1sUUTg7Nrr6uxTsxFZZgyZiQ99qG1DMkopx2vsmYc+IBd1qY3Axrb+bFgYRpsfo0o
         1G+3JFGPWE00c99fvuWXkTd7vAu1XIFXJpMG8UWfs7T5+433to9Lb0SQkYa+3Kn6RbjM
         5GaWzePSap331IagfxA1B72IBUFUxjGNWFWI7VqM3KI1uuSP67LK1w7tI5QXndMJpPWT
         fZdQ==
X-Gm-Message-State: AOAM533KvoEKIPCER6DXl6IYAVBFzSbgyVu7Qa/Lnbpr/MbNoiNRYTde
        avEkfqtJh5WUWa4lbokt88CmvrtGxAPKwdksWh/ZdC64ECc=
X-Google-Smtp-Source: ABdhPJzz/ro4Lc6Ay7slYv/xbuptHLjWeC6GRfWxUOV/UMs/OUe1EaXf8ASQ22RGz1VdFmZ7e0Do10pbasFb0tTipmQ=
X-Received: by 2002:a05:6512:3fa0:b0:44a:f66c:8365 with SMTP id
 x32-20020a0565123fa000b0044af66c8365mr3181106lfa.152.1649174734013; Tue, 05
 Apr 2022 09:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220405150912.GA625670@euclid> <YkxdasBGZ3m2Yu66@kroah.com>
 <CAMWRUK7c-hqiz+KEFkqBuvu1syCwSnF4UZzbkPFw-VWABm9qOw@mail.gmail.com>
 <CAMWRUK7Jgs3evt3bC0pnRkbRw3CS1XCULPi8NzjgGh7aLTFKCQ@mail.gmail.com> <YkxnJvJyo75c/3yk@kroah.com>
In-Reply-To: <YkxnJvJyo75c/3yk@kroah.com>
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date:   Tue, 5 Apr 2022 12:05:22 -0400
Message-ID: <CAMWRUK6Hamw9bg8-O+xqP0DKy=zcbXHaG4RQtqXo3keFj=KJyA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: fix indentation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy linux kernel <outreachy@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 11:58 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 05, 2022 at 11:45:29AM -0400, Sevinj Aghayeva wrote:
> > On Tue, Apr 5, 2022 at 11:19 AM Sevinj Aghayeva
> > <sevinj.aghayeva@gmail.com> wrote:
> > >
> > > On Tue, Apr 5, 2022 at 11:17 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Apr 05, 2022 at 11:09:12AM -0400, Sevinj Aghayeva wrote:
> > > > > Adhere to Linux kernel coding style.
> > > > >
> > > > > Reported by checkpatch:
> > > > >
> > > > > WARNING: suspect code indent for conditional statements
> > > >
> > > > You are also removing unneeded comments, right?  Please explain that as
> > > > the documentation link the bot pointed you to showed.
> > >
> > > I specified that under the --- line:
> > >
> > > v1 -> v2: Remove the comments that became irrelevant with proper indentation.
> >
> > I think I misunderstood the bot's response. It looks like you
> > triggered it because you wanted me to write a more complete
> > description of what the commit is doing. I thought I received it
> > because it was the second version of the patch from a previous
> > patchset (the last bullet point in the bot response) that didn't
> > include v2 in the subject and a v1 -> v2 after the --- line.
>
> That is one reason, yes, but you also need to update the changelog text
> to say everything you are doing in the commit.

Got it.

>
> > I can do a fresh patch with a complete description and no v2 stuff;
> > please let me know.
>
> It will be a v3 patch, right?

Right.

>
> thanks,
>
> greg k-h



-- 

Sevinj.Aghayeva
