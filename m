Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677C04BD6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbiBUHVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:21:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343584AbiBUHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:21:06 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522B2E5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:20:42 -0800 (PST)
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5PRT-1nMroS1cpR-001PqP; Mon, 21 Feb 2022 08:20:41 +0100
Received: by mail-wm1-f41.google.com with SMTP id i19so8925180wmq.5;
        Sun, 20 Feb 2022 23:20:41 -0800 (PST)
X-Gm-Message-State: AOAM533s+vhVgNtdN36REaLllpR6oEFpZfwle7ZIrCluLfHAFZdbJzl6
        A0+PKUj+/UdmnX+6119Tb4iI2YrkZkeyZLE33W4=
X-Google-Smtp-Source: ABdhPJwkhO738p7jfkIcVIpJAGPCBMxEsq4hdKYoj5i8JrWItb1GWjA9adOa10AzpY4ehuGHPz73wdTTBSk9y82K1Yw=
X-Received: by 2002:a05:600c:4ecb:b0:37c:9125:ac03 with SMTP id
 g11-20020a05600c4ecb00b0037c9125ac03mr16542202wmq.98.1645428041077; Sun, 20
 Feb 2022 23:20:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645407997.git.tonyhuang.sunplus@gmail.com> <20f858dfe999816cb05dfde5f89db48f3416358e.1645407997.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <20f858dfe999816cb05dfde5f89db48f3416358e.1645407997.git.tonyhuang.sunplus@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Feb 2022 08:20:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1FZQ2LQco8D263+YXjcSQvzU6RHAL8SKcKy8hiLnHY8g@mail.gmail.com>
Message-ID: <CAK8P3a1FZQ2LQco8D263+YXjcSQvzU6RHAL8SKcKy8hiLnHY8g@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] misc: Add iop driver for Sunplus SP7021
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Tony Huang <tony.huang@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+flWuxabUjXSN9IPizb45Hbk5k0zd9jBEveS/y5AS5pVfLTOGNR
 vlhOk0HWrBtIcDO4ph7hzHmNg6LBPJr6ruYlFKAwqPPHgVwiXS3o3aeqWLgFch1dmkBMKww
 muWSaOlvimKggChUOBBODGKA6uEpkpRSw408xD9YxemE+ld+7eSzd7kWX+HygDLpYAseKQH
 vnmowe2F+ssGrkD6+n0dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DJ7ZBQi7pDc=:+bkThK+4f7Zz3hMeUdom9J
 rBPJth0FagVycH8i0TPuB8R1AgpASaMoz1PI1K7TBYghuabS1sXaXttReqMEqF5uVrrmAshbg
 fFnDtmEvdQibGiR3/DH4ILLlCwaZ3tAvOxjbVH5t26vwR2E+z/t2FaZ96HxM5C7jySNk8Emo7
 DtW9gbAkqsPc22hAjsSDiCoqSx2aoAuuE7COEQvG8J8qqyvmck2Jsh7FT97UWrpRIIoDv/iK8
 MVnlJ2OwkniWGnDWXu6bKSTte3F0dffy8DMEQM0AD43vDx9ZrJ20z7bImga0A0M4p+P/di79B
 gqr1QVsNAONbnfE6i2h5boqloccX/Pzv8I7uYmciabsrhokTfuhtfSllcSeIOjjkte8BlYNRM
 94W+DpXvhZG4sP7Zutq+N7SubTZP+jE+4wfb1Tiw/FM4A4tFb66P62dEzFmmWzST6aXW/DpeB
 oZEx9GYakHRuwXbe8LMjFeXRQh1b0L0yO5tE0SP6N/fJgCb34wTJALKYa/3IcxyOFPj981qE5
 dTZrS3unAgBipH0w/XuHbyQ1LXMIsL9+hs8r4GWjiLMue3ss9EbMWisqjWBYk9XdsPpIJ2asq
 yJPmy+RBwHzEEwqPjMlrL6XLmOKS7ML+W8T5P0tZseO8MPvZy9TXr1k4sAAyqvIx1LUe3vmtt
 5UtQtjCx3CDih/0EEFZ3LdXREB+3u0fj1e8v8UTlfOTAeMGqAPYvm2zezFwEGcdo9/iU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 3:14 AM Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
>
> IOP(8051) embedded inside SP7021 which is used as
> Processor for I/O control, monitor RTC interrupt and
> cooperation with CPU & PMC in power management purpose.
> The IOP core is DQ8051, so also named IOP8051,
> it supports dedicated JTAG debug pins which share with SP7021.
> In standby mode operation, the power spec reach 400uA.
>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v9:
>  - Remove custom attributes sysfs.

You are now back to a driver that does nothing at all, please make it
use at least one kernel subsystem that it can hook up to before
you send it again.

Also, when listing the functionality above, describe which subsystems
you want to use for those in the long run, this would make it clearer
to see which direction you want to take this driver when you add
back the features.

         Arnd
