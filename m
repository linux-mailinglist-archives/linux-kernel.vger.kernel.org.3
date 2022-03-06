Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ED94CEAA3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 11:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiCFK6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 05:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiCFK6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 05:58:11 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B510251327;
        Sun,  6 Mar 2022 02:57:19 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id u61so25627525ybi.11;
        Sun, 06 Mar 2022 02:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aHEq+uTl6nfvsjsO/RJcNNeHwQ4EKazLFhLjmEVQatc=;
        b=MxBksCesBDIcCWl+hkBYg/w6miXRG9Q5QrE5gjytZ6YKublGRH9IYnkpD0RzjgIkMM
         Ybh0KOf6dtjpuq9kCTt4E7V1UfmygXNWfCINHRLa08wpRGCs0lNcyPvbRDZnLNBkV84z
         rj/Glxe5SM5cHaRqyBdtvKL/RDdDkPsU1uTZyeclgHZ9C67hEibAWAanMAmVw/zICM95
         Vqtoo6CNXnH63pboR78m7cZjfQucUP7CbDCNbHvoKKbYX0FxBx4F00WxDrVzw4YvAFhx
         xCwFfhPf+Dj9bUr7WHxHXTYjFqaNzTPfYhsppMAyzrL/NFBXtnTOcfUxcW2Bnb0Uv1dD
         DdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aHEq+uTl6nfvsjsO/RJcNNeHwQ4EKazLFhLjmEVQatc=;
        b=XL1OM3ZEJfK7rrxZKf7g0hayTwOR6wP+dNqk9POXnnQOeQOfhKp1iXtpHCLXu+CioD
         m6YOlr6DUXe7D5aINqNanqz+LCH2za8lS/58/OCP9/7bhmtoXC6lP0vUMI59CTf+hrJh
         Famq5Mvr+pJM3RL6g9debJ+fiwX1Gz2IBRLB3g6Iy8zr/P0ojmjz5tvg9lJCdfT3f917
         36MNPQfehZUMrDKZZuFa3gtyYigv3k1tXDlkajeGiCZRs5O9XqBkj1EoKFDKutWP/Mtz
         3R/7yehGZ8NQb2iRjw+/hWEcT6c1dZj7+Q7SMMGHzzE1LER31IwmEk4lpaANjvHraMBC
         GbTg==
X-Gm-Message-State: AOAM530/w+CpZ887AQ5PgcCmBCWoaJkuPjQX4kNcin10Pxjc1KiaiXFP
        k3LEry7hAXnBKiYbpS/tNAa2oCuWaTF/Kp2aORTEKLDkyBe1ng==
X-Google-Smtp-Source: ABdhPJybb2kdKRoB/rsyuepmnmiAe86JSY4KXc40Fc9E2GwkqLNQDoZvLstL653EXSTGn3ccBwMmArYLPv0I+kbebCQ=
X-Received: by 2002:a25:a064:0:b0:629:4589:ed3 with SMTP id
 x91-20020a25a064000000b0062945890ed3mr299260ybh.301.1646564238978; Sun, 06
 Mar 2022 02:57:18 -0800 (PST)
MIME-Version: 1.0
References: <CAFQXTv2B10=i6DMV1iJpOT-Mj9F93hOi_415cn49N6X_yDFw2g@mail.gmail.com>
 <YiSOjGLzMCvKOm0G@kroah.com>
In-Reply-To: <YiSOjGLzMCvKOm0G@kroah.com>
From:   Yunhao Tian <t123yh.xyz@gmail.com>
Date:   Sun, 6 Mar 2022 18:57:08 +0800
Message-ID: <CAFQXTv1CACLRB-Tx07pR4xFNQncdq=i7Q7=vQzgD3hpdehr7cQ@mail.gmail.com>
Subject: Re: PREEMPT_RT causes scheduling errors with f_rndis USB gadget
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B43=E6=9C=886=E6=
=97=A5=E5=91=A8=E6=97=A5 18:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Mar 06, 2022 at 06:17:54PM +0800, Yunhao Tian wrote:
> > Hi everyone,
> >
> > I'm using Linux 5.15.24-rt31 kernel with PREEMPT_RT enabled, on my
> > RK3308 board. I set up f_rndis gadget with the following script, and
> > plugged my board to a x86 Linux computer running 5.15.25 kernel:
>
> Does the same thing happen with the non-rt kernel?
>
> thanks,
>
> greg k-h

Hi Greg,

Thanks for your reply!

This doesn't happen to non-rt kernel. It will only happen when
PREEMPT_RT is turned on, with rt kernel.

Regards,
Yunhao
