Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800F04BC4EC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 03:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiBSChS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 21:37:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbiBSChQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 21:37:16 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796854BE8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:36:58 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id e19-20020a4ab993000000b0031a98fe3a9dso5846857oop.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=k7MibnFlGnXWaoyuZc5fFX+hxS1DyD57HaegQF8+k5M=;
        b=Bk7rZo63WFjFUSnO4tKCyrWj6rYnFOp7yPp/BHupJggG8IRXcqYgB8LVXZ8YwNQ97K
         e9KEHfdxp2/cJNO42Ry1qQGnp6/duq13w3fLU8f4Z/54K4iIJGyyYEiCCrjSEXaWnKrl
         uGIqwTLNcA0+cr+eIUof3oq363RdQrMaapM6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=k7MibnFlGnXWaoyuZc5fFX+hxS1DyD57HaegQF8+k5M=;
        b=GCgr9OslO8mkkU4PXJddtDhyuTKsLBIRBjmZzt3/RnjdVv5qxgFYszIOUotIwTbyMd
         WtRVfAowKy0trGP/E3Hi7g1YQCPUYdJYgLITldX3bZM4Isrw8eizDHheHYdRc/P39nwm
         1a5Exvg7yPXF40bLdnh2Cj+djfBUdsQRLS4OCMBmpGsnr/2WINVY7fjBQbgBVbAjpYOD
         kpr4lHWJ1rkXw52sMoABT9p1xHXAmUYIs7arBZhPat6ADsFUcRO/qpEReFUOeaiZwxJ6
         c+axZLLTtZ3qNXo7n/qjy7T2tRYaCskVUN+8wLxqvnkYPb1DleO4bO3Xo2kC/fftlIp0
         laAA==
X-Gm-Message-State: AOAM53133IvTVeekRvJtuzhxFAE8a9IHtRMwtO/5fZHyxzvg6qhSMSzA
        RsKNfHzMoQ7258/2b3m7c9g078ZoJKhdnm1SUKkgCA==
X-Google-Smtp-Source: ABdhPJzqlbIZ9/jzgYSBbZJnFgkexJgnaPi6xmRk2KUZIo43z8DVRDJDT73d9tERc88r8QLDQD6Sgey3RUqQPzCI1OU=
X-Received: by 2002:a05:6870:5829:b0:c8:9f42:f919 with SMTP id
 r41-20020a056870582900b000c89f42f919mr4185776oap.54.1645238218057; Fri, 18
 Feb 2022 18:36:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Feb 2022 18:36:57 -0800
MIME-Version: 1.0
In-Reply-To: <1644851994-22732-4-git-send-email-quic_srivasam@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com> <1644851994-22732-4-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Feb 2022 18:36:57 -0800
Message-ID: <CAE-0n527fs5rfPG1HonW_9ZTugANnWNYSs_0+wts+zDK=zcZjA@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] pinctrl: qcom: Update macro name to LPI specific
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, robh+dt@kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, tiwai@suse.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-14 07:19:50)
> Update NO_SLEW macro to LPI_NO_SLEW macro as this driver lpi specific.

Is this to avoid NO_SLEW somewhere else?

>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
