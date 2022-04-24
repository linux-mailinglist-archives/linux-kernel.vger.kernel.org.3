Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9768450D3BC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiDXQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiDXQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:58:20 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5245513D55;
        Sun, 24 Apr 2022 09:55:15 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 20BF5209D7EB
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH -next] ata: palmld: fix return value check in
 palmld_pata_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
CC:     <damien.lemoal@opensource.wdc.com>, <arnd@arndb.de>,
        <b.zolnierkie@samsung.com>, <robert.jarzmik@free.fr>
References: <20220424093420.2129779-1-yangyingliang@huawei.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <24916b73-15dc-1ab7-7d5d-532d177fecec@omp.ru>
Date:   Sun, 24 Apr 2022 19:55:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220424093420.2129779-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   You should CC: me on the PATA driver patches, not Bart -- he no longer maintains
the PATA drivers.

On 4/24/22 12:34 PM, Yang Yingliang wrote:

> If devm_platform_ioremap_resource() fails, it never return
> NULL pointer, replace the check with IS_ERR().
> 
> Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
[...]

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

MBR, Sergey
