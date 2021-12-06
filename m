Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9046AC14
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350577AbhLFWeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbhLFWef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:34:35 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86685C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:31:06 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso15596501otr.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 14:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ryn/Mn0oCuSAoAeG5wwZYVTAXduxPIQABtmtDskOCeA=;
        b=RTrYHW1MgkOkKe/eq8tryam6zofT8S27THitGFNsvlq3ir1eUoAkYCqPWqsnMcGR4I
         m/wLMsnTyb82WlLB6okXhnZSgAgJiYaq/5eCFGYmuLzyc/n/RLvaVoRgiKO02pyLkfsN
         IL5QK19h8u6Q5WW1f6ASgJplewHZp+gARwBfSLNaRbeticFKdkkQ8NZ0tvZ86kdpB8A4
         xPOC9R5Yq4Z67wKUIH81M81k3Ypoup2YKyPOK95QrPCHw+2xRFSkbhULCV0dqwAPIjGk
         jo/15KoMiEHb9RZ8gHwuXcZEYmV4srRQ2quhIqqBsBNH1+JRHkTG7lwsayfmg8Qy63Mk
         o3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ryn/Mn0oCuSAoAeG5wwZYVTAXduxPIQABtmtDskOCeA=;
        b=WT1eiEcVOfAfdh8/qwdtJ6i0w2pyeyGL5EgKYa18L4aiVa0ZfsyKbTbUkd8n9b5spX
         lZnd2JIszJXAZKwqIrmLrKLTDswgQZpLdal/ow+fP5URCv2lyoLK95k1tQ1Li68ZrmKT
         FAGcszT41FA8AcOlCNREhATMyCP2uZEy8L/arNi4LVTa3CPYNrs89IoLNLL6hOfXb/ZV
         eCFwK0TBrk7AoMOIywr6j6P6nAN1C6XI2IVqKcUc5nKNNTmD8JRLVcvy6MEDOw0RHry2
         K0BdaaYo8sUgFdnqyz/jE83Vw4cssEfpFsHqO2Jzc6r5kM+S2ZlATZt7BTpI5vRgLcSK
         OpIw==
X-Gm-Message-State: AOAM5329TDSEwtPFzy/wn0xowFDodqd/5vD6s7uwxdZEV+4Nr6yR29yH
        hORVagoE2eDU3ErRWvo3VDLbBg==
X-Google-Smtp-Source: ABdhPJwI2wU3uJQV08nWez45N6jPlcsYH3zUJa/kxMKikY7BSVIyMNyvnpXr5xhQJn4QzLmliMhTAw==
X-Received: by 2002:a9d:4d90:: with SMTP id u16mr32593040otk.86.1638829865897;
        Mon, 06 Dec 2021 14:31:05 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r5sm2911815oiw.20.2021.12.06.14.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:31:05 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH] MAINTAINERS: Add entry for Qualcomm clock drivers
Date:   Mon,  6 Dec 2021 16:30:56 -0600
Message-Id: <163882985136.2324147.4029165074694158634.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203013901.3460496-1-bjorn.andersson@linaro.org>
References: <20211203013901.3460496-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 17:39:01 -0800, Bjorn Andersson wrote:
> Most SoC specific clock drivers are picked by respective SoC maintainer
> and then sent to the clock maintainers on their way upstream.
> 
> This has however not been the case for the Qualcomm clock drivers -
> which doesn't actually have a maintainer per MAINTAINERS and where the
> framework maintainers have just carried the Qualcomm effort as well,
> presumably as a result of Stephen's history.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: Add entry for Qualcomm clock drivers
      commit: e3fd5f632cdd00e3652e4a5fe743c8c052af11a8

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
