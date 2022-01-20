Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E54945B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 03:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358164AbiATCD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 21:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiATCD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 21:03:58 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E6C061574;
        Wed, 19 Jan 2022 18:03:57 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c9so3893736plg.11;
        Wed, 19 Jan 2022 18:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FKvsHgDw8lU7jb9gWUC0NOGdDixcuWetMqLuAq7PwQk=;
        b=o6VUFhVlB0pYLSWPb/UZeFqVVej8u+WF+PSwjJN9+5ssoieo8N4WeZrIh5VptUcPMP
         Yy2xN+SiwfsNLWiqKcdWGZU2uPMigFiLbo4rNpg3xEt+GRlNsN0IcQC8qDqKeEpHdg8f
         ehV3GX9s86sZd8SEXW5Fg9pypmrrxHZfKERT8Wr9LW+RHJCje/gSrZex6uQSVCPPHFOU
         mgv32i8qekMw7qZSqRF1dEZVxBqfQu5vcoCsUVck04uS8iFtDzpR10WyfV3BxUNeWs6a
         EMkkO3AMIqiZuH3aHLSMm4KRtr1R2sC2SDkvDOhBJlabYH4hWZp2Fy9e88qi13XGH00N
         bgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FKvsHgDw8lU7jb9gWUC0NOGdDixcuWetMqLuAq7PwQk=;
        b=DhP8QtLVZM6yztHNe+u/b9Hkf2aCLWAVM0K5R5jYIJquy/SKgFumc/uJdKHG2z6OUR
         5taGV9wmYwHZ992H6JhsCx1kdaJN0c6XC5Xr5a6CMCPdaSuuXyL36Yd4ZvxXyXJvCWa2
         xBFgRCIJ2tgoWm4BulxOMUHKLuiZOgkZus+8cyDCMXgwajFlswiD84lb1/g9RoxCU9Bg
         vWVOkxMI4Idf7tf7FTa9NnJL4GYHWnrc8sXO04A83mI2eqWVsEBKS4urItDptkZXITLI
         qnXagLx5Wj4gnrMFPYhIUhC5baCSmuzpQsOD0J+sBanNTDrx3fQuIDqutDUjZB2x9FX3
         KsgA==
X-Gm-Message-State: AOAM532MMzRQF+QgBHXfjHo3rYKP6CnGR0lRPvbG59FY7e/QcMmYKhF4
        go1mbRozKaQAchrDrI6cA4CQ3KE5pdLJcSnbTJg=
X-Google-Smtp-Source: ABdhPJxBYyolCvoIAI4tRvAxPacUY//mEyQ2pvpMHa4c+K+6l58b4cCzU4JXW1oxXz/ozcRHDj0xk9dvkouvzalSHl4=
X-Received: by 2002:a17:903:24d:b0:14a:677d:843a with SMTP id
 j13-20020a170903024d00b0014a677d843amr36538680plh.129.1642644237330; Wed, 19
 Jan 2022 18:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20220118002214.18271-1-dipenp@nvidia.com> <20220118002214.18271-2-dipenp@nvidia.com>
In-Reply-To: <20220118002214.18271-2-dipenp@nvidia.com>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Thu, 20 Jan 2022 10:03:48 +0800
Message-ID: <CAMU9jJoFAG4taoN0SSbVGPFMKyUnkT9VkrtatGuRpU-ek+hJ2g@mail.gmail.com>
Subject: Re: [RFC v4 01/11] Documentation: Add HTE subsystem guide
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     smangipudi@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        warthog618@gmail.com, devicetree@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dipen Patel <dipenp@nvidia.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=8C 11:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Adding hte document which can help understand various APIs implemented
> in HTE framework for the HTE producers and the consumers.
>
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
> Changes in v2:
> - Removed explanation, instead added kernel-doc references.
>
> Changes in v3:
> - Addressed grammatical errors.
>
> Changes in v4:
> - Added new API hte_req_ts_by_linedata_ns description.
> - Removed hte_req_ts_by_hte_name.
>
>  Documentation/hte/hte.rst | 83 +++++++++++++++++++++++++++++++++++++++
Hi Dipen

A document build warning will be introduced=EF=BC=8CNeed to add it to the i=
ndex:

1) Create Documentation/hte/index.rst
2) Add hte/index.rst into Documentation/index.rst
3) Add hte.rst into Documentation/hte/index.rst

Thanks,
Yanteng
