Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6445663B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiGEHBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiGEHBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:01:30 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1757D1181E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:01:27 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id he28so12485965qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:mime-version:content-transfer-encoding
         :date:message-id;
        bh=DhptR+RCV6mhMiHmM9n/ndXsxPe6eRxa7hq+eTVgle0=;
        b=LXfWcA+0QYbFljRgXzll0CdvfuQk8ntKi99iyXTywBnZ7gN0A83PE1Feh6fh1//L2i
         T16UxlZjnJRBtP9MhBulmLJZQOd/s/L3IhmMqIKjhCdcTJZjNo25NCe/dNCUtlx2jZmc
         U9lRoauXiOr2Ra1t5rVzQXraVBHgTWclcTRkPhv2RcXLLmdqi6HPNRsslWi/domsGKtt
         mVLzLgLqa4gtS8ukwT+sjJvwqNEwqj++zv+abnaVrGEzD7+N582DHzI7OMBE+wPV5kS0
         nvo0QUhpxXq2l05fkgrOeTB68L3H0IMhmWVIYtQDy/DJ8PCSyr9d/oEhoC11OdWZLRsf
         jz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=DhptR+RCV6mhMiHmM9n/ndXsxPe6eRxa7hq+eTVgle0=;
        b=zRbiAUNvJAGYJaNkIxmK+12BEjdaN1suzcOp5dlt9HN5SBDJlhiEspd+SfrvBnilVp
         HuzXSvBRc9MyegNC33uXS+lohwlO5YqeaocYEHkkqiDWCVjbPAczHzDS2suH4CzQJlUX
         bXnOuVy+RTyLVyx5XYcPyRXced8pNOGIQJtAGAP30YaZcHDveIPO8I6y3hGzTiLV3qJz
         eAwDDOGsRSO0fgODY9qmI943j62pGPHbfZi/lJ7jlp3JzdCRQWZ8sfBOeYNtE2Pjf/FK
         cfS8YKVKQU5GuQaoM63otdFj4JyiNdSxpJFqus9754LgDUQ3NMnzzS1Wgucj9QQ0cQUm
         9t6A==
X-Gm-Message-State: AJIora+Po6m25ZUYQWY4f0f8FVgaDadYKNoswo3O97JWNENJVoV8rQM3
        b2Jh7qip+tLh+DrVa1dDgkkKow==
X-Google-Smtp-Source: AGRyM1vOnBlQPp/yZnMFdD4tZD4oXNp0CbA/EOPfZWJQqMf7GlR6mazlw6mhA785JKgSdrfKPUccWw==
X-Received: by 2002:a05:6214:1c88:b0:472:a7e2:bef4 with SMTP id ib8-20020a0562141c8800b00472a7e2bef4mr24590569qvb.32.1657004485621;
        Tue, 05 Jul 2022 00:01:25 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d60::c36])
        by smtp.gmail.com with ESMTPSA id p20-20020ac84614000000b00304fe96c7aasm18234451qtn.24.2022.07.05.00.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:01:25 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: next-20220616 - repeated crashes in  zap_pmd_range
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1657004484_4331P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Jul 2022 03:01:24 -0400
Message-ID: <11765.1657004484@turing-police>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1657004484_4331P
Content-Type: text/plain; charset=us-ascii

I've had multiple crashes with the same kernel stack trace on my x86_64
laptop.. There doesn't seem to be any matching reports in my linux-kernel mail
folder or where Google can find them.

[142037.910871][T92126] ------------[ cut here ]------------
[142037.990897][T92126] kernel BUG at include/linux/swapops.h:378!
[142038.070921][T92126] invalid opcode: 0000 [#1] PREEMPT SMP
[142038.150973][T92126] CPU: 0 PID: 92126 Comm: gnome-mahjongg Tainted: G        W       T 5.19.0-rc2-next-20220616-dirt
y #41 cda14773dff3831fc10ae1073ec183115d31a4be
[142038.230998][T92126] Hardware name: TOSHIBA Satellite C55-B/ZBWAA, BIOS 5.00 07/23/2015
[142038.311018][T92126] RIP: 0010:zap_pte_range+0xb71/0xba0
[142038.391046][T92126] Code: ff e9 74 fb ff ff 48 8d 49 ff e9 4c fb ff ff 49 8b 56 10 49 8b 76 08 e8 ad dc 04 00 e9 6d
fc ff ff 4c 8d 41 ff e9 6c fb ff ff <0f> 0b 48 8d 49 ff e9 f3 fa ff ff e8 af 37 d4 00 48 83 e2 f7 e9 20
[142038.471068][T92126] RSP: 0018:ffffaeca836d3a70 EFLAGS: 00010246
[142038.631101][T92126] RAX: 0000000000000000 RBX: 0000563818dc4000 RCX: 0000000000000000
[142038.711121][T92126] RDX: efffffffdca33600 RSI: efffffffdca33600 RDI: ffffe37b046b9900
[142038.791142][T92126] RBP: ffffaeca836d3b00 R08: ffffe37b046b9900 R09: 000000003b13b0a2
[142038.871162][T92126] R10: 000000009127bdcc R11: 0000000000000000 R12: ffffaeca836d3c18
[142038.951182][T92126] R13: ffff88914584be18 R14: eff0000000000600 R15: ffffaeca836d3ce0
[142039.031202][T92126] FS:  00007f2b5492b200(0000) GS:ffff889276a00000(0000) knlGS:0000000000000000
[142039.111223][T92126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[142039.191243][T92126] CR2: 0000563818de0000 CR3: 0000000110dfa000 CR4: 00000000001006f0
[142039.271263][T92126] Call Trace:
[142039.351283][T92126]  <TASK>
[142039.431309][T92126]  zap_pmd_range.isra.0+0x136/0x320
[142039.511337][T92126]  unmap_page_range+0x18a/0x2f0
[142039.591362][T92126]  ? debug_smp_processor_id+0x1b/0x20
[142039.671389][T92126]  unmap_single_vma+0x5c/0x100
[142039.751499][T92126]  ? __this_cpu_preempt_check+0x17/0x20
[142039.831525][T92126]  unmap_vmas+0x147/0x1e0
[142039.911548][T92126]  ? unmap_vmas+0x4/0x1e0
[142039.991579][T92126]  unmap_region+0x10e/0x170
[142040.071610][T92126]  do_brk_munmap+0x2b8/0x370
[142040.151641][T92126]  __do_sys_brk+0x2ec/0x3a0
[142040.231670][T92126]  __x64_sys_brk+0x11/0x20
[142040.311693][T92126]  do_syscall_64+0x3e/0x90
[142040.391718][T92126]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[142040.471740][T92126] RIP: 0033:0x7f2b5592450b
[142040.551764][T92126] Code: ff ff 0f 1f 44 00 00 64 83 3b 0d 75 07 64 c7 03 01 00 00 00 5b b8 ff ff ff ff 5d 41 5c c3
90 f3 0f 1e fa b8 0c 00 00 00 0f 05 <48> 8b 15 3e 19 0d 00 48 89 02 48 39 f8 72 06 31 c0 c3 0f 1f 00 48
[142040.631785][T92126] RSP: 002b:00007ffe9ae558a8 EFLAGS: 00000206 ORIG_RAX: 000000000000000c
[142040.791817][T92126] RAX: ffffffffffffffda RBX: fffffffffffbb000 RCX: 00007f2b5592450b
[142040.871837][T92126] RDX: fffffffffffff000 RSI: 00007f2b559f6ce0 RDI: 0000563818dbd000
[142040.951856][T92126] RBP: 0000563818e02000 R08: 00007f2b559f74a0 R09: 00007f2b559f74a0
[142041.031876][T92126] R10: 0000000000000000 R11: 0000000000000206 R12: 00007f2b559fe358
[142041.111895][T92126] R13: 0000000000000000 R14: 0000563818de1f50 R15: 00000000000200b0
[142041.191922][T92126]  </TASK>
[142041.271941][T92126] Modules linked in: snd_hrtimer tls bnep ts_bm nft_limit xt_string xt_LOG nf_log_syslog nft_compa
t nf_tables sunrpc binfmt_misc ath3k btusb btrtl btbcm btintel bluetooth vfat fat ecdh_generic ecc intel_rapl_msr rtsx_p
ci_sdmmc intel_rapl_common intel_soc_dts_thermal intel_soc_dts_iosf intel_powerclamp crct10dif_pclmul crc32_pclmul crc32
c_intel polyval_generic ghash_clmulni_intel uas joydev cryptd ath9k serio_raw ath9k_common ath9k_hw rtsx_pci ath snd_hda
_codec_realtek snd_hda_codec_hdmi mei_txe toshiba_acpi fan industrialio toshiba_bluetooth rfkill_gpio pwm_lpss_platform
pwm_lpss bfq fuse
[142045.672581][T92126] Unloaded tainted modules: polyval_clmulni():1 polyval_clmulni():1 pcc_cpufreq():1 pcc_cpufreq():
1 pcc_cpufreq():1 pcc_cpufreq():1

I've hit it with different processes running:

[15382.259484][ T8349] CPU: 0 PID: 8349 Comm: dump Tainted: G        W       T 5.19.0-rc2-next-20220616-dirty #41 cda14773dff3831fc10ae1073ec183115d31a4be
[43146.815168][T36124] CPU: 1 PID: 36124 Comm: dump Tainted: G        W       T 5.19.0-rc2-next-20220616-dirty #41 cda14773dff3831fc10ae1073ec183115d31a4be
[32328.505512][T42933] CPU: 0 PID: 42933 Comm: dump Tainted: G        W       T 5.19.0-rc2-next-20220616-dirty #41 cda14773dff3831fc10ae1073ec183115d31a4be
[127563.538386][T23585] CPU: 1 PID: 23585 Comm: skypeforlinux Tainted: G        W       T 5.19.0-rc2-next-20220616-dirty #41 cda14773dff3831fc10ae1073ec183115d31a4be
[142038.150973][T92126] CPU: 0 PID: 92126 Comm: gnome-mahjongg Tainted: G        W       T 5.19.0-rc2-next-20220616-dirty #41 cda14773dff3831fc10ae1073ec183115d31a4be
[ 1407.334003][ T1539] CPU: 1 PID: 1539 Comm: festival Tainted: G        W       T 5.19.0-rc2-next-20220616-dirty #41 cda14773dff3831fc10ae1073ec183115d31a4be
[15800.570510][T19449] CPU: 0 PID: 19449 Comm: gcr-prompter Tainted: G        W       T 5.19.0-rc2-next-20220616-dirty #41 cda14773dff3831fc10ae1073ec183115d31a4be
[394327.263409][   T29] CPU: 0 PID: 29 Comm: khungtaskd Tainted: G        W       T 5.19.0-rc2-next-20220616-dirty #41 cda14773dff3831fc10ae1073ec183115d31a4be

(On the bright side, it did motivate me to fix my system backup script to be
restartable so if it died on the last filesystem, it wouldn't re-backup all the
others :)


--==_Exmh_1657004484_4331P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJiw+HDAAoJEI0DS38y7CIcNMgH+QHrfc/tRsJ6/KqM0dFu3SaE
92y38oB2Z7Nmi0gShvX2Ny9LFlgo0Z7dfaBB06MiP2iIYIXfsUKteaQthJBRYpra
MPqK1mSPaJG92zQHjlJLIiFEZSlTe9Cu6u5vyTCCHDQKvTwd6wsKKZ8A75rDZxPR
/vAVUm9xNeSUJbB++Dxo8HQtMLXo3BJCpXXzEhTohSUzJ66LfY91kD0xrY3eZi97
f5JGZK1f+YCf3ycOHciGAZe37kVwAU39knaPkd5njo2pViOIX7wiVCnlbEB2HICb
7+LqNwfoi+k/GaKVceX+Fr/y3rHiu63ic5Ku4bOkMqMhOcGF+hBucab0lhsiJ0s=
=hiNP
-----END PGP SIGNATURE-----

--==_Exmh_1657004484_4331P--
