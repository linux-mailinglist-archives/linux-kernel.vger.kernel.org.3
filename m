Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4813A55F303
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiF2B5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiF2B52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:57:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156FF2E090
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:57:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lw20so29597644ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KjnDuNtpSD7eZexVYfmSL1k8PwdI9ho0cW38MmOj+E8=;
        b=UJ9GnuwqCrZfdS3YduhfsbMWGCPCx3Ssr9rzEW80E44bzl1qukWK1/gctHw5AvJ9hY
         eTALDhTpslk86KYclJAVnpI4z5rNNrhnVCDBRSnRqjCXAEY2//bzMOHnHWsCZClR3XKw
         WQcHR6TtE1VgEvFLKVehYLl9gQHxaoPJPNM/kNKepZcRs9DKxu+mtO9Z6r55C0YbxYYh
         ifac+bwB4wXl4ImhU4dKy8TDAn9qCvWGU9Q4LunPHqUPZSHjlAOojbdMOc5cEH7N79ho
         x+5ro1hZeXcKCfCddPuDOiq0dypr2bg3117ibNndAvWOYs5gGON3aXlAPshMj1NrZui3
         7PSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjnDuNtpSD7eZexVYfmSL1k8PwdI9ho0cW38MmOj+E8=;
        b=7RKgouff1e8aMFMBdCZLUiW3s5MJD2pYUX61gC6ClZreEAOdweZD5pByroDR3EbklJ
         jHy6RE0tj8KxCtgUEfl7nBlTenm5KTSWBCV9mP0hesGbA7T48V4PF4XzOCKm930Z1U7K
         8hbtLh+AGtpAKdhY7UdTxQHj/DbtNKIc8nCEfgKwxZQUPfCA9+ma7UjNv/YlRx2kQpWc
         6Xh7uG/n/KZ3AdtpqjUYa+WmgSd/xPvDs9cK5NPUPjk2/YnBm4XUq9731M2AXdGgmCVx
         MxN1c8ZaWg/5WdPZ6KHX55w/ZG5WmfUCp9KK7JW5mBBcfh3Ya6YPRrZC5L9WdS972sKA
         7NAQ==
X-Gm-Message-State: AJIora8S+T4nFoJGTfyAfZoqJLuTSP7hYeiic8TjItRp4IGcDkNB/h5Z
        lJ/lX+syeyXpkD8g7DNMmsK5i6u4dqKsUBC588Y=
X-Google-Smtp-Source: AGRyM1tuMLXxLNkEoh6G8ObRG/eaf7ivhKlsB652e3VHUvJp/djX5DGU72F2kJcjVmVWw/EfQt2A1nMx9Ofwym/m/0Y=
X-Received: by 2002:a17:907:6e1a:b0:726:9f52:bafc with SMTP id
 sd26-20020a1709076e1a00b007269f52bafcmr922509ejc.413.1656467845654; Tue, 28
 Jun 2022 18:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220628055949.566089-1-dzm91@hust.edu.cn> <CAHc6FU4PR9hwBY1NxdyAMAAh4rY+KHvO26PTSsDBXJ=yHK2msQ@mail.gmail.com>
 <CAD-N9QXikfrnjD-4a8pnLYUFfcm0LdpBaXjO4=CXU5MNS-jvSQ@mail.gmail.com>
In-Reply-To: <CAD-N9QXikfrnjD-4a8pnLYUFfcm0LdpBaXjO4=CXU5MNS-jvSQ@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 29 Jun 2022 09:56:44 +0800
Message-ID: <CAD-N9QX_3PeTYA3-+zJLG4LM3Gst2B2bOEg9fEVXDTx+aYPtwg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix overread in the strlcpy of init_names
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Bob Peterson <rpeterso@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jean Delvare <khali@linux-fr.org>,
        syzkaller <syzkaller@googlegroups.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Jun 29, 2022 at 9:33 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Tue, Jun 28, 2022 at 8:06 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > Dongliang Mu,
> >
> > On Tue, Jun 28, 2022 at 8:10 AM Dongliang Mu <dzm91@hust.edu.cn> wrote:
> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >
> > > In init_names, strlcpy will overread the src string as the src string is
> > > less than GFS2_FSNAME_LEN(256).
> > >
> > > Fix this by modifying strlcpy back to snprintf, reverting
> > > the commit 00377d8e3842.
> >
> > ... if the source string isn't NULL-terminated. But in that case, the
> > code will still do the same thing with this patch. In other words,
> > this doesn't fix anything. So let's check for NULL termination
> > instead.
>
> Partially yes. Even if the source string is NULL-terminated, strlcpy
> will invoke memcpy to overread the adjacent memory of source string as
> the specified length is longer than source string.

The above statement is incorrect after I double check the
implementation of strlcpy.

The correct fix should be NULL-termination check of src string.

>
> >
> > Thanks,
> > Andreas
> >
> > > Fixes: 00377d8e3842 ("[GFS2] Prefer strlcpy() over snprintf()")
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  fs/gfs2/ops_fstype.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> > > index c9b423c874a3..ee29b50d39b9 100644
> > > --- a/fs/gfs2/ops_fstype.c
> > > +++ b/fs/gfs2/ops_fstype.c
> > > @@ -383,8 +383,8 @@ static int init_names(struct gfs2_sbd *sdp, int silent)
> > >         if (!table[0])
> > >                 table = sdp->sd_vfs->s_id;
> > >
> > > -       strlcpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
> > > -       strlcpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);
> > > +       snprintf(sdp->sd_proto_name, GFS2_FSNAME_LEN, "%s", proto);
> > > +       snprintf(sdp->sd_table_name, GFS2_FSNAME_LEN, "%s", table);
> > >
> > >         table = sdp->sd_table_name;
> > >         while ((table = strchr(table, '/')))
> > > --
> > > 2.35.1
> > >
> >
