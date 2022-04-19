Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309AE50686A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350553AbiDSKPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350520AbiDSKPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:15:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1793D23BEC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:12:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v4so20581672edl.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljBcPOYzzMcveeaTpLaxvNBjbVfcFDsbJwe+MZrueGQ=;
        b=IcRlHXNQVi09OXBZ/ixkfWis4KIemcrnQJght9cMh3j/iBkK1FY4X4iXV4XsIlUjnz
         dkaJeJP8jbpVTKfEGA+rLOVOvFq82ucsTzukmSNwfpr688fn3t8z89PIS4+3Td75vCV4
         31JkOU+F+D+ZkZw5PY9iYVrPKkRfjOhRcpVsKf4RnZ8R4UN5c6C0JIFNfeubRzJa9R4U
         4kqC8MHR949k5YlClbJbzkqr/akatG7LvJX32tQJNwKxPaxog2rAnDf8sA70azsJ3vPu
         iRZT2z0m8jtPjZ419h385VEKSxSeK8sw04066OmjhIO1fL5NWk9q/mKI8vOQ0Uj42f15
         3gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljBcPOYzzMcveeaTpLaxvNBjbVfcFDsbJwe+MZrueGQ=;
        b=fnHeyoanJ5HCpLgAWCN8/xNS8CREub4VzUx/NfBt6i1dE/oJCp5nwC2KGQTbWjgewS
         wkmMfNfj0R6bhDYwYwWh11kB9MEn87VlcNFbKTEt5H9OyURJ82jfgCwTgBj02F2hYPXr
         5+qwFallrqqHojkw4KWyiXkmuTdPQyWHtrRDIwSdoOslFYDjWB6saNh3ZG9HUdh4OBa5
         1LUIbx58F6cZxhNCFU291z7y+R7ZhOx/UrRZpO4CSIA643LPLa2F11WRYYNSpreVj2v7
         ooBBb1Vpimjs57VjEv+sA5EUGB5y6nZpCsjNO66NxD2qDZPdptYJZ/xrlDEAXwzE0FxH
         xI7w==
X-Gm-Message-State: AOAM530BA60APUSLHKBMXvmQALGim5Xi1MFHabJ6l3LqqzyUszuylZLK
        jzgxiR+v6AcIuxD9tVhrK215yA==
X-Google-Smtp-Source: ABdhPJz6QvRX1yX7m7emWM6GxFi81gwx/a7fdGS3WU2xLYmolIbU/4q1xgzVM4PvSmrOMf7yjT7hIg==
X-Received: by 2002:a05:6402:1541:b0:41c:bfb9:d56b with SMTP id p1-20020a056402154100b0041cbfb9d56bmr16384916edx.344.1650363148733;
        Tue, 19 Apr 2022 03:12:28 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709064e9500b006e8973a14d0sm5581177eju.174.2022.04.19.03.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 03:12:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: align operating-points table name with dtschema
Date:   Tue, 19 Apr 2022 12:12:24 +0200
Message-Id: <165036314214.180327.9860190048104061653.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820081616.83674-1-krzysztof.kozlowski@canonical.com>
References: <20210820081616.83674-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 10:16:15 +0200, Krzysztof Kozlowski wrote:
> Align the name of operating-points node to dtschema to fix warnings like:
> 
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml:
>     opp_table0: $nodename:0: 'opp_table0' does not match '^opp-table(-[a-z0-9]+)?$'
> 
> 

Applied, thanks!

[1/2] arm64: dts: mediatek: align operating-points table name with dtschema
      commit: c743bb394d35b782ae9d9ab815d6053500914533
[2/2] arm64: dts: mediatek: align thermal zone node names with dtschema
      commit: 54ff423f837db59db0626a00d091e45dcc46787e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
