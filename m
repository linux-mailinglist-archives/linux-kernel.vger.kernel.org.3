Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC8A4EEF05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiDAOO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346732AbiDAOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:14:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E37276826;
        Fri,  1 Apr 2022 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648822353; x=1680358353;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Z6HWGEhCA14gDwvUQv/HTXsDm5KV5EQMwDPSUsHxVsY=;
  b=wP8Le9SIWBTOJZ2/SblgEb+QNOx8qnWJWxA0zrFy2OT7/Qdg2XinTOQt
   Iet5q2h06QHYyNDajN1eRjsdZo2bdJ8lBLeNwEWbH7KGWrnw87LuAYz59
   aYEw2YFW2guoLZ8V1MII4Sw0SQM9F+AoDjSfsW4vD/w3R4a1LQED6ktHM
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Apr 2022 07:12:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 07:12:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 07:12:32 -0700
Received: from [10.110.21.173] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 1 Apr 2022
 07:12:31 -0700
Message-ID: <88f7b8d0-3579-d392-f19a-b60ebd340baf@quicinc.com>
Date:   Fri, 1 Apr 2022 07:12:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Subject: Re: [PATCH v4 00/11] spi: spi-mem: Convert Aspeed SMC driver to
 spi-mem
To:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220325100849.2019209-1-clg@kaod.org>
Content-Language: en-US
In-Reply-To: <20220325100849.2019209-1-clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Cédric,

On 3/25/2022 3:08 AM, Cédric Le Goater wrote:
> Hi,
> 
> This series adds a new SPI driver using the spi-mem interface for the
> Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> SoCs.
> 
>   * AST2600 Firmware SPI Memory Controller (FMC)
>   * AST2600 SPI Flash Controller (SPI1 and SPI2)

Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>


I tested this patch series on Qualcomm DC-SCM (AST2600) board with quad
mode enabled. It has worked well so far.

The quad mode test details:
https://lore.kernel.org/linux-devicetree/e362f6dd-785f-87b3-3090-554be0fb860c@quicinc.com/T/#t

Cheers,

Jae
