Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B941C4817DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 01:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhL3AH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 19:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhL3AH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 19:07:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02617C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 16:07:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id j13so16861298plx.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 16:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/hWBxeW6VlEgpDPPN9ifq8EfRvPJP/oCX5izdzH+swI=;
        b=AxmDje3/xd29wllytbs2CZW4URFitMK0jyjdR08nQCpa5ROX/ljaaDCwkgqWm/v5n3
         RX6t9dmiGNvo20+kIlYL5Kz+SmA1kx0+TDg1XxLAa4hFd/gPubWaF4Ii//QZw3+zB++d
         /IlL4gmP7m3LU/vspr4UGHLbvipS62YuDtZ+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/hWBxeW6VlEgpDPPN9ifq8EfRvPJP/oCX5izdzH+swI=;
        b=JvvACaIeQjNbCY1YDEmNnxs0aqANlGmommnF7NRtuRDesyqNbNdpD1BbepNEjxTqDF
         zZneiEkDWSpgDIBdU1dWdg26RnmzlkOuIqk0TWYUwk1SwKbQWDUslbcGRbTK5/dfH+mT
         OuE7JIaUsH3rOxN6doH9rIODqpaKeM1CImbZtC3vKmz41oahWmtEl4kml1pmuqfNed41
         umr/aEHLReanXYYCtnofNn3XGcvQk9rs8ZFC/l43uD9nZ9m2cQsccX+my/3tb7T8Yplz
         eqeMHsuzJ4PkqOT3r030X37slki6FYY3vmbVOVa/emDTtz64BbqV9vksL57Fjlol8Is/
         sQrA==
X-Gm-Message-State: AOAM530vUhST4xhW3dmkCNyBUgv23OaOHiJ2wbgsXATkZyvqZ1o1AXyk
        lL24pkPHhRHTE+GDMjzMKKv8/A==
X-Google-Smtp-Source: ABdhPJymmUREnI2quBKKj/dWSKAyYHaOpdEd3KfjvDu/pSnJj1dOtBAMdjRNgAdnz8URso4DFIUMNw==
X-Received: by 2002:a17:903:200c:b0:149:7b1d:8145 with SMTP id s12-20020a170903200c00b001497b1d8145mr18739701pla.58.1640822876552;
        Wed, 29 Dec 2021 16:07:56 -0800 (PST)
Received: from localhost ([2620:15c:202:201:963f:6ecf:d90b:76ca])
        by smtp.gmail.com with UTF8SMTPSA id mh3sm29386264pjb.26.2021.12.29.16.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 16:07:56 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:07:54 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: sc7180: Add board regulators for MIPI
 camera trogdor boards
Message-ID: <Ycz4WmbWaQio1ijU@google.com>
References: <20211216044529.733652-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211216044529.733652-1-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 08:45:29PM -0800, Stephen Boyd wrote:
> Some trogdor boards have on-board regulators for the MIPI camera
> components. Add nodes describing these regulators so boards with these
> supplies can consume them.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
