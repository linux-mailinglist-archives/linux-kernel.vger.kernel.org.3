Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730C248A495
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbiAKAzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiAKAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:55:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC526C06173F;
        Mon, 10 Jan 2022 16:55:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m1so17444723lfq.4;
        Mon, 10 Jan 2022 16:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d4Z67oeBadyouhLSfgiT1gOw7T183RZvhYikXNuX6Io=;
        b=jlFuonFAXsZX9+ZhqlVV/YJ2Fsdbj3rkf96ctjqxWg3igmRxVYXDehoLZONhERoURQ
         5K5NzxIc5NjaIsbkS2/JxRhy6xDj7JOLG7NYgRbF/CctsV7kcwqJLgXhwt0JJau73GYf
         y9XPkGegF+K40BMDJqzbBlCSL4F+RxqVVOakntnhFjt3cH/WSJTxjqpi0t7BGOlgXSgS
         8te5c8vRwwZuP7f+Z1JVNTWyZD5dCbula2juOs1ootTmMCduTcJFotZ/YmhOpcK9EMHb
         QC+7oXuKHLkyFMh78rz/eMCQ9Yh2I+L2GC7Mv8mJmxeEsxga5+EtHD6HtpUHCjGQYnQ1
         H7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4Z67oeBadyouhLSfgiT1gOw7T183RZvhYikXNuX6Io=;
        b=TFaOisiJtk04YYFjIYSI5J42Bo0JcN6d9wDKj0SOfYeIXO1RoaEgKI87NHyMFcJvM/
         PefwsiKjoomotCxvbBv7zBmtBRfM5WJDaz30Suh+/O1TAW4TFTMSLmmZ/M3Gk8CxZql5
         hS8sEuRHGZZQes+G5haQgpUoz4Wwg5alunOhsRb38kYUTG4Sp7SEC3hL2GGFlcR0pzN6
         2jD02la4wS1dcG+VbYdSCVZCxYZz7J6v4w0pr9XlofxfrveU/JXCDE+A/Mx7e4AF7Qse
         jQCjLT1EP1kH3Wc6Vw2xO/lZtI8pFB6/yjR10CMH2rMtb+l2ZxhQSoHWgtVpBmxlqiOD
         jxOg==
X-Gm-Message-State: AOAM530y8qLAhjcBmli8tHGKCXMvd1mophcpDv+ywWtqb71ytfnW3lAu
        cnxjzbbPIZ4BixarTDk5pavFTti0TBeImqQSZsdKe9q9
X-Google-Smtp-Source: ABdhPJzpJOyOkI4Z95j5hFeqJSB2Bkm9S8fK+F+LiM3kFAoh1HsfF/lvtNPnStqu8BlP1JC5vH8RMLI07vRHyLrb+XE=
X-Received: by 2002:a05:6512:3e02:: with SMTP id i2mr1602880lfv.667.1641862533705;
 Mon, 10 Jan 2022 16:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20220111000002.139789-1-jlayton@kernel.org> <CAH2r5mtuDExJ981zs_Y=pDZhRyoTFQkKVcWef3Z=QNkz=QSyyA@mail.gmail.com>
 <394d3b3947c2a95895b0cb8f99dbeb095eacba64.camel@kernel.org>
In-Reply-To: <394d3b3947c2a95895b0cb8f99dbeb095eacba64.camel@kernel.org>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 Jan 2022 18:55:22 -0600
Message-ID: <CAH2r5mtZbkLsTx0wtbHuWYf5U0_RA-+kg9NFyoeB4C7VxABhCQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: move superblock magic defitions to magic.h
To:     Jeff Layton <jlayton@kernel.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 6:29 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2022-01-10 at 18:15 -0600, Steve French wrote:
> > Patch looks fine to me.  Do you want me to add it to the cifs for-next
> > for this merge window, or do you want it merged through a different
> > tree?
> >
>
> If you can take it in via the cifs tree, then that'd be best. I think
> it's a pretty safe patch, but there's no real rush for it. 5.17 or 5.18
> is fine.

Looks safe to me.  Merged into cifs-2.6.git for-next pending testing


> > On Mon, Jan 10, 2022 at 6:00 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > Help userland apps to identify cifs and smb2 mounts.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/cifs/cifsfs.c           | 3 ++-
> > >  fs/cifs/cifsglob.h         | 2 --
> > >  fs/cifs/smb1ops.c          | 3 ++-
> > >  fs/cifs/smb2glob.h         | 2 --
> > >  fs/cifs/smb2ops.c          | 5 +++--
> > >  include/uapi/linux/magic.h | 4 ++++
> > >  6 files changed, 11 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> > > index dca42aa87d30..5a4d56622d2b 100644
> > > --- a/fs/cifs/cifsfs.c
> > > +++ b/fs/cifs/cifsfs.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/random.h>
> > >  #include <linux/uuid.h>
> > >  #include <linux/xattr.h>
> > > +#include <uapi/linux/magic.h>
> > >  #include <net/ipv6.h>
> > >  #include "cifsfs.h"
> > >  #include "cifspdu.h"
> > > @@ -202,7 +203,7 @@ cifs_read_super(struct super_block *sb)
> > >                 sb->s_time_max = ts.tv_sec;
> > >         }
> > >
> > > -       sb->s_magic = CIFS_MAGIC_NUMBER;
> > > +       sb->s_magic = CIFS_SUPER_MAGIC;
> > >         sb->s_op = &cifs_super_ops;
> > >         sb->s_xattr = cifs_xattr_handlers;
> > >         rc = super_setup_bdi(sb);
> > > diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> > > index be74606724c7..50e857e0a311 100644
> > > --- a/fs/cifs/cifsglob.h
> > > +++ b/fs/cifs/cifsglob.h
> > > @@ -24,8 +24,6 @@
> > >  #include "../smbfs_common/smb2pdu.h"
> > >  #include "smb2pdu.h"
> > >
> > > -#define CIFS_MAGIC_NUMBER 0xFF534D42      /* the first four bytes of SMB PDUs */
> > > -
> > >  #define SMB_PATH_MAX 260
> > >  #define CIFS_PORT 445
> > >  #define RFC1001_PORT 139
> > > diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
> > > index 3b83839fc2c2..dcc8b97e2bbf 100644
> > > --- a/fs/cifs/smb1ops.c
> > > +++ b/fs/cifs/smb1ops.c
> > > @@ -7,6 +7,7 @@
> > >
> > >  #include <linux/pagemap.h>
> > >  #include <linux/vfs.h>
> > > +#include <uapi/linux/magic.h>
> > >  #include "cifsglob.h"
> > >  #include "cifsproto.h"
> > >  #include "cifs_debug.h"
> > > @@ -878,7 +879,7 @@ cifs_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
> > >  {
> > >         int rc = -EOPNOTSUPP;
> > >
> > > -       buf->f_type = CIFS_MAGIC_NUMBER;
> > > +       buf->f_type = CIFS_SUPER_MAGIC;
> > >
> > >         /*
> > >          * We could add a second check for a QFS Unix capability bit
> > > diff --git a/fs/cifs/smb2glob.h b/fs/cifs/smb2glob.h
> > > index ca692b2283cd..4125fd113cfb 100644
> > > --- a/fs/cifs/smb2glob.h
> > > +++ b/fs/cifs/smb2glob.h
> > > @@ -13,8 +13,6 @@
> > >  #ifndef _SMB2_GLOB_H
> > >  #define _SMB2_GLOB_H
> > >
> > > -#define SMB2_MAGIC_NUMBER 0xFE534D42
> > > -
> > >  /*
> > >   *****************************************************************
> > >   * Constants go here
> > > diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> > > index c5b1dea54ebc..57e856c195b5 100644
> > > --- a/fs/cifs/smb2ops.c
> > > +++ b/fs/cifs/smb2ops.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/sort.h>
> > >  #include <crypto/aead.h>
> > >  #include <linux/fiemap.h>
> > > +#include <uapi/linux/magic.h>
> > >  #include "cifsfs.h"
> > >  #include "cifsglob.h"
> > >  #include "smb2pdu.h"
> > > @@ -2747,7 +2748,7 @@ smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
> > >                 goto qfs_exit;
> > >
> > >         rsp = (struct smb2_query_info_rsp *)rsp_iov.iov_base;
> > > -       buf->f_type = SMB2_MAGIC_NUMBER;
> > > +       buf->f_type = SMB2_SUPER_MAGIC;
> > >         info = (struct smb2_fs_full_size_info *)(
> > >                 le16_to_cpu(rsp->OutputBufferOffset) + (char *)rsp);
> > >         rc = smb2_validate_iov(le16_to_cpu(rsp->OutputBufferOffset),
> > > @@ -2789,7 +2790,7 @@ smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
> > >
> > >         rc = SMB311_posix_qfs_info(xid, tcon, fid.persistent_fid,
> > >                                    fid.volatile_fid, buf);
> > > -       buf->f_type = SMB2_MAGIC_NUMBER;
> > > +       buf->f_type = SMB2_SUPER_MAGIC;
> > >         SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
> > >         return rc;
> > >  }
> > > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > > index a3034558b018..9438fd4a79c9 100644
> > > --- a/include/uapi/linux/magic.h
> > > +++ b/include/uapi/linux/magic.h
> > > @@ -53,6 +53,7 @@
> > >  #define QNX6_SUPER_MAGIC       0x68191122      /* qnx6 fs detection */
> > >  #define AFS_FS_MAGIC           0x6B414653
> > >
> > > +
> > >  #define REISERFS_SUPER_MAGIC   0x52654973      /* used by gcc */
> > >                                         /* used by file system utilities that
> > >                                            look at the superblock, etc.  */
> > > @@ -61,6 +62,9 @@
> > >  #define REISER2FS_JR_SUPER_MAGIC_STRING        "ReIsEr3Fs"
> > >
> > >  #define SMB_SUPER_MAGIC                0x517B
> > > +#define CIFS_SUPER_MAGIC       0xFF534D42      /* the first four bytes of SMB PDUs */
> > > +#define SMB2_SUPER_MAGIC       0xFE534D42
> > > +
> > >  #define CGROUP_SUPER_MAGIC     0x27e0eb
> > >  #define CGROUP2_SUPER_MAGIC    0x63677270
> > >
> > > --
> > > 2.34.1
> > >
> >
> >
>
> --
> Jeff Layton <jlayton@kernel.org>



-- 
Thanks,

Steve
