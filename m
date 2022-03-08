Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49214D23D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243250AbiCHWD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349443AbiCHWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:02:57 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0757160
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:02:00 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id x193so805016oix.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 14:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=H7bJFP/SMFW15p3pLkm+L7vfC59HK/LKRG6ORsvtMls=;
        b=i42+2Vc8KgRNR5vQOWKZQ8tq5xqvdZCWTi3cf710Q3s6ESxTVSUd3AKl1L77hB3slu
         heJQVnz6Bq7oJpDDVzgV1E3IMlLVppConv7H3E4ugb5PYClNiUuTFkD32ZUcHv3UBAGw
         uvl+qAE4GWMcPYCxEeU2WYWBJ5BuQf/TcluSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=H7bJFP/SMFW15p3pLkm+L7vfC59HK/LKRG6ORsvtMls=;
        b=jhCRQU5YiWIFrbUkHR+0XNZl/MLiVmznw/xUCzU/SVLiNr3CXyW09F8Dh69Azbq8IJ
         oL2o1dHBkw7YP/S7J83xNnhWQpDPFBCidEQoGNrTTzF9pNVNy7xAf90Agm0Zg4+zxVdp
         0YlKTKuaDap/njDIDFqCUCwUjJ7xgzG+047NkyPUMRP9nv2FVSR8D/RkJEh62roKDk/e
         8PY2BZTi6aMrhOdrjG0gUKrDpEjb4HzEwE4dBl05tW7xdboOZJXgW02g0bwEa/c1/9g5
         2ndfzv+jSZqLtk57YgZ/X5S3h8etrkoUlCR5YLJZagfZOs2NZ0gstjOS1ktk9UhbtGmj
         g1hA==
X-Gm-Message-State: AOAM530BYqU2kqUKGkfcQDma0o9iNoor4VIqNpipi+ypc7bMgvKWl87J
        M/KShh9T2wp6qKZcFxpv906/Rsie9HuyNaNzxNcxbg==
X-Google-Smtp-Source: ABdhPJzV5rZOO86yLbriX4+ATjnhaQh8o6iRmze3RyGwf6WbMtRYo4wlAN0seA1257wNimyu0mhdx+fx6AdOlUF8ZzY=
X-Received: by 2002:a05:6808:220d:b0:2d4:99cb:3849 with SMTP id
 bd13-20020a056808220d00b002d499cb3849mr4090715oib.63.1646776919910; Tue, 08
 Mar 2022 14:01:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Mar 2022 14:01:59 -0800
MIME-Version: 1.0
In-Reply-To: <1646316128-21082-3-git-send-email-quic_srivasam@quicinc.com>
References: <1646316128-21082-1-git-send-email-quic_srivasam@quicinc.com> <1646316128-21082-3-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 8 Mar 2022 14:01:59 -0800
Message-ID: <CAE-0n50tqb6+aNNRAVjHjkExZDYqbnJ+3zDnSOMgndxMVXZXzQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] dt-bindings: soundwire: qcom: Add bindings for
 audio clock reset control property
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        quic_plai@quicinc.com, robh+dt@kernel.org, rohitkr@codeaurora.org,
        sanyog.r.kale@intel.com, srinivas.kandagatla@linaro.org,
        tiwai@suse.com, vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-03-03 06:02:08)
> Update description for audio clock reset control property, which is required
> for latest chipsets, to allow rx, tx and wsa bus clock enabling in software
>  control mode by configuring dynamic clock gating control registers.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
