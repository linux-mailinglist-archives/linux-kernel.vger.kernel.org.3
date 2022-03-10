Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505E14D54D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbiCJWuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiCJWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:50:15 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B42CA328
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:49:13 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id i5so7567469oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=t+I0qZwnh/1mtoTMKusuRdpi9FIYw05453lUFv86xBw=;
        b=ObLOOlbk+7vQcmdDH+fbFFtMlvP8PZziEyXMiDrlItkhLE6UOcYb/aDodXzkD+rUni
         NyrIxFcMT3p3r5kpPw5Hpq25f10/FTeen1oiMVPeGAQNEFHUKbfenYQyzdG/ukiURIin
         v1c4yroN0n7fXvOZYwsyBVdn8bXUih4/LaWf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=t+I0qZwnh/1mtoTMKusuRdpi9FIYw05453lUFv86xBw=;
        b=wDgVQEBCHL5tQwbwloE8pCyXlO5L7tyURVO/980ztS8Ef4QwIXPLMjclsdhYed0Mj/
         Sa9TBAZzro/aEO0eBrQKMoSjiruJp07WLtXnukW/367p2ajZBwPDAKqhcPU+jIiCc5f0
         tHWrXCfsac7c0O3+UpDbLTMbLaBi0lAxiV2YgDFKVI3BnsOMIGLnVM8DehnIs1CZnhiu
         V7tEK7eXKwJ0X9Lx0r6gYEvqcu1c/XRKgjxwgel5lcKSGgv5uwsK/F1kOCEqKn4OHa7u
         F4yH2YqQcc/mU9LwA4hvgLAp9T1ip0HWZDvU4JxFp30ZA/EeC4wjXiJfhNtZLtexHimN
         WK1g==
X-Gm-Message-State: AOAM533DZe/Xz9ZAGbUHhYZGBxkUI04UL7V2UdnWWxUtOY5NqvLrd00C
        w8gc4ZzourFDDTiSI2ULISto79eFDyebD5VExj0E9g==
X-Google-Smtp-Source: ABdhPJz8cpl0bmZv1sgEBHnzOQcNoOyYatjBQuzpvoQ5gSCJfJo0K9kmFneUkDZCjTSuYH0iWY6iHNzx7+9sPMgWZFA=
X-Received: by 2002:a05:6808:220d:b0:2d4:99cb:3849 with SMTP id
 bd13-20020a056808220d00b002d499cb3849mr4739228oib.63.1646952552659; Thu, 10
 Mar 2022 14:49:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Mar 2022 17:49:12 -0500
MIME-Version: 1.0
In-Reply-To: <20220308125044.1.I3e4a1a9c102d194698b68661e69efebafec8af1c@changeid>
References: <20220308125044.1.I3e4a1a9c102d194698b68661e69efebafec8af1c@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 10 Mar 2022 17:49:12 -0500
Message-ID: <CAE-0n52x8SVUJvaUJOo-D9ayWAOwLuZ0TAK-MRwMe6gTSE=shg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Delete herobrine-r0
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Quoting Douglas Anderson (2022-03-08 12:52:35)
> As talked about in commit 61a6262f95e0 ("arm64: dts: qcom: sc7280:
> Move herobrine-r0 to its own dts"), herobrine evolved pretty
> significantly after -r0 and newer revisions are pretty
> different. Nobody needs the old boards to keep working, so let's
> delete to avoid the maintenance burden.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
