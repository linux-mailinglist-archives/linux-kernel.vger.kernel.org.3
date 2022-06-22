Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994F655552A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376963AbiFVUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 16:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347203AbiFVUBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 16:01:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F39E3A5EC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:01:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y6so16310397plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=imArjx2CC9X+T7OtwdP7nd/oJLWqho7puwRUJOwdUT8=;
        b=MViZAFQXGVYC8ncx+RyAmuOLrbrQZkX6x/0i6IbPnUzmrHMwoNAWgQS4XHuxNvI+Ci
         G6JXbwx5pV7Meou0y8o9IBvISO8zmTXowV3V9P2irnnKMsGVqP2ehV4INCTMPClPqA9T
         UFiZq2wQHQd6Hr/Ku3/eDJs7jCBMYBQmbFYR7WQGZCymCCe7p6AhjP03Dqz47GRL5rH5
         f+LZzp22B67g0Z2MAbyj6tvEHOARn0SjtAVdFC/Lv0OhQ2NcoPUPc1PQ7eTfcFh0keMh
         pRCinVl3h54HzmvTKGN13KRMeOlJc+ge4rJCP2hwYjfpU8AeuDvZz//wIM763N9IHfPL
         XFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=imArjx2CC9X+T7OtwdP7nd/oJLWqho7puwRUJOwdUT8=;
        b=WZ7JCnhI1feB+4cEANa1LyibEReyrrbfOP/lKyFkqq5FHeLBDShcY0RKJ//DAMvlxc
         wXgKK9a4eaDMR1aQ0k6N2lhQ5AirNCTwEaPxaTX6yhOlIgMemnZ3Vr8ozCmC5j6Kbjhm
         Dob6x0me14Uzew5XWH+NVK9i/SZkvNbQlu36LHIake1T0APchyA3frdpYcafbsmMTi3Y
         WYsVdcQs5/8gU7r3fp8bzXZy4iTDuWkAx/6c6zGygwS9cvRUy88nczwmpYG/eyDllFVr
         x0rZxVxvh7MUY6maQdeaEZWQKGNQIWuDBJGtnhUh3EODCTXowX/CB/gBNRPVYIvT30oX
         aJXA==
X-Gm-Message-State: AJIora9HMHQuKXj1ar4md3Q/rX23eY37mXJhSqZm257st05S/yKHtZaS
        PWH9sgNo0T+WuVDasTXvcRw=
X-Google-Smtp-Source: AGRyM1uqe3yrSNaBQYKSnCgSfaWSU0jBjcHXa8DLATCqgVTKLngoQBW+pWUH+9RvwTZcnnbb/lzOgw==
X-Received: by 2002:a17:90b:1d88:b0:1ec:d5f6:f141 with SMTP id pf8-20020a17090b1d8800b001ecd5f6f141mr55345pjb.119.1655928080240;
        Wed, 22 Jun 2022 13:01:20 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p9-20020a63ab09000000b00408a9264b36sm13798031pgf.3.2022.06.22.13.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 13:01:19 -0700 (PDT)
Message-ID: <5f74021a-c838-fcdb-7486-ef2eee12f4ce@gmail.com>
Date:   Thu, 23 Jun 2022 05:01:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] extcon: drop unexpected word "the" in the comments
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org
References: <20220621115003.109395-1-jiangjian@cdjrlc.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220621115003.109395-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 21. 20:50, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: ./drivers/extcon/extcon.c
> line: 250
> 
> /* Find the the index of extcon cable in edev->supported_cable */
> changed to
> /* Find the index of extcon cable in edev->supported_cable */
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/extcon/extcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index d3a32b806499..0e40418ad287 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -247,7 +247,7 @@ static int find_cable_index_by_id(struct extcon_dev *edev, const unsigned int id
>  {
>  	int i;
>  
> -	/* Find the the index of extcon cable in edev->supported_cable */
> +	/* Find the index of extcon cable in edev->supported_cable */
>  	for (i = 0; i < edev->max_supported; i++) {
>  		if (edev->supported_cable[i] == id)
>  			return i;

Use captitla letter of first char as following:
- extcon: Drop unexpected word "the" in the comments

Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
