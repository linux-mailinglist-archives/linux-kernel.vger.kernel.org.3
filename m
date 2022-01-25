Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE249AC69
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347689AbiAYG3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345667AbiAYG0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:26:41 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB66C08B4C9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 20:49:14 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a28so24255836lfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 20:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5Fu4TSCbARG2mLm13zGvdTuvUr0QZW1RLiG8C79TO4=;
        b=ALObGffeoHvxkSiwET8Xu/lyNFq4JRJID+mFveG6Bc3LlZS7pd3L1dMGJe4ZNRLSpH
         /pM8asQ76V2Iz+fdIUVR5NDb4SsLSmXBjCf+LHc54fNOBxXOzFIUFB/leJNVPFy6q2jC
         LJq3AErof5GERCLLq3x6fM4W221i1NIwaZsvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5Fu4TSCbARG2mLm13zGvdTuvUr0QZW1RLiG8C79TO4=;
        b=fsQPeYlCzBCYyOXl04tIBOS9+NJqHiQ2KhyfpxN0ByfsBApTdlqRLfwv6K8meAXI3v
         9CJDpAvcTsl3k6pHQ5+6yCu6B/IQQQve7NdPAszMhO5l9hyTzUYI/i33Ef5KMfCFujpV
         Gl4xnQgGRG+B/SK/nAqSKdYzjlzI3CewDMuHfoPo7Po4K3DlmqmAtnjq8I0nnpjkAFdj
         ht9ZtDla8OYtaTytXAy7TFBjaM4Ijl0JpvLBYdW3G7AiEbDZ61ZtGyX0i2QefxvWAohd
         elMbaElH8Qh00S2dOrVynm31zucotAvnWZC7Q4dIiid7pTYklG8eQNADuT1eomM5gBfa
         ALAw==
X-Gm-Message-State: AOAM530bCJaYnQe5X+sk5N7FvYQhPDjahc2c3bt+66PpJUEUNH00iaC0
        Nrhf8uWsaNiGsJVFHUTpwinJsxPByjg8U5POx+wQ5Q==
X-Google-Smtp-Source: ABdhPJw+fQ0ckcKc3qv7ppFk2Xk6/Um2Yoc2Zv9iQG2zxzejOFnaWR7Al/D6yLftIA4t1oRd32TQpjupUhg8yfOZ3rY=
X-Received: by 2002:a05:6512:1288:: with SMTP id u8mr524232lfs.443.1643086152391;
 Mon, 24 Jan 2022 20:49:12 -0800 (PST)
MIME-Version: 1.0
References: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org>
 <164036941060.3935440.13095761506560620701.b4-ty@linaro.org> <CAD=FV=Vdjw-6GytO=Rpt==OYbnrNon3pYQnrZtUT4vX11S6ykw@mail.gmail.com>
In-Reply-To: <CAD=FV=Vdjw-6GytO=Rpt==OYbnrNon3pYQnrZtUT4vX11S6ykw@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 24 Jan 2022 20:49:01 -0800
Message-ID: <CABmPvSGOLRKX20WO21P_qvtvDo812QGDr4nYOWE04pjoSGDGcw@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280
 IDP boards
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>, rjliao@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        saluvala@codeaurora.org, LKML <linux-kernel@vger.kernel.org>,
        hbandi@codeaurora.org, BlueZ <linux-bluetooth@vger.kernel.org>,
        hemantg@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following up on this patch, this patch didn't seem to land anywhere,
what is the plan to land this?

Thanks,
Miao

On Thu, Jan 13, 2022 at 3:59 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Dec 24, 2021 at 10:10 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Wed, 15 Dec 2021 22:36:03 +0530, Balakrishna Godavarthi wrote:
> > > Add bluetooth SoC WCN6750 node for SC7280 IDP boards.
> > >
> > >
> >
> > Applied, thanks!
> >
> > [1/1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 IDP boards
> >       commit: 3a89ff3087c03c2295250c07234efa75873c7b51
>
> Just to confirm, this later got dropped, right? I don't see it in the
> Qualcomm git tree, so presumably it'll land once the merge window
> closes.
>
> -Doug
