Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12668552049
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbiFTPTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbiFTPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:19:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27028E3C;
        Mon, 20 Jun 2022 08:12:26 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KEQU7b024436;
        Mon, 20 Jun 2022 17:12:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5rxaXKrnxGJg+Tuh7+UheAYB9LVA5fqJwlB51AZL1IQ=;
 b=eXd923Q/3qtdj2Ll3aAymendGBBqcWVD4VWvFM6GeiwhgJmIWRQDPFlvuHE+kMUJ1S4g
 XBFp6dysrtVvEuQU2MYdIoDKpNvPPTQiDhIlpgbSOWsymVV2nzNve4zmSeas6ggTKMd2
 fpUyh9UFMp9S/oWZwJ84vco1v1AN8qpbApOqAUvEdnOSAvwuWP+7U1E/lEiVsnYhlyYW
 cduOBJmaRu5UMoIPpLslGo/g5+Q3X29sRGM4HafYpf+WMyMl53j1fE77GiuilCEm3SCx
 ZtGmvC/EiXOzwkOmZzFLPCq05mKDJek6C1StGcVY5v4YQM3MRdWQl1+q8pWhIrbUvioy kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gs71tm62q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 17:12:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9872E10002A;
        Mon, 20 Jun 2022 17:12:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1754422D18A;
        Mon, 20 Jun 2022 17:12:05 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.118) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 20 Jun
 2022 17:12:04 +0200
Message-ID: <ab33d6d5-cedf-fb01-77a2-c56e8b6b1b49@foss.st.com>
Date:   Mon, 20 Jun 2022 17:12:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: rcc: stm32: select the "secure" path for
 stm32mp13
Content-Language: en-US
To:     <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
References: <20220613093815.18334-1-alexandre.torgue@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220613093815.18334-1-alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.118]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 11:38, Alexandre Torgue wrote:
> Like for stm32mp15, when stm32 RCC node is used to interact with a secure
> context (using clock SCMI protocol), a different path has to be used for
> yaml verification.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> ---
> 
> Hi Rob, Krzysztof,
> 
> If you agree with this patch, I'll apply it directly in my STM32 tree.
> 
> Thanks
> Alex
> 
> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> index f8c474227807..242fe922b035 100644
> --- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> @@ -78,6 +78,7 @@ if:
>         contains:
>           enum:
>             - st,stm32mp1-rcc-secure
> +          - st,stm32mp13-rcc
>   then:
>     properties:
>       clocks:

Applied on stm32-next.
