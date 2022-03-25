Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791CF4E7CAF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiCYTnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiCYTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:43:21 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6E915B873
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:13:46 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 12so9164838oix.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lxCDnuzvI/dDOwtYF1oqphLQYyj16qlSkfozPWjfyEs=;
        b=IVtFFTm3opL1SvfintDvcx2agZk19yMVZYzgsJj2Nw6d+IpllQ8w6KPYzYe6/OSGwG
         XTUV6+5obZzj5GrVSCLM0sAj+SfjXi6QXi+osfdiMa4s2tW2hO4Icf0QndreQK/6ftuR
         HonuN+aKjB2KlBq6n60YrIZdOO82yXB0iWFwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lxCDnuzvI/dDOwtYF1oqphLQYyj16qlSkfozPWjfyEs=;
        b=fwW17b5m/6xtoDp+bM5f7wuSh2IaLbK06Jg9gvxelkA1mSriG6dkt+NgRNm9YSZ7Nd
         LfT+qwhFEfwXrWvogZU0/sRAq6Vo9lhko9nxbsGN/T7Cpe7dCTr/ptXiIClLuNrnajEA
         /DcG7UUtVy3Cpeznl64bo8EJlBCo4CzO/398j2MDQg+grc8I3HvUIQKiiC417s8DuW/F
         mgq0yoNA2b0vqjto/OVPYS+5/AaIhtD8y6Ni86nspUV9Z6zy7R3EQa/9hBDjOKWxzL8H
         nqEgWoxDgrO7pzm33ZjVy3N/8c+Q4QcDhq0jUIgIUiT5meBTnwc7ZgQ1CmTM5rYmm1PG
         joEQ==
X-Gm-Message-State: AOAM532gDgdeQVgG+qd0Bd4YqkhCvqDnz0xQhpzugKvr7tjERCmc2rdT
        Cx6KGl6MvznOJnTxxZb3X4AIeyxM5WOLpL5U9qQ9R8ZndZ4=
X-Google-Smtp-Source: ABdhPJz8JscmF7Q6aPXFTxS1Lm1vUzWWkKJ+skiG2uD+xzMzId2eANsm+pO6DweUUkxpGaGwXRpkrXq18QFkNFmegPc=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr5627914oie.193.1648231743322; Fri, 25
 Mar 2022 11:09:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 13:09:02 -0500
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WhhVBys4k7nZJ-SHB4y2Jf7JL9eeGUdBTqYG+c3m8-kA@mail.gmail.com>
References: <20220325081100.1.I9f06fec63b978699fe62591fec9e5ac31bb3a69d@changeid>
 <CAE-0n50hUGbH7_khhbsg3fbX_MCK0gEoStk-3xoUzje_a1=KQQ@mail.gmail.com> <CAD=FV=WhhVBys4k7nZJ-SHB4y2Jf7JL9eeGUdBTqYG+c3m8-kA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 13:09:02 -0500
Message-ID: <CAE-0n52x6Hsb-jktp1asQROsQo5Cnz+jsBGRru-pNhSnj7ipTg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-herobrine: Audio codec wants
 1.8V, not 1.62V
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-03-25 08:47:24)
>
> Yeah, I guess it sorta felt like it was a sub-part of the previous
> section since it was also adjusting Qcard regulators, but you're right
> that it's not actually a board-local name. What about if I change the
> section heading for "BOARD-LOCAL NAMES FOR REGULATORS THAT CONNECT TO
> QCARD" to:
>
> /*
>  * ADJUSTMENTS TO QCARD REGULATORS
>  *
>  * Mostly this is just board-local names for regulators that come from
>  * Qcard, but this also has some minor regulator overrides.
>  *
>  * Names are only listed here if regulators go somewhere other than a
>  * testpoint.
>  */
>
> I'll wait a few days and then send a v2 if that sounds OK.

Sounds good to me.
