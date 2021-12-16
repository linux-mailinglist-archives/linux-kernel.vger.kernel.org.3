Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80733478038
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbhLPW6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhLPW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:58:52 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF45C061574;
        Thu, 16 Dec 2021 14:58:51 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id m12so326012ild.0;
        Thu, 16 Dec 2021 14:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0m4Q3hGlzYdyBIUPzHCZSSuAjneWrkCoYtGboZy5fY=;
        b=ma4JKiyDAeTftIR5xYKRx+/AMah3OImnO4fn4pBnKhulZ9PrilolWzhqyXoBqphaOQ
         ub6N0wmjl+phIPjmgRGBb4as0YxuRm8E+MrnYMYJLzmhyIr8cVtzBMbMQ8qwJX4WyuHj
         +k6WI52JtgCaMWj+ZVGIKO/VlUp1FrUwNUqUUnCPMGSJ2BOUaULXeityBNlVY3YqtX4B
         doBqkU0N+lX+1wx4IPfMgkv/7thqAJpcr5F98fKU1viFhkyyX5m0vLzgbmCUpwOxQYmn
         0YAhrmbGvVitmJunkHN0zJUgaJ/EXEzGRAbMJI9pGMIueRJV9ftGV74RM7L8KyB32c8z
         jmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0m4Q3hGlzYdyBIUPzHCZSSuAjneWrkCoYtGboZy5fY=;
        b=dUYdIv3FE5XpT9KQ8G+WD2H3qbQT6hcdiRmPDpI9yCwrf1vXRXOevcEqi8gzkl/xYL
         hfxDDykWdYzdaY462BoPss4C7VYiwLBHEDhqkbCoIKcXNaVJlK82+CGhyhlDEjwfDbd8
         a+rz/SsUGV0S7v9MdviMdkvkbTyMMoVhVs27CPAzoh+EL0XgyKHC+mAYwnneca9Ath86
         mU4BklTO1teB6yZMY54YpWwsnUxL3KbgV7cTTx7CrM31N+tdUpOT2dfnTbCsN2kKJBKt
         oXgJuRG0Sgvcta0nvhUz8+T48jIAD5wPr8oJuQnzHEG8aRXuTBxE9+tIiYVe8rXur824
         95Fg==
X-Gm-Message-State: AOAM531Iz8akkd6kj0VLtRMp6aGxcvQUi9pLFmTb2s/CBnAVzJA4Il1b
        6mR+chDK6vMofIoKqIwddtLx6YXQQuTvioHd+GoECYSZVFRZ3PTjtrc=
X-Google-Smtp-Source: ABdhPJzNrq2MAGYiMRpet+HvO8uSMEKpVsvMvcHfLSLDsglmds6TCDUSSHydXYQN4lgW68iqs1F3nnsCzHVPqtCLz30=
X-Received: by 2002:a05:6e02:1445:: with SMTP id p5mr121952ilo.164.1639695531309;
 Thu, 16 Dec 2021 14:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20211216205303.768991-1-eugene.shalygin@gmail.com>
 <CAHp75VeERqjxrt7C4hrDnJpY1aCQPtF=CQ=MLY8e9Gik57P3DQ@mail.gmail.com> <20211217000424.41da446e@netbook-debian>
In-Reply-To: <20211217000424.41da446e@netbook-debian>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 16 Dec 2021 23:58:40 +0100
Message-ID: <CAB95QAQs5=t37UTv2r=ewj1QaaD5LQckGXG1zL+wWYxYTgBdtA@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

On Thu, 16 Dec 2021 at 23:04, Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Hi Eugene,
>
> Have you found some issues with idea of usage ACPI WMI methods as
> failback solution, like in case when ASUS will release some BIOS with
> different mutex path or different motherboard where will be same WMI
> methods but fully different internal logic?

Not direct ones, but yes. First of all, I still don't understand what
causes the big slowdown in ec_read() calls. I learned that Fedora and
Arch kernel configs result in the slowdown, while my custom minimal
kernel does not (well, it is still slow but nevertheless). I tried to
unload all the modules I do not have in my custom kernel, I tried to
disable every option which is related to ACPI in the Fedora config,
but the slowdown did not disappear. Then it is not that simple to
gather information from other users, because one needs the ec_sys
module to measure ec_read() performance, but it is not available in
many distribution kernels it seems.

Instead of that I've changed data structures for board description to
include the mutex path there, so that we can handle various paths or
version dependent paths for each motherboard. I can add code to select
the mutex path based on the BIOS version for the next iteration. Also
considering adding a module parameter to override that path. I think
that will be maintainable and give users a way for a local fix while
waiting for kernel update. Would you agree?

That way, I believe, the WMI fallback is rendered barely useful and I
decided to drop it.

Best regards,
Eugene
