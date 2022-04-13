Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DDD500009
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiDMUgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiDMUgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:36:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C86156
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:34:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u19so5632151lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v/vz88+MzPaF9+gxdJjGj9X24km3lwGNweK9uHwzCBE=;
        b=LcP3wgBirZj9Ean8yRjuduXu8kcCP+8ZJJviSlkM0WcUGQVUW9r3Beube3Q/w8167U
         fnHJSfeViDL5ZLnwl2lHsNXTGGa/t9CWxXeKtalepowghtRZk9bEIHwhvd5q5oqJpLm7
         VVFbNA4biJ541tbDKQ8QEPuLizcbl8zNut09yKmxiQc+gdabofYoBL8Nt/FWJIgzbD3c
         LFVVIa5vbG8JX4fcNjf73J6MyM+b4z/Cv/+MN08wa8Qnp9GrySucokoF6dA9F2VSPVwp
         +5jQn+c2Oe42MgA5kJyoh+SlTHli796o4nSdsTdXLAhnhdgJ8nRebGXKgVWJ73xQo/im
         61zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v/vz88+MzPaF9+gxdJjGj9X24km3lwGNweK9uHwzCBE=;
        b=ygWSNs4dhkYNi4w2InDxrEOpAbyqDNzdT1M3+VwGf9TSBTILCUKiqvqoshZ3rnLjxt
         lVZq+zbOeBiAw9KfUyRwbadZrpC1bJJ68z3zHcW66JvGZGc5SWoCrLVf1WCXLVkQ1Go/
         ILHc3vaOp4fU0n/Gad52FGRftc0fu0ZxD8yWKkEzV4chURfeDc35gPtCJhv8aM6/7sww
         UpivK0mD8twGlUetpA6jx/3dOrR77ypi6Ysxv26vKyCfh44l6wLtNgCPfv/EGjtB4jST
         dEc9dwKdSTRAy8tYZCu1YnfRrIakRrOPb5+SCzvd/2FfcCnzQN2wI/WnEMDpX4L6zek9
         xPqg==
X-Gm-Message-State: AOAM531IeUFjmZ7a6lbdaADIhC0g65JexTr7oXiWhZdsfE8XQKflsq0U
        RdT9ZmXpWNEa/mYabOunLJU=
X-Google-Smtp-Source: ABdhPJxN01CWnr32DOv6C3yB1Nh97ZYIuWrEWuN2tQ9CtSTD4i8eVnP0H+vGx/FX7bTWphFt6EEtuQ==
X-Received: by 2002:a05:6512:1322:b0:44b:75d:ac8 with SMTP id x34-20020a056512132200b0044b075d0ac8mr28290383lfu.213.1649882057138;
        Wed, 13 Apr 2022 13:34:17 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id e18-20020a196752000000b0046b8d3cd18csm2754lfj.55.2022.04.13.13.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 13:34:16 -0700 (PDT)
Message-ID: <e32f1f61-127c-3e90-0f06-7b60cdca9ef7@gmail.com>
Date:   Wed, 13 Apr 2022 23:34:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/6] staging: r8188eu: replace spaces with tabs
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <cover.1649880454.git.jhpark1013@gmail.com>
 <c2d719eba2a374be573034022218a098e4db9e77.1649880454.git.jhpark1013@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <c2d719eba2a374be573034022218a098e4db9e77.1649880454.git.jhpark1013@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaehee,

On 4/13/22 23:11, Jaehee Park wrote:
> Use tabs instead of spaces. Issue found with checkpatch.
> WARNING: suspect code indent for conditional statements
> 
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_mlme.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index b943fb190e4c..7a90fe826d1d 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -722,7 +722,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
>   			pmlmepriv->to_join = false;
>   			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
>   			if (s_ret == _SUCCESS) {
> -			     _set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
> +				_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
>   			} else if (s_ret == 2) { /* there is no need to wait for join */
>   				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
>   				rtw_indicate_connect(adapter);

Not related to your patch, but looks like `s_ret` can't be 2.

rtw_select_and_join_from_scanned_queue

   rtw_joinbss_cmd

     rtw_enqueue_cmd
       _rtw_enqueue_cmd <- always returns SUCCESS


Other functions from calltrace may return _FAIL, but _FAIL is not equal 
2, right?



With regards,
Pavel Skripkin
