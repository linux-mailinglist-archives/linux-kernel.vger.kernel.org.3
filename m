Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35D94A4E15
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351085AbiAaSYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350379AbiAaSYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:24:36 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9384DC061758
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:36 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i16-20020a056830011000b005a3cc8d20fbso7469824otp.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZrxVRyRyNFCJP75CoHEUtHl9XBbgxc1ckBeCy2/c3w=;
        b=skmNCEYHXJ8+qJ1S05uwnU35BlAtl49BF/tVmc7e639/DplJ27YzThxfhhoGjhUdjX
         kba3oZsqDD5YV7MhxYgx87aunsEV/CrtZnU7K0h82cHwU4pMTnjiIig0t5/CWunZ41EA
         SpMILVNgYz1wkrjrMQ7DOcRNuQ64eNrDDyo7zrp7GbXoo5KpwAQIjEe44Nt3kpiKB9G5
         awW9z0faQyhWZAq4z+uco17IxqmejoLhKwha3ACZPnW00whMmHmcMlJ3naPZXYJLMSsp
         J4qyja62POYbVuPper9mvwUH0tVHHLL1funo1Y8AyT4H37WP5VK05klP+fRh+KbIIpGm
         12xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZrxVRyRyNFCJP75CoHEUtHl9XBbgxc1ckBeCy2/c3w=;
        b=iUcentQINT9n773cOWtQOHfFLEpw3CTIkOC0ko/0Lk3bOpm7j2werGYcUqb+TbedUh
         S0S5B8nVgsKkYu+1xDDkqcsmOssVo00T1Eda/LnGBMcWSdnKskiLigfrwxHVbsmfKdij
         TNysM1L4UAFe2qpxDod+wH815WTBmIAen0oeBNeRZxhLKuSs5QNq1FVPPJ0OLFUgeSyf
         IjZ4PcBxuSN4tWtXxLuNA/kSwFYJWiCJ/WFFXszpsR4WKob04RlneP8SkUqfVKuEXcUc
         6TB834XsUVjRk6jMcp0cSwwSILXQeC24UOW88kx2BPZk3oK2YxuXaJi9pEhXLEgwavam
         nPJw==
X-Gm-Message-State: AOAM533jAvACpGDudfYlE0JtE+46zN85JTHXBUKhV2U6dCe5+lAATJ7e
        mykKuyKZxhRztEUWvYHJo0iWaw==
X-Google-Smtp-Source: ABdhPJz5eE5TyTfzLnb50gGVxVx0P18CltBdrHHEOnVoMKhBbFbmwvpHLQveFzKOIx6Nmy0NnlaISw==
X-Received: by 2002:a9d:748d:: with SMTP id t13mr12213366otk.276.1643653475935;
        Mon, 31 Jan 2022 10:24:35 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y19sm3273722oti.49.2022.01.31.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:24:35 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     mka@chromium.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Collins <collinsd@codeaurora.org>, swboyd@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Add PMG1110(Seco Jr) PMIC support
Date:   Mon, 31 Jan 2022 12:24:24 -0600
Message-Id: <164365345128.3009281.16782097629100983959.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1637668167-31325-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1637668167-31325-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 17:19:24 +0530, Satya Priya wrote:
> This series depends on below series which adds the base CRD dts
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=584349
> 
> Satya Priya (3):
>   dt-bindings: regulator: Add compatible for pmg1110
>   regulator: qcom-rpmh: Add PMG1110 regulators
>   arm64: dts: qcom: sc7280: Add pmg1110 regulators for sc7280-crd
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sc7280: Add pmg1110 regulators for sc7280-crd
      commit: 073a39a2a63abd46339a50eb07bd23958d99efbe

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
