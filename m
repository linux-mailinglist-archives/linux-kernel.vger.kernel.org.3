Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058704CBED4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiCCN1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiCCN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:27:02 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C95C188870;
        Thu,  3 Mar 2022 05:26:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D2EEE1F45958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646313975;
        bh=k5xFW6i4L3WwCRx35Ju08ivxV0c8I0qb1DGSeWYfBek=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kpfuwSwN+LDt9K35qXOF5HQpbNgOX6e8bFXzk89wB6ZG36PkQ0vGorVyK0CP1Zwgo
         wBndc0E33MaUUwPoAV4s+cu+ayqAIIOdXefHyEtEX4kEqkpskpsiyJGDoQkwGnzkpZ
         q1qdisdiHzyfjNwCMYA6uT19fREB5hc06+NAKMhqXS0Obs7ap200B6JFt5A9RICjkN
         bzvQAZptVqMJSHJyIbsUDF2KSkZ3A0nPkJyVu59bLb98+1vz5BCqh1B6StWPyt2Yi8
         vX8IuhilA43fdon/qlED6PJRA29LruVEYcFQSYorppnCCMyqObhJjA0SYn2qIyTIBm
         QcyJQ42xZZNgw==
Message-ID: <a9f47e86-e29e-6ea3-6098-878cf58d8329@collabora.com>
Date:   Thu, 3 Mar 2022 14:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 3/3] clk: qcom: Add display clock controller driver for
 SM6125
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220303131812.302302-1-marijn.suijten@somainline.org>
 <20220303131812.302302-4-marijn.suijten@somainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220303131812.302302-4-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/03/22 14:18, Marijn Suijten ha scritto:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Add support for the display clock controller found on SM6125
> based devices. This allows display drivers to probe and
> control their clocks.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Hello! :))

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/clk/qcom/Kconfig         |   9 +
>   drivers/clk/qcom/Makefile        |   1 +
>   drivers/clk/qcom/dispcc-sm6125.c | 709 +++++++++++++++++++++++++++++++
>   3 files changed, 719 insertions(+)
>   create mode 100644 drivers/clk/qcom/dispcc-sm6125.c
> 
