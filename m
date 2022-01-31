Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5504A52DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiAaXEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:04:25 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:53090 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiAaXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:04:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643670262; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=zw1Yj5FBLCHqW7QysextbS43RRIoASpz2CYOQrDzFu4=; b=eebB2j66Nf4c1iyqT5T+wndi3QBD6PFSA2DSJmmhlzltdVpLZAlzx7SmN++viiWmkVWkse6i
 lq+hpskhjhLTONZJpgZlD8qOpbm+7J6jhyIvRb0hevcvVG0TF1Zvu+sKt71PqT1CdeOy2tsw
 1g4muToJWi5uVTiBiifV80dJMrU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61f86af6e42a102d96a5e9d4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Jan 2022 23:04:22
 GMT
Sender: subbaram=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 351B1C43618; Mon, 31 Jan 2022 23:04:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.47.233.232] (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: subbaram)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4443C4338F;
        Mon, 31 Jan 2022 23:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E4443C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH 3/3] spmi: pmic-arb: Add support for PMIC v7
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220131172450.2528065-1-vkoul@kernel.org>
 <20220131172450.2528065-4-vkoul@kernel.org>
From:   Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Message-ID: <b28ad431-a760-ed02-5bcc-3fc421061759@codeaurora.org>
Date:   Mon, 31 Jan 2022 15:04:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220131172450.2528065-4-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 9:24 AM, Vinod Koul wrote:
> From: David Dai <daidavid1@codeaurora.org>
>
> PMIC v7 has different offset values and seqeunces, so add support for
> this new version of PMIC
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Can you please fix the author based on my comments [1]?

[1] https://lore.kernel.org/linux-arm-msm/8f6645ff-0753-bcd3-f692-6be205cf71b8@quicinc.com/

-Subbaraman
