Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858724A568D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiBAFV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiBAFUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:48 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26CBC061759
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:43 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id i16-20020a056830011000b005a3cc8d20fbso8808072otp.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ry1KVCLodT30pxR0phJHQWO+PZtDOVeQMcsip3OfdTY=;
        b=aTZPtmAGdZDLvzurlF4oSjIoWR4277PVrc7Uac/gOWuizOuTRgFF//g0uor42N1wZv
         iA9UWLJ8bp5aZ9UB+1FIDJGxeaDYgLj6wl3RLjaZgthR1bgLV/c/GUh0rdNroedI5ZcM
         l4ZI4E6atRazjLTnfCcNzSYGiXLYypFpeAy9v+DxNQmCvlnm6Suu1rexiBgyzJpecbPq
         l666nVHNxb8/IIuoYHmI8twC7ysskypBpLWuCMnzZnPKhStwJwuUe/z+4RxWx+6nk4h4
         FLF4qDONAW9lKHNSdUZ/KDiCwlbnY7Dk4/OFNojRoOMp4xOglCKsCxrIAf+fzY/bzkri
         GKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ry1KVCLodT30pxR0phJHQWO+PZtDOVeQMcsip3OfdTY=;
        b=LxmmCxS+O0zxEzrsZ4RNRrevUym1Fa1nPiFOxRnvdRPtnzF4n/PrPQ546ieZIqImfj
         2JsPOCb+Rpb3vbj5pfAV+vpDpwteC3ytiwqJvSsGISL7CuCv1zbfkLt/Ok/t6nadaXO/
         C7kjDLB4tBjMkZ8HKzBv4WZbxFJHiQS6ETxrm89McOU5iIKuSNRfnAkSiWJw6LB0EmC8
         gfqyDPVuVZgWdLig68hXjURnd2xYeHyl0UDY0fzTbAqUBkbXU1lne7U3NmlblTz3Chtv
         K51VB21PGs2gd3VxlDPKYIh3iuUY3egZSClSpZk4Mje9M3OvG32rlOzcezBH7VxGnkF1
         z/Cw==
X-Gm-Message-State: AOAM530eJw37xd+61Lpw0/VonKynepsu8qRgb96RGSg100pUHFcTzBpD
        dGnEjo1Bb7Xzk7nPsRX8UzEhUQ==
X-Google-Smtp-Source: ABdhPJztSrYUbSJw7VycFZKQ2ZDAlLdb4aHLheqEoISnXvoiYEOmY/wM2qKkHnqDV4c6LKDu0dcufA==
X-Received: by 2002:a9d:7cc3:: with SMTP id r3mr13724563otn.121.1643692843179;
        Mon, 31 Jan 2022 21:20:43 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:42 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     stable@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sm8250: Fix MSI IRQ for PCIe1 and PCIe2
Date:   Mon, 31 Jan 2022 23:19:52 -0600
Message-Id: <164369277345.3095904.4546009312058638059.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220112035556.5108-1-manivannan.sadhasivam@linaro.org>
References: <20220112035556.5108-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 09:25:56 +0530, Manivannan Sadhasivam wrote:
> Fix the MSI IRQ used for PCIe instances 1 and 2.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250: Fix MSI IRQ for PCIe1 and PCIe2
      commit: 1b7101e8124b450f2d6a35591e9cbb478c143ace

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
