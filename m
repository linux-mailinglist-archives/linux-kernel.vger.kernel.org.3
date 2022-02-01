Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428DE4A5646
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiBAFUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiBAFUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:20 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E36EC061401
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:20 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id m9so31142042oia.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZy9N9A/8By8PNsO5anLZTQKWqfMahz7/6Il6QeXvpc=;
        b=VABOq6rPw8pnwuggus59/1Ios/bIAkUw1oJhtbHqIGslAJ8fcchHG9GhIrddg1SaUl
         BOYtG3sdUmg+h8eM7rsEW/Dn8j7E2Abltx0xHfy9quWCiqqeCtc8U0TTCxYMU5Y7BdKA
         kgVNBJLoI0O2HRwZCkFU1rnpnrWL85wIte7VCo8g71/xSeaZFQdl5+/M0I3qz+7Y3Qef
         kNyoAfj/93wwkLIM8ATPSTgMzaKwM0oYP/eJwWMM7C07JD9Uo9j/JwOh8IhHaYwtu8ar
         LFZetu7X5BcDVGTFJ01u336BfB82siI5EfRjj8OLZDZT1xzbsqafpBmfXo34W/TZn7O9
         Ii3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZy9N9A/8By8PNsO5anLZTQKWqfMahz7/6Il6QeXvpc=;
        b=xuO1fHEpGz4TfNnRY3/mSJgt/4NUx78NpFTClk8v2X+bwYik0wfy+RQPtBi6v2th9b
         Djn8MDTOdo65waWWpCfXgh6htb4fLeJOJQbZwjvlCrTpgIQ+cxkSfz7H4hAItS9Iv8hd
         ZXCDQjppbtXkUM0KKw8+f2k7lwaIsA2zGjLQYAA7Vw5bslHvCO/HXKqMz2AS/yLMy3IQ
         J9IXphZts59W6MNssN+fGzLc4kmn4Ff+jcDIx8H2+6UevIh20szTnagn8hMw787U6yd1
         Vckf6saaapsM0JBbCYoyRjUhlvXl0GtDEZ0LNJJkbM6HXLgG5lgt8tI/Qa4qFP9R4Xob
         wYqQ==
X-Gm-Message-State: AOAM532InwqI0wl4yulIrAIwms3RobJ0DMpjZ3wW1tMhIBuLC3/6i3LR
        reaGXWyECUy4Kv2GP5VJRgVmyQ==
X-Google-Smtp-Source: ABdhPJzhKFNKfJF9YvEcqhtb/HPRWAXAhZ9NOtzvrusgRCao2NlpLEeH5xl4XmwV8+JUMFRAqt71wg==
X-Received: by 2002:a05:6808:189d:: with SMTP id bi29mr224370oib.68.1643692819496;
        Mon, 31 Jan 2022 21:20:19 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:19 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: pms405: assign device specific compatible
Date:   Mon, 31 Jan 2022 23:19:29 -0600
Message-Id: <164369277344.3095904.8630080866658614547.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227215238.113956-1-david@ixit.cz>
References: <20211227215238.113956-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 22:52:37 +0100, David Heidelberg wrote:
> Follow common pattern for this device, first specific
> and then generic compatible.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: pms405: assign device specific compatible
      commit: 5239ce22278a664c419e7afcbc38a93c6c569bc0

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
