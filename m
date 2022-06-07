Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067F53F574
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 07:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiFGFEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 01:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbiFGFEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:04:21 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595E8C1ECE;
        Mon,  6 Jun 2022 22:04:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25754BWT013755;
        Tue, 7 Jun 2022 00:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654578251;
        bh=LuyJp6N2+OSRRSCMTgRGlAsY50dcRaUtJNXh97nhDcw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LGQLeIUFehUMVRddXGsbBAUwn98Txzayy1mu+Htw/cWRp1SqI7xa54Z0vWJw1v8VS
         PoC03iinNDyZRo2HttU17al509mLTTroHnvyrlXczBgGM/in0zgvi9xB+2A1bBr5Gx
         3XmqiVcpApZ2STi6dLMlVI3JcmfB5Am4WsrqMDmI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25754Bro003108
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jun 2022 00:04:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Jun 2022 00:04:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Jun 2022 00:04:10 -0500
Received: from [172.24.220.119] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25753v3M120195;
        Tue, 7 Jun 2022 00:03:59 -0500
Message-ID: <37bbd74e-17e2-5b45-43da-f1103dd0c752@ti.com>
Date:   Tue, 7 Jun 2022 10:33:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/6] Introduce PRU remoteproc consumer API
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <rogerq@kernel.org>,
        <grygorii.strashko@ti.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        <robh@kernel.org>
References: <20220603121520.13730-1-p-mohan@ti.com>
 <20220606155612.GA809345@p14s> <20220606161518.GB809345@p14s>
From:   Puranjay Mohan <p-mohan@ti.com>
In-Reply-To: <20220606161518.GB809345@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 06/06/22 21:45, Mathieu Poirier wrote:
> On Mon, Jun 06, 2022 at 09:56:12AM -0600, Mathieu Poirier wrote:
>> I have started to review this set, comments will come over the next few days.  I
>> will clearly inform you when I am done reviewing.
> 
> This patch is giving me several checkpatch warnings that should have been caught
> before sending the patches out to the mailing list.  As such I will not review
> this work and seriously considering adding your next revision at the very bottom
> of my queue.

I am sorry for this. I had introduced the 6th patch in v4 and it is
giving these errors. I have fixed them and sent a v5. Please don't move
the v5 to the bottom of the queue. I will be extra cautious from next time.

Thanks,
Puranjay Mohan

> 
>>
>> Thanks,
>> Mathieu
>>
>> On Fri, Jun 03, 2022 at 05:45:14PM +0530, Puranjay Mohan wrote:
>>> This is the v4 of the patch series [1]. The v3 had some comments
>>> on the DT patch that have been addressed here. The 6th patch in this
>>> series was missed in the previous versions, so, it has been added now.
>>>
>>> I have posted two more patch series that depend on this series, one to
>>> the soc tree and another to the networking tree. I had sent all the 3
>>> series, including this one as RFC [2] to get comments and to explain the
>>> dependencies.
>>>
>>> The Programmable Real-Time Unit and Industrial Communication Subsystem
>>> (PRU-ICSS or simply PRUSS) on various TI SoCs consists of dual 32-bit
>>> RISC cores (Programmable Real-Time Units, or PRUs) for program execution.
>>>
>>> There are 3 foundation components for PRUSS subsystem: the PRUSS platform
>>> driver, the PRUSS INTC driver and the PRUSS remoteproc driver. All were
>>> already merged and can be found under:
>>> 1) drivers/soc/ti/pruss.c
>>>    Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> 2) drivers/irqchip/irq-pruss-intc.c
>>>    Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
>>> 3) drivers/remoteproc/pru_rproc.c
>>>    Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>>>
>>> The programmable nature of the PRUs provide flexibility to implement custom
>>> peripheral interfaces, fast real-time responses, or specialized data handling.
>>> Example of a PRU consumer drivers will be:
>>>   - Software UART over PRUSS
>>>   - PRU-ICSS Ethernet EMAC
>>>
>>> In order to make usage of common PRU resources and allow the consumer drivers to
>>> configure the PRU hardware for specific usage the PRU API is introduced.
>>>
>>> [1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220418104118.12878-1-p-mohan@ti.com/
>>> [2] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/
>>>
>>> Thanks and Regards,
>>> Puranjay Mohan
>>>
>>> Roger Quadros (1):
>>>   remoteproc: pru: Add pru_rproc_set_ctable() function
>>>
>>> Suman Anna (2):
>>>   dt-bindings: remoteproc: Add PRU consumer bindings
>>>   remoteproc: pru: Make sysfs entries read-only for PRU client driven
>>>     boots
>>>
>>> Tero Kristo (3):
>>>   remoteproc: pru: Add APIs to get and put the PRU cores
>>>   remoteproc: pru: Configure firmware based on client setup
>>>   remoteproc: pru: add support for configuring GPMUX based on client
>>>     setup
>>>
>>>  .../bindings/remoteproc/ti,pru-consumer.yaml  |  69 +++++
>>>  drivers/remoteproc/pru_rproc.c                | 254 +++++++++++++++++-
>>>  include/linux/pruss.h                         |  78 ++++++
>>>  3 files changed, 396 insertions(+), 5 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>>>  create mode 100644 include/linux/pruss.h
>>>
>>> -- 
>>> 2.17.1
>>>
