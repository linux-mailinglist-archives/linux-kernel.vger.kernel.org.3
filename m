Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505614C1DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbiBWV3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiBWV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:29:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8278936B66;
        Wed, 23 Feb 2022 13:28:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j22so15624452wrb.13;
        Wed, 23 Feb 2022 13:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0YK7APaDiTPWfwD2QnORHvmLB5q84+dKOtRyftB0uhU=;
        b=WLpMmO9MRwflWvya8gR3yu5MLwDjHJMy/NtZOfH2MBKCM06xKgAT5PR2Hg4RjD5Dxx
         s2E3/6DOu4nwZzrSKn3vRbQlfCZw1dERZ61z5btlsd4dlCeFb0TCKG0tX9IK7wDNLfZl
         Tb4HdBt3/V8qyBysfwma4TVc4qpcDnR2bvEN+Fp3MPTh2aU0yNROilTWQvLGSu6ziSlt
         sY6r/7rPqpCRLYlh91U7sf6fBdsKqkI053dIvZnMegjpnC5kEEInWv3hhVcJVlzd/0S/
         niDpi+JsS4Whm0jkbOmlJviRTSZbKF4zmojmIJoeGo+xZXP7HUCUlRZRFPpaLGJeZnxI
         /7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0YK7APaDiTPWfwD2QnORHvmLB5q84+dKOtRyftB0uhU=;
        b=vDVAzlxqoCeU1qYSIYQAg1TWwMdPJPgrxacPp8Dow5IfwLd5dHKtXYaPaUeB1fN+9N
         JCdX4C4Z2xRbil+T1Z7LNPvd1JDZdaVoY1eMkd/5eRnJIZ4MoX4clU4CUnqIZJT88Fkt
         YLrdgHj+erM629mWmwIwCevRGnUb+G7hIDtTvfsIzLsG2LDsK2fnd3OEUPpZbHzTgErA
         tjhqM7dqUGHOkwu79ZKwNXiupiAgB0PWsDZdivnwFBhQTZ6onG8pd8NtmOL2O84RgkX2
         Wjwt8iE3V77E6GRqHOsuTHIo5HjmJbdWAE2RaqeJyKnz5L5nulH0uCqdjcP5OSHXBK28
         DqOw==
X-Gm-Message-State: AOAM532sxafYxBjyTcE1rl4nQbk3is4RCQUL/Vl7PO8CCm7Fz8QZxW5I
        MqLhHhrSnc0sf1uawv3gAs4=
X-Google-Smtp-Source: ABdhPJw7LZnXitIO3MYp14pRCaZMOD4GDLd8Ot3GC4uDtFYcc2pmomZdcQPO+2XrPQeSWhK4rxU1zA==
X-Received: by 2002:a05:6000:12cc:b0:1ed:b776:a86b with SMTP id l12-20020a05600012cc00b001edb776a86bmr1130345wrx.307.1645651715942;
        Wed, 23 Feb 2022 13:28:35 -0800 (PST)
Received: from [192.168.2.122] (p578f0c28.dip0.t-ipconnect.de. [87.143.12.40])
        by smtp.gmail.com with ESMTPSA id i15sm713311wmq.23.2022.02.23.13.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 13:28:35 -0800 (PST)
Message-ID: <ab97c2a5-7705-eae8-9bc2-908e7a9cb709@gmail.com>
Date:   Wed, 23 Feb 2022 22:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v9 00/11] Restructure the rpmsg_char driver and introduce
 rpmsg_ctrl driver
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, julien.massot@iot.bzh
References: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
From:   Philipp Rossak <embed3d@gmail.com>
In-Reply-To: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

thanks for working on this! I'm currently testing/using this patch 
series on my imx7d project because it adds the capability that the 
remote processor can register it's endpoints dynamically (as mentioned 
in the objectives).

After a few tests, debugging, and checking the openamp specification [1] 
I think that you missed the second ns_announcement that should be sent 
from linux master to the slave after it created the channel/endpoint. 
Without this second announcement the remote processor is not able to 
send messages to the linux master because it doesn't know the 
destination address until it receives a message from the linux master.

Cheers,
Philipp


[1]: 
https://github.com/OpenAMP/open-amp/blob/main/docs/img/coprocessor-rpmsg-ns.png

On 24.01.22 11:25, Arnaud Pouliquen wrote:
> Updates from V8 [1]:
> - rebase on 5.17-rc1 + rpmsg char cdev release fixes[2][3]
> - updates based on Bjorn Andersson's comments:
>    - remove rpmsg_create_default_ept API, set directly the ept->priv in rpmsg_chrdev_probe
>      function.
>    - rework commit message in [8/9]rpmsg: char: Introduce the "rpmsg-raw" channel
> 
> Patchset description:
> 
> The current rpmsg_char module implements a /dev/rpmsg_ctrl interface that provides the ability to
> instantiate char devices (/dev/rpmsgX) associated with an rpmsg endpoint for communication with the
> remote processor.
> This implementation fits with QCOM rpmsg backend but not with the magement by chanel implemented
> in the generic rpmsg virtio backend.
> This series restructures the rpmsg_char driver to decorrelate the control part from the data part
> in order to improve its compatible with the rpmsg virtio backend.
> 
> Objective:
> - Expose a /dev/rpmsg_ctrlX interface for the application that is no longer dedicated to the
>    rpmsg_char but generalized to all rpmsg services. This offers capability to create and destroy
>    rpmsg channels from a user's application initiative (using the new RPMSG_CREATE_DEV_IOCTL and
>    RPMSG_DESTROY_DEV_IOCTL controls).
>    An application will be able to create/establish an rpmsg communication channel to communicate
>    with the remote processor, and not only wait the remote processor initiative.
>    This is interesting for example to establish a temporary communication link for diagnosis,
>    calibration, debugging... or instantiate  new data flows on some user actions.
> - Add capability to probe the rpmsg_char device at the initiative of the remote processor
>   (rpmsg service announcement mechanism).
>    This allows platforms based on the rpmsg virtio backend to create the /dev/rpmgX interface with
>    a rpmsg name service announcement.
> 
> Subsets:
>    - Extract the control part of the char dev and create the rpmsg_ctrl.c file (patches 1 to 6)
>    - Introduce the "rpmsg-raw" channel in rpmsg_char(patches 7 to 10)
>    - Introduce the RPMSG_CREATE_DEV_IOCTL IOCTL and RPMSG_DESTROY_DEV_IOCTL to instantiate RPMsg
>      devices (patch 11)
>      The application can then create or release a channel by specifying:
>         - the name service of the device to instantiate.
>         - the source address.
>         - the destination address.
> 
> This series has be applied and tested on 'commit e783362eb54c ("Linux 5.17-rc1") +
> rpmsg_char cdev release fixes [2][3]
> 
> [1] https://lkml.org/lkml/2021/12/7/186
> [2] https://lkml.org/lkml/2022/1/10/1129
> [3] https://lkml.org/lkml/2022/1/10/1130
> 
> Arnaud Pouliquen (11):
>    rpmsg: char: Export eptdev create and destroy functions
>    rpmsg: Create the rpmsg class in core instead of in rpmsg char
>    rpmsg: Move the rpmsg control device from rpmsg_char to rpmsg_ctrl
>    arm: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
>    RISC-V: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
>    arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL
>    rpmsg: Update rpmsg_chrdev_register_device function
>    rpmsg: char: Refactor rpmsg_chrdev_eptdev_create function
>    rpmsg: char: Add possibility to use default endpoint of the rpmsg
>      device
>    rpmsg: char: Introduce the "rpmsg-raw" channel
>    rpmsg: ctrl: Introduce new RPMSG_CREATE/RELEASE_DEV_IOCTL controls
> 
>   arch/arm/configs/qcom_defconfig   |   1 +
>   arch/arm64/configs/defconfig      |   1 +
>   arch/riscv/configs/defconfig      |   1 +
>   arch/riscv/configs/rv32_defconfig |   1 +
>   drivers/rpmsg/Kconfig             |   8 +
>   drivers/rpmsg/Makefile            |   1 +
>   drivers/rpmsg/qcom_glink_native.c |   2 +-
>   drivers/rpmsg/qcom_smd.c          |   2 +-
>   drivers/rpmsg/rpmsg_char.c        | 231 +++++++++++-----------------
>   drivers/rpmsg/rpmsg_char.h        |  46 ++++++
>   drivers/rpmsg/rpmsg_core.c        |  15 +-
>   drivers/rpmsg/rpmsg_ctrl.c        | 243 ++++++++++++++++++++++++++++++
>   drivers/rpmsg/rpmsg_internal.h    |  10 +-
>   drivers/rpmsg/virtio_rpmsg_bus.c  |   2 +-
>   include/uapi/linux/rpmsg.h        |  10 ++
>   15 files changed, 419 insertions(+), 155 deletions(-)
>   create mode 100644 drivers/rpmsg/rpmsg_char.h
>   create mode 100644 drivers/rpmsg/rpmsg_ctrl.c
> 
