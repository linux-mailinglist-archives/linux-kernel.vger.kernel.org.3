Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8986C476004
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245352AbhLOR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbhLOR5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:57:33 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85D0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 09:57:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so19948581pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 09:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0UQwrR8nztzBdJpsrXKSkivXvI2bisLviWSkYI1RuFg=;
        b=h5WpgU54efXlAJPt2ZOWqh39VhVF4Mj8ZdNpmFs6ohI1LO1pGXiEKyNDDDGLz1P4mO
         DWQOHKkzMdAosYip2+m2ylFEMYAeBlzKogFNXCUDcBmvAd5RZidSVPZzn2EtUPci+Gk9
         iqHTI86k2N2fL3bvSQSMXM9avR0LE83ASJCTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0UQwrR8nztzBdJpsrXKSkivXvI2bisLviWSkYI1RuFg=;
        b=ljsPTTzb2pNhVCwxdLT6CBr402V3PeO0LGRRfQtsFi7IogX/5fyplUDOuHdSV1/SKG
         Co2WZ+MV1lzYq7awCdg9PN20JdqwfcaNygyH/S3+q6w8tCjdVPFjjSYDNmoTo+cT6Ihr
         Gg1r6WeispIkAf8Bh7YYHAbeyVmaihOai7CwPJPi/RxSMe6r9U1KNtB6e9iY6/h21gY6
         uMAGBjmVIxhpBP189urN/Kgb+D4ptTGV+QqG+K7VzxREU3sRHmr1BCv+0hm5zN0i+rjK
         2Tn6giLuxM2XW0MFyc0GghVx6J5VPyDjogL741PZh2Sh+8bNrW6I6On0Wiut/vRyQFDN
         s0Iw==
X-Gm-Message-State: AOAM531M0lDeEGrhPpOicH5rUTDUCT55QzUsT+FkbtdkS5QkDssFZeFv
        X0lji119ZgWA84OIxDZJTyUDJA==
X-Google-Smtp-Source: ABdhPJy/WFxlvXktRBoFkIxaqTD1Pgc2S0N0D3YDLYBKkEC/1cFQNSjmztuXkGwnzEEDmx1OzjC+yg==
X-Received: by 2002:a17:902:bd44:b0:148:a2e8:2c51 with SMTP id b4-20020a170902bd4400b00148a2e82c51mr5382642plx.160.1639591050392;
        Wed, 15 Dec 2021 09:57:30 -0800 (PST)
Received: from localhost ([2620:15c:202:201:4570:3a38:a59b:d420])
        by smtp.gmail.com with UTF8SMTPSA id bt2sm2892224pjb.57.2021.12.15.09.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 09:57:30 -0800 (PST)
Date:   Wed, 15 Dec 2021 09:57:28 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org,
        mcchou@chromium.org, saluvala@codeaurora.org
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add bluetooth node on
 SC7280 IDP boards
Message-ID: <YbosiM3ZZl5zrZcV@google.com>
References: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:36:03PM +0530, Balakrishna Godavarthi wrote:
> Add bluetooth SoC WCN6750 node for SC7280 IDP boards.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
