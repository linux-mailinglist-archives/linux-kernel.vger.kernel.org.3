Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643F519B83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347084AbiEDJ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiEDJ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:26:14 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D934320BF1;
        Wed,  4 May 2022 02:22:38 -0700 (PDT)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MpDeD-1oBOgk0aPX-00qiYF; Wed, 04 May 2022 11:22:37 +0200
Received: by mail-wr1-f43.google.com with SMTP id u3so1158532wrg.3;
        Wed, 04 May 2022 02:22:37 -0700 (PDT)
X-Gm-Message-State: AOAM532SD3igmSSCON62FMekH/WVG7A/d8cfyh6S9O9xI97CEPFE/OfS
        3j4ZY7kvaldWNuRbSHnvaO5stahQDManTu+FpTQ=
X-Google-Smtp-Source: ABdhPJxvWk+C0zObcqGD19j3cU4HHvntTbxSInzUsf+NIpJaRhVyLSgYX+6CtYnkxEtA2LPnNIFYG2h3Yq60uBKm27k=
X-Received: by 2002:a05:6000:707:b0:20c:4fd8:1d61 with SMTP id
 bs7-20020a056000070700b0020c4fd81d61mr16210048wrb.407.1651656156705; Wed, 04
 May 2022 02:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtYRVKKRx=W7npj911E8QPY9UObSBCppFyGGkT=wZsXFQ@mail.gmail.com>
In-Reply-To: <CA+G9fYtYRVKKRx=W7npj911E8QPY9UObSBCppFyGGkT=wZsXFQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 May 2022 11:22:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a062No7XP5AUcpc5ZdECmDUUWgGfP+fdXqY2Ko=HnYHbQ@mail.gmail.com>
Message-ID: <CAK8P3a062No7XP5AUcpc5ZdECmDUUWgGfP+fdXqY2Ko=HnYHbQ@mail.gmail.com>
Subject: Re: [next] db410c: WARNING: CPU: 3 PID: 57 at kernel/locking/mutex.c:582
 __mutex_lock
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Zci9ghtCAFJS1JDhmowfFjYok9QF0wOxoC0KzjTQq06pZoDZ5Ps
 drvys87HwIkNBo0rMSgd/3s8oexk6jq2kmzGopHMUR9AeKcB/12CX7kYiraY3DrSDgFiM9n
 S5QYx0SL3JNNJCFj0n9vFc6A/62Izy46883euRF2tosE5khylmu4nOG/mllteCv7KV8l6Ph
 SZTTMZmMa+T4VtiPe5mGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gTbyZTD9byI=:RYUsw186MKFjXIoqzYfSOe
 EForn2DW1yefI9PXOR/wUwpm7rjgI/8qPDMMLV26ZH2+jc3jMlU+h3nov3n3LuXj4bTk0nM5G
 cW71uQLinaImXUMsxJTqROjxkVaYW+D4iXD8hSpqJcP4Gxe8bXvS3M76XF7CyHoHSA/1yfKTB
 WG82HSncgSBfzxrA7tpec1EwBshZpkHfhFadZfc1AantpPBt+3BNh39X/T4s2FAuJTksmTJAl
 bEnvzV7nFiHTKDCJUy6IADlMA9B8ViHeMOVGaGF0xYDVopHeUJQ5vYYK3IqnLV2VRqZwekEks
 ahbPzmocOeaDnaPNu6RTCuWLmS6NPFIKAUxOluFZSjodD9/zdbeCZQ45I9UxAtea/gc5koVky
 NFgj+i3khfgumRpHOJGjYX7CnZDsCZiUbUHocXO1e2sDJntYLTXvXNzoM5YXn9v0Dom9HeU8i
 JNazXVqfcioytr9m6E6z4LF+YBRZCtUuShFv/DDkUKDgKaWbJTmpYf0+2R0JnTwAmc0HB4ez4
 wqJS4vLXEBla1IWfBVMjiheekscKn5ZwLesm+kCNXMUIac0eU0/y/A+gpRn7lVrgqwxuvLPje
 sdPcxpaE3xZC3RpNTY9pQXnrDpZtvo4ZO3ayfLX+saRnzzyK8EPDXVpcM6mWJGoNmjiUXsMB1
 fKyYc9vNyvTFFNMGynn+NCJXoU7fxN+4Uh/6swLX4MHTqazRO08QFurv1WSV1F/wU5uQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 11:09 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following kernel DEBUG_LOCKS_WARN_ON(lock->magic != lock) noticed on arm64
> dragonboard 410c device while booting Linux next-20220502 tag kernel.
>
> warning:
> ---------
> [    6.052275] ------------[ cut here ]------------
> [    6.052289] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> [    6.052314] WARNING: CPU: 3 PID: 57 at kernel/locking/mutex.c:582
> __mutex_lock+0x1dc/0x420
> [    6.052345] Modules linked in:
> [    6.052361] CPU: 3 PID: 57 Comm: kworker/u8:2 Not tainted
> 5.18.0-rc5-next-20220502 #1
> [    6.052374] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    6.052384] Workqueue: events_unbound deferred_probe_work_func
> [    6.052408] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    6.052421] pc : __mutex_lock+0x1dc/0x420
> [    6.052434] lr : __mutex_lock+0x1dc/0x420
> [    6.052446] sp : ffff80000c42b9a0
> [    6.052453] x29: ffff80000c42b9a0 x28: ffff80000b314860 x27: ffff00000408810d
> [    6.052481] x26: ffff80000adb4bb8 x25: ffff000005220a74 x24: 0000000000000000
> [    6.052506] x23: 0000000000000000 x22: ffff800008bbef8c x21: 0000000000000002
> [    6.052533] x20: 0000000000000000 x19: ffff00000c1a5110 x18: 0000000000000000
> [    6.052558] x17: ffff800008bbd594 x16: ffff800008bc10f4 x15: ffff80000927b6c4
> [    6.052585] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 5f534b434f4c5f47
> [    6.052611] x11: 656820747563205b x10: 0000000000000029 x9 : ffff8000081cc7b8
> [    6.052637] x8 : 0000000000000029 x7 : 0000000000000013 x6 : 0000000000000001
> [    6.267204] x5 : ffff80000adb5000 x4 : ffff80000adb54f0 x3 : 0000000000000000
> [    6.274321] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000005265080
> [    6.281439] Call trace:
> [    6.288524]  __mutex_lock+0x1dc/0x420
> [    6.290789]  mutex_lock_nested+0x4c/0x90
> [    6.294610]  driver_set_override+0x12c/0x160
> [    6.298605]  qcom_smd_register_edge+0x2d8/0x52c

The problem is in

static int qcom_smd_create_chrdev(struct qcom_smd_edge *edge)
{
        struct qcom_smd_device *qsdev;

        qsdev = kzalloc(sizeof(*qsdev), GFP_KERNEL);
        if (!qsdev)
                return -ENOMEM;

        qsdev->edge = edge;
        qsdev->rpdev.ops = &qcom_smd_device_ops;
        qsdev->rpdev.dev.parent = &edge->dev;
        qsdev->rpdev.dev.release = qcom_smd_release_device;

        return rpmsg_ctrldev_register_device(&qsdev->rpdev);
}

 static inline int rpmsg_ctrldev_register_device(struct rpmsg_device *rpdev)
 {
       int ret;

        strcpy(rpdev->id.name, "rpmsg_ctrl");
       ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
                                 rpdev->id.name, strlen(rpdev->id.name));
       if (ret)
               return ret;

       ret = rpmsg_register_device(rpdev);
       if (ret)
               kfree(rpdev->driver_override);

       return ret;
 }

This allocates an uninitialized device structure that is then passed
driver_set_override() before calling device_register(), so the
mutex is not initialized yet.

        Arnd
