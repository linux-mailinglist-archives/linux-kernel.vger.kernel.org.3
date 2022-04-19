Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC97506BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351998AbiDSMEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351961AbiDSMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:02:17 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1492316A;
        Tue, 19 Apr 2022 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650369530; x=1681905530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tBgvWdaivKxPupWluH3aaPmc9RwgWxsFZBbdngJpiVA=;
  b=JcjUbGWeMsDFfx1rbGnrA6cMcVZ/L1jo5VFc6WkYse2CP0pkNToMfpqA
   p22zFlq6IZrU+6u75ltiJnEQHY/lIsr993DehZp/+7/uDI9/gTk31D3e7
   FIIUWKhi0E16bMKkT0QDPX5FNs8E+8ew/SLjcdXujMSnVFOoSFqtadCEW
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 19 Apr 2022 04:58:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 04:58:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 04:58:48 -0700
Received: from [10.79.142.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 04:58:44 -0700
Message-ID: <07b820e5-87e7-37ea-734d-df3e994c9698@quicinc.com>
Date:   Tue, 19 Apr 2022 17:28:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V7 0/7] Add driver support for Data Capture and Compare
 Engine(DCC) for SM8150,SC7280,SC7180,SDM845
Content-Language: en-CA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@codeaurora.org>,
        <vkoul@kernel.org>
References: <cover.1646285069.git.quic_schowdhu@quicinc.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <cover.1646285069.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/3/2022 11:57 AM, Souradeep Chowdhury wrote:
> DCC(Data Capture and Compare) is a DMA engine designed for debugging purposes.
> In case of a system crash or manual software triggers by the user the DCC hardware
> stores the value at the register addresses which can be used for debugging purposes.
> The DCC driver provides the user with debugfs interface to configure the register
> addresses. The options that the DCC hardware provides include reading from registers,
> writing to registers, first reading and then writing to registers and looping
> through the values of the same register.
>
> In certain cases a register write needs to be executed for accessing the rest of the
> registers, also the user might want to record the changing values of a register with
> time for which he has the option to use the loop feature.
>
> The options mentioned above are exposed to the user by debugfs files once the driver
> is probed. The details and usage of this debugfs files are documented in
> Documentation/ABI/testing/debugfs-driver-dcc.
>
> As an example let us consider a couple of debug scenarios where DCC has been proved to be
> effective for debugging purposes:-
>
> i)TimeStamp Related Issue
>
> On SC7180, there was a coresight timestamp issue where it would occasionally be all 0
> instead of proper timestamp values.
>
> Proper timestamp:
> Idx:3373; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x13004d8f5b7aa; CC=0x9e
>
> Zero timestamp:
> Idx:3387; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x0; CC=0xa2
>
> Now this is a non-fatal issue and doesn't need a system reset, but still needs
> to be rootcaused and fixed for those who do care about coresight etm traces.
> Since this is a timestamp issue, we would be looking for any timestamp related
> clocks and such.
>
> We get all the clk register details from IP documentation and configure it
> via DCC config_read debugfs node. Before that we set the current linked list.
>
> /* Set the current linked list */
> echo 3 > /sys/kernel/debug/dcc/../curr_list
>
> /* Program the linked list with the addresses */
> echo 0x10c004 > /sys/kernel/debug/dcc/../config_read
> echo 0x10c008 > /sys/kernel/debug/dcc/../config_read
> echo 0x10c00c > /sys/kernel/debug/dcc/../config_read
> echo 0x10c010 > /sys/kernel/debug/dcc/../config_read
> ..... and so on for other timestamp related clk registers
>
> /* Other way of specifying is in "addr len" pair, in below case it
> specifies to capture 4 words starting 0x10C004 */
>
> echo 0x10C004 4 > /sys/kernel/debug/dcc/../config_read
>
> /* Enable DCC */
> echo 1 > /sys/kernel/debug/dcc/../enable
>
> /* Run the timestamp test for working case */
>
> /* Send SW trigger */
> echo 1 > /sys/kernel/debug/dcc/../trigger
>
> /* Read SRAM */
> cat /dev/dcc_sram > dcc_sram1.bin
>
> /* Run the timestamp test for non-working case */
>
> /* Send SW trigger */
> echo 1 > /sys/kernel/debug/dcc/../trigger
>
> /* Read SRAM */
> cat /dev/dcc_sram > dcc_sram2.bin
>
> Get the parser from [1] and checkout the latest branch.
>
> /* Parse the SRAM bin */
> python dcc_parser.py -s dcc_sram1.bin --v2 -o output/
> python dcc_parser.py -s dcc_sram2.bin --v2 -o output/
>
> Sample parsed output of dcc_sram1.bin:
>
> <hwioDump version="1">
>          <timestamp>03/14/21</timestamp>
>              <generator>Linux DCC Parser</generator>
>                  <chip name="None" version="None">
>                  <register address="0x0010c004" value="0x80000000" />
>                  <register address="0x0010c008" value="0x00000008" />
>                  <register address="0x0010c00c" value="0x80004220" />
>                  <register address="0x0010c010" value="0x80000000" />
>              </chip>
>      <next_ll_offset>next_ll_offset : 0x1c </next_ll_offset>
> </hwioDump>
>
> ii)NOC register errors
>
> A particular class of registers called NOC which are functional registers was reporting
> errors while logging the values.To trace these errors the DCC has been used effectively.
> The steps followed were similar to the ones mentioned above.
> In addition to NOC registers a few other dependent registers were configured in DCC to
> monitor it's values during a crash. A look at the dependent register values revealed that
> the crash was happening due to a secured access to one of these dependent registers.
> All these debugging activity and finding the root cause was achieved using DCC.
>
> DCC parser is available at the following open source location
>
> https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/tools/tree/dcc_parser
>
> Changes in V7
>
> *The DCC interface has been shifted from sysfs to debugfs. The new interface
>   details are documented in Documentation/ABI/testing/debugfs-driver-dcc.
>
> *All the rest of the  comments from previous versions have been implemented.
>
>
> Souradeep Chowdhury (7):
>    dt-bindings: Added the yaml bindings for DCC
>    soc: qcom: dcc:Add driver support for Data Capture and Compare
>      unit(DCC)
>    MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
>      support
>    arm64: dts: qcom: sm8150: Add Data Capture and Compare(DCC) support
>      node
>    arm64: dts: qcom: sc7280: Add Data Capture and Compare(DCC) support
>      node
>    arm64: dts: qcom: sc7180: Add Data Capture and Compare(DCC) support
>      node
>    arm64: dts: qcom: sdm845: Add Data Capture and Compare(DCC) support
>      node
>
>   Documentation/ABI/testing/debugfs-driver-dcc       |  124 ++
>   .../devicetree/bindings/arm/msm/qcom,dcc.yaml      |   43 +
>   MAINTAINERS                                        |    8 +
>   arch/arm64/boot/dts/qcom/sc7180.dtsi               |    6 +
>   arch/arm64/boot/dts/qcom/sc7280.dtsi               |    6 +
>   arch/arm64/boot/dts/qcom/sdm845.dtsi               |    6 +
>   arch/arm64/boot/dts/qcom/sm8150.dtsi               |    6 +
>   drivers/soc/qcom/Kconfig                           |    8 +
>   drivers/soc/qcom/Makefile                          |    1 +
>   drivers/soc/qcom/dcc.c                             | 1465 ++++++++++++++++++++
>   10 files changed, 1673 insertions(+)
>   create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
>   create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
>   create mode 100644 drivers/soc/qcom/dcc.c
>
> --
> 2.7.4

Hi,

Gentle Ping

  Let me know if there is any feedback regarding this patch

Thanks,

Souradeep

