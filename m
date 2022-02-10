Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC29E4B17FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344883AbiBJWOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:14:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344871AbiBJWOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:14:16 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825D21107
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:14:16 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g14so19611418ybs.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzTsCVg25jOEc/xpZYzmfEGfUf94ZVS3t/UZfGC+2lo=;
        b=KWkHpDLtazxt6v2gNisdLxNCR3V4u9TjeT/TQyQaw1v8TcBCtydORV69sbjWvAIn3f
         /3JNnbLrUOkgum+LUuQUAE24ojtws1LPibgwA+dDSVakatUgw0+PmHDgko8o/k4CH/jy
         snaAoLir6VxboHWgMsFcW6ONHkX7Gf0FqzFKXT+/aVbd4ukFb+XM4vZifbBHNoWX0qGv
         bQx+uHD3+XTqKDuIBk2rn2HEiq4XQOpbxKRdEOOKnIlNnm7jlNQVeeo1liiZuhmje+jo
         Yd+qe3Z8G2VfzSGRoj7FBn/9jERXb6rtByUU/kCQ72f0c/B6kk1NTB27eJQAs/VWbzUs
         w/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzTsCVg25jOEc/xpZYzmfEGfUf94ZVS3t/UZfGC+2lo=;
        b=dyMEGW+tZYI4oUvsiE1X+LIWgHv7B9kwZCQvZlMgQ0Zz+V+LJkA7CL4mKoghxVIs4C
         GEZG/tPQ0fP/O3cC/lSHW7b700of6ZA5dBuFF9IfSKNENPBvpAD/1r+F1p3QJyptieG8
         wxfmp56qUat1irvt1E4wN0A/H3601JFzE4NoHhoCgZ7VMGQvH4Vbm0e/SKQhqXwsxA4v
         TiToPdyGMV+XsowAPgEBm60kLq5Yyz0JW7+/qeNrseZza4Ms8DBT7wBFmNb6NTXs2XyZ
         fLt3ikfcRLc5dEE/4dkMQm9KfzPN7jnTzGWC905+9SbNLRTqUvZ3AEAZ4/kSgzU3aq4N
         12+A==
X-Gm-Message-State: AOAM532aRRANuGdmhbWpZ13RLystUDWmxTeS9dlMKV7rMJTiPiA72APf
        Z+FXa3SQjFbs2UURXbjfuVXuZRseJjEemu5dxsj7w8SxVlC2Ng==
X-Google-Smtp-Source: ABdhPJz4F7WbPEr0F2YLkQmxbw7f5LqRfio13kMy4Rw8WvaOeqmmqBPWmhAf8DxRWfraaMPqQx8z9M6X4zA1zs7UPfs=
X-Received: by 2002:a81:bd12:: with SMTP id b18mr9687458ywi.136.1644531255734;
 Thu, 10 Feb 2022 14:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20220209205740.9926-1-leonardo.aa88@gmail.com> <YgS2dAHofenuyVjg@kroah.com>
In-Reply-To: <YgS2dAHofenuyVjg@kroah.com>
From:   Leonardo Araujo <leonardo.aa88@gmail.com>
Date:   Thu, 10 Feb 2022 19:14:04 -0300
Message-ID: <CACytOSBrQQg6Zuy6jesmjrbqgTkEKcaCrp7aB+DEuAE917Ww2w@mail.gmail.com>
Subject: Re: [PATCH] Staging: r8188eu: core: Avoid CamelCase: <bEnterPS>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Greg,

first of all, thank you for your time and review. I am learning a lot
from your responses since I started contributing, after I came across
a YouTube video of one of your presentations on how to contribute to
the Linux kernel. I will study the documentation more in depth and
send a proper patch series as you requested.

Best regards,

Leonardo Araujo

Atenciosamente,

Eng. M.Sc. Leonardo A. de Araujo


On Thu, Feb 10, 2022 at 3:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 09, 2022 at 05:57:40PM -0300, Leonardo Araujo wrote:
> > Fixed a coding style issue.
>
> Please read the kernel documentation for how to write better subject
> lines and changelog texts.  These need a lot of work, you can't just put
> the checkpatch message in the subject and then nothing in the changelog
> body.
>
> >
> > Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_cmd.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> > index e42119e16284..4ec4da6d3078 100644
> > --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> > +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> > @@ -880,7 +880,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan)
> >
> >  static void traffic_status_watchdog(struct adapter *padapter)
> >  {
> > -     u8      bEnterPS;
> > +     u8      b_enter_ps;
>
> No, think about what you are changing here.  Why keep the "b" at all?
> What does this variable name?  Why was there a "b" to start with?
>
>
> >       u8      bBusyTraffic = false, bTxBusyTraffic = false, bRxBusyTraffic = false;
>
>
> What about all of these other variables, why ignore them and not send a
> patch series to fix them all up?
>
> Remember where the "b" comes from, this is "hungarian notation" and is
> trying to describe the type of the variable, which makes no sense in
> this century.  Please do not keep it around for no reason at all.
>
> thanks,
>
> greg k-h
