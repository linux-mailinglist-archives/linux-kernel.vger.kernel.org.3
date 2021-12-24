Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4EA47F08B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 19:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353431AbhLXSMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 13:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353424AbhLXSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 13:12:06 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF3C061759
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 10:12:06 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id v22-20020a9d4e96000000b005799790cf0bso11823399otk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 10:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=givG84UFD4gNa7xeZxhpUFNzV7usFzOyWYPoeEhti1E=;
        b=u6mcMpK3feWBd6geWPTXyLMyawyZJpHes483r06hwk4TL08UdY/o+mkrGSwemRxHiD
         ZZ7CP4EMtJmhQAjbFyd+PmTi9B9tYwhKjPEeK1CX7boCoOiRvIIb78+/kWSgsLYcTUa0
         uGCc4Euyn4JDqSyTZ53vg5BjAtvymuzBLH9be9Wkn4qXFREn2d9CrkKXRGz95cFby8Hi
         BOfICf98sWXKZ1I2E9tnSeeyZI3D9hcIGK+9N7Ff5p64zCQxrODNtNE2xXTe4NHtdSE/
         xFuQ/6hiR4BpJV0MPUA76GDP4p5JvxnOcaLeTQdSSnQMUHjqaYPa6od5BqPQFKilo49D
         dkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=givG84UFD4gNa7xeZxhpUFNzV7usFzOyWYPoeEhti1E=;
        b=KN6QN85wCVEJkQZBtcsjUBsrfqgStPwKigc+kKtbQD+al/YO0t4+j2Wnz0BoRyVly+
         cAxInfbqvG4ONAjqFad4kaJ1vC9YAmtCRVC4Yu9lJjKV0Jm3FYdUV7xabnee/HQwod8k
         TGVx38j1YfZVQLd4ZZJnrDqkWsUEH+IhjFbvvqS+WJyU1mULIst7DfnTtev8FUixd7uS
         GwwR5wTIlE7GyXbH+B3xlANU4f23SibYEoJ4wBBaKUitoMQimDNATss5wY2ZroOQt0wi
         xubUwCN4UTU2Wf4kVedxWsa8tt1ysfVkFsiKMZOiu2y1EW58hyqkq2dJYttTG1sbdvbp
         tfRA==
X-Gm-Message-State: AOAM531tcDQ4f47seX709XySEziccjP+3UAV3xy3Z7pfrC2SSqdlrN7o
        7/x8Xth939qrpc7stmsGbHGGUg==
X-Google-Smtp-Source: ABdhPJxW3loolgEUsdpaDRQ7lS5/U7vOfjUzMzyHJ9fnLd3MTMl54ab6cZ2PFwTgKxJrqYrZkYG0AA==
X-Received: by 2002:a9d:66d:: with SMTP id 100mr5357747otn.40.1640369525626;
        Fri, 24 Dec 2021 10:12:05 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 186sm1740772oig.28.2021.12.24.10.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 10:12:05 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     ~okias/devicetree@lists.sr.ht, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: use standartized naming for spmi node
Date:   Fri, 24 Dec 2021 12:12:01 -0600
Message-Id: <164036951699.3936163.2946375253138631316.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211224163107.53708-1-david@ixit.cz>
References: <20211224163107.53708-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 17:31:07 +0100, David Heidelberg wrote:
> Following naming convention, rename qcom,spmi@ node to spmi@
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996: use standartized naming for spmi node
      commit: 22cc83a0cee99d5cc50be20103fab3b303db51ea

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
