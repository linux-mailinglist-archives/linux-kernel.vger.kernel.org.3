Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE64B51FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354536AbiBNNmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:42:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbiBNNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:42:18 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023EFCF3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:42:10 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id w4so279435vsq.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYmxekf2PWzR2/i3bVFnkQ14B4tkSWyC4DnusYihO3I=;
        b=1JhVRFST0LNWvvPmsn7MS4mxjw7dVMcmwX/F/OWpnhKGyeM4c3fif1o0PPnt0XYMe/
         pcvDXPd4/jAivMEjh2YCq2/0j58DS0798gPtvpthEVt0WoMWhPY0Noby1c+UxWPS3F53
         P9M+hPi6W9c0kcTAsWMjasOS0N/mj73f2rbbM6WiRyducs5aXBwNMj05Z+QWRlo7GHe6
         jW8xwx7BOEmB+3DZaElCtnZgrpsKLCFehNnvQxDD4SZfmlillGg0+qZMbqYNHk9oesO3
         xQlVqLpB2OZk8yg7blzk48xBbX+weErOwkHEGsdu5upX4eHM9gfN/Ynq7TbS90vCXcb0
         1fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYmxekf2PWzR2/i3bVFnkQ14B4tkSWyC4DnusYihO3I=;
        b=MhXqfmlXXeZYd+xBDBnajedGNL1YgoYPrtpYJAQzaZt+gXcbJTXO8QmEHatcF2MwCG
         IjssOAB6HYQqP2cJSAB+5r64t8jIo19mch1Bjuo6aI1yLxiTI9HLDJEeT5qnLNEq0G+5
         oLdfZr4WVkrgczIEFo0FZdlRrk5z48JMei+beHZJiVLtv5X09QeZ4Iy142gJaLtm4Y29
         bMHrILVVeUleMUdNHvutziFkYmRtT5pi2VxAQBZjh/7qHS+Ymj5oIyZrSCER64RqTYYZ
         hQLkKOPTk3KBOyCI77lCxqs6OzANYj/GkLZxRIWG2+fMa50S3Qr5TmbGvmtqDh+Mv7Un
         rx7w==
X-Gm-Message-State: AOAM531BxlMRS72+ul/+AVL/SbcyTegT3Q6BWRxfNny7dNP15I88sUEe
        GmJN5Sacu7PNxny0Sve3Kl1NqpSG8X8zDxPUIF1AUA==
X-Google-Smtp-Source: ABdhPJw+ajKnNNREHC7pzmYX+LUkRrHrVuCescAMJ+CbHn6QV4HhknBN2ltRFpNVIT/KuE2REVEJDvx4WtHwl2o6EkM=
X-Received: by 2002:a05:6102:3e90:: with SMTP id m16mr1485690vsv.21.1644846129807;
 Mon, 14 Feb 2022 05:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20220214092510.221474733@linuxfoundation.org>
In-Reply-To: <20220214092510.221474733@linuxfoundation.org>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Mon, 14 Feb 2022 19:11:33 +0530
Message-ID: <CAG=yYwnUnDpGD1RtxCJM0m65a75j397N+7KZ98zNjnVwjJ0Tqg@mail.gmail.com>
Subject: Re: [PATCH 5.16 000/203] 5.16.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 3:48 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.16.10 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Feb 2022 09:24:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
hello,

Compiled and booted  5.16.10-rc1+  on  VivoBook 15_ASUS Laptop X507UAR.
NO new regressions from dmesg.

Tested-by: Jeffrin Jose T  <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology  -  autonomous
