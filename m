Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D845F496967
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 03:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiAVCWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 21:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiAVCWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 21:22:19 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB19C06173B;
        Fri, 21 Jan 2022 18:22:19 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c6so32739153ybk.3;
        Fri, 21 Jan 2022 18:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0WFsl464O1plaAdb1DqUc2FVm3sL9ZIJC+WKaUWfUbY=;
        b=GDj/J3wvMb7a7yQnhMjuXVC+fNwBgi7tTQcyVGHVuY6nxhGeKrskBjuEelpg1nrpGp
         +TkzOpNNWRPqKMrFwiX71+kqmI/TTNo7MN6Q5u0YI8fgvJalTUKkRnsNqREEujjszKOd
         iXTWa66eagtiGSbe1V+MTtLEJpg8uU5oBHP5kq2OvwuQsAzrBVJAuFiEnx+hG/wLKu8R
         egaMLbWAVq8POsKHE/bR8PEqI/0ryKBjztSeoeOOwNS9SOtyIzfxlsbSGAODzCaH+Skj
         USYPyfOtRAgBBeqRPa9Px1TlqpkPLGEFJQ5LMzFg0gpaIPEahSOBPoqN+NP91yWwJLEv
         PU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0WFsl464O1plaAdb1DqUc2FVm3sL9ZIJC+WKaUWfUbY=;
        b=QlIrb1rYog1DvKwXOwMygYmZhWvD+gc9wJ/ol/NqL19BK8zvvqsDk+48JoHQkgs2Jq
         rapzU6n+A3YONNYyZkK5o40DEg4VQtdRS0iFxKCTYtoAcRfHVESo8rj06sEKSsjuiEWw
         oCtEsAtB+HhPYuCGfS+gWKemIHMdU0lsHFXvyPqwvqFHdndnfvKW3Hd5NTrv10m+hNG1
         MufokmiJgQ9s8B+8IulI4/JY9gQBw2y8kOmkg8DlbLpasD0UFonln5lLae1IXJ8opnP+
         z7Q2hOv5Wk/hW9HdFUhCsCa8P5G6kFcULifb37ezKqHzU+fv7U+2p/keEpHVqGo1YsZ7
         /Jbw==
X-Gm-Message-State: AOAM530nA8ZS8COTecacOuP8IIDeutHwrM5SFi4VOL5RkqUaoGND/l7w
        dfDs5Yf1CBvNzpreAxnnbRwiIDlYQ7mYxypR3XzTorsSidU=
X-Google-Smtp-Source: ABdhPJwYwPQ+DUeWkFo38oGf0XBHqn1JkHM8zwXVbMjt7Yr8cw+7ws6W+uTuj1bLmgjPZIJZgKAiPk6GzvFVpJIPc+U=
X-Received: by 2002:a25:6f0a:: with SMTP id k10mr10232548ybc.536.1642818138850;
 Fri, 21 Jan 2022 18:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20220118002214.18271-1-dipenp@nvidia.com> <20220118002214.18271-2-dipenp@nvidia.com>
 <CAMU9jJoFAG4taoN0SSbVGPFMKyUnkT9VkrtatGuRpU-ek+hJ2g@mail.gmail.com> <7c8a32fd-8233-cc69-d4d3-668a3a14aa14@nvidia.com>
In-Reply-To: <7c8a32fd-8233-cc69-d4d3-668a3a14aa14@nvidia.com>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Sat, 22 Jan 2022 10:22:07 +0800
Message-ID: <CAMU9jJrBOdV79Ho34bgT808gTPoTrGHA_mZLQbbzNigmg0myGw@mail.gmail.com>
Subject: Re: [RFC v4 01/11] Documentation: Add HTE subsystem guide
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     smangipudi@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, LKML <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, warthog618@gmail.com,
        devicetree@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dipen Patel <dipenp@nvidia.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8820=E6=97=A5=
=E5=91=A8=E5=9B=9B 12:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Teng,
>
>  I believe I added in patch 0003. Before sending this patch series, I did=
 make htmldocs and did compile successfully. Let me know in case I am missi=
ng something.
Sorry I didn't read through your patch carefully.

 I'll be happy to translate fresh documentation into Chinese, please
let me know if these are applied, Thank you!   >_<

Thanks,
Yanteng
>
> On 1/19/22 6:03 PM, teng sterling wrote:
> > Dipen Patel <dipenp@nvidia.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=8C 11:06=E5=86=99=E9=81=93=EF=BC=9A
> >> Adding hte document which can help understand various APIs implemented
> >> in HTE framework for the HTE producers and the consumers.
> >>
> >> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> >> ---
> >> Changes in v2:
> >> - Removed explanation, instead added kernel-doc references.
> >>
> >> Changes in v3:
> >> - Addressed grammatical errors.
> >>
> >> Changes in v4:
> >> - Added new API hte_req_ts_by_linedata_ns description.
> >> - Removed hte_req_ts_by_hte_name.
> >>
> >>  Documentation/hte/hte.rst | 83 ++++++++++++++++++++++++++++++++++++++=
+
> > Hi Dipen
> >
> > A document build warning will be introduced=EF=BC=8CNeed to add it to t=
he index:
> >
> > 1) Create Documentation/hte/index.rst
> > 2) Add hte/index.rst into Documentation/index.rst
> > 3) Add hte.rst into Documentation/hte/index.rst
> >
> > Thanks,
> > Yanteng
