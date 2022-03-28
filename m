Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D74E97ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243104AbiC1NXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243100AbiC1NW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:22:59 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CC05D5EE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:21:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so11001939pgn.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5c3917MAZUYc8aYNOkJjQUYFUTHwIYAfPcFsBEaVqNw=;
        b=r39mJhBONAyJ7iXYcHhktyYbkv/FPoZd74/kg4pgnTyGP1heoE7mTSS62HxWYxqLm4
         PuXMXRdxhhUPQgQDEKXSTDKbCERIm4ZxXgMFSGHxPwq7rEmRd9kjNCbu4ZDixvhilV6w
         v7W70+Mv6ParbmAjsbbGsb/VYLI5oIHC3oCg2tQ6awPFhRo5EDLR5YqsOm9KVXQzwjBa
         eoC/H/OtOefp9xkaXUJ81Hjr+2imn9dVDM5MEf0XlnRX/GUs6ZJOroYAWgl09x6vwwmY
         rSRL7wd4/o3bYrmaSkTnqSR6MV/SQGq88Hrx+DT1s/9/8Ge1VJ8k8golO2cYUQMzpRGC
         NVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5c3917MAZUYc8aYNOkJjQUYFUTHwIYAfPcFsBEaVqNw=;
        b=s9GDGJlAQnHhZktigFtTfRRDlP55wpisI1uQdHTucJQDBFEDRMEKjOtnjXTxevlEHO
         boO+oy9nQ7h9HiBSnXD/GwWWhXDfrAJzKuUpmyFsf/bpg4g+wegG9hWxzwgfrql/WWTv
         mLoRktgbOYcMHNR4h8UZEesHFCYhZnPvYTGwgs6U+6spkiwySVGV1pNRemNZrxdXlmNn
         fJ3D9cuzjNHWCF3Xvh8EtzLv2n+ajxnMO889EGC3LxFoU1XqFd6pEAiE7wFem2wuljYS
         HnvlpJkbFThL8blZaEbjvMw8lJ93eG2hxqBV6aJVvEIDI3zpPNn22ofBhure0RcSLIAI
         CrDg==
X-Gm-Message-State: AOAM533MH8mBpOEgiR1oTMT1icoifPSxERZFs/ZrpZLBM64qc4ri4Suc
        L6F+wgItG776HZ67V07MReisibRqB1cjFfVm6P3LQg==
X-Google-Smtp-Source: ABdhPJyfHIEgcq0z1XfEkx7RvUBOUzGmsXb6PCpzATZyq9pUeZ2izW3H71PqV4LgpviFa/P7cR8EnzqtvU9/vZhAiCg=
X-Received: by 2002:a05:6a00:1741:b0:4fa:f5bc:30bd with SMTP id
 j1-20020a056a00174100b004faf5bc30bdmr20188685pfc.0.1648473678172; Mon, 28 Mar
 2022 06:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220322080213.1487134-1-xji@analogixsemi.com>
 <CAJMQK-j+PhB6dZBuKG3NtW94oT0bVkp9G1bXhmyZLgYOmTCgog@mail.gmail.com>
 <20220322085208.GA1487511@anxtwsw-Precision-3640-Tower> <CAGXv+5Gddu8VU7xjX-r2=u85i7Ut=_6JpQV6py52OyzEkpezTg@mail.gmail.com>
 <20220322101342.GA1493353@anxtwsw-Precision-3640-Tower> <CAG3jFytYcLP_1JJzoTU8YcwXp8==EpPdad5z02ROu8HtuaqfzQ@mail.gmail.com>
 <20220325062912.GA1527766@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220325062912.GA1527766@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 28 Mar 2022 15:21:06 +0200
Message-ID: <CAG3jFysrg6opHQpqdy9aDSQWFkwyGfZYG9PStTaApkS=euk1Ag@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Set downstream sink into normal status
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>, qwen@analogixsemi.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        treapking@chromium.org, pihsun@chromium.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>, tzungbi@google.com,
        bliang@analogixsemi.com
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

On Fri, 25 Mar 2022 at 07:29, Xin Ji <xji@analogixsemi.com> wrote:
>
> On Thu, Mar 24, 2022 at 01:07:56PM +0100, Robert Foss wrote:
> > > > > > The driver uses DRM_DEV_* for logs. Can we use this?
> > > > > Hi Hsin-Yi, as comment in drm/drm_print.h:
> > > > > "NOTE: this is deprecated in favor of drm_dbg". DRM bridge driver not
> > > > > use DRM_DEV_* any more. I'll send a patch to replace all of DRM_DEV_*
> > > > > later.
> > > >
> > > > drm_dbg is better than dev_dbg though. With the former, you still get the
> > > > option to control it with the drm.debug module parameter, unlike the latter
> > > > which normally gets compiled out.
> > > >
> > > > Please use drm_dbg*.
> > > >
> > > > ChenYu
> > >
> > > Hi ChenYu, the parameter of drm_dbg is "drm", if use drm_dbg, it will
> > > change more code, I'll consider to upstream new patch to replace all of
> > > them later.
> > >
> >
> > Alright, since the driver already uses these logging functions, let's
> > apply this patch and fix the logging function this driver uses in a
> > separate series.
> >
> > Xin: Can you submit a patch/series that converts this driver to use
> > drm_dbg* functions instead?
> Hi Robert Foss, OK, I'll submit patch after this patch get merged.
> Thanks,

Applied to drm-misc-next.

Rob.
