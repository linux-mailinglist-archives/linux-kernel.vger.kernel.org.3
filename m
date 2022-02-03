Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD04A8FE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiBCV27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344822AbiBCV25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:28:57 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D76FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:28:57 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id e21-20020a9d0195000000b005a3cd7c1e09so3687407ote.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=AVufOZ/yIUBTbxUpH00x2bwAXYzopgYq3RQrFXSpyyo=;
        b=WKmiPKm35iKFc0i9l1wYMp+2LUQ+5k9Luqw9i/aRkDYzDaO7xEP/zC3JIsBC7OBo9g
         +SsFYDBWCMtTP7DlRS/QHgeX/CdIGH+mcmUxLTMyROixfFDSAyaZH6YqyvT7aPIfzNtA
         IBhjuqw1pJatyrI72Ub00QJPKpZwKt75ndaak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=AVufOZ/yIUBTbxUpH00x2bwAXYzopgYq3RQrFXSpyyo=;
        b=LcuwbZmREh25K91ak8yiIiu56ybu0XNGdP5e8bXrr7h8+xeWEsrfcR9YhP66enicRY
         sECeNAk5+ljrVwqTwKJQHO0POIH2W51FYkBquQcS5lRLrlxXMXIdAYS2So//zC0euNhx
         fC14zJyi0ruj0fM6pWuFwfUvAl3sdcRwPkAAovUrkwzEWZPOmhTH+YHlE7epFk2YuUEB
         Qp0LfmJdeIfvZPbyynnC6CZXFSRMHOPrS/iNFE/jFxcLAHy8uZpZbnh/TRJ0GC3Vx6W1
         K8b72ZkLcxCVZ4BbBw2t3nZpJUkyeYCRy/9jcg4VJdYU7wU8I5pP46pMs4oFp3KrKIeB
         YVNA==
X-Gm-Message-State: AOAM531mnQJOQ/cKeNGJ3QItIPU2mfYOofmZLUCvnXI/AwEkRHuK+7Ef
        NGyYgaTPvKIBYT3yLs/HP+xSg0AeeSTZreVpX5ckhg==
X-Google-Smtp-Source: ABdhPJw3dtUZBKr9Zcf/k586jLxFXbrM94d97rCy9OFHl5fdHvZ1r73pHH5pttGLZdgDMFuw4AVW90cM7/TJr0+KlXs=
X-Received: by 2002:a05:6830:1d8f:: with SMTP id y15mr26531oti.77.1643923736920;
 Thu, 03 Feb 2022 13:28:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:28:56 +0000
MIME-Version: 1.0
In-Reply-To: <20220202132301.v3.6.I874c6f2a62b7922a33e10d390a8983219a76250b@changeid>
References: <20220202212348.1391534-1-dianders@chromium.org> <20220202132301.v3.6.I874c6f2a62b7922a33e10d390a8983219a76250b@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:28:56 +0000
Message-ID: <CAE-0n500O_zah4mg=aKrGZB+NoNN4-UqmjiR+qPSvcddhgTcRA@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] arm64: dts: qcom: sc7280: Fix sort order of
 dp_hot_plug_det / pcie1_clkreq_n
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-02-02 13:23:40)
> The two nodes were mis-sorted. Reorder. This is a no-op change.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
