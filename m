Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED19587034
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiHASJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiHASJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:09:27 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779D6631F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:09:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f11so10356768pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=buI3P5LUkfgSTkKT1wJ6o5Ld9MFKem6S6jV5l/Tz040=;
        b=TVwpWFePbr7QIkqPK9g0bD8Qm+c+9gedf9K69Au2nuHkik5NrNb8XdmcKPBnRwZm8f
         7uSBSoATG3SUx25HqOfh0vTim/6WsK55SpzGO/PwpdVP+2TcblfmsehXXGDId2CyT+eZ
         0qMKYb+BYfeHN/VqyVXuOIF6z7y0jpkf4lS+ZSptVOLdkrrq13JjRxWg0My42zYZggAq
         KSotrKZLarXj6L5YIpWsY5tsrjZB11YnsHQpO/ZIUzpcgxOGR3ZekGiDp6fMlX+mrqHG
         Azos+VZxcMfjsKogb4CpFsHJHk+bcuf66SoWkYg+DSx1vXBVER9POIebMtatfiSClEvz
         eBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=buI3P5LUkfgSTkKT1wJ6o5Ld9MFKem6S6jV5l/Tz040=;
        b=Kg3OL7DUVt++oRr05o8NXj5r4JwxSdG4woka4pU5OucUB0ot59nUiZtMPyMgF/FKkv
         rKM1v/6Fy14nJcEuV/iMdyUJUG/WVDLWVbAK+x/MpdPx5G/Hr0IgzXilBs3H7lvnrkv9
         IGui/vWN3XD0LCSiIXCC2PG99kpDcF26HCk0Q201oMNGvfK7o39hA5CdLWuZVf+nhn07
         a3JNsKjayX4g2nePrerMxjAWrEFFN0TunhnvE0Lr9qZOjhwITNXiqrmLgXiNYc7vMXfE
         R9NNYi+WQTIMF6087PwrpLbiHAMUMteukR9BoaY1i1qxButCtQ0G2c17j4+yQ7ISdoej
         DYzg==
X-Gm-Message-State: AJIora8IfVoWd8NaVVwWwH2RGWZm6b4iBAthNZgzn/Ge6rKWsDPIfYWr
        0F0bikM4YE1eBR3aFt2ifUqbM1sP/6vTXP9MGLQ=
X-Google-Smtp-Source: AGRyM1skO9OZiznQiXUbkRy30yfoNVffr4YujYni5aDsd2Ou0FtD/t/MZHUSdYd8pTZt4SNUy1tyvd03KGnG1+QiY9k=
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:630e with SMTP id
 b12-20020a056a00114c00b005282c7a630emr17173878pfm.86.1659377365550; Mon, 01
 Aug 2022 11:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220725163246.38486-1-vdasa@vmware.com> <Yt7bfyANrfdPxdS8@kroah.com>
 <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com> <YuAD90UfLnf1Ojso@kroah.com>
 <47D07B41-C327-4908-A383-683FC6C67040@vmware.com> <CAJ60do+Lgnx6gfHncckF-=8F=zzn81tCiFNLOmg_8TyuLGUotw@mail.gmail.com>
 <CAJ60doKSPJbvXoTZDfSmaAV5Sh3-RiqtTUw73S3R3TBknLmqDA@mail.gmail.com>
In-Reply-To: <CAJ60doKSPJbvXoTZDfSmaAV5Sh3-RiqtTUw73S3R3TBknLmqDA@mail.gmail.com>
From:   rajesh jalisatgi <rajeshjalisatgi@gmail.com>
Date:   Mon, 1 Aug 2022 11:09:14 -0700
Message-ID: <CAJ60doLTnYDpLKxCgJo05qERk+2sU+wkX0w=3A8J1kLZVzrmMA@mail.gmail.com>
Subject: Fwd: [PATCH] VMCI: Update maintainers for VMCI
To:     Vishnu Dasa <vdasa@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Bryan Tan <bryantan@vmware.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 8:55 AM Vishnu Dasa <vdasa@vmware.com> wrote:
>
>
> > On Jul 26, 2022, at 8:10 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 25, 2022 at 06:29:25PM +0000, Vishnu Dasa wrote:
> >>
> >>> On Jul 25, 2022, at 11:05 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>
> >>> On Mon, Jul 25, 2022 at 09:32:46AM -0700, vdasa@vmware.com wrote:
> >>>> From: Vishnu Dasa <vdasa@vmware.com>
> >>>>
> >>>> Remove Rajesh as a maintainer for the VMCI driver.
> >>>
> >>> Why?
> >>
> >> Rajesh is no longer with VMware and won't be working on VMCI.
> >
> > But employment does not matter for maintainership and has nothing to do
> > with it.  Maintainership follows the person, not the company, you all
> > know this.
> >
> > So for obvious reasons, I can't take this type of change without Rajesh
> > acking it.
>
> I understand.  After getting in touch with Rajesh, cc'ing him via his personal
> email ID.
>
> Rajesh, could you please provide your ack if you agree with this patch to
> remove you as the maintainer for VMCI?


 I understand that this patch removes me as the maintainer for VMCI.
 Acked-by: Rajesh Jalisatgi <rajeshjalisatgi@gmail.com>

Thanks
Rajesh
