Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D28513267
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiD1L1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245064AbiD1L1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:27:01 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1266D971;
        Thu, 28 Apr 2022 04:23:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23SBNRXm112466;
        Thu, 28 Apr 2022 06:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651145007;
        bh=5t3OzA0Rw/NGVThHMxQu6xew1IgZchZszoPZC/r7wwY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=U3WwLaFQKcA8juoBzoJ6Y6E5ReyXXClgnmOv/P5Wr+nyQehNI/8L0F0MTE8pKV8eS
         3D9gHclMZ2i5RG26Kvpp+Vkw4rtfUK5sfXAm+C3plcXYfLmBrAZ/x9bq7l66npIImz
         Wo5aZCw9wmOgBy+CebCN6trSVY8+u4AF8UySDj40=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23SBNRFQ011008
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Apr 2022 06:23:27 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 28
 Apr 2022 06:23:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 28 Apr 2022 06:23:27 -0500
Received: from [10.24.69.24] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23SBNNd4068230;
        Thu, 28 Apr 2022 06:23:23 -0500
Message-ID: <ee1c1601-6db9-70d7-401a-8f67ec406ffc@ti.com>
Date:   Thu, 28 Apr 2022 16:53:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/5] Introduce PRU remoteproc consumer API
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <rogerq@kernel.org>,
        <grygorii.strashko@ti.com>, <vigneshr@ti.com>, <kishon@ti.com>
References: <20220418104118.12878-1-p-mohan@ti.com>
From:   Puranjay Mohan <p-mohan@ti.com>
In-Reply-To: <20220418104118.12878-1-p-mohan@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Hi Mathieu,

I am writing to follow up on this patch series.
This has been on the list for the last 10 days and I have not received
any comments on it. So, does this look good to everyone?

I had solved the minor checkpatch issues from v2 so I guess this series
should be good now?

Looking forward to your comments.

Thanks
Puranjay Mohan

On 18/04/22 16:11, Puranjay Mohan wrote:
> This is the v3 of the patch series [1]. The v2 had some minor comments
> which have been addressed here.
> 
> I will be posting two more patch series which depend on this series, one to
> the soc tree and another to the networking tree. I had sent all the 3
> series, including this one as RFC [2] to get comments and to explain the
> dependencies.
> 
> The Programmable Real-Time Unit and Industrial Communication Subsystem
> (PRU-ICSS or simply PRUSS) on various TI SoCs consists of dual 32-bit
> RISC cores (Programmable Real-Time Units, or PRUs) for program execution.
> 
> There are 3 foundation components for PRUSS subsystem: the PRUSS platform
> driver, the PRUSS INTC driver and the PRUSS remoteproc driver. All were
> already merged and can be found under:
> 1) drivers/soc/ti/pruss.c
>    Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> 2) drivers/irqchip/irq-pruss-intc.c
>    Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
> 3) drivers/remoteproc/pru_rproc.c
>    Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> 
> The programmable nature of the PRUs provide flexibility to implement custom
> peripheral interfaces, fast real-time responses, or specialized data handling.
> Example of a PRU consumer drivers will be:
>   - Software UART over PRUSS
>   - PRU-ICSS Ethernet EMAC
> 
> In order to make usage of common PRU resources and allow the consumer drivers to
> configure the PRU hardware for specific usage the PRU API is introduced.
> 
> [1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20201216165239.2744-1-grzegorz.jaszczyk@linaro.org/
> [2] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/
> 
> Thanks,
> Puranjay Mohan
> 
> Roger Quadros (1):
>   remoteproc: pru: Add pru_rproc_set_ctable() function
> 
> Suman Anna (2):
>   dt-bindings: remoteproc: Add PRU consumer bindings
>   remoteproc: pru: Make sysfs entries read-only for PRU client driven
>     boots
> 
> Tero Kristo (2):
>   remoteproc: pru: Add APIs to get and put the PRU cores
>   remoteproc: pru: Configure firmware based on client setup
> 
>  .../bindings/remoteproc/ti,pru-consumer.yaml  |  70 ++++++
>  drivers/remoteproc/pru_rproc.c                | 234 +++++++++++++++++-
>  include/linux/pruss.h                         |  78 ++++++
>  3 files changed, 377 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>  create mode 100644 include/linux/pruss.h
> 
