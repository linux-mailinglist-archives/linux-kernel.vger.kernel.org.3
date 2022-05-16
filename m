Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3BD5290FC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 22:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346629AbiEPTy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346243AbiEPTu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:50:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266FE43EF3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:45:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h29so27687406lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uUfVm42ZQNq+014IW1sf3DQHsLIVj6aXXsUckSeTuwM=;
        b=V+moZ65xYCfiJkcirAAUUuL5GWd5JL8+6D06wvLfUPuwIY6fNQFLXCAGe/bRJTef3D
         dDtxNiVCSGvpF6a+vuzD4/4m62cQbzbEa8GF7YowgtPbzyuEmFkzUdXjuKBlkS0V9dZn
         yfUZ0Vt/Q8KvCThJcOvDYklKjRzc7VRy+mapzNeeCaAw0lICrm+n0tgI9iRkNlBhdAgM
         c/uBJL9pO7GAr52HJyVUOvhXHfJghKczv5N1p8pOCsztPc0Zz4SA/FsN20HeHrsRzHJ4
         cn/uR0ZaUd4zFd8jIsYLDI0waodll597mK8FXXX/t2TaVZcv8Ya26f3XMJonPjDAar7F
         FQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uUfVm42ZQNq+014IW1sf3DQHsLIVj6aXXsUckSeTuwM=;
        b=Z5wYL8qXPAUjF2FbCBTfsRpDUX9iGmzgDxU5V1BFqlZw0RwZeEC+c214pEBc69nPHy
         hx8BJcY6twLM1LGNeOx24QKulkzfr1VHVIyklwDx0y82pK1eVf88EHJlwSbAG+AYQeAJ
         HYQuGFUTZ0/ZSKkEdZe4yrbXVyjgf/gS0w6bGGPsbWnfcSYlk5Y82wgG781hKeOgQ/gP
         7kl+7Hyvw+XLcBDzFMzPQMLRquqN81CPLBaEyPLclkt1SvG2CeP0xZmsGg+4Yh4z7E9n
         vnOknkuZXn5X8gpTEZOi9UvWq5IGwzjEemlUbyHR9U1PqLPwG87kLS+/lx2rTGAlvA1Y
         YVxw==
X-Gm-Message-State: AOAM530cTK6cq8J+6lF6h2mftrZG5R+Vasb/woDMuS4J0jQ5e/PAVoGZ
        dgrY21F4twhwU54NKxzn2GkBAygux+Ky/A==
X-Google-Smtp-Source: ABdhPJzhuBrUIgSvINGOPQFV34k2TU982jsDwjgoIihymBDOgC4KtnTFCODJapFZn8pyN89Sc2pNzg==
X-Received: by 2002:a05:6512:1154:b0:472:65ab:4159 with SMTP id m20-20020a056512115400b0047265ab4159mr13927604lfg.411.1652730322328;
        Mon, 16 May 2022 12:45:22 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.216])
        by smtp.gmail.com with ESMTPSA id j10-20020a2e800a000000b002539c858cccsm1424256ljg.49.2022.05.16.12.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 12:45:21 -0700 (PDT)
Message-ID: <7b926f43-8c6b-6eae-edc6-02dc16376eb0@gmail.com>
Date:   Mon, 16 May 2022 22:45:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] staging: r8188eu: fix checkpatch.pl warnings in
 rtw_pwrctrl
Content-Language: en-US
To:     Vihas Makwana <makvihas@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220516170306.6008-1-makvihas@gmail.com>
 <20220516170306.6008-3-makvihas@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220516170306.6008-3-makvihas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vihas,

On 5/16/22 20:03, Vihas Makwana wrote:
> Refactor the code to fix following warnings:
>      WARNING: Comparisons should place the constant on the right side of the test
> 
> Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> ---

[code snip]

>   		if ((pwrpriv->smart_ps == smart_ps) &&
> @@ -356,7 +356,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
>   
>   	pwrctrlpriv->LpsIdleCount = 0;
>   	pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/*  PS_MODE_MIN; */
> -	pwrctrlpriv->bLeisurePs = PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt;
> +	pwrctrlpriv->bLeisurePs =  pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE;
>   

Please remove extra space




With regards,
Pavel Skripkin
