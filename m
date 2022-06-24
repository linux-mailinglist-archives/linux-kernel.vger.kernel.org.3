Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC8559FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiFXSBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiFXSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:01:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653284D9CE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:01:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ej4so4520926edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FihH+wFZdHJzWdAHO5W9L+MEXrCjKPFXmbCyP+M30fc=;
        b=CfgI1rTukijr/p19JI7e9i/2E8rGCaNwtR63+EGnzZQdw3kfOo75LFCH8sm5OrZU+h
         yVfD+TuO+K2UfqyURxxTXLnV2sH0dBr3kGYBdUvFM2+sxlbxuYm3YI57KUSBXi4L3Q+J
         R33opJx/huDwfocZTx3naQjd6b0xK4xVIPsE52Cci0GHpW79/doJv6s9Bw+Ni853gTkv
         xV5t/D7uKH9Psp46Kh1C9RXSEfBDE5cPmYDE07Ss9/euZrTHI+6lZdAVhWOouc55yd/M
         uwnwrOJ7OOMBHbMLdWt1Iiv4GlnD7amK/jWdG4zmm0Bx1Sv7zIyX5QJY1yVg8dUFxoVX
         mT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FihH+wFZdHJzWdAHO5W9L+MEXrCjKPFXmbCyP+M30fc=;
        b=VTxWuYY+cSC5EsBLjIVsqpTBVXU5Fctktn6onrbUw6Xsh4bndiGVahFbRsr7nv3+Vr
         SjHrCmOC+PPZ4V2OPJ/hnzdmHAdrjphrGzIqeV6jeogR+TXOfK3J3zBkmNSjz3tUrNxu
         2iiwKimzNzHO2pkzVRKupJZcsoV1YHtfJp0G3X5/LzaTBRgIXhQlbLzcs71IE18xqL1+
         NNLK6kK0wkclcg2kbKR0uutyRjJfMrxXHSGOXfKdkxO3n0FD+60H9q2CGFpfeOoEkb+w
         nnEG2IoLSXupBvpLkQoJoZQAxyHev5ghRBxmKlCoCTjX5ur19Wjlb1ve0SOn1G3bKwbt
         ligw==
X-Gm-Message-State: AJIora9jV0AkquVcJloTK6OxNvTkOBXaFO0/uVXv6iD/CcNHyvnBOY0J
        0+hiCeb4Autlmoe4hQItUuU=
X-Google-Smtp-Source: AGRyM1td++ElRAofxZa9qKQ/SuYdcx8iXCAN3JnpO5oQCuWWgdSayAZaLIykYwWrH0+Plit+9wT68g==
X-Received: by 2002:a05:6402:2706:b0:430:6238:78d5 with SMTP id y6-20020a056402270600b00430623878d5mr329759edd.413.1656093702880;
        Fri, 24 Jun 2022 11:01:42 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906298a00b00705cd37fd5asm1489202eje.72.2022.06.24.11.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 11:01:42 -0700 (PDT)
Message-ID: <50badb0b-0cac-d935-02bf-f05403f6d765@gmail.com>
Date:   Fri, 24 Jun 2022 20:01:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] staging: r8188eu: core/rtw_recv.c: clean up nested if
 statements
Content-Language: en-US
To:     Chang Yu <marcus.yu.56@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220624144526.437322-1-marcus.yu.56@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220624144526.437322-1-marcus.yu.56@gmail.com>
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

On 6/24/22 16:45, Chang Yu wrote:
> Combine two nested if statements into a single one to fix indentation
> issue and improve readability, as suggested by checkpatch.pl
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
> Changes in v4:
>   - Added missing change log and resend
> 
> Changes in v3:
>   - Modified subject and description to be more descriptive
> 
> Changes in v2:
>   - Added a pair of parentheses to make operator precedence explicit
> 
> 
>   drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 6564e82ddd66..020bc212532f 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -166,10 +166,8 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
>   
>   	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
>   
> -	if (padapter) {
> -		if (pfree_recv_queue == &precvpriv->free_recv_queue)
> -				precvpriv->free_recvframe_cnt++;
> -	}
> +	if (padapter && (pfree_recv_queue == &precvpriv->free_recv_queue))
> +		precvpriv->free_recvframe_cnt++;
>   
>   	spin_unlock_bh(&pfree_recv_queue->lock);
>   

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
