Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C15873B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiHAWIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHAWIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63ABDF7D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D8760C41
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 22:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CFFC433C1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 22:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659391696;
        bh=ylL+9XPTLT0fyfN3XB6nY/0p8L0Umvp15CRnPSj8PEk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eCEOamcotY5pzx2fvVikTGr17LdtMvmo2d3CiKXra0H9/+gORgEBAIAI3o0UCMw/+
         iPct8Ou/7E8db8wEyzLQn1bxlRmin/xLKC0ZsC+N+nBOiYofQ3/p0vnrf2ltlpZjqz
         TvXqI8WM9IiB7AT9fppXq9ba5dLgRpT1wmjXrl87Nbij5Da+pkYlrjPoLhjAUwJVYh
         eo204Xiy1ESUJmxWw+PcOZ76O/ODnrem9s/Gy2qbWH9OvIsABMhBMKMl51GncKMLBt
         F1LdAa+WoBLWbhV3tY5MgzdHqOFCbCAbjbZvlezcBjpxw2oOx/aXjZBoddyit2BfHX
         lBU/njiMWORdg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-10e615a36b0so13726723fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 15:08:16 -0700 (PDT)
X-Gm-Message-State: AJIora8Ooe+n/kZT+Z0m2DTWzXwYeJ04ZNQQFyjE1uabhZXtiliI64lh
        x0OKBHebYDkfcI/D3af5EBR85D8ujTINxUIuMjQ=
X-Google-Smtp-Source: AGRyM1uFHoyt5nkrNBN3JG/vwFQGV3aP8wyfui/Gj8uVXKGMucBYfiQ9FFe7YmPzNQ9UMWtFiSPLyi7PG50LUduxsvY=
X-Received: by 2002:a05:6870:f69d:b0:10d:81ea:3540 with SMTP id
 el29-20020a056870f69d00b0010d81ea3540mr8555919oab.257.1659391695878; Mon, 01
 Aug 2022 15:08:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6839:41a4:0:0:0:0 with HTTP; Mon, 1 Aug 2022 15:08:14
 -0700 (PDT)
In-Reply-To: <202208010716.Io52CJih-lkp@intel.com>
References: <202208010716.Io52CJih-lkp@intel.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 2 Aug 2022 07:08:14 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8oi_XuY2AtXWK_TCsZXOsCG4izMSj6TiOMDvneVxFnQg@mail.gmail.com>
Message-ID: <CAKYAXd8oi_XuY2AtXWK_TCsZXOsCG4izMSj6TiOMDvneVxFnQg@mail.gmail.com>
Subject: Re: [samba-ksmbd:ksmbd-for-next-next 12/12] fs/ksmbd/smbacl.c:1213
 smb_check_perm_dacl() warn: variable dereferenced before check 'pntsd' (see
 line 1212)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-08-01 21:10 GMT+09:00, Dan Carpenter <dan.carpenter@oracle.com>:
> tree:   git://git.samba.org/ksmbd.git ksmbd-for-next-next
> head:   d0b73d20ca9100c7b969b65d8a1ff49cdd1fa9c9
> commit: d0b73d20ca9100c7b969b65d8a1ff49cdd1fa9c9 [12/12] ksmbd: fix
> heap-based overflow in set_ntacl_dacl()
> config: arc-randconfig-m041-20220731
> (https://download.01.org/0day-ci/archive/20220801/202208010716.Io52CJih-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 12.1.0
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Hi Dan,

I will fix it.

Thanks for your report!
>
> New smatch warnings:
> fs/ksmbd/smbacl.c:1213 smb_check_perm_dacl() warn: variable dereferenced
> before check 'pntsd' (see line 1212)
> fs/ksmbd/smb2pdu.c:5182 smb2_get_info_sec() error: uninitialized symbol
> 'secdesclen'.
>
> Old smatch warnings:
> fs/ksmbd/smb2pdu.c:549 smb2_allocate_rsp_buf() warn: Please consider using
> kvzalloc instead of kvmalloc
> fs/ksmbd/smb2pdu.c:6123 smb2_read_pipe() warn: Please consider using
> kvzalloc instead of kvmalloc
> fs/ksmbd/smb2pdu.c:6275 smb2_read() warn: Please consider using kvzalloc
> instead of kvmalloc
> fs/ksmbd/smb2pdu.c:6424 smb2_write_rdma_channel() warn: Please consider
> using kvzalloc instead of kvmalloc
>
> vim +/pntsd +1213 fs/ksmbd/smbacl.c
>
> ef24c962d0f290 fs/ksmbd/smbacl.c Hyunchul Lee      2021-06-30  1188  int
> smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1189
> 			__le32 *pdaccess, int uid)
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1190  {
> 465d720485eff1 fs/ksmbd/smbacl.c Hyunchul Lee      2021-07-03  1191  	struct
> user_namespace *user_ns = mnt_user_ns(path->mnt);
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1192  	struct
> smb_ntsd *pntsd = NULL;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1193  	struct
> smb_acl *pdacl;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1194  	struct
> posix_acl *posix_acls;
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1195  	int rc
> = 0, pntsd_size, acl_size, aces_size, pdacl_size, dacl_offset;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1196  	struct
> smb_sid sid;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1197  	int
> granted = le32_to_cpu(*pdaccess & ~FILE_MAXIMAL_ACCESS_LE);
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1198  	struct
> smb_ace *ace;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1199  	int i,
> found = 0;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1200
> 	unsigned int access_bits = 0;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1201  	struct
> smb_ace *others_ace = NULL;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1202  	struct
> posix_acl_entry *pa_entry;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1203
> 	unsigned int sid_type = SIDOWNER;
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1204
> 	unsigned short ace_size;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1205
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1206
> 	ksmbd_debug(SMB, "check permission using windows acl\n");
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1207
> 	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
> af34983e831587 fs/ksmbd/smbacl.c Hyunchul Lee      2021-06-30  1208  					
>  path->dentry, &pntsd);
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1209  	if
> (pntsd_size <= 0)
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1210  		goto
> err_out;
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1211
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28 @1212
> 	dacl_offset = le32_to_cpu(pntsd->dacloffset);
>
>                      ^^^^^^^^^^^^^^^^^
> Dereference
>
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28 @1213  	if
> (!pntsd || !pntsd->dacloffset ||
>
> ^^^^^
> Checked too late
>
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1214  	
> (dacl_offset + sizeof(struct smb_acl) > pntsd_size))
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1215  		goto
> err_out;
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1216
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1217  	pdacl
> = (struct smb_acl *)((char *)pntsd + le32_to_cpu(pntsd->dacloffset));
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1218
> 	acl_size = pntsd_size - dacl_offset;
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1219
> 	pdacl_size = le16_to_cpu(pdacl->size);
> 50355b0b20103a fs/cifsd/smbacl.c Namjae Jeon       2021-03-19  1220
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1221  	if
> (pdacl_size > acl_size || pdacl_size < sizeof(struct smb_acl))
> d0b73d20ca9100 fs/ksmbd/smbacl.c Namjae Jeon       2022-07-28  1222  		goto
> err_out;
> 50355b0b20103a fs/cifsd/smbacl.c Namjae Jeon       2021-03-19  1223
> e2f34481b24db2 fs/cifsd/smbacl.c Namjae Jeon       2021-03-16  1224  	if
> (!pdacl->num_aces) {
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>
>
