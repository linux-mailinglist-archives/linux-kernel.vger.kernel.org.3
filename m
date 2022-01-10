Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAAF489EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbiAJSDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:03:13 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33716 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbiAJSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:03:09 -0500
Received: by mail-ot1-f44.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso15892318otf.0;
        Mon, 10 Jan 2022 10:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHOge8f285bUwWiwcIOK5mGtXreVJpH3JR+WmddSG+w=;
        b=LTysMEVfxi7flcjd2l0IQKPKqfZ6HbxQp27GfV/ECae4jB/YLxu00qD9x+1l3vdLB5
         MK9rUB4Ykwtu4swRDFuSwB6+FqgD1f+o5Oly8hsLdhUP1yMApTa/7m2TdN1gSw63zh17
         RwIy9NveNW6yMJtS4tkEm3q3bGeM6vbzUuj3B3nhBIvuDyirdbvYCuEErkz1WuzqCBCL
         GJPvqFBYulgyGVdu2/VaoJRjzQgeFUWVSzctY/vff8b5Jh6F2iAS4N2rbFG+frczQSZ3
         b0Uf/hI8alC2IPLuCweZ9q7VQp0IMBTweycny2a5RLARMzAMraIwxaX9weRekiZWlJ7y
         +zfw==
X-Gm-Message-State: AOAM532FecPmOA39fuXJHm120/C6eTZ/GQzp+rOfzqd3R1ZNRlZhWZAD
        +2BJLFparyytAJ6WTK5A7g==
X-Google-Smtp-Source: ABdhPJy2eemZljd8HGQlyZW1LQmzSFvk96tev44J/1OoHkgOIWYMFcYNSrMUsQxaE0C/3FNF0Xh2Kg==
X-Received: by 2002:a05:6830:3110:: with SMTP id b16mr705116ots.367.1641837788966;
        Mon, 10 Jan 2022 10:03:08 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 23sm1563517oty.6.2022.01.10.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:03:08 -0800 (PST)
Received: (nullmailer pid 1197339 invoked by uid 1000);
        Mon, 10 Jan 2022 18:03:07 -0000
Date:   Mon, 10 Jan 2022 12:03:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH] drm/msm/dp: Add DisplayPort controller for SM8350
Message-ID: <Ydx028kx9H4skxUu@robh.at.kernel.org>
References: <20211228045934.1524865-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228045934.1524865-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 20:59:34 -0800, Bjorn Andersson wrote:
> The Qualcomm SM8350 platform comes with a single DisplayPort controller,
> add support for this in the DisplayPort driver.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dp-controller.yaml    | 1 +
>  drivers/gpu/drm/msm/dp/dp_display.c                       | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
