Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9839359C97C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiHVUBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiHVUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:01:14 -0400
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E887A52FF8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:00:51 -0700 (PDT)
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
        by mx0b-00364e01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MJuLTn005524
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pps01; bh=NwBaqiqjV96gAiGASIa98OtPq+SfiPYIbjEAnvA4dsc=;
 b=sjc0bWe/aj80GAcnYz/CgAJyhJhBlsgxU3mYwfYVcq0SPacsljHF6oHJKBu7Pja2KOLZ
 yuJbgyFZ3I2FqZJUVEmtVuKkc2v2rtOXlCSA0ziraJyCS+T04S93CLxhStMh/l4s2pmQ
 kH5bK5DuxyqeXNqtHtaUk96a/UkrpBJhjZ8ptfVwTDyxfWb9wElCHk1ocaJB4352N+xF
 L0+0fU5HTQoD9QHbH4hstOPo10otUnQsqM2m79Kda3gtzs996ugeGLRWn2zXEdtwZnbo
 GTlHnVUhBtiwbZoM66eSxOx/CTjMQG18A9vWeKG2YQ8r20W6yii1szltEVbwpDPSIyTo yw== 
Received: from sendprdmail20.cc.columbia.edu (sendprdmail20.cc.columbia.edu [128.59.72.22])
        by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 3j2wj7n5m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:00:50 -0400
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
        by sendprdmail20.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 27MK0oYW057171
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:00:50 -0400
Received: by mail-ua1-f71.google.com with SMTP id 32-20020ab003a3000000b0039eec047caaso915774uau.15
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NwBaqiqjV96gAiGASIa98OtPq+SfiPYIbjEAnvA4dsc=;
        b=fPhaN4l33GrUvVwVEwEUr0bp4zLL3U7Vmuv+mTHv05IdK9FQFYA5h9KSAFBf9BGzHv
         LvXbDtrZINEPpBBKH5TuaH77Mza4RIeDlty0E/ykQKVDh0CEHx1Yy/xpuEz+hFMCRKp/
         LvbE2iV+UuH3fumaiBjnyXEX++R1kC+KKifpj8iDj79zPYjFsnYHB1y9gAyqRkVGgaZD
         fcastasatwq+X+DqrFCT8FsrwkLES0+g3FoaoecuAUuUbiJNsyS4TosxmO1seYm4LNqy
         kKHP4qxdrz7rtsboGfif8bY3cPBT52Gy57TuAcsODTDwDNJbbi2NgfCh6H/Za7N1SLS1
         GpiQ==
X-Gm-Message-State: ACgBeo1YRCDcV53SSdHU+T7p8t98Eb6xvrGO+gskABcucaT/JRhMzPzO
        jLwccJYxbG6juW/raTLPgxIqHyaZloxUjYxMr/eCj5/0Y53Eg+lu1qXr1bfDXd2kl5NVDEcGnZM
        PwoOZuGYsSnuCnc/9Jsk+7PMoLRpyAyPhsgxKWgvlDIeQFNgv
X-Received: by 2002:a67:d284:0:b0:390:3f27:a274 with SMTP id z4-20020a67d284000000b003903f27a274mr4327297vsi.12.1661198449615;
        Mon, 22 Aug 2022 13:00:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ozSi0IzmAx38EYVD7HBQ0oS/5Yt3yR4ZRmG1ltA7uoqEQmj9iHMn1hMmWiRlDuBCfd0EdLN8GRu2S+Dfm/EY=
X-Received: by 2002:a67:d284:0:b0:390:3f27:a274 with SMTP id
 z4-20020a67d284000000b003903f27a274mr4327286vsi.12.1661198449262; Mon, 22 Aug
 2022 13:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEHB2493pZRXs863w58QWnUTtv3HHfg85aYhLn5HJHCwxqtHQg@mail.gmail.com>
 <87fshs7kaa.wl-tiwai@suse.de>
In-Reply-To: <87fshs7kaa.wl-tiwai@suse.de>
From:   Gabriel Ryan <gabe@cs.columbia.edu>
Date:   Mon, 22 Aug 2022 16:00:42 -0400
Message-ID: <CALbthteSTTb5ok-xhcrkfmbtu+kgnWCX0SMBKJ-yNLzPNWGEvA@mail.gmail.com>
Subject: Re: data-race in snd_seq_oss_midi_check_exit_port / snd_seq_oss_midi_setup
To:     Takashi Iwai <tiwai@suse.de>
Cc:     abhishek.shah@columbia.edu, alsa-devel@alsa-project.org,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: DI5Lse_yA7v-jggB8LcUsZJ0oXIVc9qr
X-Proofpoint-ORIG-GUID: DI5Lse_yA7v-jggB8LcUsZJ0oXIVc9qr
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_12,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=10
 malwarescore=0 lowpriorityscore=10 mlxlogscore=999 impostorscore=10
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220080
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

Makes sense, we'll note this race as benign for our future reference.

Thanks for taking the time to look at this!

Best,

Gabe

On Fri, Aug 19, 2022 at 3:41 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 19 Aug 2022 03:00:00 +0200,
> Abhishek Shah wrote:
> >
> >
> > Hi all,
> >
> > We found a race involving the max_midi_devs variable. We see an interleaving
> > where the following check here passes before the
> > snd_seq_oss_midi_check_exit_port() finishes, but this check should not pass
> > if max_midi_devs will become zero, but we are not sure of its implications in
> > terms of security impact. Please let us know what you think.
>
> Through a quick glance, I guess it's rather harmless (although a bit
> fragile from the code sanity POV).
>
> A MIDI port could be closed at any time, and the dp->max_mididevs
> holds locally the upper bound of currently possibly accessible ports.
> The actual access to each port is done via get_mdev() in
> seq_oss_midi.c, which is a sort of refcount managed, and it should be
> fine that a port disappears meanwhile.
>
> That said, it'd be even feasible just dropping dp->max_mididevs field
> and scan all MIDI ports at each time, but it won't bring much benefit,
> either.
>
>
> thanks,
>
> Takashi
>
> >
> > Thanks!
> >
> > -------------------Report---------------------
> >
> > write to 0xffffffff88382f80 of 4 bytes by task 6541 on cpu 0:
> >  snd_seq_oss_midi_check_exit_port+0x1a6/0x270 sound/core/seq/oss/
> > seq_oss_midi.c:237
> >  receive_announce+0x193/0x1b0 sound/core/seq/oss/seq_oss_init.c:143
> >  snd_seq_deliver_single_event+0x30d/0x4e0 sound/core/seq/seq_clientmgr.c:640
> >  deliver_to_subscribers sound/core/seq/seq_clientmgr.c:695 [inline]
> >  snd_seq_deliver_event+0x38c/0x490 sound/core/seq/seq_clientmgr.c:830
> >  snd_seq_kernel_client_dispatch+0x189/0x1a0 sound/core/seq/
> > seq_clientmgr.c:2339
> >  snd_seq_system_broadcast+0x98/0xd0 sound/core/seq/seq_system.c:86
> >  snd_seq_ioctl_delete_port+0x9a/0xc0 sound/core/seq/seq_clientmgr.c:1356
> >  snd_seq_ioctl+0x198/0x2d0 sound/core/seq/seq_clientmgr.c:2173
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> >  __se_sys_ioctl+0xe1/0x150 fs/ioctl.c:856
> >  __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:856
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > read to 0xffffffff88382f80 of 4 bytes by task 6542 on cpu 1:
> >  snd_seq_oss_midi_setup+0x1b/0x40 sound/core/seq/oss/seq_oss_midi.c:273
> >  snd_seq_oss_open+0x364/0x900 sound/core/seq/oss/seq_oss_init.c:198
> >  odev_open+0x55/0x70 sound/core/seq/oss/seq_oss.c:128
> >  soundcore_open+0x315/0x3a0 sound/sound_core.c:593
> >  chrdev_open+0x373/0x3f0 fs/char_dev.c:414
> >  do_dentry_open+0x543/0x8f0 fs/open.c:824
> >  vfs_open+0x47/0x50 fs/open.c:958
> >  do_open fs/namei.c:3476 [inline]
> >  path_openat+0x1906/0x1dc0 fs/namei.c:3609
> >  do_filp_open+0xef/0x200 fs/namei.c:3636
> >  do_sys_openat2+0xa5/0x2a0 fs/open.c:1213
> >  do_sys_open fs/open.c:1229 [inline]
> >  __do_sys_openat fs/open.c:1245 [inline]
> >  __se_sys_openat fs/open.c:1240 [inline]
> >  __x64_sys_openat+0xf0/0x120 fs/open.c:1240
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 6542 Comm: syz-executor2-n Not tainted 5.18.0-rc5+ #107
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/
> > 2014
> >
> > Reproducing Inputs
> >
> > Input CPU 0:
> > r0 = openat$sndseq(0xffffffffffffff9c, &(0x7f0000000040)='/dev/snd/seq\x00',
> > 0x0)
> > ioctl$SNDRV_SEQ_IOCTL_CREATE_PORT(r0, 0xc0a85320, &(0x7f0000000240)={{0x80},
> > 'port1\x00', 0x10})
> > ioctl$SNDRV_SEQ_IOCTL_SET_CLIENT_POOL(r0, 0x40a85321, &(0x7f0000000100)=
> > {0x80})
> >
> > Input CPU 1:
> > r0 = openat$sequencer2(0xffffff9c, &(0x7f0000000000)='/dev/sequencer2\x00',
> > 0x0, 0x0)
> > ioctl$SNDCTL_SYNTH_INFO(r0, 0xc08c5102, &(0x7f0000000200)=
> > {"02961a3ce6d4828f8b5559726313251b55fa11d8d65406f1f33c9af8e3f8", 0xffffffff})
> >
> >

-- 
Gabriel Ryan
PhD Candidate at Columbia University
