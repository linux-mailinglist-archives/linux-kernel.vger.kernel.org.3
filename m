Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9755727D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiFWFLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiFWFK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:10:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680622BB0C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:58:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ay16so19197098ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eoUDrMh+erUbdaGJmsTl+ZRL/9QjZmm3J/nLPRs3FRA=;
        b=pdeYcyzIM/EeuiIsOGwFOug2CFDdImgKiroLQPKSUymMzgHK9YYCTF2BAEsz6plaEM
         z0t15pKe5c+FRjMrZ4RmmazpMaPT6a1ytZfgwbCxLAmQoceyLHCTouUvmwJhA5HnLfd8
         g0xY9rpDI7/aCcCgsX0C9LS/458kRbfPQhI5W+bQK1qtZDxfmMrFWwPLb4GqYV4ZQvu1
         zTG2z8MozpRuOheZ0gHBhjs2Z1hN3C6t5GSw1SIwCKmVidLUp60WvgQLkQGS+WORZ3Th
         dNY1bsxYk6MAH3rTqsmDEhn6DY5QnO4wYb+BCh9wDLUkxKF2zuZGvW9TN2wuc+BElU02
         /M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eoUDrMh+erUbdaGJmsTl+ZRL/9QjZmm3J/nLPRs3FRA=;
        b=TUvJ1WzqXwNwG0baoqUp+NHgD+gE01ct3BEhn5u1zAVC9x1QTxEzLXWg0dDyRmw3mV
         Zhivc7Qry4juCzXWy6bpt/iDk+9/kZZZ1hOYzcb0NkNWPS3ib9WFGF9SAETKjqDKdeN7
         OOPJtVoLokjpPfSD9P7LBDxl3LaFV7UpW70Ayu2YmHcjNt8/svP8TYLwFnCpIYWNSQiE
         pUyPptsSEnA2jkXKJLkzBL1fjcUXOKI0iWGk2s8sCn9VtAjRtUPbL2mFS/m6REJb0HBb
         4bwDJ0Xueevc6U1dSZ2Ed7o2b+qnF+lTJ+0d+OMwUkmqb+PeXZs95Yi7cWBIu/P3tdmQ
         Nn7Q==
X-Gm-Message-State: AJIora/Pnb8TevOy1mJXEu9WZa+DzdQmDmVyBrhtDtRmAERx9XVY+IkI
        G1AIuFbUKBb8NZZN8GsA/Oc=
X-Google-Smtp-Source: AGRyM1unO018+yZqKcHgMCl7hjTKn1obDbpp6FC73SYGcurEyYlhY8u1mzBcFu9wOCW10r6IW2/AfQ==
X-Received: by 2002:a17:907:3f04:b0:6e8:4b0e:438d with SMTP id hq4-20020a1709073f0400b006e84b0e438dmr6341869ejc.391.1655960312999;
        Wed, 22 Jun 2022 21:58:32 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6923:8d97:93cc:4023:b7a9? (p200300c78f2e69238d9793cc4023b7a9.dip0.t-ipconnect.de. [2003:c7:8f2e:6923:8d97:93cc:4023:b7a9])
        by smtp.gmail.com with ESMTPSA id ff10-20020a1709069c0a00b006fec69696a0sm9970539ejc.220.2022.06.22.21.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 21:58:32 -0700 (PDT)
Message-ID: <d50c16c1-0bc2-fdc4-16ab-0c27df824ffb@gmail.com>
Date:   Thu, 23 Jun 2022 06:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] staging: r8188eu: combine nested if statements into one
Content-Language: en-US
To:     Chang Yu <marcus.yu.56@gmail.com>, Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220623031515.402691-1-marcus.yu.56@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220623031515.402691-1-marcus.yu.56@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 05:15, Chang Yu wrote:
> -	if (padapter) {
> -		if (pfree_recv_queue == &precvpriv->free_recv_queue)
> -				precvpriv->free_recvframe_cnt++;
> -	}
> +	if (padapter && pfree_recv_queue == &precvpriv->free_recv_queue)
> +		precvpriv->free_recvframe_cnt++;

Hi

tested with:
#include <stdio.h>
int main() {
     char padapter = 1;
     int pfree_recv_queue = 256;
     int free_recv_queue = 256;

     if (padapter) {
     	if (pfree_recv_queue == free_recv_queue)
             printf("Executed before patch: 
precvpriv->free_recvframe_cnt++;\n");
     }

     if (padapter && pfree_recv_queue == free_recv_queue)
		printf("Executed after patch: precvpriv->free_recvframe_cnt++;\n");

    return 0;
}

Seems to work. But the rules which operation is done first && or == are 
not too easy. I would prefer to have:

if (padapter && (pfree_recv_queue == free_recv_queue))

So it is very easy to read what is evaluated first.

But this is just my opinion and does not have to be right.

Thanks for your patch.

Bye Philipp
