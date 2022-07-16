Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD468576B80
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 05:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiGPDr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 23:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGPDr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 23:47:27 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B2B186EF;
        Fri, 15 Jul 2022 20:47:26 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id l190so5884803vsc.0;
        Fri, 15 Jul 2022 20:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGWfWYXPfiLvd3vbWyevJ7CNG70A+KKafGnsLWBzmhQ=;
        b=BJLdSuZMAjyLFWccG4cfKkDk0+ocVeQ4ngluR72PnJWHGuQ68HvDDHXgAt+Mmxe6WC
         EIS1FaeHTDxK2PdJmnHW9HTt+3xHifpUqw2dXV1z09C0Lksupe+oV0kj2X+CsjDxZCyP
         h3riAwmShyLV7PqCvnYHWjNv0C106qMNfHQlNTJouHGWc+LGqs1U8H4saJbHeJQhscqu
         TBRfJ+OGNDTkq+byEQ0KhOBHgQW+gNqxxp7rlNX3eb6lwlEW40AwCbcIFDoMJOWuTRqZ
         XZEBnJjzHwQ6ceycVctxbyy1oM8BBFMcz8hkz0y1v9EvAjvI6Jylc9NTCu/WkoqIJeiK
         27wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGWfWYXPfiLvd3vbWyevJ7CNG70A+KKafGnsLWBzmhQ=;
        b=mosrsgomkVXqcBzS/jBZR8Oop2ImQaz+8RN1IYNZb4g3qwbtXdW5VzvKB1RCeTbKQy
         +W2GAc3A0AzAGO8m7xMVYPOvnUGr6QAV1KCyuCEeCP506EwzF+HGwPEXGo5FcpGR4rpr
         ugHqR0tvaHyuJVsm2aRldTsF34BKY54mXQXcpZNbGIacLXZSvWKdI0w0Etd5LpYpA2Fn
         i0eE5hwmtn9GX5XKNui7Y21b6c+62wqgI3FYnC69UheOCrlhLtZXKl6T7PKuADnHR9//
         QIOwbZdvqoGjrhzvV/mz7chRQnT3ap5RHdsyuS9HF5CUf+cksVIGARizrCugB5wKKTLF
         DfPw==
X-Gm-Message-State: AJIora/HuDUvSCAohqBU0+9SzuisPSR2Xm6trVNXtYqVSXziFIxMVhoA
        zb/1f4JLXWS6RbraG6dhMaA2SwcgXGK0UmTmaM5o7AvcD5E=
X-Google-Smtp-Source: AGRyM1tx8tFiDZjLT1QTBMByoqYqfgK/aCT2vNiHoLT+Auh0f4oSTW1bdA3gdqAvJcKRxQ5iW/k8xJ/vRG5ugDNkMMQ=
X-Received: by 2002:a67:c98e:0:b0:356:fb90:f729 with SMTP id
 y14-20020a67c98e000000b00356fb90f729mr7377409vsk.17.1657943245480; Fri, 15
 Jul 2022 20:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220630093027.26200-1-yuzhe@nfschina.com>
In-Reply-To: <20220630093027.26200-1-yuzhe@nfschina.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 15 Jul 2022 22:47:14 -0500
Message-ID: <CAH2r5mvOwRH_N8NuouK=N0yDqcCZD2chxZM=52y11a5-yrZAeg@mail.gmail.com>
Subject: Re: [PATCH] cifs: remove unnecessary type castings
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>, liqiong@nfschina.com
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

merged into cifs-2.6.git for-next

On Thu, Jun 30, 2022 at 4:38 AM Yu Zhe <yuzhe@nfschina.com> wrote:
>
> remove unnecessary void* type castings.
>
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  fs/cifs/connect.c  | 2 +-
>  fs/cifs/inode.c    | 4 ++--
>  fs/cifs/netmisc.c  | 2 +-
>  fs/cifs/smb2misc.c | 2 +-
>  fs/cifs/smb2pdu.c  | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index fa29c9aae24b..90863b3b5204 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -2646,7 +2646,7 @@ match_prepath(struct super_block *sb, struct cifs_mnt_data *mnt_data)
>  int
>  cifs_match_super(struct super_block *sb, void *data)
>  {
> -       struct cifs_mnt_data *mnt_data = (struct cifs_mnt_data *)data;
> +       struct cifs_mnt_data *mnt_data = data;
>         struct smb3_fs_context *ctx;
>         struct cifs_sb_info *cifs_sb;
>         struct TCP_Server_Info *tcp_srv;
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index 81da81e18553..3ad303dd5e5a 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -1223,7 +1223,7 @@ static const struct inode_operations cifs_ipc_inode_ops = {
>  static int
>  cifs_find_inode(struct inode *inode, void *opaque)
>  {
> -       struct cifs_fattr *fattr = (struct cifs_fattr *) opaque;
> +       struct cifs_fattr *fattr = opaque;
>
>         /* don't match inode with different uniqueid */
>         if (CIFS_I(inode)->uniqueid != fattr->cf_uniqueid)
> @@ -1247,7 +1247,7 @@ cifs_find_inode(struct inode *inode, void *opaque)
>  static int
>  cifs_init_inode(struct inode *inode, void *opaque)
>  {
> -       struct cifs_fattr *fattr = (struct cifs_fattr *) opaque;
> +       struct cifs_fattr *fattr = opaque;
>
>         CIFS_I(inode)->uniqueid = fattr->cf_uniqueid;
>         CIFS_I(inode)->createtime = fattr->cf_createtime;
> diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
> index 235aa1b395eb..28caae7aed1b 100644
> --- a/fs/cifs/netmisc.c
> +++ b/fs/cifs/netmisc.c
> @@ -911,7 +911,7 @@ map_and_check_smb_error(struct mid_q_entry *mid, bool logErr)
>  unsigned int
>  smbCalcSize(void *buf, struct TCP_Server_Info *server)
>  {
> -       struct smb_hdr *ptr = (struct smb_hdr *)buf;
> +       struct smb_hdr *ptr = buf;
>         return (sizeof(struct smb_hdr) + (2 * ptr->WordCount) +
>                 2 /* size of the bcc field */ + get_bcc(ptr));
>  }
> diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
> index 17813c3d0c6e..db0f27fd373b 100644
> --- a/fs/cifs/smb2misc.c
> +++ b/fs/cifs/smb2misc.c
> @@ -402,7 +402,7 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *shdr)
>  unsigned int
>  smb2_calc_size(void *buf, struct TCP_Server_Info *srvr)
>  {
> -       struct smb2_pdu *pdu = (struct smb2_pdu *)buf;
> +       struct smb2_pdu *pdu = buf;
>         struct smb2_hdr *shdr = &pdu->hdr;
>         int offset; /* the offset from the beginning of SMB to data area */
>         int data_length; /* the length of the variable length data area */
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 12b4dddaedb0..92fb513e5478 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -354,7 +354,7 @@ fill_small_buf(__le16 smb2_command, struct cifs_tcon *tcon,
>                void *buf,
>                unsigned int *total_len)
>  {
> -       struct smb2_pdu *spdu = (struct smb2_pdu *)buf;
> +       struct smb2_pdu *spdu = buf;
>         /* lookup word count ie StructureSize from table */
>         __u16 parmsize = smb2_req_struct_sizes[le16_to_cpu(smb2_command)];
>
> --
> 2.11.0
>


-- 
Thanks,

Steve
