Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07BA57F97C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiGYGe4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jul 2022 02:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYGey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:34:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F19BDEBC;
        Sun, 24 Jul 2022 23:34:52 -0700 (PDT)
Received: from mail-yb1-f174.google.com ([209.85.219.174]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxDgm-1nIeHq1Ygi-00xdBg; Mon, 25 Jul 2022 08:34:50 +0200
Received: by mail-yb1-f174.google.com with SMTP id r3so18420524ybr.6;
        Sun, 24 Jul 2022 23:34:50 -0700 (PDT)
X-Gm-Message-State: AJIora/wGjnOtXdNy8YPgjFwGYKnb4LKbtEPMae9WjC7bMMQfLbPSd24
        QxuewmiufMBbV9el25zi1f5iedRRhdLqMlPYyuw=
X-Google-Smtp-Source: AGRyM1sGLkw4aJn1HNx3IEfYHktSuUgf/62QRFsCyHiqKFcP2xKhpEE3DffyH3k+rdGJlryPzfWKqPb5CFt6r49usFA=
X-Received: by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP id
 s15-20020a056902120f00b0066822289627mr8961174ybu.134.1658730889063; Sun, 24
 Jul 2022 23:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220704025632.235968-1-renzhijie2@huawei.com>
 <CAK8P3a07jGCuAVQAZgpENRP_xFLiogU9W1Uze+n21h7TdOZhog@mail.gmail.com>
 <df9909dc-3303-808e-575a-47190f636279@huawei.com> <CAK8P3a3SA9zvVu0i1m0kqbemLd4WfTMGfpc8VwhsmJOBgZHvsA@mail.gmail.com>
 <af043109-c101-a147-707b-82e79469ae73@huawei.com>
In-Reply-To: <af043109-c101-a147-707b-82e79469ae73@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Jul 2022 08:34:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0LCaMoWArcQNY5qayUABgRXWEogrtQQ-sbR+zY6n=O4w@mail.gmail.com>
Message-ID: <CAK8P3a0LCaMoWArcQNY5qayUABgRXWEogrtQQ-sbR+zY6n=O4w@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, stanley.chu@mediatek.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:pPXj472gOxDCKOUdDVMug14blajMG3OpwpXdEMYEQfYjbOekJU0
 yGtIsVQ7G0TEEYlKWZzG+kf9xqmmH4OJeEscFhcBO3/mtia4yg05gezJvU1DJqARvAO+ORO
 DEq5Xd0ZPWYI4mbic/Gmc04asiS1jmLJcl0fxREnI8xtk1VoZ5nIvc8AvMkbKl20vrIu01T
 uKZPuCiM9pW+0O5KCS2sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kUFT0qALxt4=:xiBh3K95xwwv35lvXTCLRo
 YiyeI0+KAbrS+9HTsSQZnmYoEMpDZmP8qmvQxaeBvjm5KRSC4GZhFqppGJ2oxFWvsJyT+uPF0
 Ts5MT5ROjkKSJO8OM7b4uzEz/qtywLIbuQRKueY3rk5pN//2yQcZWPlASjcZNAnR+SKkAXcLo
 ZfyrJhrm4dsqOoGdyiJHFikGdN4mm3r55i8PCLFXjwFcTaGiVyvH6STyt9yaAwmMYoM4YPKLx
 XgHeH06zH1waCO0sWjw15vfepGJEJIJ9pjoWPJULy4OcQT4ItAAZFMjS35Nex+OmCo/U05j8Y
 UCB64DZ3kg5GUF085G63WZBD6nspvtWizbUFweyFOEikpBd7x22ry6RsI97MuWhfdgq2bfJpZ
 dE21VRpf1TB3+U+L8x5YXPZTQANSFsK0XvCGOkd8KRNLiYbXX/MRqm6UiRLEIJrgyPOmtx8ak
 KBqtEh68S3QFujM/GyIQr1TMqLLuqvuYJ8F+Ld/LCf8Ia1r1jweZe4D1Elq+I47DyklreoUu3
 LFMoADV1k3WVq510cF2HTG3MtZhKQEIrtVBgnW7YM1YA3DrLsvuPwUfEHHpZUVs4+A2avnuS+
 TOlJCLHBS0JmCY6Ci6rtZWRiZbB2rsCuRyf68u8ZQsA3KKwG0fmNxgU876bKH+XJnhrl7hZOZ
 /tFIUfKqmLBNvLx5TjCNQy86QUWd98ibILvtrUmaORnnSwDu3xLABNYMypQi2LXWRiB3wfISN
 u/md0vAg560eC4twBUpMRtNXRovKSDSguwRb1lStZb/vh/qOZhncd2nAlG4FmddtsgA+fTKM5
 kHxnlbhMTf/YlfAZQjWHTip2fd1csGVYRp9NH7nUQNbLd5jE2StTzLAQ73TPYIYvUMvDSNwkW
 gXaNpCvDp3Wo/gTzib6w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 5:38 AM Ren Zhijie <renzhijie2@huawei.com> wrote:
> 在 2022/7/13 16:48, Arnd Bergmann 写道:
>
> I try to use the new marcos SYSTEM_SLEEP_PM_OPS and RUNTIME_PM_OPS to
> replace the old ones, and remove #ifdef around the declarations in the
> header, my local changes attach below.
>
> But it seems  that doesn't work, which has ld errors:
>
> aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> drivers/ufs/host/ufs-mediatek.o: In function `ufs_mtk_runtime_resume':
> ufs-mediatek.c:(.text+0x1d0c): undefined reference to
> `ufshcd_runtime_resume'
> drivers/ufs/host/ufs-mediatek.o: In function `ufs_mtk_runtime_suspend':
> ufs-mediatek.c:(.text+0x1d64): undefined reference to
> `ufshcd_runtime_suspend'
> Makefile:1255: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
> (CONFIG_PM and CONFIG_PM_SLEEP are both not set, and
>

It appears that there is a mistake in the RUNTIME_PM_OPS()
macro definition, can you try this patch on top?

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 871c9c49ec9d..84592229d754 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -334,9 +334,9 @@ struct dev_pm_ops {
        .restore_noirq = pm_sleep_ptr(resume_fn),

 #define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
-       .runtime_suspend = suspend_fn, \
-       .runtime_resume = resume_fn, \
-       .runtime_idle = idle_fn,
+       .runtime_suspend = pm_ptr(suspend_fn), \
+       .runtime_resume = pm_ptr(resume_fn), \
+       .runtime_idle = pm_ptr(idle_fn),

 #ifdef CONFIG_PM_SLEEP
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \

Commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate
old ones") introduced all the macros with the intent of using pm_ptr()
and pm_sleep_ptr() in them, and I think Paul accidentally forgot to add
those in this instance.

       Arnd
