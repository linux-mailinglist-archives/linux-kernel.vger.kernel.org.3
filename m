Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C282646B77D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhLGJi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:38:58 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:43876 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234100AbhLGJiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:38:46 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B793qL2003535;
        Tue, 7 Dec 2021 10:35:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=OZRzd7CtLaEEjK8QBafsNuOEhymPrvAmrI4t5/GSY/w=;
 b=JgX3uBNAC90HS8ZVrXp5TOxGhXo8aaSIEw2Io3MvTiWAXQnuaVz3deHlSeq5DLRHG06l
 Bel6lUvpcQbZmG0QmalZuthiSiD6wDqecUUL1LdPZuXGm7c/L6+1ZaWWWoXDw21ogB/4
 3wV2AWftg6dEyrhs0zH6UkTdRqscGXRLb2t6VcrjDhCKj1O3hyXniJrNweyN3x2hHt0L
 24DVhrM57iLz945Ep+Eo3U5YzBbovGQfh5zOO06BTcQWFyZv6U/kEFO8PzCQj0pPP6wn
 WPqthXhp4jxSBJkm07s+wE1mKJsY3TabHxrPWj6hfkDpp9+Pl5WmPXOfSfkkEscpUlk8 tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csmx0m6ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 10:35:04 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B1A2810002A;
        Tue,  7 Dec 2021 10:35:03 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88C0D2178C0;
        Tue,  7 Dec 2021 10:35:02 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec
 2021 10:35:02 +0100
Subject: Re: [PATCH] media: c8sectpfe: remove redundant assignment to pointer
 tsin
To:     Colin Ian King <colin.i.king@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211205003745.227491-1-colin.i.king@gmail.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <b8d7a9c9-7108-8141-cd22-0759b821e4c4@foss.st.com>
Date:   Tue, 7 Dec 2021 10:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211205003745.227491-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_03,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin

On 12/5/21 1:37 AM, Colin Ian King wrote:
> Pointer tsin is being assigned a value that is never read. The assignment
> is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
> index 02dc78bd7fab..e1f520903248 100644
> --- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
> +++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
> @@ -930,12 +930,8 @@ static int configure_channels(struct c8sectpfei *fei)
>  
>  	/* iterate round each tsin and configure memdma descriptor and IB hw */
>  	for_each_child_of_node(np, child) {
> -
> -		tsin = fei->channel_data[index];
> -
>  		ret = configure_memdma_and_inputblock(fei,
>  						fei->channel_data[index]);
> -
>  		if (ret) {
>  			dev_err(fei->dev,
>  				"configure_memdma_and_inputblock failed\n");
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
