Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322C25365FF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354157AbiE0QbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiE0QbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 12:31:14 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20CBB17;
        Fri, 27 May 2022 09:31:12 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id n24so1734874uap.13;
        Fri, 27 May 2022 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctFpEEv955RYm+y83Gk0sDmbGcbmbbGg5LVscxsmgxo=;
        b=Pn1KixmuZAFhcxHP25mRFFOo3LdW47hbgFBG9b5TxMqXpnTYtt8PEiUeCiaxpQpy3k
         ATLkutuV5J9u6WDdntlNfKwUG9KZkAggvgUIhrs8gYKPgdsuaWY4iptzDi7azg11k8jc
         +cgYeAyo085ddMVP72CcEKTmfMCK8zN52oXep5XEwJhWz83r7D1fQdyfyG+aOy/yFrmv
         OwE2AOkAec40Ts4tE7ylcJv6cPl79XvSHlpIMXx0r12nnlTLOkplTiDP/VTo5eFNdRRh
         qX6vOFc1rQocr9xXDTiqhL0DlFrjokdAXt+hLl8f0Xc3ET/rHrRGUHga6GjWxI3rG5si
         z0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctFpEEv955RYm+y83Gk0sDmbGcbmbbGg5LVscxsmgxo=;
        b=5ZBO/KLOufB5rE1L7nnLdh5RAdErRCD5CcMOHU4TEKu8HVn1B0qsfKdTmebA6qjYqc
         ynSG6/MABVOZl7ygA34QfOtdko8GqNx8Xzh3vTz5g0u7cOR/by5Fyi6wpHOrTz/TAVOr
         2QD1E5bKNplC6Db3ePIbp6bSMpnhDzJpHgW/1Aod2Cwbe7zp9bPD7d83QTEMj4F179Il
         8/EJ2YzKHXKnOeT0xP71niDfdleyio3IF3EV/tv1IVeXbZ3iSje+rnZWD8bmdIhdrq9a
         KqHP+u5OXhdSKAep37WwOEZ0weTzbyTeTCFrcEyK9P8V7YfKGc5jNC+uJ9undEgY86ev
         yV1g==
X-Gm-Message-State: AOAM532lZvMS7Lwgr+DHxbDS4yjgKwjLfODTSMtFS54D2ibPw53Uhum1
        7b7LPdhoZmUt4dw7eETiWLtB/fuZuMjhAckilcw=
X-Google-Smtp-Source: ABdhPJw1igWtq4LKxiWyloYIkN/kgSJJ/Av3ghuMNGjmv+l7CxiawXBuvCqJJuBSd50EOlst2k98B4M7dUm2UxwA0wY=
X-Received: by 2002:ab0:2008:0:b0:352:2b3a:6bce with SMTP id
 v8-20020ab02008000000b003522b3a6bcemr16212622uak.19.1653669071678; Fri, 27
 May 2022 09:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mug2=wOYp-mwRKWJPRiyh2xtdP06A-i3fVL=JuidMsReQ@mail.gmail.com>
In-Reply-To: <CAH2r5mug2=wOYp-mwRKWJPRiyh2xtdP06A-i3fVL=JuidMsReQ@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 27 May 2022 11:31:00 -0500
Message-ID: <CAH2r5mvCkULdPxYQa4nboPZ+EH27iyRAadeKaomMr9CgcTx-fw@mail.gmail.com>
Subject: Re: [GIT PULL] SMB3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
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

Al wants to postpone Dave's iov_iter changes (he had some additional
things he wants changed in those).  I will resend the P/R without
those 4 patches from Dave Howells.

On Fri, May 27, 2022 at 1:52 AM Steve French <smfrench@gmail.com> wrote:
>
> Please pull the following changes since commit
> 42226c989789d8da4af1de0c31070c96726d990c:
>
>   Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)
>
> are available in the Git repository at:
>
>   git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc-smb3-client-fixes-part1
>
> for you to fetch changes up to 9f114d7bfc6c35ca23a82efce60e0db535a186f1:
>
>   smb3: remove unneeded null check in cifs_readdir (2022-05-26 11:15:14 -0500)
>
> ----------------------------------------------------------------
> Twenty eight cifs/smb3 client fixes, including:
> - a series of fixes for multichannel fixes to improve reconnect after
> network failure
> - improved caching of root directory contents (extending benefit of
> directory leases)
> - 2 DFS fixes
> - 3 fixes for improved debugging
> - an NTLMSSP fix for mounts t0 older servers
> - new mount parm to allow disabling creating sparse files
> - various cleanup fixes and minor fixes pointed out by coverity
> - the first part of Dave's updates for iov_iter support
>
> Not included in this P/R are the last two patches in Dave's series
> converting i/o paths in cifs.ko to use iterators,
> as well as some RDMA (smbdirect) fixes and a patch to dynamically
> requery and adjust the network interfaces on the
> fly - all of which are still being tested.
> ----------------------------------------------------------------
> ChenXiaoSong (1):
>       cifs: return the more nuanced writeback error on close()
>
> David Howells (4):
>       iov_iter: Add a function to extract an iter's buffers to a bvec iter
>       iov_iter: Add a general purpose iteration function
>       cifs: Add some helper functions
>       cifs: Add a function to read into an iter from a socket
>
> Enzo Matsumiya (3):
>       cifs: don't call cifs_dfs_query_info_nonascii_quirk() if nodfs was set
>       cifs: return ENOENT for DFS lookup_cache_entry()
>       cifs: print TIDs as hex
>
> Julia Lawall (1):
>       cifs: smbd: fix typo in comment
>
> Paulo Alcantara (2):
>       cifs: fix signed integer overflow when fl_end is OFFSET_MAX
>       cifs: fix ntlmssp on old servers
>
> Ronnie Sahlberg (4):
>       cifs: move definition of cifs_fattr earlier in cifsglob.h
>       cifs: check for smb1 in open_cached_dir()
>       cifs: set the CREATE_NOT_FILE when opening the directory in
> use_cached_dir()
>       cifs: cache the dirents for entries in a cached directory
>
> Shyam Prasad N (3):
>       cifs: do not use tcpStatus after negotiate completes
>       cifs: use new enum for ses_status
>       cifs: avoid parallel session setups on same channel
>
> Steve French (10):
>       SMB3: EBADF/EIO errors in rename/open caused by race condition
> in smb2_compound_op
>       smb3: add trace point for lease not found issue
>       smb3: add trace point for oplock not found
>       Add defines for various newer FSCTLs
>       Add various fsctl structs
>       cifs: fix minor compile warning
>       smb3: check for null tcon
>       smb3: don't set rc when used and unneeded in query_info_compound
>       smb3: add mount parm nosparse
>       smb3: remove unneeded null check in cifs_readdir
>
>  fs/cifs/cifs_debug.c       |  11 +++-
>  fs/cifs/cifsfs.c           |   2 +
>  fs/cifs/cifsfs.h           |   3 +
>  fs/cifs/cifsglob.h         | 124 +++++++++++++++++++++++++++------------
>  fs/cifs/cifsproto.h        |  12 ++++
>  fs/cifs/cifssmb.c          |  99 ++++++++++++++++++++++++++++++-
>  fs/cifs/connect.c          | 123 +++++++++++++++++++++++----------------
>  fs/cifs/dfs_cache.c        |   6 +-
>  fs/cifs/file.c             |  13 +++--
>  fs/cifs/fs_context.c       |  33 +++--------
>  fs/cifs/fs_context.h       |   4 +-
>  fs/cifs/misc.c             |  11 ++--
>  fs/cifs/readdir.c          | 179
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  fs/cifs/sess.c             |  33 ++++++++++-
>  fs/cifs/smb2inode.c        |   7 ++-
>  fs/cifs/smb2misc.c         |  12 +++-
>  fs/cifs/smb2ops.c          |  32 +++++++++--
>  fs/cifs/smb2pdu.c          |   5 +-
>  fs/cifs/smb2pdu.h          |  22 -------
>  fs/cifs/smb2transport.c    |   7 ++-
>  fs/cifs/smbdirect.c        |   2 +-
>  fs/cifs/trace.h            |   2 +
>  fs/cifs/transport.c        |   8 +--
>  fs/smbfs_common/smb2pdu.h  | 108 +++++++++++++++++++++++++++++++---
>  fs/smbfs_common/smbfsctl.h |   6 ++
>  include/linux/uio.h        |   8 +++
>  lib/iov_iter.c             | 133 ++++++++++++++++++++++++++++++++++++++++++
>  27 files changed, 816 insertions(+), 189 deletions(-)
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
