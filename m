Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD8F4A5630
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiBAFUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiBAFUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:13 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8165EC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:13 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so15166447otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cx8fEVB8X8EesF6Bvy5LtHeQjU0eGcRlsykwpkoHgGI=;
        b=Z/ivLjWz+XanTM1yK2Y63SsPtGhseJijnN2oCrexxO25T1gu1UhPkFJzZDM41C+iHE
         znhJHmlsLfZqIucqi6bn8UpnIzctLLZXC69GWcB14OI5dMVqcf/5mK2JzkU2xsNX8pgr
         FpM/qld4PzQ7bQeo65KKusFAyM75ymaF6Lk8tZrqRQh95A50YUhFNc4m5HWUbvyDLm/N
         +Ay0cWt/8DqiZ6JYM1nqitVQB1Q6/WsKQNBN19tMBfwPwEtls9O8MiUHGWFWMkz/F77A
         7uI9y+OG9PWJZql2Xrb+4xMBw3gUEXWicbM80LCfnVRrY8rdgIpy5mpzTa9K1kJOTve/
         wWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cx8fEVB8X8EesF6Bvy5LtHeQjU0eGcRlsykwpkoHgGI=;
        b=Zdql+5sZIVWQ4fcib/E04oCcSNN7G0mcQj5JagnTWKAV9Z6pbnUVCJS8+uTCM81aOu
         5HdnwzIaA5CWawI5u9xyQjV5R7kJ0Jsi+MurbXNLGR+VEwJADtMX4yrx2+SF4yqXpRqN
         F9aO+d88YSHQhRfSC2U4mXz81zgaZccpTsduV3d85Hl5Na1tw90MtrHWe3URDZb6Ft9z
         /ZeiM/MFeQxyTA2Bsbp/lf5c3xdUiXJYEoPgXMbTErvy0lzzZqm8uM4/Fq8eZ3d60dig
         ADfuBCsoVfq5XvOYf+c+S/oVlIBrvuj18jmuq5QU91Sv/XcbYhSsRacEULdyZdYe1mt2
         slTw==
X-Gm-Message-State: AOAM530s/360bcEL8yMiy9/4Ejb/SG9BTSpcasufvfFRC8NWhnbd+736
        iA94KEKQ0YHm3iydQrIgLju0EA==
X-Google-Smtp-Source: ABdhPJy0LfI4jZMHzaml2YQNVRzNO2LuHftEv2Pju3MWi2mzlanzeFfH3V4ky9Z76VrJ27FL7e6aUQ==
X-Received: by 2002:a9d:6d07:: with SMTP id o7mr13214068otp.363.1643692812815;
        Mon, 31 Jan 2022 21:20:12 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:12 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8350: Correct UFS symbol clocks
Date:   Mon, 31 Jan 2022 23:19:22 -0600
Message-Id: <164369277342.3095904.16603287886524385869.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211222162058.3418902-1-bjorn.andersson@linaro.org>
References: <20211222162058.3418902-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 08:20:58 -0800, Bjorn Andersson wrote:
> The introduction of '9a61f813fcc8 ("clk: qcom: regmap-mux: fix parent
> clock lookup")' broke UFS support on SM8350.
> 
> The cause for this is that the symbol clocks have a specified rate in
> the "freq-table-hz" table in the UFS node, which causes the UFS code to
> request a rate change, for which the "bi_tcxo" happens to provide the
> closest rate.  Prior to the change in regmap-mux it was determined
> (incorrectly) that no change was needed and everything worked.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8350: Correct UFS symbol clocks
      commit: 0fd4dcb607ce29110d6c0b481a98c4ff3d300551

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
