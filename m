Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406FB4D6FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiCLPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiCLPM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:12:56 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3A986C9;
        Sat, 12 Mar 2022 07:11:51 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2e2ca8d7812so61141417b3.13;
        Sat, 12 Mar 2022 07:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K98030A73zLeeoJmJeXlU5g/68giFukC00BYhoPQePQ=;
        b=PJWpgYp3y0X47kmD0RbKsQsv50e9EHMwVHy1fGRT7+xPaXqBBTyb8WJlhz4aXeUmX+
         i/3bK+Je/HlZShOGXMYLYxN8oXmb99quNJJx73gq2YNhS/zrIYHouDgIdJbmubBv3OuI
         CmqGu9lIl7ghHJWkSKX9hghFz17XkbYgrbjZwN4adnQB6VYn2hZxYkf3esSi2cizPCYO
         x/lxj1iA4z9/8HKKCZ0vJ44SQwHL6aPsIBD+vkNEzWVlYfPHTyph1K/kXboaRa1azVti
         dKpzLi75jl/Y9F8YUU0blFYSbja9ClzAVi4UWckQF+sgJUsoCyJRwIVjr3Uow+TxaeAz
         O32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K98030A73zLeeoJmJeXlU5g/68giFukC00BYhoPQePQ=;
        b=18osgWswvog/8QmBv4l5Ub1ZOGv2t20r2nO15Q/9UESbAGClJtBvrECsHA0ozj0jaw
         /TmYgyygyDzZhWvVKQ9mCSM1a07z6RmnwQUwMj7Pjt0pi2MNJJvZ5ybien0iGQ1eD64d
         CznLyNid9e3EKxByw34U904WcRR+Ya6UXPwUxVDFakLwdgm/eJxtioAQBWywrgEXJ5eq
         PsZF3YDDRNmTNlqyEaiYuY0ABVXXyxEv96Or1EUy7ItsEBXHX9SvdQQcxoa3avcM/9Ae
         WYGIEc+EXIWTEAaGvOVrFfbid7qu6u/tx//IU2tdI7wECXMc1BXUkisXjW5WyWSC1Hov
         rx/A==
X-Gm-Message-State: AOAM53337sOGqRLiGxfjDicoh6liAadqGetdEsyS3Q0K/SbKaoiw6E3e
        Buxq5a5BUU6o6g/nZ/ARKHk841RWcmtlzdPm37DgmgKD1fM=
X-Google-Smtp-Source: ABdhPJx9jMKBuCWxF8MForqcYIH25wObesDaHt4kx/iw7ePlPHMda/GyAodFlasmPOzu/17EecxEpDx7Z8YGycLjFQ0=
X-Received: by 2002:a81:9844:0:b0:2db:db74:f7db with SMTP id
 p65-20020a819844000000b002dbdb74f7dbmr12407164ywg.359.1647097910104; Sat, 12
 Mar 2022 07:11:50 -0800 (PST)
MIME-Version: 1.0
References: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn>
 <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
 <CAKFNMokdB+Zph-1OyC1-Xnyi93r+yKSusgaEaa=CkuUBttwRZA@mail.gmail.com>
 <CAD-N9QU8-Od3G+-=RHM5K7vR2-4Af+4t=XutJJVdmkKhH7OarA@mail.gmail.com>
 <CAKFNMo=E8mMuY7Et0auH02fOzGKx04k2=LOj8mZJ6a-=J+sPzQ@mail.gmail.com>
 <CAD-N9QWt=d2Vj2bevSzOPL4AWF08_zTyq=hHOcOOROCazNY4_A@mail.gmail.com>
 <CAD-N9QWrBLygN24EC6QLRFF6uf7=PiTRdA4suKqEXJ7tk9aocA@mail.gmail.com> <dac7104a-21ac-24f4-6132-e51960fa0b7e@gmail.com>
In-Reply-To: <dac7104a-21ac-24f4-6132-e51960fa0b7e@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 13 Mar 2022 00:11:38 +0900
Message-ID: <CAKFNMon3=fFWtuUa1_wDyK9agpCXjbzA8b+rj=OYu=7Gs8nMqQ@mail.gmail.com>
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
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

Hi Pavel,

On Sat, Mar 12, 2022 at 11:20 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Hi Dongliang,
>
> On 3/9/22 11:30, Dongliang Mu wrote:
> >> Now I am checking the log and trying to find error injection in the
> >> log file, as said by Pavel.
> >
> > Attached is the report and log file.
> >
> > @Pavel Skripkin I don't find any useful error injection in the log file.
> >
> > In case I made some mistakes, I will clean up my local crash reports,
> > update to the latest upstream kernel and restart the syzkaller. Let's
> > see if the crash still occurs.
>
> The execution path is clear from the logs. Quick grep for nilfs shows
> these lines
>
> [  886.701044][T25972] NILFS (loop2): broken superblock, retrying with
> spare superblock (blocksize = 1024)
> [  886.703251][T25972] NILFS (loop2): broken superblock, retrying with
> spare superblock (blocksize = 4096)
> [  886.706454][T25972] NILFS (loop2): error -4 creating segctord thread
>
> So here is calltrace:
>
> nilfs_fill_super
>    nilfs_attach_log_writer
>      nilfs_segctor_start_thread <- failed
>
>
> In case of nilfs_attach_log_writer() error code jumps to
> failed_checkpoint label and calls destroy_nilfs() which should call
> nilfs_sysfs_delete_device_group().

nilfs_sysfs_delete_device_group() is called in destroy_nilfs()
if nilfs->ns_flags has THE_NILFS_INIT flag -- nilfs_init() inline
function tests this flag.

The flag is set after init_nilfs() succeeded at the beginning of
nilfs_fill_super() because the set_nilfs_init() inline in init_nilfs() sets it.

So,  nilfs_sysfs_delete_group() seems to be called in case of
the above failure.   Am I missing something?

Thanks,
Ryusuke Konishi


>
> So I can really see how this leak is possible on top of current Linus' HEAD.
>
>
> Also in the log there are onlyh 4 syz_mount_image$nilfs2 programs, so
> only one of them may be a reproducer. If you have spare time you can try
> to execute them using syz-execprog and see if it works :))
>
>
>
> With regards,
> Pavel Skripkin
