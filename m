Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF1E46AC23
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351036AbhLFWeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350390AbhLFWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:34:40 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DA3C0613FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:31:11 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q25so24303570oiw.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 14:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8JVL3Wl4hdOJhphGenOGrs6smP3Su+MyORe4mmQGOI=;
        b=ISXL4cv7/jCQYg3ANeFOJnBzCOoxkVijwa/AMaxuvUeQI1xzmbHkjpjj6QoMzHqSgb
         WNyAYNm9lgLbd4rfjfjuWG7kSu062iqNFDXJ+FtJepGt8HlFQaDLyv6p45lZD9RAamW1
         b5hcTch+XXYYIINZOYxcZTNwGTiGUzRBUrKaYmbfRuByqoIcqDA421NXcPF4LmDYv0Jr
         0nL872AbWjpv9IsIDo6LJXJtOHIcUHYlqQFtwmQ1UIF7zyhB4dWspCwbNuNwMxgwXpAa
         617Wddm6hJsrwb5F9E9A3YOILwpOkK29eHf/BJ8Cz7EzY5NjxoeevJ/uVWgymKqL0NcR
         u+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8JVL3Wl4hdOJhphGenOGrs6smP3Su+MyORe4mmQGOI=;
        b=NMMKCtYlbwpFHYhL9hzfcOFt32C84T4hH0Pb24j1ljlQROwEOyUmPz0+ZeoKcC6Klc
         E94F8XqYWU90x74wolivkDKiW6ZF83e7KMmfWPwX1F5dVAq6w614ifzHZExDBviIVS6r
         LDF+y4+47naVqcelmF1b5FWfzqaJu8Jx9Aa1RuGJwZBz8RVLe3RopDr5SVDdNymBfKQA
         75q6iQgDmMD2hYDYXZeKmh3/BFVdsYhm8py2TBF8cjuFlZ5dKtWUdeKjKfPcbCK/fpuk
         XbqU5/wI6Jq5RxZcaxsfhA4YNlCx5IwZHDfH420YbAv/e896ko0m/x4w6YOKIujvDu/n
         zxcQ==
X-Gm-Message-State: AOAM530oxLT831DI+uDSeiDP00jxRUDjLkziX8uXY2FWeSezsyoL/aKW
        Swvfgqy4BrcTLEPBmysF6lwRfg==
X-Google-Smtp-Source: ABdhPJw8YkdPX/mY10EYwdbMtop9Qoh5JjfF8qjSjkl5nnybOZ0r9GbEFJE5golfbfkFDnbJiYq/zQ==
X-Received: by 2002:a05:6808:50:: with SMTP id v16mr1637046oic.34.1638829870418;
        Mon, 06 Dec 2021 14:31:10 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r5sm2911815oiw.20.2021.12.06.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:31:10 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 0/4] clk: qcom: Add clocks for SM8450 SoC
Date:   Mon,  6 Dec 2021 16:31:01 -0600
Message-Id: <163882985136.2324147.13619088408482529005.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201072310.3968679-1-vkoul@kernel.org>
References: <20211201072310.3968679-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 12:53:06 +0530, Vinod Koul wrote:
> This series adds the GCC and RPMH clock support required for SM8450 SoC
> along with devicetree binding for these clocks.
> 
> Please note that the GCC driver patch depends on new alpha LUCID_EVO
> introduced by Vamsi in [1]. That would be required to be picked before this
> patch can be applied.
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: clock: Add RPMHCC bindings for SM8450
      commit: ea59846bd206614211ee43a31e001bed5062f21d
[4/4] clk: qcom: rpmh: add support for SM8450 rpmh clocks
      commit: ab5d31790f4d50d601f150223d6da3dfaab50349

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
