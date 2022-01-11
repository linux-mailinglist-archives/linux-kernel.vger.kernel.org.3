Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68248A435
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbiAKAPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbiAKAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:15:18 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA1C06173F;
        Mon, 10 Jan 2022 16:15:17 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g26so50389941lfv.11;
        Mon, 10 Jan 2022 16:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=92d8AwPw4yRi2sHQ6z2EC/EZpooHKJ1o4fM/qffcFXY=;
        b=ELhaEJfvbEhtsQXWTRivo8aJ+2gdeKPiDXmaiPskq95KBmVtnvnhrHFwJ4Hvcn5OR4
         AWsv4Os8WRpBFGdTqhmX91gmeXMxXKnCETw+ydUi8kIqsVe7QJ9W1aCC3dMPwjxIBHzx
         wxxD8SA8mk+1cPx+J6lsoruSCNTqvNvmXXpb4pgq7tuGp98FAPtn5Q0dpoottDKXU64f
         4iZ1RLtLjdojfcMjLBZJAQO8S/EVozwYUPyWHyzkmF4dEplV1H9NR4tiihVoA2EG5oHd
         Szn9P/c8J4clMRyQfQTtA/HkMTTuGd+kWG7R6ZFHtW8WvUSIXADvIO63Vg9LWBb8QsZz
         6AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92d8AwPw4yRi2sHQ6z2EC/EZpooHKJ1o4fM/qffcFXY=;
        b=GMMOWclM4fI0eToqpPXOJ2tIoLp8SJg6ACNse6m+G77npRDKwFdiX6kxHLM6iXM1YF
         XOMAKzFlt5lLEEQ5vbE5cfhB3ehlHW8e9RSkHsGJc9wze//8oa3JMcOdhp9Gc6PB76OX
         a5A/OzSfz6MTQ1PKMyPWi58fk2vpVPXKxm57CHNJ7dSFJVLuYmNxm7ujKh2+Cp4ybOtm
         dtqzZaQtE88fIff74VxG6vsuEfHYMqLf9gfUDv/MmUaSprkXsiG7cZZSy0yLDsBmCmMZ
         2d8vh6ztXT4UAmm1nUb1U0ksPYQEliB18dANMDbT/bh3DJD7sbNg5wBV0ZkFms2VK2HG
         6qFg==
X-Gm-Message-State: AOAM532WLScKlp7zqktkBhLwcsn5oPBCfiAe8iuEimBOHBU41engd7c7
        LossCnKBPnfygm/s9EccVNd/2f3C9bPUyY/tlv4+EwGE
X-Google-Smtp-Source: ABdhPJyxK4gD/3/HIg7bkF1mYOSnLlahLwI7orMRBRWo+m+auhN2Sehp13SiQKg8FVBCSltuWkbwEMc8MHSZw3NNF98=
X-Received: by 2002:a2e:aa9b:: with SMTP id bj27mr1223272ljb.23.1641860115541;
 Mon, 10 Jan 2022 16:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20220111000002.139789-1-jlayton@kernel.org>
In-Reply-To: <20220111000002.139789-1-jlayton@kernel.org>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 Jan 2022 18:15:04 -0600
Message-ID: <CAH2r5mtuDExJ981zs_Y=pDZhRyoTFQkKVcWef3Z=QNkz=QSyyA@mail.gmail.com>
Subject: Re: [PATCH] cifs: move superblock magic defitions to magic.h
To:     Jeff Layton <jlayton@kernel.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks fine to me.  Do you want me to add it to the cifs for-next
for this merge window, or do you want it merged through a different
tree?

On Mon, Jan 10, 2022 at 6:00 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> Help userland apps to identify cifs and smb2 mounts.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/cifs/cifsfs.c           | 3 ++-
>  fs/cifs/cifsglob.h         | 2 --
>  fs/cifs/smb1ops.c          | 3 ++-
>  fs/cifs/smb2glob.h         | 2 --
>  fs/cifs/smb2ops.c          | 5 +++--
>  include/uapi/linux/magic.h | 4 ++++
>  6 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index dca42aa87d30..5a4d56622d2b 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -26,6 +26,7 @@
>  #include <linux/random.h>
>  #include <linux/uuid.h>
>  #include <linux/xattr.h>
> +#include <uapi/linux/magic.h>
>  #include <net/ipv6.h>
>  #include "cifsfs.h"
>  #include "cifspdu.h"
> @@ -202,7 +203,7 @@ cifs_read_super(struct super_block *sb)
>                 sb->s_time_max = ts.tv_sec;
>         }
>
> -       sb->s_magic = CIFS_MAGIC_NUMBER;
> +       sb->s_magic = CIFS_SUPER_MAGIC;
>         sb->s_op = &cifs_super_ops;
>         sb->s_xattr = cifs_xattr_handlers;
>         rc = super_setup_bdi(sb);
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index be74606724c7..50e857e0a311 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -24,8 +24,6 @@
>  #include "../smbfs_common/smb2pdu.h"
>  #include "smb2pdu.h"
>
> -#define CIFS_MAGIC_NUMBER 0xFF534D42      /* the first four bytes of SMB PDUs */
> -
>  #define SMB_PATH_MAX 260
>  #define CIFS_PORT 445
>  #define RFC1001_PORT 139
> diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
> index 3b83839fc2c2..dcc8b97e2bbf 100644
> --- a/fs/cifs/smb1ops.c
> +++ b/fs/cifs/smb1ops.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/pagemap.h>
>  #include <linux/vfs.h>
> +#include <uapi/linux/magic.h>
>  #include "cifsglob.h"
>  #include "cifsproto.h"
>  #include "cifs_debug.h"
> @@ -878,7 +879,7 @@ cifs_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
>  {
>         int rc = -EOPNOTSUPP;
>
> -       buf->f_type = CIFS_MAGIC_NUMBER;
> +       buf->f_type = CIFS_SUPER_MAGIC;
>
>         /*
>          * We could add a second check for a QFS Unix capability bit
> diff --git a/fs/cifs/smb2glob.h b/fs/cifs/smb2glob.h
> index ca692b2283cd..4125fd113cfb 100644
> --- a/fs/cifs/smb2glob.h
> +++ b/fs/cifs/smb2glob.h
> @@ -13,8 +13,6 @@
>  #ifndef _SMB2_GLOB_H
>  #define _SMB2_GLOB_H
>
> -#define SMB2_MAGIC_NUMBER 0xFE534D42
> -
>  /*
>   *****************************************************************
>   * Constants go here
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index c5b1dea54ebc..57e856c195b5 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -13,6 +13,7 @@
>  #include <linux/sort.h>
>  #include <crypto/aead.h>
>  #include <linux/fiemap.h>
> +#include <uapi/linux/magic.h>
>  #include "cifsfs.h"
>  #include "cifsglob.h"
>  #include "smb2pdu.h"
> @@ -2747,7 +2748,7 @@ smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
>                 goto qfs_exit;
>
>         rsp = (struct smb2_query_info_rsp *)rsp_iov.iov_base;
> -       buf->f_type = SMB2_MAGIC_NUMBER;
> +       buf->f_type = SMB2_SUPER_MAGIC;
>         info = (struct smb2_fs_full_size_info *)(
>                 le16_to_cpu(rsp->OutputBufferOffset) + (char *)rsp);
>         rc = smb2_validate_iov(le16_to_cpu(rsp->OutputBufferOffset),
> @@ -2789,7 +2790,7 @@ smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
>
>         rc = SMB311_posix_qfs_info(xid, tcon, fid.persistent_fid,
>                                    fid.volatile_fid, buf);
> -       buf->f_type = SMB2_MAGIC_NUMBER;
> +       buf->f_type = SMB2_SUPER_MAGIC;
>         SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
>         return rc;
>  }
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index a3034558b018..9438fd4a79c9 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -53,6 +53,7 @@
>  #define QNX6_SUPER_MAGIC       0x68191122      /* qnx6 fs detection */
>  #define AFS_FS_MAGIC           0x6B414653
>
> +
>  #define REISERFS_SUPER_MAGIC   0x52654973      /* used by gcc */
>                                         /* used by file system utilities that
>                                            look at the superblock, etc.  */
> @@ -61,6 +62,9 @@
>  #define REISER2FS_JR_SUPER_MAGIC_STRING        "ReIsEr3Fs"
>
>  #define SMB_SUPER_MAGIC                0x517B
> +#define CIFS_SUPER_MAGIC       0xFF534D42      /* the first four bytes of SMB PDUs */
> +#define SMB2_SUPER_MAGIC       0xFE534D42
> +
>  #define CGROUP_SUPER_MAGIC     0x27e0eb
>  #define CGROUP2_SUPER_MAGIC    0x63677270
>
> --
> 2.34.1
>


-- 
Thanks,

Steve
