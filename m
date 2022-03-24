Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509F94E5DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 05:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345726AbiCXFAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiCXFAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:02 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C6F27CE1;
        Wed, 23 Mar 2022 21:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648097910; x=1679633910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iiEtpNu4c8/sErjB+2x1k9Syp1Xj7TsL/2/CXhHWsAA=;
  b=X0gYlJ0MaqQUgHixl9IE3EvcL/Ab5DDnAAFEx2jXI/2wqkw2htyGslk7
   +prc4a+i0o+Cuse7KSmCJLbFkhcEU7KX5vRa2+pE85e8PuKbiRIWfS1Oq
   6AsilATbDnNY7l2jY0oPGnhAdpm15u1gMWcHtaBNzZgYJa7zi+g7c23qL
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Mar 2022 21:58:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 21:58:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 21:58:29 -0700
Received: from [10.216.13.127] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 23 Mar
 2022 21:58:25 -0700
Message-ID: <3a27712d-1d6d-06a3-2c1a-ac264d6d3fb3@quicinc.com>
Date:   Thu, 24 Mar 2022 10:28:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 4/4] arm64: dts: qcom: sc7280: Add CRD rev5
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>, <devicetree@vger.kernel.org>,
        "Douglas Anderson" <dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
 <20220316172814.v1.4.I37bdb77fdd06fb4143056366d7ec35b929528002@changeid>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220316172814.v1.4.I37bdb77fdd06fb4143056366d7ec35b929528002@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/2022 5:58 AM, Matthias Kaehlcke wrote:
> Add support for Qualcomm's SC7280 CRD rev5 (aka CRD 3.0/3.1).
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Rajendra Nayak <quic_rjendra@quicinc.com>
