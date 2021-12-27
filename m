Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B234847FC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhL0Le5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhL0Ley (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:34:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED11EC061401
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 03:34:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so12985931pjf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 03:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jd2KJ61wX8nV+l4qEphFCwhVfyjEv9bxYKlxVpeMJ2A=;
        b=NNDIgnSEg2wLqr1Oah+q7fFr6cEvL+XAs2dTBnebktoahy5V/7IDqoIVmDml2y7xLF
         Ut4jMnLGvDDHVzxqlJf+Ynttv4Ic1EUknE0q3JEfur2QWx1eilkEgee0TduEPGyIrLsc
         EJxYchls9SdEkEUV6XGuSBB70l26a0m3Eb35ESP73eZtOzXVr+CNJLgbyjkWMOdu+vZY
         CAQee6i5GhN4fwm5i5PH2B50PialLZ4pjsJKbeSkpuun0xtHkzqRe87aPcoa8dkmJVjd
         rbh5mEeCRS2Nv+1E3xQNoCwMfYrGWk4QrCNXJCscG1SkMSDD3P84vZaUlmgZu1naYSBz
         F+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jd2KJ61wX8nV+l4qEphFCwhVfyjEv9bxYKlxVpeMJ2A=;
        b=xZ5JQCrHUmM09SDWiFE/CJENCUm+aUD7J1D8omy51Fh0KHvjOg4M0ChVTagmFO1IZO
         U1mQQRPx3di+cyi/aBL+frhfDzc6XCLtu1lVHnMPPQq77Hf2ZpOKIQf25/yE3bdlNNGQ
         2O530gMqWZsZXKJhLQrm3c8MTXSlT3yc8KQ2D0k15dkkAdVdf1EJtKelu8gIi8GxzO78
         6KKDfH4DJ4NRRSPvCtwZ+1TyzHRlbYX9HToA/GB+5pn80EC9WzFTcIxsfZJWe12HUgTC
         rW81kmg6g9EGlLQNtGQwrT26BwGcfht9zWVpQSvcQaEY9rAU11SLCFwAoUC56bq+l00V
         qDeA==
X-Gm-Message-State: AOAM533LoDo1OmegOuJU6S07uM/HYLPWyRSPodTKo4u3FHlqxjQx94av
        G2mjpvPOE3l5/RzRphQ9OVwusUYYPYk6ABCSYsSMr8oygWmNdA==
X-Google-Smtp-Source: ABdhPJx7SqYM0Oy0x/uoDjZKqUvD0JXYlvnirwPp9gvGxyGaCSbFU0OFSlw1IZ6WFjKfztl1+LS/626aO+jtG3VCOd0=
X-Received: by 2002:a17:902:8c92:b0:149:848e:e337 with SMTP id
 t18-20020a1709028c9200b00149848ee337mr2912718plo.139.1640604893476; Mon, 27
 Dec 2021 03:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20211222094558.2098791-1-jsd@semihalf.com> <20211222094558.2098791-3-jsd@semihalf.com>
 <a1b47be4-f208-1a59-d704-99a463bb2fe0@linux.intel.com>
In-Reply-To: <a1b47be4-f208-1a59-d704-99a463bb2fe0@linux.intel.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 27 Dec 2021 12:34:42 +0100
Message-ID: <CAOtMz3N=BPfudoamy3dVUZ6E07_Cw0OD_mJgZRrX+UWnY7c8ww@mail.gmail.com>
Subject: Re: [RFC 2/2] i2c: designware: Add AMD PSP I2C bus support
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 23 gru 2021 o 15:37 Jarkko Nikula
<jarkko.nikula@linux.intel.com> napisa=C5=82(a):
>
> On 12/22/21 11:45, Jan Dabros wrote:
> >
> > Introduce new CONFIG and add new menuconfig selection list in order to
> > allow (optional) selection between baytrail and amdpsp semaphore.
> >
> For the Linux distribution point of view selection must happen runtime.
> Otherwise either AMD PSP or Baytrail semaphore support is missing from
> the installation image.

I see, thanks for your input.
Will modify the driver so that it should work with both (Baytrail,
AMDPSP and potential new ones) semaphore modules compiled in.
Executing probe()'s at runtime will allow to select and install
correct callbacks.

Best Regards,
Jan
