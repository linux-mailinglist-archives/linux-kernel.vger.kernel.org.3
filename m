Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739C553B117
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiFBBG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiFBBGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:06:55 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5F2739
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 18:06:49 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 2 Jun
 2022 09:06:50 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 2 Jun
 2022 09:06:47 +0800
Message-ID: <76735081-4d9a-9aa5-f8bf-0c86f2e3a8db@meizu.com>
Date:   Thu, 2 Jun 2022 09:06:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] coda: remove unused variable
To:     Jan Harkes <jaharkes@cs.cmu.edu>, <coda@cs.cmu.edu>
CC:     <codalist@coda.cs.cmu.edu>, <linux-kernel@vger.kernel.org>
References: <1654070283-7216-1-git-send-email-baihaowen@meizu.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <1654070283-7216-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/6/1 下午3:58, Haowen Bai 写道:
> The variable insize is initialized but never used otherwise.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  fs/coda/upcall.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
> index 59f6cfd06f96..c214b424426d 100644
> --- a/fs/coda/upcall.c
> +++ b/fs/coda/upcall.c
> @@ -477,10 +477,9 @@ int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
>  {
>          union inputArgs *inp;
>          union outputArgs *outp;  
> -	int insize, outsize, error;
> +	int outsize, error;
>  	int iocsize;
>  
> -	insize = VC_MAXMSGSIZE;
>  	UPARG(CODA_IOCTL);
>  
>          /* build packet for Venus */
Sorry, ignore this patch.

-- 
Haowen Bai

