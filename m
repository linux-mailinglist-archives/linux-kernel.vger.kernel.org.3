Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06D4A567F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiBAFVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiBAFUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:41 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A90C061760
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:41 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id e81so31208991oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1xAd7MhWM114EP/lwapQoULra05aKelSN/7cTNRJ0I=;
        b=T1dKB6l2snA7lgKPCks1ks13hIqSTQ6YBMknAlnYZYkpxA2M1bWlJd5U+xN1nVN3G2
         s11kYH6Z2ZM9srQu5NARZcYY+QTzUXAxisOB3V+3SN5tJv5btTwM6rFVCvh7+pj1FN6W
         lCRF44RLxC6BW0D4DioXhBfQ+fJHUOT+27QrAFzLEs6nDl2Tj627gHAm/cuHy06sZGgg
         xT9TDey8LX+VZMBP1e3fHrIRTJstn0P6SEZ0++TRHtp+vqtuowfOEn9IfPdU1FVopIT4
         daEBkIEWrmkFTBgmNkxoGgsmusajJaAykgWPebFpqOIApV7pQXqY+bS0bfCIrbh3jQC5
         OQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1xAd7MhWM114EP/lwapQoULra05aKelSN/7cTNRJ0I=;
        b=C8MPV8uiASl7W1THepVtYSDV5gvEWvWJaewXvG6FSH7qqS9HsHYgfrTTPRihbcH7Eg
         QPWTwWs8UTI6K6iXA/GLvfuZkDahb5MznhXBf2qy0/t/Betxi2mB4FFVIL14sxGI6mRV
         G1Mcmqsj2+XdYswyRqgKt+jLJxAQEinqae7noqQaoDJFF+ty0bpWLkSYHR7cusEqijML
         /lJ1s6oq6+26FCvkWJn6BQZwpD0ORxHzW8wvXcTbdHFUiuM9VHo8KUhVjK+jTVE5AZNd
         6yWLuptuZcyJArKciP+qk0Cwg1Y4NRGYQiACgWid8qqpcsSdPioASnPwjk/CCgXdd04l
         03gQ==
X-Gm-Message-State: AOAM532I8dUO7N//6lNGpie/sfDH1JLGDezCew+p7CqXX4VCh9hkmIIc
        LcRZWhNWthbMUGfdEVV5SLutng==
X-Google-Smtp-Source: ABdhPJxo2omDXankE0jqJ/j4SG+TP6imO5bLi/34uTkLJWm74Vq42aWzp6gTmYp2htyCU97kMIknMA==
X-Received: by 2002:aca:398a:: with SMTP id g132mr203882oia.207.1643692840370;
        Mon, 31 Jan 2022 21:20:40 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:39 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jack Matthews <jm5112356@gmail.com>, linux-arm-msm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, luca@z3ntu.xyz,
        devicetree@vger.kernel.org, bartosz.dudziak@snejp.pl,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: pm8226: Add vibration motor node
Date:   Mon, 31 Jan 2022 23:19:49 -0600
Message-Id: <164369277342.3095904.17898703423921081111.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211123003256.2467776-1-jm5112356@gmail.com>
References: <20211123003256.2467776-1-jm5112356@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 00:32:55 +0000, Jack Matthews wrote:
> Add a node for pm8226's vibration motor driver.
> Keep it disabled by default, some devices don't make use of it.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: pm8226: Add vibration motor node
      commit: d88198fcb540268e2165d2d1eecca005ca5fc394

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
