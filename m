Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143724A5673
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiBAFVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiBAFUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:35 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D6C061770
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:31 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so15127263otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VaYERgrCYJYZC2sGCpcTnhMQ2mYXiT84+ab+3nA9rpw=;
        b=WsiBSLmgDX+LxQPMN05hU7a2gD03Bsotcx7FE5afyAKnw3C7leA4wgLlCOcmfrMle2
         3/fOIi3raAC1hk9DvbYbynw9lh6qEJSyiRE6v7gvZUj6eBUAc435xIYj7+UhMxS1Ue7z
         8R3uVqOx5I3H0cjlz+XoHyUeSmCwQ1RQ79qcqESQpXd/FuEoXA6xbYXuthV1VCj695O6
         vY1k99euxZM+hGhcrstTV0k3qd2awyp8MdVrPMpXjCQk8GSeC+6RlxMavQX6Wv1e+/zj
         MHTOWYmCb7kOBIM9MaJO8bGMmsUw6WhOKzb98ChLSuRX7rnrhzqzw0o9TLo13UmNMS9F
         Q7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VaYERgrCYJYZC2sGCpcTnhMQ2mYXiT84+ab+3nA9rpw=;
        b=gEngHaMbRluXo7Ve7Bnu9daeMJmsYkxTto5CpSrv+yK2nzAY7ZYlZOzv/7+N/bXx8v
         ciFLgZ8n7vCJ9iMiR2LaMCBPC+pbswflE1X14JC0aYUbYn3vTLkLZUJl6sP8s0gBi22X
         ko0hBfzjAznASeoCB1LEd65of818Za0o0BUjlhA0ciV9Ctge/D+n8Sb1bEeS0be6T07c
         JfQksmPOBTQFGbtIEpw6cn3sWPsjlPK7wnrFTcNf7TIaExaJrT8q1uN1O9TsVXsBNWzt
         ZgeMwpnq5eBm5O9+4TiQZwlmA5uQS7RMK4lWQVA/Arl2Yullg8yWLflR4Esz/4Bkk4Jl
         0uIQ==
X-Gm-Message-State: AOAM531wqbZNhBQ/yHjOczFbtJQkbpd/hPotnvb0s9yeprsRjJvQQSCY
        AmtypFTnOUILiEBtSN9NqkT8Hg==
X-Google-Smtp-Source: ABdhPJwUaqMWRCcEhx4ti2ERXPU+9UOv400FlNwzFuWUXRUB4gpiqFkcOHBLzaRY4jcaocWbJPfuvg==
X-Received: by 2002:a9d:4d08:: with SMTP id n8mr13118939otf.16.1643692830488;
        Mon, 31 Jan 2022 21:20:30 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:30 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] ARM: dts: qcom: add KPSS GCC compatible to clock nodes
Date:   Mon, 31 Jan 2022 23:19:38 -0600
Message-Id: <164369277345.3095904.6223007740319980874.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220108175509.62804-1-david@ixit.cz>
References: <20220108175509.62804-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 18:55:09 +0100, David Heidelberg wrote:
> Some of nodes missing additional compatible.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: add KPSS GCC compatible to clock nodes
      commit: 9f4a052795cd8b4adbe3c5eb0fb92b6122dbdc95

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
