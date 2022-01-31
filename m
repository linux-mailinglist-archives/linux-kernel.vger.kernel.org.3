Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206934A4E26
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355751AbiAaSZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351787AbiAaSYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:24:41 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE4AC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:41 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id m10so3311506oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYta55xSiekvR6ycRHJY9PhHDqdxVNRraCMuzUTrPrQ=;
        b=Fjf44gLrZq/EZVYX7+Yxr24O0sU3Rav8JqjIyhXvXU4td7PeJoHRuo/GibzsZbYOEV
         lcCCSNSofNGL/uKOemqPUhMng8o8uZ57f0giio/QDkynbXeOwocw3CyJDU4NG1444tFi
         PkF4bAlOhjPnKWraf7QZ0neeElb9Bg12Q3LgFmD6C7TkkUmPUvGjYsewRyADXmWhUHUW
         OpbxVeTeImdf03nu3Ip64Kw3nS5G+Tue58kb4qTNVX8jc2pgAEoNi/SDIjVms93OHf5n
         rc6Gna0YeBps9+tYjOYuc9EMJBIWR/Zgee/ijavevIlEFp4Ck8UkfBWCyKoVX2B8SyBA
         jT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYta55xSiekvR6ycRHJY9PhHDqdxVNRraCMuzUTrPrQ=;
        b=6uFSWZXDg6vxCkFbbjoDtcEewtH6ZbCdu7xWgY3uiDuz22tVww6famBgMe1D1elhU3
         o7TlfM0kNhWaPjhEpArhbmnt2YpoxZ78X5xZAoshQ2pLYKg4u2QbSwrEfoBNchynGviy
         ii/X0B/mI3GOMFKJThW3liWwPJx9iYEIcjnCnnxIJLzVWSEuMLqgs1laOeMMDr4wF+M9
         PoLecIkwS1F0AY3m7pj/HJXD+q4hvHAeCBhAkJacWBgXBIi+FQTaUvfcKObEq2wABFbw
         1rAe7yiTnUIdp6olrxlvJW2PRybFhQ7aW3RTbJQiwn1lKnZLUqnVtitHm4V1WVJ19DZQ
         CZbg==
X-Gm-Message-State: AOAM5328NIhkP0x6CQSDRIUFJavOn7L4xBjcMse6PucAAzh2cvbRnCUv
        zgYIo+h9nXLe1LHg9DbfMJ1ALQ==
X-Google-Smtp-Source: ABdhPJyTZL4uJGBKm4v5nPyAaNPk+s4KcWqFNWqLuykJ99q+ZYEIUaNNX2Du6hxKQyyC/MdKWBM2tQ==
X-Received: by 2002:aca:110f:: with SMTP id 15mr13668399oir.176.1643653480896;
        Mon, 31 Jan 2022 10:24:40 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y19sm3273722oti.49.2022.01.31.10.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:24:40 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2] arm64: dts: sc7180: Add board regulators for MIPI camera trogdor boards
Date:   Mon, 31 Jan 2022 12:24:28 -0600
Message-Id: <164365345128.3009281.7629779063912351414.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216044529.733652-1-swboyd@chromium.org>
References: <20211216044529.733652-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 20:45:29 -0800, Stephen Boyd wrote:
> Some trogdor boards have on-board regulators for the MIPI camera
> components. Add nodes describing these regulators so boards with these
> supplies can consume them.
> 
> 

Applied, thanks!

[1/1] arm64: dts: sc7180: Add board regulators for MIPI camera trogdor boards
      commit: bb59462e414f8c0c55800064e9be4c596ae6898d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
