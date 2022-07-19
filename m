Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E59457922A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiGSEsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiGSEsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:48:19 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858173AE5B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:17 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10c0052da61so29289325fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fMS8P/Q+lF/PvlI/Lf4gxXphjeO/3/esE095bH6bCkM=;
        b=U90ckEN8Vo/sEtPG5TNM2yN4eQDF2L52+lH7M0PTdbtWh6ScfDaov/9x8R2z+Y4c5N
         RkrFBtG4zrxMtwZrrm2vG1zBm7XOUnLOnm2OWUk3+Td/rf5YL24f++wHNKAup+NSG9ui
         kAb2fY16Sp30MrVU1KhqhJisPtgQPb+ZwhV2d2Q6gYve+vsZMJ2Ahw17P/1JnUeIaask
         k82Iz2WTfhvZZvwDhgjnNXZ40ulZaUmCKjgMCQtMa4MOAAQrJKp8ctFXDbOwD5DrJOCS
         2qomPOo86hHUVNn6K95HpdkE918c+a5d6rJ/MbiPpIQAa0AzmGT/ucYfqR1beM2hgoG3
         JTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMS8P/Q+lF/PvlI/Lf4gxXphjeO/3/esE095bH6bCkM=;
        b=ZJhvQUpyr5qixyTCAp4UAibYJX0f3JKh8fLZzRVvfmqFTBdumeQKK/ooTAzAkL7+O1
         PAuTE8iF96XDcANwjPFYpg6bG/JOm6JMNcw+o4+XqFeS8A34EA4KFMHK9DoBGQaAOQgk
         LY/xk7SRvRqwHLiOWh5xF4OnpWObyPQu4OzEaPm8gcw7wITHJ2XvK+1PBUP4rDGZVeNd
         YPjcYVryDshZxdedoZUAbx4v/OCkIIs2v1t6T4qC7lQxMkmxWBqFIf0X7URhSSIS3/yR
         ofqvVTZRJ2eS+rNsvZg9GMcssIiU4mI6OGjnJ4mkP37d4apEXFsUuWYCCUquX9FAXTLq
         4TLw==
X-Gm-Message-State: AJIora+WhSRRuQ85xYyYcxvX/Vk4M6FFYCijWS99T4orN978YfQg/fmU
        Wwes0xk4l9eXVldoWpW7CJhI3A==
X-Google-Smtp-Source: AGRyM1ve0eUcI45b1anrOMLHM3Qc4rf7K1tjbBb44yWawJ325P2QiX7kqk49IYSKDZWF0YifCvc2BA==
X-Received: by 2002:a05:6808:1189:b0:33a:34b3:6788 with SMTP id j9-20020a056808118900b0033a34b36788mr13668076oil.194.1658206096923;
        Mon, 18 Jul 2022 21:48:16 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w9-20020a9d70c9000000b0061c9bbac1f9sm2803209otj.16.2022.07.18.21.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 21:48:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     steev@kali.org
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: (subset) [PATCH] arm64: dts: sdm850: Remove unnecessary turbo-mode
Date:   Mon, 18 Jul 2022 23:48:04 -0500
Message-Id: <165820608071.1955453.9975622712373840303.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220718230109.8193-1-steev@kali.org>
References: <20220718230109.8193-1-steev@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 18:01:08 -0500, Steev Klimaszewski wrote:
> qcom-cpufreq-hw finds turbo-mode in the LUT hardware tables
> and slaps the flag on the last element, so there's no reason
> to add it in the dts, so remove it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: sdm850: Remove unnecessary turbo-mode
      commit: 757991c0778f5c9621955358a9fbf88999131ae1

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
