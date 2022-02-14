Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2B24B4D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348746AbiBNKti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:49:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiBNKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:49:13 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C940BDA72;
        Mon, 14 Feb 2022 02:12:13 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21E86urF026746;
        Mon, 14 Feb 2022 11:11:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=MpTqBNhX+HIyoyjXnQ6/DBGf/cO04PKi4xy5WrWMQtM=;
 b=55UHFt0xRaAGpxn2Pr8CS2hOQbO5daWb1jFg7gbjWrrTxF8SuQ8Fr5X4YLwUJ18r0iG+
 a05X2ZlAldKYLmZDICq/fH6FuipuQBmWduzK52C1XKBDkQagpQHZiDLR2PiXJKAO8n6H
 B1WVk9i5XcVranVUk+W43HboAlMqmSqrGQ99Qdly5zkSfP0Y16cfNJNdCBDXObFLTJ9z
 PuoTnKNH9lgi14OtayFnvMc/QeAHCsLWEQf2olS4s3nxcF22yucBEYez0a7N0fYOZ9YP
 GBFsDQdNumGCo9FjFnB0y3vTjfY/ySiJeXmUBrRswVJ5USVkxDs4Y0Wv7eTNz4SL8BnB Yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e74c3bs05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 11:11:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9646910002A;
        Mon, 14 Feb 2022 11:11:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C004219DED;
        Mon, 14 Feb 2022 11:11:57 +0100 (CET)
Received: from [10.48.0.252] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 14 Feb
 2022 11:11:57 +0100
Message-ID: <c3c1d310-19f0-889b-04b5-f3628e09b3bf@foss.st.com>
Date:   Mon, 14 Feb 2022 11:11:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] ARM: dts: stm32: remove timer duplicate unit-address
 on stm32f7 series
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, <robh+dt@kernel.org>
CC:     <olivier.moysan@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1644403729-22665-1-git-send-email-fabrice.gasnier@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <1644403729-22665-1-git-send-email-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_02,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 2/9/22 11:48, Fabrice Gasnier wrote:
> Remove a series of warnings seen when building with W=1, like:
> Warning (unique_unit_address): /soc/timer@40000c00: duplicate unit-address
> (also used in node /soc/timers@40000c00)
> 
> This approach is based on some discussions[1], to restructure the dtsi
> and dts files.
> [1] https://lore.kernel.org/linux-arm-kernel/Yaf4jiZIp8+ndaXs@robh.at.kernel.org/
> 
>   arch/arm/boot/dts/stm32746g-eval.dts  | 12 +++++++++
>   arch/arm/boot/dts/stm32f746-disco.dts | 12 +++++++++
>   arch/arm/boot/dts/stm32f746.dtsi      | 47 -----------------------------------
>   arch/arm/boot/dts/stm32f769-disco.dts | 12 +++++++++
>   4 files changed, 36 insertions(+), 47 deletions(-)
> 

Series applied on stm32-next.

Cheers
Alex
