Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7142653B582
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiFBI5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiFBI5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:57:32 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CAB1C4249;
        Thu,  2 Jun 2022 01:57:29 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2528kAW9032493;
        Thu, 2 Jun 2022 10:57:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=hcNgPtnIfcimLXDxpWweLtRx8lzUM3MbOgkpTU0EGqQ=;
 b=b8qgBokjz71ZqQ7LTeWQ/zNtwEPB9EguJNBcJFZkjM+LdfA21kDzLlagXl8vX/3UgNUf
 FSciEY/pIAa8QUa7he7JRYQGWLomUiE4S+HGEfjqXrRbSLmYvYIKRT/CVzgPhXFenAYD
 IMfQgLtl2TlcejC6UqIjtNPweSlFGgxbVQ57ut0XlDVEhc7NpJPahxH+yNCvIi6HuOHW
 xl2+tAEROc7L3aa65/JRvuZPy+cAs3QE+DIkjTF4GnxPjFL9o89YiWewco3RPDy2hi6h
 S7Z7dn5uA6E7W0ggm/L76k0sbbPcW7klQbo4QI/CROOIl7grQOVur8MeRlUl0NclWLnB pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3get03g2dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 10:57:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A6CA410002A;
        Thu,  2 Jun 2022 10:57:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A06A8216EF4;
        Thu,  2 Jun 2022 10:57:20 +0200 (CEST)
Received: from [10.211.11.162] (10.75.127.49) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 2 Jun
 2022 10:57:20 +0200
Message-ID: <83fff5a2-7f7d-8a1b-0308-7d2e0138d407@foss.st.com>
Date:   Thu, 2 Jun 2022 10:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [0/2] spi: stm32-qspi: Remove unused parameters
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20220602085556.348139-1-patrice.chotard@foss.st.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220602085556.348139-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_01,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this series has been submitted with inccorect commit title.

I will resubmit this series

Patrice

On 6/2/22 10:55, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> This series cleans up spi-stm32-qspi driver by removing unused parameters
> 
> Patrice Chotard (2):
>   spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
>   spi: stm32-qspi: Remove stm32_qspi_wait_cmd() unused parameter
> 
>  drivers/spi/spi-stm32-qspi.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
