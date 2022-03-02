Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7174CA1ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiCBKOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbiCBKOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:14:06 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12E62B278
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:13:22 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c23so1278429ioi.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 02:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n/va5PuoUYUrMdAnEJH/5BVU8R8hPyHSL3l6c3JGTEI=;
        b=7/D7e72U3eXPy0qot+X5W3ZtTrt1LQtQnW4I17LkNgPjd/I6dSguPJpT5PifCuHojs
         yXn8bVzlGwLTyhFC8NAbs5aIDtjpkWqEzp5qpLNj9GN1W06vQ3QrFpHVyMqQWsFe7NYw
         /FUoGQF75G5tfmBo/8MXfMoaCDvnvCQTlad7piOYmjk2Ug8fFe8waFYkRcXQY93Q/F6W
         RiG4S5UiFeYOxOhd6XK5MVmU6Y65fz5frYckWTbYsD1LO0cki7i37iEdlNMAWuFWD9+T
         ugH163XNPpLyfMPZfAvfAey4MdBcqK3xfGSrjB2MiovMyby+U5F8L5VAtIx7RNy/YCQE
         +b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n/va5PuoUYUrMdAnEJH/5BVU8R8hPyHSL3l6c3JGTEI=;
        b=QR48dWpmF/E9lQ92jePPwxcbRwx4CKz/zwXXPHWkN0Y863n3oOBOpij3M3kczT7i5X
         eanvE0/Bs6MqDExT94tRDXeQQLTCNRCMGb5tOoX/EF1DH2hKYVqubagZEX7JHSqqhL8v
         GS6/I1gDvVQw9wzD1k/d4v1QVA3lEx08rpoTjwgTOR7gC9G67kWF8h2JCEf+Cy49Yxk/
         WJxMT25aO2p+VtosWsIsedYBc5xj4wa4e/AOE6QMJPD/P6yfaPBkJFjOjbZb/jh/jltk
         CuhJiJ4HS5J/dsklrmxXwTsYTsnMx8noLLRC/XCsQ2ci7SEA79DoqQgMMmXQecdiPj6X
         Y7KQ==
X-Gm-Message-State: AOAM533FneFs+07bRsefP90OSuaG7QeMLCcUv3JzmWUHTLcKpdJlRSOn
        SQMAYUqvhYkFA/emE6ldiwNkBwPSx1GOrkvIgAlbpA==
X-Google-Smtp-Source: ABdhPJwi5a5pnoBoiow+gCoyvl+naffUXTuNGaq0HgF1hNQyVeEkOReDHm1F1EtCUxzaXxbv9XvBmkxP8lf5wMBMQOs=
X-Received: by 2002:a02:6383:0:b0:314:d9da:13b2 with SMTP id
 j125-20020a026383000000b00314d9da13b2mr24352512jac.99.1646216002260; Wed, 02
 Mar 2022 02:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20220228193928.3ec6ee98@canb.auug.org.au> <YhyPfcjJtIKNQtF8@google.com>
 <Yhyn72NO/roH1gA8@kroah.com> <YhzENKPtY+WOp566@google.com>
 <Yh09/r/nT2LeE82n@kroah.com> <Yh3pZXQPP9kmcSSx@google.com>
 <Yh325S5PyPiJf4F5@kroah.com> <Yh37gTCPaESkgNzV@google.com>
 <Yh6N4mWCfHtlBM07@kroah.com> <Yh8vmWeW+sPz0DdD@google.com>
In-Reply-To: <Yh8vmWeW+sPz0DdD@google.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 2 Mar 2022 11:13:11 +0100
Message-ID: <CA+HBbNF-KZ3+R_+O1e8m1tHfHXKRwqO0uF3D85R9czpYGnot+w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 9:49 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 01 Mar 2022, Greg KH wrote:
> > > > How do you want to see this merged?
> > >
> > > The plan is for the whole set to be merged together via MFD.
> > >
> > > All of the other maintainers have now Acked, so it's ready to go:
> > >
> > >   https://lore.kernel.org/all/20220131133049.77780-1-robert.marko@sar=
tura.hr/
> > >
> > > Looking at the diff, I'm not entirely sure why you took it in the
> > > first place?
> >
> > As I mentioned above, someone else asked me to as it was sitting around
> > for quite a while with no movement.
>
> Okay, just went to investigate.
>
> The set hasn't been merged because it is missing a DT Ack from Rob.

Does anybody know if Rob is active?
He has not replied to any of the patch revisions in many months.
I have tried pinging/bumping on the patches but it did not help.

Regards,
Robert
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
