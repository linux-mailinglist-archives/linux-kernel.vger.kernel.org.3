Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD24A5642
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiBAFU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiBAFUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:18 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC77C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:18 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id v67so31179397oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqXAaV/sPDogRgO8dgQ79brA6tX8/SxUkeACdNnwTRc=;
        b=z3Ld5S7HRkhH+JkXb8FKdtUI8jaXIhbfojWq6SogY2PfXKIu4IjVKAIMdsXQwrWoum
         L+hEffUMI7gSoyUEwojJ+b5ZiDGBkrjMEm0qo/ed4MQQgc1lOzQyqi5BHbpnP8Sig4uv
         /lSHWQZFniodLHwshGTDfAdor/oPOeO1HepZNPwuPYzBEPOrR6cHK5PCBYOcuRsbmd94
         N3bg2zfXf6vW5FPFAQemDWAOqpqgLtfK2ud5tyzRlue10nLtSYBbxaPtDQzUe8frKcEW
         /B6yO7NVIac4OvCoCPY3cmsnfkckZCoO+CGpsP7YE4RNQW86XDYrX6o7KaoZhB+sHBMz
         thEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqXAaV/sPDogRgO8dgQ79brA6tX8/SxUkeACdNnwTRc=;
        b=TaN72mmwZNdYaKO4HrAm0KxOuk997y8NFqbepFAoapAPHVwg7lS5O3olwC730tXY41
         3JvfsMuvdDXrtV5z15WvaZt+6z0SvohOGsMizrl8QxjUtbDHhUYYirk5RFRjdS+jcLjV
         D3uiM2hRx23d2MQyC9W13EJJLQISZgMEQlGVA8++64MnOG5qbpqjf8Nxi+cCa798peZE
         yYZL+k8kDaqCfjEtKrA5dvPOQ7ygbdMOxITvunTca9tbOptI5CZwiQkGkAam8TrPx8N+
         LxxSkc0K4HPYgHwvDd2l/h0ti3qaBd3gkjrkKITGJeRRO/uASpXOR3Rg8rXwjuRxDEBt
         f8bw==
X-Gm-Message-State: AOAM530jLCML0AJTRvmXM6Bp2aQG06K7jjIQejmaxYuQlyXHqeg/Ieo+
        t2BU6SBAyayDPfYpJT2mfQ3bY/RzrkDpcw==
X-Google-Smtp-Source: ABdhPJz4u9CdSpFEHQaUUaDVrqjOjOxTRkAQBdqK7nmVb20LLUegRW2NJ2TzBvg9+3M4J4fKkV8IWw==
X-Received: by 2002:a54:408e:: with SMTP id i14mr232260oii.200.1643692817657;
        Mon, 31 Jan 2022 21:20:17 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:17 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: msm8916: improve usb hs node formating
Date:   Mon, 31 Jan 2022 23:19:27 -0600
Message-Id: <164369277344.3095904.14409216810722485264.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229193731.72690-1-david@ixit.cz>
References: <20211229193731.72690-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 20:37:31 +0100, David Heidelberg wrote:
> qcom,init-seq registers are in pairs
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916: improve usb hs node formating
      commit: 640e71aac554c70180a9b4faa455e80a58fb369e

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
