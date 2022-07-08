Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5E556B13A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiGHEDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGHEDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:03:51 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D2E73596;
        Thu,  7 Jul 2022 21:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657253030; x=1688789030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ieabIjs/1UMKubAGBvSExYnswdhV6Tfe3w0OQQgbOLQ=;
  b=ajpiSvCQTD8OKih1wqcaVtzPfFh0G1+JsQSEGZ+7Pftz3pLJRO5u6epN
   jNrmWakpWYAj7DDzeFMmlhpEkC61OX0mh4Mq5AV61aJ7bsWCIhMyj5LVy
   gKC8XquPIpnIT669caCk+M95n5Y5T8vzn32T5AkrFsJBlPIqh3S6FTvur
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jul 2022 21:03:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 21:03:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 21:03:49 -0700
Received: from [10.216.11.69] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Jul 2022
 21:03:45 -0700
Message-ID: <33815bdd-3a30-594d-3304-8b81f2774190@quicinc.com>
Date:   Fri, 8 Jul 2022 09:33:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v14 00/12] Add soundcard support for sc7280 based
 platforms.
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
References: <1657200184-29565-1-git-send-email-quic_srivasam@quicinc.com>
 <Ysb7rZ4tIpN9fm8w@builder.lan>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Ysb7rZ4tIpN9fm8w@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 7/7/2022 8:58 PM, Bjorn Andersson wrote:
Thanks for your time Bjorn!!!
> On Thu 07 Jul 08:22 CDT 2022, Srinivasa Rao Mandadapu wrote:
>
>> This patch set is to add bolero digital macros, WCD and maxim codecs nodes
>> for audio on sc7280 based platforms.
>>
>> This patch set depends on:
>>      [LPASS DTS: wcd related pinmux reorg]
>>      -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=657389
>>      [Clock DTS: reset control changes]
>>      -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638002
>>      [Clock: External MCLK and reset control driver changes]
>>      -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=650267
> As far as I understand I can't apply this series until Taniya's clock
> patches has been picked up?
Okay. It seems Taniya's patches also in final stage of review.
>
>>      [Clock DTS: lpasscc node disable and lpasscore node name changes]
>>      -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=657325
> You're the author of these 3 other patch sets, so why are you asking me
> to stitch them together, instead of just sending me one series that I
> can easily apply.
Here 3 dependent patch series are of Clock Teams patches.  only patch 
from me is [

LPASS DTS: wcd related pinmux reorg] patch. Which is not dependent on any
other patch and can be applied directly as it's reviewed by. Will take care next
time and will combine patches wherever is possible.

>
> If you want your patches merged, make it easy for the maintainer to
> merge them!
Sure. Will take care next time.  For Now will keep it as it is, as it's 
independent patch and only one.
>
> Regards,
> Bjorn
>
>> Changes Since V13:
>>      -- Move digital codecs enabling to separate wcd specific dtsi file in CRD 3.0+ patches.
>>      -- Remove redundant output high setting in wcd reset node.
>>      -- Revert external mclk name.
>>      -- Update dependency list.
>>      -- Rebase as per latest kernel repository.
>> Changes Since V12:
>>      -- Update 'lpasscore' clock node name to lpass_core to match latest clock patches.
>>      -- Update external mclk0 name and it's source node.
>>      -- Move sound node to separate wcd specific dtsi file.
>>      -- Move CRD specific lpass_cpu node Enabling to separate wcd specific dtsi file.
>>      -- Update dependency list.
>> Changes Since V11:
>>      -- Remove output-low pinconf setting in wcd-reset-n-sleep node.
>>      -- Update dependency list.
>> Changes Since V10:
>>      -- Modify digital macro codecs pin control labels.
>>      -- Updated dependency list.
>> Changes Since V9:
>>      -- Move wcd codec and digital codec nodes to sc7280-qcard file.
>>      -- Modify the reg property as per link number in sound node.
>>      -- Fix the us-euro pin control usage in wcd codec node.
>>      -- Move wcd pin control nodes to specific crd board files.
>>      -- Sort max98360a codec node in alphabetical order.
>>      -- Modify the commit messages.
>> Changes Since V8:
>>      -- Split patches as per sc7280 CRD revision 3, 4 and 5 boards.
>>      -- Add corresponding dt nodes for herobrine crd boards.
>>      -- Update dai-link node names as per dt-bindings in sound node.
>>      -- Add reg property in sound node as per dt-bindings which was removed in previous series.
>>      -- Fix typo errors.
>>      -- Update wcd codec pin control properties in board specific files.
>> Changes Since V7:
>>      -- Remove redundant interrupt names in soundwire node.
>>      -- Fix typo errors.
>>      -- Remove redundant reg property in sound node.
>>      -- Rebased on top of latest kernel tip.
>> Changes Since V6:
>>      -- Modify link-names and audio routing in a sound node.
>>      -- Move amp_en pin control node to appropriate consumer patch.
>>      -- Split patches as per digital macro codecs and board specific codecs and sort it.
>>      -- Modify label and node names to lpass specific.
>> Changes Since V5:
>>      -- Move soc specific bolero digital codec nodes to soc specific file.
>>      -- Bring wcd938x codec reset pin control and US/EURO HS selection nodes from other series.
>>      -- Change node name and remove redundant status property in sound node.
>> Changes Since V4:
>>      -- Update nodes in sorting order.
>>      -- Update DTS node names as per dt-bindings.
>>      -- Update Node properties in proper order.
>>      -- Update missing pinctrl properties like US/EURO HS selection, wcd reset control.
>>      -- Remove redundant labels.
>>      -- Remove unused size cells and address cells in tx macro node.
>>      -- Keep all same nodes at one place, which are defined in same file.
>>      -- Add max98360a codec node to herobrine board specific targets.
>> Changes Since V3:
>>      -- Move digital codec macro nodes to board specific dtsi file.
>>      -- Update pin controls in lpass cpu node.
>>      -- Update dependency patch list.
>>      -- Create patches on latest kernel.
>> Changes Since V2:
>>      -- Add power domains to digital codec macro nodes.
>>      -- Change clock node usage in lpass cpu node.
>>      -- Add codec mem clock to lpass cpu node.
>>      -- Modify the node names to be generic.
>>      -- Move sound and codec nodes to root node.
>>      -- sort dai links as per reg.
>>      -- Fix typo errors.
>> Changes Since V1:
>>      -- Update the commit message of cpu node patch.
>>      -- Add gpio control property to support Euro headset in wcd938x node.
>>      -- Fix clock properties in lpass cpu and digital codec macro node.
>>
>> Srinivasa Rao Mandadapu (12):
>>    arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital
>>      macro codecs
>>    arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD
>>      1.0/2.0 and IDP boards
>>    arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD
>>      3.0/3.1
>>    arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0/2.0 and
>>      IDP boards
>>    arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 3.0/3.1
>>    arm64: dts: qcom: sc7280: Add max98360a codec for CRD 1.0/2.0 and IDP
>>      boards
>>    arm64: dts: qcom: sc7280: herobrine: Add max98360a codec node
>>    arm64: dts: qcom: sc7280: Add lpass cpu node
>>    arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 1.0/2.0 and
>>      IDP boards.
>>    arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 3.0/3.1
>>    arm64: dts: qcom: sc7280: Add sound node for CRD 1.0/2.0 and IDP
>>      boards
>>    arm64: dts: qcom: sc7280: Add sound node for CRD 3.0/3.1
>>
>>   arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts         |  37 ++++
>>   .../dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi   | 155 +++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi     |   8 +
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 216 +++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi         |  73 +++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi               | 190 ++++++++++++++++++
>>   6 files changed, 679 insertions(+)
>>
>> -- 
>> 2.7.4
>>
