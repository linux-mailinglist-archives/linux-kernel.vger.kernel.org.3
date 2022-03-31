Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416C94ED112
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352159AbiCaAxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343836AbiCaAxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:53:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEC359A74
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:52:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b15so26411153edn.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thejof-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2txw61svx6obcjtGKyD/NG5gYzR+g9VyFSVAJ5BGC8=;
        b=ke6146Xl7kQyN4HNXX3YTzaEu36AaYH3WzPdcfbp/QdKkdE0ZfkuRAq4cocVSGllrn
         H8uY9VYHhipk+s8ibTbgHw6EV+8U30GV/Aud3AEKxLetQn9DwG1fZWNE115ZMK3EqQFt
         PwLMaotZFCV3lL2L8IQVs+cOkyzgNU18x8naLqrXxo+Jr1Rocu3GRTtRC2/v2XwAWcT/
         XXg9iamJ5IJUYFwF0eyi2pCu4SRk+jQ0ktnlq0N2rwWUsZCelq8/3AC0V4xxDh38kMxq
         bovehtHLFIEB/diYtuaCB5peIw01071xPlbmSdHA3zhPaHLvsCwpS092GBavO97Kx81N
         4M8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2txw61svx6obcjtGKyD/NG5gYzR+g9VyFSVAJ5BGC8=;
        b=kzvV/2gRWUIGFuquSlub2zFzjZmrg+vKhMJEKDowxyyR0xd8OXV3w3ESnoJfXhYjgG
         q/ciKGEdOY3Z5zQ5UCs6mDFrKYA3ZCP7ePgEKibVzL153A2ekzSRDH6b6g7EgzgLQnyU
         ZwG/73dDgQ7SqPpTVC07xCFE91LC6pmSygLYWeK8H2cX8sufZRoGy+WuBLQVdiBJXWl2
         KNGxZTi3jryjkcihPv4s0gKmSt0vPyqIZ5/mtVYhYch56dX/lupH8+h7c/A3L200sVMV
         PShB0/M2BToM8Lmj/NKT8eEObvlmu0FoMfpD88gjNUa+4AV9ZC5KaFfdX38cqgsHecxK
         TWwQ==
X-Gm-Message-State: AOAM530P7VnzeWx4Xjp3Xi9qHkEhu+ulGv7laRSV3IOEC9srJcYIX4Fz
        5W+BDF8YmwAhXKLJdb8Gacu8hWYyrA266UoPjgzVyVP6TJ0s6gqa
X-Google-Smtp-Source: ABdhPJxtFISX2R3WRfLxMghC98LkZ+T016cUOqCmnCWHz+8EMJg5/nfouL0rClMtyo6uGdr62rlsu6LMm4H1Ru7nPuQ=
X-Received: by 2002:a50:9b11:0:b0:419:a8f:580c with SMTP id
 o17-20020a509b11000000b004190a8f580cmr14232739edi.292.1648687926294; Wed, 30
 Mar 2022 17:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220324021957.20173-1-jof@thejof.com> <20220325131814.7664f1d43c07b091548be2bf@linux-foundation.org>
In-Reply-To: <20220325131814.7664f1d43c07b091548be2bf@linux-foundation.org>
From:   Jonathan Lassoff <jof@thejof.com>
Date:   Thu, 31 Mar 2022 00:51:55 +0000
Message-ID: <CAHsqw9vcvRzSEBsqpLXWd36fq0-v9yuWY2Jrd_FZtaqb43eAuA@mail.gmail.com>
Subject: Re: [PATCH v2] Add FAT messages to printk index
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022 at 20:18, Andrew Morton <akpm@linux-foundation.org> wrote:
> It would be nice to see some before-and-after sample output to help
> reviewers understand this proposal.

By diffing the output of the debugfs interface
(/sys/kernel/debug/printk/index/vmlinux), it looks like this:

--- before
+++ after
-<-1> fs/fat/misc.c:56 fat_msg "%sFAT-fs (%s): %pV\n"
+<3> fs/fat/dir.c:1323 fat_add_entries "%sFAT-fs (%s): Corrupted
directory (i_pos %lld)"
+<4> fs/fat/dir.c:1066 fat_remove_entries "%sFAT-fs (%s): Couldn't
remove the long name slots"
+<4> fs/fat/dir.c:173 uni16_to_x8 "%sFAT-fs (%s): filename was
truncated while converting."
+<3> fs/fat/dir.c:102 fat__get_entry "%sFAT-fs (%s): Directory
bread(block %llu) failed"
+<3> fs/fat/fatent.c:110 fat_ent_bread "%sFAT-fs (%s): FAT read failed
(blocknr %llu)"
+<3> fs/fat/fatent.c:97 fat12_ent_bread "%sFAT-fs (%s): FAT read
failed (blocknr %llu)"
+<6> fs/fat/inode.c:1889 fat_fill_super "%sFAT-fs (%s): Can't find a
valid FAT filesystem"
+<4> fs/fat/inode.c:1878 fat_fill_super "%sFAT-fs (%s): mounting with
\"discard\" option, but the device does not support discard"
+<3> fs/fat/inode.c:1871 fat_fill_super "%sFAT-fs (%s): get root inode failed"
+<3> fs/fat/inode.c:1837 fat_fill_super "%sFAT-fs (%s): IO charset %s not found"
+<3> fs/fat/inode.c:1829 fat_fill_super "%sFAT-fs (%s): codepage %s not found"
+<3> fs/fat/inode.c:1794 fat_fill_super "%sFAT-fs (%s): count of
clusters too big (%u)"
+<3> fs/fat/inode.c:1766 fat_fill_super "%sFAT-fs (%s): bogus number
of directory entries (%u)"
+<4> fs/fat/inode.c:1738 fat_fill_super "%sFAT-fs (%s): Invalid FSINFO
signature: 0x%08x, 0x%08x (sector = %lu)"
+<3> fs/fat/inode.c:1731 fat_fill_super "%sFAT-fs (%s): bread failed,
FSINFO block (sector = %lu)"
+<3> fs/fat/inode.c:1688 fat_fill_super "%sFAT-fs (%s): unable to read
boot sector (logical sector size = %lu)"
+<3> fs/fat/inode.c:1680 fat_fill_super "%sFAT-fs (%s): unable to set
blocksize %u"
+<3> fs/fat/inode.c:1671 fat_fill_super "%sFAT-fs (%s): logical sector
size too small for device (logical sector size = %u)"
+<3> fs/fat/inode.c:1650 fat_fill_super "%sFAT-fs (%s): unable to read
boot sector"
+<6> fs/fat/inode.c:1580 fat_read_static_bpb "%sFAT-fs (%s): This
looks like a DOS 1.x volume; assuming default BPB values"
+<4> fs/fat/inode.c:1573 fat_read_static_bpb "%sFAT-fs (%s): This
looks like a DOS 1.x volume, but isn't a recognized floppy size (%llu
sectors)"
+<3> fs/fat/inode.c:1559 fat_read_static_bpb "%sFAT-fs (%s): %s; DOS
2.x BPB is non-zero"
+<3> fs/fat/inode.c:1548 fat_read_static_bpb "%sFAT-fs (%s): %s; no
bootstrapping code"
+<3> fs/fat/inode.c:1525 fat_read_bpb "%sFAT-fs (%s): bogus number of
FAT sectors"
+<3> fs/fat/inode.c:1511 fat_read_bpb "%sFAT-fs (%s): bogus logical
sector size %u"
+<3> fs/fat/inode.c:1502 fat_read_bpb "%sFAT-fs (%s): invalid media
value (0x%02x)"
+<3> fs/fat/inode.c:1491 fat_read_bpb "%sFAT-fs (%s): bogus number of
FAT structure"
+<3> fs/fat/inode.c:1485 fat_read_bpb "%sFAT-fs (%s): bogus number of
reserved sectors"
+<4> fs/fat/inode.c:1366 parse_options "%sFAT-fs (%s): utf8 is not a
recommended IO charset for FAT filesystems, filesystem will be case
sensitive!"
+<3> fs/fat/inode.c:1355 parse_options "%sFAT-fs (%s): Unrecognized
mount option \"%s\" or missing value"
+<6> fs/fat/inode.c:1349 parse_options "%sFAT-fs (%s): \"%s\" option
is obsolete, not supported now"
+<3> fs/fat/inode.c:869 __fat_write_inode "%sFAT-fs (%s): unable to
read inode block for updating (i_pos %lld)"
+<3> fs/fat/inode.c:690 fat_set_state "%sFAT-fs (%s): unable to read
boot sector to mark fs as dirty"
+<4> fs/fat/inode.c:682 fat_set_state "%sFAT-fs (%s): Volume was not
properly unmounted. Some data may be corrupt. Please run fsck."
+<4> fs/fat/inode.c:643 fat_free_eofblocks "%sFAT-fs (%s): Failed to
update on disk inode for unused fallocated blocks, inode could be
corrupted. Please run fsck"
+<3> fs/fat/misc.c:86 fat_clusters_flush "%sFAT-fs (%s): Invalid
FSINFO signature: 0x%08x, 0x%08x (sector = %lu)"
+<3> fs/fat/misc.c:79 fat_clusters_flush "%sFAT-fs (%s): bread failed
in fat_clusters_flush"
+<3> fs/fat/misc.c:39 __fat_fs_error "%sFAT-fs (%s): Filesystem has
been set read-only"
+<3> fs/fat/misc.c:31 __fat_fs_error "%sFAT-fs (%s): error, %pV"
+<3> fs/fat/nfs.c:225 fat_rebuild_parent "%sFAT-fs (%s): unable to
read cluster of parent directory"
+<3> fs/fat/nfs.c:73 __fat_nfs_get_inode "%sFAT-fs (%s): unable to
read block(%llu) for building NFS inode"

> > Reported-by: kernel test robot <lkp@intel.com>
>
> We'll need a Signed-off-by: for this, please.
> Documentation/process/submitting-patches.rst describes this.

*facepalm*
Sorry about that and thanks for some patience.... I'm still a total newbie.

In some of the other subsystems, I've gotten some resistance to
mentioning a "semi-stable interface" (with regard to the existing
debugfs interface, since it's not actually making any stability
guarantees), so I'd like to follow up again with a [PATCH v4] that
rewords the message and includes a Signed-off-by:

-- jof
