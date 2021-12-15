Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884B44761C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhLOTcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhLOTc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:32:28 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DABC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:32:27 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso26200573ota.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=KCcCNfuto1fwE5eENpKC+nkF/sRCm+bkNjr97zeXP5k=;
        b=AhonrVu+8ZlLbXNMR2eSNrdEE4oll8p9p2eAk4XvDMUN6TOEl7ESsoWlqAajD2BUlo
         Q3SP30lGjRDjFsRSbz+fLXShWL6Xw2O0DsLTwzZ/RtslkBzbKd+kRGEOy2Vq/gc+2J6O
         sMM13+zGYZSPKKUoikyktK9mtBV/VariK2nPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=KCcCNfuto1fwE5eENpKC+nkF/sRCm+bkNjr97zeXP5k=;
        b=677yJ+1bcoECm6CMTHvsQfhOFntY2OBsba0M38jPHZKQpQzZjgwsAW75D1k7Iku8JR
         /54aD1R5vL0kA/IWlaL25OEpYxKrN6TW+9I5dWCZ0eNK18ellHlvDdkNSOMJ7Lq7TPGs
         fnVNNOzsm3gu7lzREFgOwNDPSH/SC9JXuGYsB8cTaMxuIYFjUI/2opypGE8ZKD7byfqy
         Xh/CVhH1Ph/7i7vD1tBhsN0cAa9Z9EAXpjlu08D0U/rZcUVFVmPIScPVJ51k9vG80t4L
         GqSsIZpYUC87FxMp8TjEJaQiy+rPJXPW7kjeH+USvEhzAWVEgCzJaW/lhi2FndJcSui2
         dzLA==
X-Gm-Message-State: AOAM531nCWnygUdPhI2kEoN1UFTbodwsRTV2x0ej7wcyGrxBUghkHkwD
        2fXteKuSRCyi33Csfc0cvWOuWNznm1MP7yLKLs2u9w==
X-Google-Smtp-Source: ABdhPJyexg/795HehcLl8cNNfOqwAGaPZ/BtHR5KlkmgOJqRlq5kPbvEb0Ra/YXyAgX2GsXKtwH2fkUpUy+sB92eL9w=
X-Received: by 2002:a05:6830:30b7:: with SMTP id g23mr9739312ots.159.1639596747244;
 Wed, 15 Dec 2021 11:32:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 11:32:26 -0800
MIME-Version: 1.0
In-Reply-To: <20211215085554.444351-1-deng.changcheng@zte.com.cn>
References: <20211215085554.444351-1-deng.changcheng@zte.com.cn>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 15 Dec 2021 11:32:26 -0800
Message-ID: <CAE-0n52Uf=rcGVxz1U3p6H+icOz1OoacdOFsQtDHCdcdKYTsJw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: remove unneeded variable
To:     cgel.zte@gmail.com, robdclark@gmail.com
Cc:     sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch, quic_khsieh@quicinc.com,
        dmitry.baryshkov@linaro.org, bjorn.andersson@linaro.org,
        linux@roeck-us.net, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2021-12-15 00:55:54)
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>
> Remove unneeded variable used to store return value.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
