Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69A455E483
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbiF1N3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345807AbiF1N2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:28:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF779FCF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:27:52 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id k20so9584438qkj.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aMNqmnMIKi7I+oM6Vp8+9eJ8fBtT2TW4TZeFgJi3fQ=;
        b=ic/oVE++fn5k1NV7kQALi6XGEpYofohGQkFZG9DwgUaJuJfylrH3XxlNM0cQoCbBIM
         DJuuAsQ5Gk/2EnAlJY0qf7tzNZbUlrKFJvDBUU9Ag9q6KPMK7EkBTYsak4Bs76iy+AGB
         e66nvxfFyt+p79zKrFPOZfTlYpbAn980ykkGl0wvQnuqLdbPXagmadFuojAFaZJaPeaP
         7yEMArdWzAixYfuCI9fh5RrBzmngWSZSi5SsRevJUbw9BopMWgqDXDfuoLY7OA7JRg4H
         PUa2/HyC9B1TSFeX1zUowg0zCkBFMh4m+mqi4ZT/B3ddtGlbcAZWgGkFIuvsOCdZjw5R
         8p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aMNqmnMIKi7I+oM6Vp8+9eJ8fBtT2TW4TZeFgJi3fQ=;
        b=a4ULLqrz9cxTaMhqsrnxdwJLyGmQDUZ5voAdVotHuh/JpclgysKza8n6A/+E/xhdgh
         qQ7xFjYHb5vidGVJCiwJUdH82a6DjJZ31x7pCnvVPUW8YEgQWTgYdQBrse9nPSS3Guxa
         kegblJPIOmBeB4perGWypOSvRKYiDPGImcBxjFGgs24Z69DOr3OU5bgyGWBYogyyP8OA
         E6u8peJ3/rtq8g9ogFcWRGB2erDLWHWNMQQA+m0lxmQC1ivCsKsCt4f9YThP2W46huC8
         lR5vseM7Pvw05GevBvMwkih/QrCa+BKOR20LhW1tWNk6IqEgdGQNXapqlHeopPUua0RI
         k/2w==
X-Gm-Message-State: AJIora9koiUOSMYqgDBKunTsJUcoZgdMBQOpZJzwZDvjhjile7mm1/uP
        ho1LJFF6evSmFbY6ocyhRGpO21htUt+otGZ2FW//Qw==
X-Google-Smtp-Source: AGRyM1uFzx5XNDSGUv3VsL7v2OiaMA2icVF5JOU4zDf8SI+B/+wfHtiB9FSjEjdS1E/Sbs+16KnN2332vmlti9fKlRo=
X-Received: by 2002:a05:620a:2a0e:b0:6a7:8346:1601 with SMTP id
 o14-20020a05620a2a0e00b006a783461601mr11247731qkp.593.1656422871286; Tue, 28
 Jun 2022 06:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220501202025.211567-1-konrad.dybcio@somainline.org>
 <20220501202025.211567-2-konrad.dybcio@somainline.org> <CAA8EJpqM5i88UKSrQyG1pMM6NQb8naTri-jNt++q7oKB-zdGAg@mail.gmail.com>
 <e57300bb-163b-2963-e55e-a5d0b0678f4f@somainline.org>
In-Reply-To: <e57300bb-163b-2963-e55e-a5d0b0678f4f@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 28 Jun 2022 16:27:40 +0300
Message-ID: <CAA8EJppvye=3-Wp09Wk0eO5tJ=pvu2kdM7ipz+HMOow0Qs69RA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal: qcom: tsens-v1: Add support for MSM8992/4 TSENS
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 at 16:19, Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
>
> On 27.06.2022 17:15, Dmitry Baryshkov wrote:
> > On Sun, 1 May 2022 at 23:21, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
> >>
> >> MSM8994, despite being heavily based on MSM8974, uses the
> >> 1.2 version of TSENS. Also, 8994 being 8994, it has a custom
> >> way of calculating the slope.
> >>
> >> MSM8992 in turn is a cut-down version of MSM8994 and uses
> >> the same TSENS hardware, albeit with a different set of sensors.
> >>
> >> Also tested on 8976 (by a person who didn't want to be named)
> >> to make sure the 11->16 max_sensors changes didn't break anything.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> >> ---
> >> Changes since v2:
> >>
> >> - don't use slope before it's initialized (whoops!)
> >> - don't re-assign the same value to p[0..15]
> >> - free calib_rsel
> >> - use the same ops for 8992 and 8994
> >>
> >>  drivers/thermal/qcom/tsens-v1.c | 293 ++++++++++++++++++++++++++++++--
> >>  drivers/thermal/qcom/tsens.c    |   6 +
> >>  drivers/thermal/qcom/tsens.h    |   2 +-
> >>  3 files changed, 288 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> >> index 573e261ccca7..58864962f370 100644
> >> --- a/drivers/thermal/qcom/tsens-v1.c
> >> +++ b/drivers/thermal/qcom/tsens-v1.c
> >> @@ -142,6 +142,99 @@
> >>  #define CAL_SEL_MASK   7
> >>  #define CAL_SEL_SHIFT  0
> >>
> >> +/* eeprom layout data for 8994 */
> >> +#define MSM8994_BASE0_MASK     0x3ff
> >> +#define MSM8994_BASE1_MASK     0xffc00
> >> +#define MSM8994_BASE0_SHIFT    0
> >> +#define MSM8994_BASE1_SHIFT    10
> >
> > Generally I feel that all the _MASK values can be better generated
> > using the GENMASK and newly defined _SHIFT value.
> Yes, I agree, however I think it'd be better to do it for
> all the defines in this file at once in a separate commit.

Then I'd suggest fixing the file first and adding 8992/4 on top of that.

>
> Konrad
> >
> >> +
> >> +#define MSM8994_S0_MASK        0xf00000
> >> +#define MSM8994_S1_MASK        0xf000000
> >> +#define MSM8994_S2_MASK        0xf0000000
> >> +#define MSM8994_S3_MASK        0xf
> >> +#define MSM8994_S4_MASK        0xf0
> >> +#define MSM8994_S5_MASK        0xf00
> >> +#define MSM8994_S6_MASK        0xf000
> >> +#define MSM8994_S7_MASK        0xf0000
> >> +#define MSM8994_S8_MASK        0xf00000
> >> +#define MSM8994_S9_MASK        0xf000000
> >> +#define MSM8994_S10_MASK       0xf0000000
> >> +#define MSM8994_S11_MASK       0xf
> >> +#define MSM8994_S12_MASK       0xf0
> >> +#define MSM8994_S13_MASK       0xf00
> >> +#define MSM8994_S14_MASK       0xf000
> >> +#define MSM8994_S15_MASK       0xf0000
> >> +
> >> +#define MSM8994_S0_SHIFT       20
> >> +#define MSM8994_S1_SHIFT       24
> >> +#define MSM8994_S2_SHIFT       28
> >> +#define MSM8994_S3_SHIFT       0
> >> +#define MSM8994_S4_SHIFT       4
> >> +#define MSM8994_S5_SHIFT       8
> >> +#define MSM8994_S6_SHIFT       12
> >> +#define MSM8994_S7_SHIFT       16
> >> +#define MSM8994_S8_SHIFT       20
> >> +#define MSM8994_S9_SHIFT       24
> >> +#define MSM8994_S10_SHIFT      28
> >> +#define MSM8994_S11_SHIFT      0
> >> +#define MSM8994_S12_SHIFT      4
> >> +#define MSM8994_S13_SHIFT      8
> >> +#define MSM8994_S14_SHIFT      12
> >> +#define MSM8994_S15_SHIFT      16
> >
> > [skipped the rest]
> >



-- 
With best wishes
Dmitry
