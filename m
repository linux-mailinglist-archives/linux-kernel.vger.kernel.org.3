Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBCB4A52D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiAaXCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:02:37 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:24737 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiAaXCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643670153; x=1675206153;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=H1a9HxdVODmInEXv6RwN+8BAn3XyLCuEMoPx5epZaR4=;
  b=rps5f03A5+3O/kMI9rfg8zOfLZul9VoJrdEERrcy3BAycxGF6YCVobLE
   PF+PevJ6LKfmY9IVkdTFzazSxASPnlvJV403SxRgk33qs+p4qsV1GYfXP
   HDVKtaJwqkenBDSZFt6UMCSCIYiE630+j4DCyEUYzE6Tc97gyet/bNuCC
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 31 Jan 2022 15:02:33 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:02:32 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 31 Jan 2022 15:02:32 -0800
Received: from [10.47.233.232] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 31 Jan
 2022 15:02:32 -0800
Subject: Re: [PATCH 1/3] dt-bindings: spmi: convert Qualcomm SPMI PMIC ARB to
 dtschema
To:     Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220131172450.2528065-1-vkoul@kernel.org>
 <20220131172450.2528065-2-vkoul@kernel.org>
From:   Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Message-ID: <ec54ccc7-ae27-f19c-bb4c-db3d207f4182@quicinc.com>
Date:   Mon, 31 Jan 2022 15:02:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220131172450.2528065-2-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 9:24 AM, Vinod Koul wrote:
> Convert Qualcomm SPMI PMIC  arb binding to dtschema format.

No concerns but, there are many patches going around for this.

Fenglin Wu had it in his v4 series [1] which he had dropped in his v5
series [2] as this one [3] from David H got a "Reviewed-by".

So, wondering if this can be dropped off?

[1] https://lore.kernel.org/linux-arm-msm/1640071211-31462-12-git-send-email-quic_fenglinw@quicinc.com/
[2] https://lore.kernel.org/linux-arm-msm/1643178713-17178-1-git-send-email-quic_fenglinw@quicinc.com/
[3] https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/

-Subbaraman

