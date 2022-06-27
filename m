Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348E755B5E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiF0EAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 00:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiF0EAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 00:00:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD7C3887;
        Sun, 26 Jun 2022 21:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656302411; x=1687838411;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4Kar03BCEB4L24G5H6w4MX8UHJ3D7qBoro9yJwBflPk=;
  b=ql6SQ0IZOtbwkv7x0KmpNj1JmxVCEMsNo+gp4zOc1vX30W6Ctrx6+xNn
   FpBqLio4wI5JQ9RFMVrGp+0tIdaErr8+JLj+IE39j6M7HWNKrNk45mlS+
   9ChWs3FetMIMdf1yOGBwCLUWaCgg8o48MgKJHXMXyZlF5X2hdo8bKBZd+
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Jun 2022 21:00:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 21:00:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 26 Jun 2022 21:00:08 -0700
Received: from [10.216.28.64] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 26 Jun
 2022 21:00:03 -0700
Message-ID: <74337c92-0b23-b37a-861d-54996ae827a3@quicinc.com>
Date:   Mon, 27 Jun 2022 09:29:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] ASoC: google: dt-bindings: Update
 sc7280-audioreach-herobrine compatible name
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
References: <1655892799-29641-1-git-send-email-quic_srivasam@quicinc.com>
 <1655892799-29641-2-git-send-email-quic_srivasam@quicinc.com>
 <YrMPNpE+RWIZP372@sirena.org.uk>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YrMPNpE+RWIZP372@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 6/22/2022 6:16 PM, Mark Brown wrote:
Thanks for Your Time Mark Brown!!
> On Wed, Jun 22, 2022 at 03:43:18PM +0530, Srinivasa Rao Mandadapu wrote:
>> Update audioreach based compatible string for sc7280 based ADSP enabled
>> platforms.
>>     compatible:
>>       enum:
>>         - google,sc7280-herobrine
>> +      - google,sc7280-audioreach-herobrine
> Isn't the DSP firmware selection a purely software one?
Yes. It's purely software related. will discard this additional 
compatible string, and re-spin the patch.
