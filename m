Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D953528447
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbiEPMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiEPMft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:35:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E430B101E4;
        Mon, 16 May 2022 05:35:48 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24GCZjSb028649;
        Mon, 16 May 2022 07:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652704545;
        bh=/0u+9KzA8iafIXTx/LF596vcL7D0tHPBH+q6NdMh6cY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=TMSdLkVwK5GhyFLSP3s5OWKhg4knI96FUrwxaCIVbwtljcHDyD+hHmjHO3T46V8fe
         woavz7wA6oyRW2Qyaz0n7uip1HS3EyOV9ZB1I9+uCyYSlBt9HKHz4ZlNrQpYCN4R+s
         7596eT/NQ7QuUK3ece6x09Y9TXRU1P2sVtPu6VNU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24GCZjld120787
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 May 2022 07:35:45 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 16
 May 2022 07:35:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 16 May 2022 07:35:44 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24GCZfr1011768;
        Mon, 16 May 2022 07:35:42 -0500
Message-ID: <de237f2c-6630-2f63-e1da-915ab55a1a7c@ti.com>
Date:   Mon, 16 May 2022 18:05:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: pru: Update bindings for K3
 AM62x SoCs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Suman Anna <s-anna@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220427083509.14458-1-kishon@ti.com>
 <20220427083509.14458-2-kishon@ti.com>
 <7bc6fb49-ae7e-d270-b2a4-a14a1d933d61@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <7bc6fb49-ae7e-d270-b2a4-a14a1d933d61@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 28/04/22 11:48, Krzysztof Kozlowski wrote:
> On 27/04/2022 10:35, Kishon Vijay Abraham I wrote:
>> Update the PRU remoteproc bindings for the PRU cores on AM62x SoCs.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>> index d7c3a78e37e6..e351550b012c 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
>> @@ -47,6 +47,7 @@ properties:
>>        - ti,j721e-pru    # for PRUs in K3 J721E SoC family
>>        - ti,j721e-rtu    # for RTUs in K3 J721E SoC family
>>        - ti,j721e-tx-pru # for Tx_PRUs in K3 J721E SoC family
>> +      - ti,am625-pru    # for PRUs in K3 AM62x SoC family
> 
> Looks like out of order.

yes, this is out of sync with the existing format binding. I'll send a
patch fixing it.

Thanks,
Kishon
