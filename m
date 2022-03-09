Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB34D2AEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiCIIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiCIIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:52:24 -0500
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D17162016;
        Wed,  9 Mar 2022 00:51:20 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 00A442323C37
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <c3bc54ce-3a13-e0d7-97e6-bd4d553f577c@omp.ru>
Date:   Wed, 9 Mar 2022 11:51:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH V3] ata: pata_pxa: Use platform_get_irq() to get the
 interrupt
To:     <cgel.zte@gmail.com>, <damien.lemoal@opensource.wdc.com>
CC:     <chi.minghao@zte.com.cn>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zealci@zte.com.cn>
References: <d1dfb244-eda3-b5c6-c6bd-c0294a9a4a94@opensource.wdc.com>
 <20220309072834.2081944-1-chi.minghao@zte.com.cn>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <20220309072834.2081944-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.2022 10:28, cgel.zte@gmail.com wrote:

> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> v1->v2:
>      - Use more specific in the subject: ata: pata_pxa:
>      - Switch to returning 'irq'
> v2->v3:
>      - drop the unlikely()
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
