Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397285308EE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350496AbiEWFmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiEWFmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:42:09 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE9A1A82F
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:42:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id d137so23455864ybc.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ce0c2vLV4sUxJ3tplGN0HOr0r8Zisa3HjuO2lTepL0=;
        b=nU3WHf/uNoLdnh6e/fN3cHwHpncxXIGuGl8npuSPITaRM+jazkeWJRrntmBecWREdD
         q9LuDuypasKmgTOTX4h8vRDx6Jty7G3x7Z+P3VpHhvfjOOHd3528yyObXNliG2WAmx+X
         qOJfFVD4QWN/uvDDx0VjkJu79wIqE1d14JE8swaBoe37oDEu/DfwymFViFakVSR4BtLd
         rCq0XJ6JsgxDYmRP/h+/U4s1NQFnVayTggL2c00aqVu6eoGfgS1KNM5joJCTmC/jtw5y
         6y8ofgFqk97LCgZtepEeB4HtDSylf+rjwwWo1c7GIiQNX9lL5G62UgrDEPRR/vICZbhm
         xW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ce0c2vLV4sUxJ3tplGN0HOr0r8Zisa3HjuO2lTepL0=;
        b=RmQb5jRL6cXt4EeM5rO2+7ph9uABW78t7N/H8o2gsLz/4E/OVuttbHoSP/98s5ruNO
         iCSc/TziBFs4oxiW4o56N2qfziimynB0z67IrZoF3bLYgLzuYiGVun6QXzB/s+SHmj6h
         6aeOEdx2Ih8s/vW65eciVKm8FVTEjGnEEIcX/ob8fbUJMQ6ObWDE4q+ZF6GOhucKeynx
         vrqWNoTbasmJfpst66FfFtfsJ2WpYAALddvRZSnZtI19HDh/7rs67Yc8GQ6AVvCVq/dp
         z3aqcXkvJX6qVq7k4l087CDrqspF5ajV9Q0lzPkvDe0i75nVAUv9jl1w29e55J1TFC6b
         56Wg==
X-Gm-Message-State: AOAM533EOQH2FmPoMKA5pPnbKhDsgCgVnLjhak0sOfoZxWVsbhTYMJUV
        tkdk5iuCtJTL21XoTZD+HbQw02mmDMSFGbRFIz5Mbw==
X-Google-Smtp-Source: ABdhPJwWI9ZKihp7w8I2OHZ6R+V09XAtRCWmqUzL7juIxAFOsmTHJBoFETmaUkRqtUvbFqep1Ij8CGItEmblXxOB1QI=
X-Received: by 2002:a25:b10c:0:b0:64f:649b:622f with SMTP id
 g12-20020a25b10c000000b0064f649b622fmr12826897ybj.253.1653284525322; Sun, 22
 May 2022 22:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org> <20220522195138.35943-1-konrad.dybcio@somainline.org>
In-Reply-To: <20220522195138.35943-1-konrad.dybcio@somainline.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Mon, 23 May 2022 11:11:29 +0530
Message-ID: <CAMi1Hd161=vc2eLVsnYVeeU6mNH8Fx8XfiQMUe_K=LbjyetSZw@mail.gmail.com>
Subject: Re: Removal of qcom,board-id and qcom,msm-id
To:     krzysztof.kozlowski@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     agross@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, robh@kernel.org,
        sboyd@kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 at 01:22, Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
> Hi,
>
> removing these properties will not bring almost any benefit (other than making
> some checks happy any saving some <200 LoC) and will make the lives of almost
> all people doing independent development for linux-on-msm harder. There are
> almost unironically like 3 people outside Linaro and QUIC who have
> non-vendor-fused development boards AND the sources to rebuild the
> bootloader on their own. Making it harder to boot is only going to
> discourage people from developing on these devices, which is already not
> that pleasant, especially with newer platforms where you have to fight with
> the oh-so-bright ideas of Android boot chain..
>
> This only concerns devices released before sm8350, as the new ones will not
> even boot with these properties present (or at least SONY Sagami, but I
> doubt it's an isolated case), so other than completing support for older
> devices, it won't be an issue going forward, anyway. But there are give
> or take 50 locked down devices in mainline right now, and many more waiting
> to be upstreamed in various downstream close-to-mainline trees that should
> not be disregarded just because Qualcomm is far from the best at making
> their BSP software stack clean.
>
> One solution is to chainload another, (n+1)-stage bootloader, but this is
> not ideal, as:
>
> 1) the stock bootloader can boot Linux just fine on most devices (except
> for single exceptions, where beloved OEMs didn't implement arm64 booting or
> something)
>
> 2) the boot chain on MSM is already 3- or 4- stage and adding to that will
> only create an unnecessary mess
>
> 3) the job of kernel people is not to break userspace. If the
> device can not even exit bootloader after a kernel upgrade, it's a big
> failure.
>
> If you *really really really* want these either gone or documented, we can
> for example use them in the SOCID driver, read the values from DTB and
> compare against what SMEM has to say and for example print a warning when
> there are inconsistencies or use it as a fallback when it fails for any
> reason, such as using a newer SoC on an older kernel, without updates
> for SOCID read (which are sometimes necessary, which was the case for 8450
> recently, iirc).
>
> My stance is to just leave them as is, as moving them anywhere, or removing
> them at all will cause unnecessary mess and waste time that could have been
> spent on more glaring issues..

I couldn't have put it better myself. I suggest we document these
properties, if that is the blocker, and keep them. A lot has changed
in the last 7 years, we now have dozens of devices booting upstream
kernel using these properties.

And fwiw, I have not used dtbTool before, if anything I'd rather
explore dtb overlays.

Regards,
Amit Pundir

>
> Konrad
