Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3BB4EA79C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiC2GDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiC2GDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:03:12 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B972F33EB7;
        Mon, 28 Mar 2022 23:01:28 -0700 (PDT)
Received: from [192.168.0.4] (ip5f5aef5a.dynamic.kabel-deutschland.de [95.90.239.90])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A45BF61EA1929;
        Tue, 29 Mar 2022 08:01:25 +0200 (CEST)
Message-ID: <e0680f5f-c8fe-2bbb-dfee-cf9c148d60da@molgen.mpg.de>
Date:   Tue, 29 Mar 2022 08:01:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcmVzb2x2?=
 =?UTF-8?Q?e_s3_hang_for_r7340?=
Content-Language: en-US
To:     =?UTF-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        David Airlie <airlied@linux.ie>,
        Lijo Lazar <lijo.lazar@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Wang <kevin1.wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
References: <1l3bxtj7h5f-1l3d7rcmiz8@nsmail6.0>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1l3bxtj7h5f-1l3d7rcmiz8@nsmail6.0>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear 李真,


[Your mailer formatted the message oddly. Maybe configure it to use only 
plain text email with no HTML parts – common in Linux kernel community 
–, or, if not possible, switch to something else (Mozilla Thunderbird, …).]


Am 29.03.22 um 04:54 schrieb 李真能:

[…]

> *日　期：*2022-03-28 15:38
> *发件人：*Paul Menzel

[…]

> Am 28.03.22 um 09:36 schrieb Paul Menzel:
>   > Dear Zhenneng,
>   >
>   >
>   > Thank you for your patch.
>   >
>   > Am 28.03.22 um 06:05 schrieb Zhenneng Li:
>   >> This is a workaround for s3 hang for r7340(amdgpu).
>   >
>   > Is it hanging when resuming from S3?
> 
> Yes, this func is a delayed work after init graphics card.

Thank for clarifying it.

>   > Maybe also use the line below for
>   > the commit message summary:
>   >
>   > drm/amdgpu: Add 1 ms delay to init handler to fix s3 resume hang
>   >
>   > Also, please add a space before the ( in “r7340(amdgpu)”.
>   >
>   >> When we test s3 with r7340 on arm64 platform, graphics card will hang up,
>   >> the error message are as follows:
>   >> Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.599374][ 7] [  T291] amdgpu 0000:02:00.0: fb0: amdgpudrmfb frame buffer device
>   >> Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.612869][ 7] [  T291] [drm:amdgpu_device_ip_late_init [amdgpu]] *ERROR* late_init of IP blockfailed -22
>   >> Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.623392][ 7] [  T291] amdgpu 0000:02:00.0: amdgpu_device_ip_late_init failed
>   >> Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.630696][ 7] [  T291] amdgpu 0000:02:00.0: Fatal error during GPU init
>   >> Mar  4 01:14:11 greatwall-GW-XXXXXX-XXX kernel: [    1.637477][ 7] [  T291] [drm] amdgpu: finishing device.
>   >
>   > The prefix in the beginning is not really needed. Only the stuff after
>   > `kernel: `.
>   >
>   > Maybe also add the output of `lspci -nn -s …` for that r7340 device.
>   >
>   >> Change-Id: I5048b3894c0ca9faf2f4847ddab61f9eb17b4823
>   >
>   > Without the Gerrit instance this belongs to, the Change-Id is of no use
>   > in the public.
>   >
>   >> Signed-off-by: Zhenneng Li
>   >> ---
>   >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>   >>   1 file changed, 2 insertions(+)
>   >>
>   >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>   >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>   >> index 3987ecb24ef4..1eced991b5b2 100644
>   >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>   >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>   >> @@ -2903,6 +2903,8 @@ static void
>   >> amdgpu_device_delayed_init_work_handler(struct work_struct *work)
>   >>           container_of(work, struct amdgpu_device, delayed_init_work.work);
>   >>       int r;
>   >> +    mdelay(1);
>   >> +
>   >
> 
>   > Wow, I wonder how long it took you to find that workaround.
> 
> About 3 months, I try to add this delay
> work(amdgpu_device_delayed_init_work_handler) from 2000ms to 2500ms, or use mb()
> instead of mdelay(1), but it's useless, I don't know the reason，the occurrence
> probability  of this bug is one ten-thousandth, do you know the possible reasons?

Oh, it’s not even always reproducible. That is hard. Did you try another 
graphics card or another ARM board to rule out hardware specific issues?

Sorry, I do not. Maybe the developers with access to non-public 
datasheets and erratas know.

>   >>       r = amdgpu_ib_ring_tests(adev);
>   >>       if (r)
>   >>           DRM_ERROR("ib ring test failed (%d).\n", r);


Kind regards,

Paul
