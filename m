Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE1491137
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbiAQVBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiAQVBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:01:36 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6775C061574;
        Mon, 17 Jan 2022 13:01:35 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id m196so21138487ybf.4;
        Mon, 17 Jan 2022 13:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/L36AdK5Ipen2tmpRXUP0pX59XDvEK9cBawMrh2MjE=;
        b=DligtBPwqn6VtiU+rpAn5X+wN11F98GkoqMRJbBi53/INouP3OZYi4BtPYLmhfHf7W
         YAbGiO6l/guh3I1zu20VxIFUqvd2xlQ4X2C7GWESOPxMC1Rtmvysn0lBEoc0krZG2eDh
         +EHyAxlxaB91ofBqytmoOm6j3O3EhP+ujjSCroUGMLct0ASx49rMLrK95JesRNrkO97j
         L/5hAuK3K08Y80yWzXfXX9DtZqRenb2y2Gnm40NOQvZUaal9aV8Q+puBweI0GDpnJ31Z
         mPVhhzwNuk8lvKAdau1XGZj3HSTJpTLmM3eurQKuW6CJNz//eHH4uJEJaB28/wgmpS8m
         uyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/L36AdK5Ipen2tmpRXUP0pX59XDvEK9cBawMrh2MjE=;
        b=FvdIVExb3eHWlsvtpTVHkYIw+ps3EvojSl+O2i31Hj7uhJnvg4JPF14Ib0C3BxnV01
         ErcgPYh8kDvAeMEV7Kx4QZEum8MtMTth2tjQqtXPrSE5S+yNCXUksAHcdZ29WvBpbiw5
         2m9BSSwMDPWoN58g6xY/efcGzMXC2tc2nUVEkCnLa+b3RCho95zgqwi2xPq0BZM0GRuh
         6JcOs3DIBmCQhVmsroMf9qOgtj+N/DiMqWnVI4gKbgTA7ej3LgtFRfiLyxOJO6LDN1aF
         /NJES2X2ZaykDxM6vBPhzBDDb6QERjUixRd3KARqSS9W2XG1Umkc+UJVzFhfYlZhwTRM
         06kg==
X-Gm-Message-State: AOAM533TElS5eNJTUFJVpADAq0NfL0HPJDHjC0Vcngt/KX4hEJjQTecl
        dTccfLYfkEt+SjVBe4SJPKGU6Rrxe/xY7m2uN1kSmcRf
X-Google-Smtp-Source: ABdhPJz2qC1gbLERDHPFPmDnVv4rb4ybLBXYBQWsc0lxZSVX9k2ZYOya1CMbAN8jg7o53QZDYaTP6MHHW0h2Q+EsfXA=
X-Received: by 2002:a25:b184:: with SMTP id h4mr13155000ybj.738.1642453295121;
 Mon, 17 Jan 2022 13:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20220114064625.765511-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20220114064625.765511-1-deng.changcheng@zte.com.cn>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Tue, 18 Jan 2022 07:01:23 +1000
Message-ID: <CAN05THS5A5r8PgaHk8BaK+8kTyT8mJ3LdB__tJCbSb8Cs+yaKQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: Replace one-element array with flexible-array member
To:     cgel.zte@gmail.com
Cc:     Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is wrong.
qi_iov is not even the trailing element of the array so we cant change
it to be a flexible array member.
This change will likely clobber io_iov so the potential for breaking,
memory leaks or ooops is quite possible.
qi_iov is supposed to be exactly one element in size.

Same for close_iov, while it is the last element in the structure, it
is not a flexible array but an array of exactly one member.
This change to close_iov would likely lead to reading/writing beyond
the end of the structure.


NACK

On Sat, Jan 15, 2022 at 12:44 AM <cgel.zte@gmail.com> wrote:
>
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use "flexible array members" for these cases. The older
> style of one-element or zero-length arrays should no longer be used.
> Reference:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  fs/cifs/smb2ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index af5d0830bc8a..5c104b2f308a 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -1609,10 +1609,10 @@ struct iqi_vars {
>         struct smb_rqst rqst[3];
>         struct kvec rsp_iov[3];
>         struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
> -       struct kvec qi_iov[1];
> +       struct kvec qi_iov[];
>         struct kvec io_iov[SMB2_IOCTL_IOV_SIZE];
>         struct kvec si_iov[SMB2_SET_INFO_IOV_SIZE];
> -       struct kvec close_iov[1];
> +       struct kvec close_iov[];
>  };
>
>  static int
> --
> 2.25.1
>
