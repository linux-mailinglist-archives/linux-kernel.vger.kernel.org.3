Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB755F8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiF2HWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiF2HWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:22:42 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C7833EA4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:22:41 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w193so20474920oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=TvfrSXu4f0TU8sJk8nHVngOGB75STSEGTvK6rVGCRBo=;
        b=KSYNVPp/M+aBIfHacFqj11Sm5k23Er/fz5hD79lvLg2qAdMiNwn7Ieu7YNV90mA70F
         daalhEZkwB6Apo4Ai71cvL4evznxFuW7QZ/jnNWgrXANheLoBxRLyN5sSUQiVHgCv9HR
         97v9IV3l+QYGVehGdIPIXHssVTk8Z6wn9878g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=TvfrSXu4f0TU8sJk8nHVngOGB75STSEGTvK6rVGCRBo=;
        b=t0wXehYAgsJE/H4NJuCc7Vd7uq2tFuEDuxHu7yqyKy3Izf0kZSZdXLDxoRqedpGCvJ
         6klohcrNP8L3H5RB+tNVGXh3gM3BwVvysf2gf4qCFXiWc8MvA/ws6hbOfkhtXZYznZrN
         Y2vE1qk0KKUty2w3Iln8xd1vubGMvIeT5hZm24cnXpSXE2cEJ6Cqw7Sppzwcb4JwCpig
         xnmSkoZRJhol3TNZoXDE/vSdnlIuszvUc8GPuQ4WscH/4oy+qU/tWZVY6GMhkOO7Ipmx
         BbgJbNVKGVR4fPLc3roWAM4UHNabVJvPQYtD399XmbX+eBj51crCOjP3lwpSWRXx3UJv
         RqSg==
X-Gm-Message-State: AJIora8tn6wpxnD5DcRz2b5qOuQlEMSktrMrAgr+UtT6Tc9bFEROAI66
        YL5h2myHzx1HKkxnVaG6Gd8GU4PiUdkH/SDTrbbztg==
X-Google-Smtp-Source: AGRyM1v4WSDbVO+K2+4kAKFrYZQtpAn74YXqFxA1mnEY/IT8bcyyhmbIZcF9WfGx+sYO6Yz4yLIx2Fc2KzL9daEEeyw=
X-Received: by 2002:a05:6808:171c:b0:334:9342:63ef with SMTP id
 bc28-20020a056808171c00b00334934263efmr1192888oib.63.1656487360982; Wed, 29
 Jun 2022 00:22:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jun 2022 02:22:40 -0500
MIME-Version: 1.0
In-Reply-To: <1656484485-23350-1-git-send-email-quic_srivasam@quicinc.com>
References: <1656484485-23350-1-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 29 Jun 2022 02:22:40 -0500
Message-ID: <CAE-0n50XpUfe9LQ0UByRXeWVcHjzXTmSb+Lf5m87pJmhjA0wVg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sc7280: Fix compile bug
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@quicinc.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-06-28 23:34:45)
> Fix the compilation error, caused by updtating constant variable.

s/updtating/updating/

> Hence remove redundant constant variable, which is no more useful
> as per new design.
>
> The issue is due to some unstaged changes. Fix it up.
>
> Fixes: 36fe26843d6d ("pinctrl: qcom: sc7280: Add clock optional check for ADSP bypass targets")
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
