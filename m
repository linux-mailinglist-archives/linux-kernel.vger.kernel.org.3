Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB34E39B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbiCVHeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbiCVHeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:34:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65231EED6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:32:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x2so1217582plm.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fRHXHdq9sIkqlyiTxFiQtH6G5pXkSNbmNTGgMTt0bOQ=;
        b=TPx0oSwO7h7QEO5cqVFXwB3quVvtz268JdYpCk4br1Z1poT3D5vabUCpXkj1Bw/0q/
         EWzq+l6NO3fRcHm1TaW+NEI1Ov3NlEgTmYp9j7/sLFBPrFkquSpRF8FcAv+1Oqzbkr86
         M6yhcpvgFWhJIf27qIkYNI4YE298oHeYqP9bgMtmUlYa1IEHnDcQa+ZWAmeECODAzLPz
         Vjq28gs1Y6UqLA+8gt7bifwCHOWQBWMkID775EQDZFSUMCpu8nV8M6kGRa2SYRVoiJEA
         4z/BXLFlT9VWAppunT+8ru6ncAoF22Bck764+A27DzCNobDVJ3yhjCX2T+mK7fOLj42z
         i+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fRHXHdq9sIkqlyiTxFiQtH6G5pXkSNbmNTGgMTt0bOQ=;
        b=V4FNCkQ6DDA8wtVIAdchmVyU8fatG4Z7Q1J9gZ7g2oBuQm+ry/zDrgt/RWHeHjpehN
         VeXH2SgUPIaE+Zu6w1sP1TAHi/NH10n15nYoUOXrDGgjU/s/BgGcnz5bckqcILQlWbV7
         R2hh1mP9x1mHJ77LCT63Fhmxv3Mw+LoxG5Hw9VhyiPULr0IwJRTFUolwseYafo0vWT3H
         j5WNHFCVY230xHlKiw1gTsOR7RauEdus0fMJSwDZJezO58abMEGCIVbxkboUyE813cyz
         Hbck5EJcoC7Jb9mtYTJxS/cCKbL9hg1NXxWyEVDTc/7pEXvPCdgHs9kNO/LxbDSz5/wB
         LemA==
X-Gm-Message-State: AOAM531L0vBchNfRxMI/U3K/O45NP3afBLCu86u91iVKXo6+yOLi+8Vt
        V3ymwU6YMQWQvrdqz+Tuau4=
X-Google-Smtp-Source: ABdhPJyZ8PXs4+Jcc1F4UyJFa/ztfwHtvkcDB32PwMh9G/DmRB62d3fWuPMCpuOeiuruGnmIh+nGjA==
X-Received: by 2002:a17:902:6941:b0:14c:b815:6d45 with SMTP id k1-20020a170902694100b0014cb8156d45mr16816192plt.49.1647934360078;
        Tue, 22 Mar 2022 00:32:40 -0700 (PDT)
Received: from [30.225.24.67] ([47.246.98.147])
        by smtp.gmail.com with ESMTPSA id d24-20020a637358000000b003823aefde04sm10119063pgn.86.2022.03.22.00.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 00:32:39 -0700 (PDT)
Message-ID: <0bb64f66-6343-72d4-3948-6c6dd49be41a@gmail.com>
Date:   Tue, 22 Mar 2022 15:32:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: quota_local: fix mount crash of
 filesystems with quota enabled
Content-Language: en-US
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     linux-kernel@vger.kernel.org, Tuo Li <islituo@gmail.com>,
        Dayvison <sathlerds@gmail.com>, ocfs2-devel@oss.oracle.com,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20220322031215.1449435-1-vvidic@valentin-vidic.from.hr>
From:   Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <20220322031215.1449435-1-vvidic@valentin-vidic.from.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/22 11:12 AM, Valentin Vidic via Ocfs2-devel wrote:
> ocfs2_qinfo_lock_res_init is called too early while oinfo->dqi_gi.dqi_s=
b
> is still a NULL pointer causing a crash on mount when quotas are enable=
d.
> Restore ocfs2_qinfo_lock_res_init original call location in
> ocfs2_global_read_info after the value of oinfo->dqi_gi.dqi_sb is set.
>=20
> [  389.111864] ocfs2: Mounting device (254,16) on (node 2, slot 0) with=
 ordered data mode.
> [  389.160182] BUG: kernel NULL pointer dereference, address: 000000000=
0000398
> [  389.160295] #PF: supervisor read access in kernel mode
> [  389.160343] #PF: error_code(0x0000) - not-present page
> [  389.160390] PGD 0 P4D 0
> [  389.160432] Oops: 0000 [#1] PREEMPT SMP PTI
> [  389.160477] CPU: 0 PID: 836 Comm: mount.ocfs2 Not tainted 5.16.0-4-a=
md64 #1  Debian 5.16.12-1
> [  389.160591] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.14.0-2 04/01/2014
> [  389.160714] RIP: 0010:ocfs2_qinfo_lock_res_init+0x44/0x50 [ocfs2]
> [  389.161290] Code: 00 00 00 48 63 b3 b8 01 00 00 e8 87 bb ff ff 49 89=
 d8 48 89 ee ba 08 00 00 00 48 8b 83 b0 01 00 00 48 c7 c1 a0 e0 dc c0 5b =
5d <48> 8b b8 98 03 00 00 e9 70 c4 ff ff 0f 1f 44 00 00 41 56 41 89 ce
> [  389.161460] RSP: 0018:ffffb2c0c0047be8 EFLAGS: 00010282
> [  389.161510] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fffffff=
fc0dce0a0
> [  389.161619] RDX: 0000000000000008 RSI: ffff8b685c343c30 RDI: ffffb2c=
0c0047bb8
> [  389.161747] RBP: ffff8b685c343c00 R08: ffff8b685c343c00 R09: 0000000=
000000000
> [  389.161809] R10: ffffb2c0c0047bb0 R11: ffffffffc0d8f030 R12: ffff8b6=
85c343c18
> [  389.161868] R13: ffff8b68462d3ec8 R14: 0000000000000000 R15: ffff8b6=
848fb6800
> [  389.161929] FS:  00007f7956901c00(0000) GS:ffff8b687ec00000(0000) kn=
lGS:0000000000000000
> [  389.162009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  389.162060] CR2: 0000000000000398 CR3: 000000000554a004 CR4: 0000000=
000370ef0
> [  389.162129] Call Trace:
> [  389.162184]  <TASK>
> [  389.162211]  ocfs2_local_read_info+0xb9/0x6f0 [ocfs2]
> [  389.162479]  ? ocfs2_local_check_quota_file+0x197/0x390 [ocfs2]
> [  389.162774]  dquot_load_quota_sb+0x216/0x470
> [  389.162849]  ? preempt_count_add+0x68/0xa0
> [  389.162895]  dquot_load_quota_inode+0x85/0x100
> [  389.162943]  ocfs2_enable_quotas+0xa0/0x1c0 [ocfs2]
> [  389.163151]  ocfs2_fill_super.cold+0xc8/0x1bf [ocfs2]
> [  389.163374]  mount_bdev+0x185/0x1b0
> [  389.163431]  ? ocfs2_initialize_super.isra.0+0xf40/0xf40 [ocfs2]
> [  389.163673]  legacy_get_tree+0x27/0x40
> [  389.163726]  vfs_get_tree+0x25/0xb0
> [  389.163764]  path_mount+0x465/0xac0
> [  389.163804]  __x64_sys_mount+0x103/0x140
> [  389.163844]  do_syscall_64+0x3b/0xc0
> [  389.163919]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  389.164016] RIP: 0033:0x7f7956e0258a
> [  389.164057] Code: 48 8b 0d e9 28 0d 00 f7 d8 64 89 01 48 83 c8 ff c3=
 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b6 28 0d 00 f7 d8 64 89 01 48
> [  389.164206] RSP: 002b:00007fff9be78718 EFLAGS: 00000246 ORIG_RAX: 00=
000000000000a5
> [  389.164273] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7=
956e0258a
> [  389.164334] RDX: 000055bffbe230ae RSI: 000055bffc7ec370 RDI: 000055b=
ffc7f33f0
> [  389.164395] RBP: 00007fff9be788d0 R08: 000055bffc7f3390 R09: 00007ff=
f9be76110
> [  389.164454] R10: 0000000000000000 R11: 0000000000000246 R12: 000055b=
ffbe230ae
> [  389.164514] R13: 000055bffc7ec301 R14: 00007fff9be787c0 R15: 00007ff=
f9be78740
> [  389.166469]  </TASK>
> [  389.168355] Modules linked in: ocfs2 quota_tree ocfs2_dlmfs ocfs2_st=
ack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue sctp ip6_udp_tunnel =
udp_tunnel libcrc32c intel_rapl_msr intel_rapl_common intel_pmc_core_pltd=
rv intel_pmc_core kvm_intel kvm irqbypass ghash_clmulni_intel snd_hda_cod=
ec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acp=
i aesni_intel crypto_simd qxl snd_hda_codec cryptd drm_ttm_helper rapl sn=
d_hda_core ttm snd_hwdep snd_pcm serio_raw snd_timer iTCO_wdt pcspkr inte=
l_pmc_bxt iTCO_vendor_support drm_kms_helper snd virtio_rng rng_core soun=
dcore virtio_balloon virtio_console cec evdev joydev i6300esb rc_core wat=
chdog qemu_fw_cfg button auth_rpcgss sunrpc drm fuse configfs ip_tables x=
_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic hid_generic usbhid=
 hid virtio_net net_failover failover virtio_blk ahci xhci_pci libahci li=
bata xhci_hcd crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel=
 virtio_pci virtio_pci_legacy_dev virtio_pci_modern
>  _dev
> [  389.168645]  virtio psmouse usbcore scsi_mod i2c_i801 i2c_smbus scsi=
_common lpc_ich usb_common virtio_ring
> [  389.187016] CR2: 0000000000000398
> [  389.188963] ---[ end trace 571e3ca036b59855 ]---
>=20
> Fixes: 6c85c2c72819 ("ocfs2: quota_local: fix possible uninitialized-va=
riable access in ocfs2_local_read_info()")
> Reported-by: Dayvison <sathlerds@gmail.com>
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1007141
> Cc: stable@vger.kernel.org
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  fs/ocfs2/quota_global.c | 1 +
>  fs/ocfs2/quota_local.c  | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
> index f033de733adb..eda83487c9ec 100644
> --- a/fs/ocfs2/quota_global.c
> +++ b/fs/ocfs2/quota_global.c
> @@ -357,6 +357,7 @@ int ocfs2_global_read_info(struct super_block *sb, =
int type)
>  	}
>  	oinfo->dqi_gi.dqi_sb =3D sb;
>  	oinfo->dqi_gi.dqi_type =3D type;
> +	ocfs2_qinfo_lock_res_init(&oinfo->dqi_gqlock, oinfo);
>  	oinfo->dqi_gi.dqi_entry_size =3D sizeof(struct ocfs2_global_disk_dqbl=
k);
>  	oinfo->dqi_gi.dqi_ops =3D &ocfs2_global_ops;
>  	oinfo->dqi_gqi_bh =3D NULL;
> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
> index 0e4b16d4c037..e6037e4a1641 100644
> --- a/fs/ocfs2/quota_local.c
> +++ b/fs/ocfs2/quota_local.c
> @@ -703,7 +703,6 @@ static int ocfs2_local_read_info(struct super_block=
 *sb, int type)
>  	oinfo->dqi_type =3D type;
>  	INIT_LIST_HEAD(&oinfo->dqi_chunk);
>  	oinfo->dqi_gqinode =3D NULL;
> -	ocfs2_qinfo_lock_res_init(&oinfo->dqi_gqlock, oinfo);
>  	oinfo->dqi_rec =3D NULL;
>  	oinfo->dqi_lqi_bh =3D NULL;
>  	oinfo->dqi_libh =3D NULL;

Thanks for pointing this out. My fault when reviewing the introduced comm=
it.
But this change will lead to access uninitialized dqi_gqlock when
=EF=BB=BFocfs2_global_read_info() fails.
How about the following way?

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index f033de733adb..effe92c7d693 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -337,7 +337,6 @@ void ocfs2_unlock_global_qf(struct ocfs2_mem_dqinfo *=
oinfo, int ex)
 /* Read information header from global quota file */
 int ocfs2_global_read_info(struct super_block *sb, int type)
 {
-	struct inode *gqinode =3D NULL;
 	unsigned int ino[OCFS2_MAXQUOTAS] =3D { USER_QUOTA_SYSTEM_INODE,
 					      GROUP_QUOTA_SYSTEM_INODE };
 	struct ocfs2_global_disk_dqinfo dinfo;
@@ -346,29 +345,31 @@ int ocfs2_global_read_info(struct super_block *sb, =
int type)
 	u64 pcount;
 	int status;
=20
+	oinfo->dqi_gi.dqi_sb =3D sb;
+	oinfo->dqi_gi.dqi_type =3D type;
+	ocfs2_qinfo_lock_res_init(&oinfo->dqi_gqlock, oinfo);
+	oinfo->dqi_gi.dqi_entry_size =3D sizeof(struct ocfs2_global_disk_dqblk)=
;
+	oinfo->dqi_gi.dqi_ops =3D &ocfs2_global_ops;
+	oinfo->dqi_gqi_bh =3D NULL;
+	oinfo->dqi_gqi_count =3D 0;
+
 	/* Read global header */
-	gqinode =3D ocfs2_get_system_file_inode(OCFS2_SB(sb), ino[type],
+	oinfo->dqi_gqinode =3D ocfs2_get_system_file_inode(OCFS2_SB(sb), ino[ty=
pe],
 			OCFS2_INVALID_SLOT);
-	if (!gqinode) {
+	if (!oinfo->dqi_gqinode) {
 		mlog(ML_ERROR, "failed to get global quota inode (type=3D%d)\n",
 			type);
 		status =3D -EINVAL;
 		goto out_err;
 	}
-	oinfo->dqi_gi.dqi_sb =3D sb;
-	oinfo->dqi_gi.dqi_type =3D type;
-	oinfo->dqi_gi.dqi_entry_size =3D sizeof(struct ocfs2_global_disk_dqblk)=
;
-	oinfo->dqi_gi.dqi_ops =3D &ocfs2_global_ops;
-	oinfo->dqi_gqi_bh =3D NULL;
-	oinfo->dqi_gqi_count =3D 0;
-	oinfo->dqi_gqinode =3D gqinode;
+
 	status =3D ocfs2_lock_global_qf(oinfo, 0);
 	if (status < 0) {
 		mlog_errno(status);
 		goto out_err;
 	}
=20
-	status =3D ocfs2_extent_map_get_blocks(gqinode, 0, &oinfo->dqi_giblk,
+	status =3D ocfs2_extent_map_get_blocks(oinfo->dqi_gqinode, 0, &oinfo->d=
qi_giblk,
 					     &pcount, NULL);
 	if (status < 0)
 		goto out_unlock;
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 0e4b16d4c037..b1a8b046f4c2 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -702,8 +702,6 @@ static int ocfs2_local_read_info(struct super_block *=
sb, int type)
 	info->dqi_priv =3D oinfo;
 	oinfo->dqi_type =3D type;
 	INIT_LIST_HEAD(&oinfo->dqi_chunk);
-	oinfo->dqi_gqinode =3D NULL;
-	ocfs2_qinfo_lock_res_init(&oinfo->dqi_gqlock, oinfo);
 	oinfo->dqi_rec =3D NULL;
 	oinfo->dqi_lqi_bh =3D NULL;
 	oinfo->dqi_libh =3D NULL;

