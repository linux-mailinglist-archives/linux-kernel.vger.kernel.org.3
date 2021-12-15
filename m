Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAD84765B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhLOW2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhLOW15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:27:57 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D09C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:27:56 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso26712067otr.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1jaFOJRzdq3x9WzOCPWbxi4lln7eUG+9jlUAXo/NCI=;
        b=lo+9tihPQ4PhqEiFwq0qhpbo4eIrKXPODpS30ASYysmOveR9nd43OjgGvg6z/BSYKR
         c8TSbiBdRcPx7rfW4BTrghAMOW0XF4oOZCzHOIob5+rD6kMT/8kufClTPM3AjRPfjZvd
         WhqjUuDh0TeoEQlYEk05cdAG2X2k6PetRowBpMk4HQCoIP2rcYcQLzFwpxsh2vp8iWOe
         0tjFq8fzpJCEleI69IfEXEddKycfjDOIg+Mxlae0zbUJBKbU0rOtWvSmeG16wCXVig0B
         Oa+U4Z4/IB1lNnCBZdZpA/qil9FDPj7DH+H3lnLkQkuATLn1EFpmoVpNUS/aLit+nRnt
         UiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1jaFOJRzdq3x9WzOCPWbxi4lln7eUG+9jlUAXo/NCI=;
        b=XfqrXcM6uCYnKTSARBFfStJRpp2y1yGhw2QYBpdTxXLIb4+V7x5+OvAfjq8K26qnBv
         H9buvWt5q8UudaiW9CX6LYYW3vazcIpEcchAOOJ2zJc/UC1hpcUnE6Cb23aY54DyDhYi
         4L5wX8sPrzmMhCcfZuwZj6LLGTbBFB1nQjvI97DxDvOqO9xVeU3TOCJ8jvFzFzQCCXba
         LUl2d94iE/Gw86Lq6UAxmLgb1eFKg0T9yPhqx/YdWxzFyFCyukb/sgtAeTfc1IpcNsZ0
         iF3QMDdJ9H6KG76SNpCnM8+/mBv+FW6/IGvXo9LxSmyFWf7sVP7LLUBElIiR7iXIy/K9
         NNrQ==
X-Gm-Message-State: AOAM533/rx6XHHq13sYvuh5Mb8OAV3qn6bOQvtHi7YE3t0JNJhef80sF
        L9nEtRQ7qGPkXJKV4kgqJrYK/w==
X-Google-Smtp-Source: ABdhPJzaK0xufB8+lzhrMyUZal/R+F3V5OC6jZ5SDnHg0B2uLuAKczygLZBP3B/g5dZojbNfyCiuFQ==
X-Received: by 2002:a05:6830:232e:: with SMTP id q14mr10689326otg.133.1639607276106;
        Wed, 15 Dec 2021 14:27:56 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm700500oth.81.2021.12.15.14.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:27:55 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH] soc: qcom: socinfo: Add SM6350 and SM7225
Date:   Wed, 15 Dec 2021 16:27:28 -0600
Message-Id: <163960723734.3062250.3076248613827283388.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211213081111.20217-1-luca.weiss@fairphone.com>
References: <20211213081111.20217-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:11:11 +0100, Luca Weiss wrote:
> Both SoCs are known as 'lagoon' downstream. Add their ids to the socinfo
> driver.
> 
> 

Applied, thanks!

[1/1] soc: qcom: socinfo: Add SM6350 and SM7225
      commit: 22e8f8dcb7a88f2167607a52542f2f1bb6f53559

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
