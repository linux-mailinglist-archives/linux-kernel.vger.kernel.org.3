Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466F54749CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhLNRjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhLNRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:39:18 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6BC061574;
        Tue, 14 Dec 2021 09:39:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so66608189edu.4;
        Tue, 14 Dec 2021 09:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxAuJbLvvTcbumNHXWVkWEBJhfQUVBNZ5jnWFkaTSsc=;
        b=e1SoDw3pmy2JdP7IPrREK0jG2cn8uEHq3kXD6m0PSAb9xnBxyMJyQpXBuTIRSFH5vr
         zyVEsFVTqd8MSQXyp/MfyJksmCCFXUXB3qV/Bd+PLR+/NTMM/ADSF7xFeohIHOGpC9pC
         1B6mV275t3/L/9afXznLmVGlBQImU+BRr3+n5eA21JyFwyPeXmog12j6S9Yzg2bWa6Aq
         ObcgC3XZAAwTmxxPyK9EO4f2TaErwdSTGDwH9EGwFNkvfiUGH9oQBnMJZ3VHG96cKHrE
         fp4YSAkbRfctF07IF/z2x+J7CaDV+15TqPXg62JDKZZtjF8pE3JfNgMFqDcoH+Gb3PkO
         il4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxAuJbLvvTcbumNHXWVkWEBJhfQUVBNZ5jnWFkaTSsc=;
        b=M0hUVhia5wQqWt64dsCOsWbIWiNx1bJLMMYohWmlmnE4qehoKINyU4PStQq4x6AVDE
         e3Qg8RFMaDPTDr5mcWuRc+m5fdcGEFU9F3QRwXK8GO5ZU/nKbnE4q8FfzqCbF5oHP/Sc
         O/iddlry7W3rdzStn+KrQ1Nq3hAZ1rHOQENx3tZQOySjyYDNPxqRUvy5uus4kGC3Ec8C
         pip1/XtIfHVnBTz8s2drDzHO+VpLWI3kGlwClS1c1vCJjsjdS+t4NAcg+/LwcwEqUDem
         a41BNyFcJZmb1dmD1HaA9rom60AUE0H+suwMiS3eXu8Cg0aCzIrcrQD0a2oS50MTwHBM
         VcVQ==
X-Gm-Message-State: AOAM5322bQUzs39506mnTtZrKxJWFEpuAOiu3VSShgCEGk17ESOHjnsb
        7BvuWxEYSvuv/zL2SGqEkD+sXREFCj92ECXdK3g=
X-Google-Smtp-Source: ABdhPJyfe+m1TWfKEDr/wqXpFTcnF2opPxqMTsYASJHjTvEd+Gg2pPTfJJac6JIWJDSG3LI8qCeW4TcStTKIuDs6H+E=
X-Received: by 2002:a17:906:a3c6:: with SMTP id ca6mr2672214ejb.639.1639503556811;
 Tue, 14 Dec 2021 09:39:16 -0800 (PST)
MIME-Version: 1.0
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
 <1638891339-21806-4-git-send-email-quic_srivasam@quicinc.com>
 <CAHp75Vd=47Tv9Sf+styPhxS2=O1H2KUDeKQXTULUYU5fDgGwwA@mail.gmail.com>
 <0f6621e5-f014-27c9-be8b-6c32ab994304@quicinc.com> <CAHp75VdL3hmr23CcJLDpvbHaKv5HrDZjmVQpCnRNmPM7nEx6WQ@mail.gmail.com>
 <4bcfadd0-8abb-e9e9-ad18-a5b1d3d46308@quicinc.com>
In-Reply-To: <4bcfadd0-8abb-e9e9-ad18-a5b1d3d46308@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Dec 2021 19:37:47 +0200
Message-ID: <CAHp75Vcnc96QYy5_mzYCbhrsJ=iEghKR0Z8XaX+DnVeNN3DthQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] pinctrl: qcom: Extract chip specific LPASS LPI code
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, plai@codeaurora.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, judyhsiao@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 7:22 PM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
> On 12/14/2021 10:46 PM, Andy Shevchenko wrote:
> > On Tue, Dec 14, 2021 at 7:15 PM Srinivasa Rao Mandadapu
> > <quic_srivasam@quicinc.com> wrote:
> >> On 12/8/2021 11:58 AM, Andy Shevchenko wrote:

...

> >>>> +struct lpi_pingroup {
> >>>> +       const char *name;
> >>>> +       const unsigned int *pins;
> >>>> +       unsigned int npins;
> >>>> +       unsigned int pin;
> >>>> +       /* Bit offset in slew register for SoundWire pins only */
> >>>> +       int slew_offset;
> >>>> +       unsigned int *funcs;
> >>>> +       unsigned int nfuncs;
> >>>> +};
> >>> Are you going to convert this to use struct group_desc?
> > Any comments on this? It sounds like further improvements.
> Actually this also needs as separate patch. these patches will do as
> separate series.

Of course, that's why I put  the second sentence after the question in my reply.

-- 
With Best Regards,
Andy Shevchenko
