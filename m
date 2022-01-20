Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9470E495409
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346468AbiATSRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346228AbiATSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:17:27 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BB1C061401
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:17:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v11-20020a17090a520b00b001b512482f36so3684166pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=uC24dwBDFYlPwZIYL2HsVi2/C5I01RLnxTMvvJMu+BQ=;
        b=lY5AG79+OamxRdgX54aP/AbsEAj4jjC05Li4bJX637zqF/+EVSHrNBzbeJwatK4jLy
         f22WQiH1toeAILYl6sTtTM6NFAp3jRQDpVAHxxQA98wKEZcULLjKNxnESY33dCFVZmXd
         IGdJKzKmPqGYOn6XlC1xn3NorC4uPMh/6cmhOCFbBzDu+17bl8OmiU1uTgkZnxp26LqT
         B+oF02kGj7CmDyYEmZfUcMK6aV1//4tU/5bHLpQLfZTcp8xwRZD+BXrLoem3r6WJRP5M
         JC03L09Hm4LN4ua6WFQdHRj7a0bFuBTv4h4YucZDNPs+j25ahc3zQLKdMvl8dRMUm31/
         XkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=uC24dwBDFYlPwZIYL2HsVi2/C5I01RLnxTMvvJMu+BQ=;
        b=Volt/nz1EfdpNmgUI+GEFeGm/dlhlFgjQwgbM4FnXYsoecGwR+I4wgAyZSbEyU7qvK
         iF+f9R1i/9jTDyJXY+YKN1xC83nKLUpykCfKZ83hEmFitnw8NRtxpVRVa9gECzPZDneS
         /GXO0r7eolyUXHmPgwhX8T/dSCQIhizA1XDLCuHj4p+1CmzBmDjRzXGO/yL2Lh+1y2FY
         WGEQzUxDQkkPtUiVnT6HaAziVd7S2O1K9sB22aUK2vtbmTYDFIIyva1LbG0e4DEQYUjg
         Fzqr2D+cAAg2wO/SLMgQlo7tF2LVDPkaYxZ+N/HhPZlNdCeZWNRHrp1dMNH0Wt9k9dbX
         UvMQ==
X-Gm-Message-State: AOAM533O9l4Rj+/S0kpCjfqX/rZfdIFhReDUOV+Nb9L6JJxRjbtAsXQY
        enymGCEMYWX6xnam+/MNRTnXmQ==
X-Google-Smtp-Source: ABdhPJziNRpPC3KLwKGQytXhOnjNqmYk6QLfSsTVaekBbezJEDJk6aCEWnW9OX1QP+GwuVrq/1BX/Q==
X-Received: by 2002:a17:902:ed85:b0:14a:2471:e11d with SMTP id e5-20020a170902ed8500b0014a2471e11dmr39168021plj.77.1642702646769;
        Thu, 20 Jan 2022 10:17:26 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id c35sm3064385pgl.6.2022.01.20.10.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:17:26 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:17:26 -0800 (PST)
X-Google-Original-Date: Thu, 20 Jan 2022 10:15:39 PST (-0800)
Subject:     Re: [PATCH] riscv: dts: sifive unmatched: Add gpio poweroff
In-Reply-To: <ED7B7FCA-182C-45AC-90E7-17559762DE0B@jrtc27.com>
CC:     dimitri.ledkov@canonical.com, w6rz@comcast.net, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, plr.vincent@gmail.com,
        krzysztof.kozlowski@canonical.com, qiuwenbo@kylinos.com.cn,
        yash.shah@sifive.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jrtc27@jrtc27.com
Message-ID: <mhng-21187529-2437-47dd-9506-9d877123b539@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 09:16:00 PST (-0800), jrtc27@jrtc27.com wrote:
> On 31 Dec 2021, at 16:49, Dimitri John Ledkov <dimitri.ledkov@canonical.com> wrote:
>> 
>> However, in some configurations uboot loads kernel provided dtb, then this pin needs to be defines for SBI to provide poweroff via this pin.
>> 
>> Kernel, uboot, opensbi dtbs for unmatched must be consistent with each other and all should define poweroff pin.
>
> U-Boot SPL loads its embedded DTB for OpenSBI’s use. U-Boot “proper”
> loads the kernel’s DTB for the kernel’s use. The DTB loaded for the
> kernel is never fed back somehow. Just as we don’t provide DDR timing
> information in the kernel DTB, only U-Boot’s, there should be no need
> to provide information about this GPIO to the kernel. Either the kernel
> will prioritise SBI power-off, which renders the DTB node a complete
> waste of space, and possibly confusing to exist, or the kernel will
> prioritise GPIO power-off, which should be discouraged as you’re
> supposed to use standardised firmware interfaces for these kinds of
> platform-specific things.

The DTs (and bindings, etc) in the kernel source tree are meant for more 
than just the kernel's consumption.  I know we have (and will likely 
always have) some diff with the other consumers of device trees, but we 
can at least try to get folks on the same page about small stuff like 
this.

There is also some utility to having this visible to Linux: at a bare 
minimum it lets us know that GPIO pin has an important function.

This patch is on for-next.

>
> Jess
>
>> On Fri, 31 Dec 2021, 06:58 James Clarke, <jrtc27@jrtc27.com> wrote:
>> On 31 Dec 2021, at 06:11, Ron Economos <w6rz@comcast.net> wrote:
>> > 
>> > This patch is required for the following commit to work.
>> > 
>> > commit f2928e224d85 ("riscv: set default pm_power_off to NULL")
>> > 
>> > Signed-off-by: Ron Economos <w6rz@comcast.net>
>> > ---
>> > arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
>> > 1 file changed, 5 insertions(+)
>> > 
>> > diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
>> > index 6bfa1f24d3de..c4ed9efdff03 100644
>> > --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
>> > +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
>> > @@ -39,6 +39,11 @@ rtcclk: rtcclk {
>> >        clock-frequency = <RTCCLK_FREQ>;
>> >        clock-output-names = "rtcclk";
>> >    };
>> > +
>> > +    gpio-poweroff {
>> > +        compatible = "gpio-poweroff";
>> > +        gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
>> > +    };
>> 
>> Why? It’s abstracted by firmware, which works.
>> 
>> Jess
>> 
