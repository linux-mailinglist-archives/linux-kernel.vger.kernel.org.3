Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7BA597734
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbiHQT6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiHQT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:58:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1B2EB3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:58:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id j8so26360782ejx.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=H8RqMJpz3gpVJV4o2tIE2vyCb5Bbg07Gt0ZIJQfJ7eg=;
        b=N483dwnSlNlIj5QQoI3T+GQ6c9rb7Nz8l//rbtlK3VMCFUfb7BDg2jezE7VXKYIsnR
         HzCewBDWy3a0o6AJuh2I2d72CA6zMtiOssENMLZabUudnEGNfbJfD2R4cHfg3mBjxf7j
         ploY4w0dOb3Op/F2uUxeJYu1vMnzbCtmVDy55sWSuLQycgZzrdQNQEFOgBA3ZQpuKbrQ
         g9yn3hQGXa307Qt7Q50IvaBZtn4Kmxw2SM97JYoQ/qNJ2FfgTwoZm9Pky3DcQhgy1/W5
         KrI7UEgEWsdXrv+/zNDeBV1QvofwIl6lYQsa/4Mm1B51lPiPRX1fFDgJUqqQk5TuUjfE
         QLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=H8RqMJpz3gpVJV4o2tIE2vyCb5Bbg07Gt0ZIJQfJ7eg=;
        b=4YRorlJc9CQKrBe6io4Gmow2YEmxonVcvxaNdJr18mU95TPqp42NP+PwIAXB6nUHZh
         7x3m1fBJnAZj0N7SC5e8JLUwvjPWWPeIRNIxgeaI8x2lblZ4gxViR66b4DGPGsMeyaoH
         VflyjwqROZKy7afu0bYsXDqaxV5LZQ8yt4Zc4Aj+P4oasM/sKf3U5hFad09o5eu2aNWb
         ofiwF16Ient9xTycv0YUXzTSv+VQGxEnSu1iSvYE56rF92jg3SgR2/dL8rIaXCe36qie
         03VF441kgE/i8qsWpom94Xxi2ZoBkp1GPXJH0cvW4G3CGlyCrnY7bO+JsZwwDw4/AbZp
         8F5w==
X-Gm-Message-State: ACgBeo3w+F7lCNZDwVmtdKMJYdl8UvQBXQZhfPPm6udeido1D6rJX81P
        A2FbEsOZhoWBIGA8IBE9XLE=
X-Google-Smtp-Source: AA6agR640mEDqJ4rtTRIJ24ohzCzH0cDMNuXNS19JwBALVLnYNkCY9sWu6MXFQL1FpJfIGDLyuaWFw==
X-Received: by 2002:a17:907:1361:b0:730:8f59:6434 with SMTP id yo1-20020a170907136100b007308f596434mr17909658ejb.745.1660766288991;
        Wed, 17 Aug 2022 12:58:08 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6948:e090:6ae6:365f:722? (p200300c78f2e6948e0906ae6365f0722.dip0.t-ipconnect.de. [2003:c7:8f2e:6948:e090:6ae6:365f:722])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090623e900b007304bdf18cfsm7146005ejg.136.2022.08.17.12.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 12:58:08 -0700 (PDT)
Message-ID: <2678f750-34a2-f0fa-4783-143c3fc88924@gmail.com>
Date:   Wed, 17 Aug 2022 21:58:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: remove rtw_endofpktfile()
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220817063223.8140-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220817063223.8140-1-straube.linux@gmail.com>
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

On 8/17/22 08:32, Michael Straube wrote:
> The function rtw_endofpktfile() just checks for pkt_len == 0.
> Remove rtw_endofpktfile() and merge the check into the caller to
> improve readability and simplify the driver code.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_xmit.c      |  2 +-
>   drivers/staging/r8188eu/include/xmit_osdep.h |  1 -
>   drivers/staging/r8188eu/os_dep/xmit_linux.c  | 11 -----------
>   3 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index 24401f3ae2a0..48631ef56114 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -970,7 +970,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
>   
>   		frg_inx++;
>   
> -		if (bmcst || rtw_endofpktfile(&pktfile)) {
> +		if (bmcst || pktfile.pkt_len == 0) {
>   			pattrib->nr_frags = frg_inx;
>   
>   			pattrib->last_txcmdsz = pattrib->hdrlen + pattrib->iv_len + ((pattrib->nr_frags == 1) ? llc_sz : 0) +
> diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
> index 00658681fef9..130dc06efe73 100644
> --- a/drivers/staging/r8188eu/include/xmit_osdep.h
> +++ b/drivers/staging/r8188eu/include/xmit_osdep.h
> @@ -40,7 +40,6 @@ void rtw_os_xmit_resource_free(struct adapter *padapter,
>   uint rtw_remainder_len(struct pkt_file *pfile);
>   void _rtw_open_pktfile(struct sk_buff *pkt, struct pkt_file *pfile);
>   uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
> -bool rtw_endofpktfile(struct pkt_file *pfile);
>   
>   void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt);
>   void rtw_os_xmit_complete(struct adapter *padapter,
> diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> index 91a1e4e3219a..85ef27735b88 100644
> --- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> @@ -54,17 +54,6 @@ uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
>   	return len;
>   }
>   
> -bool rtw_endofpktfile(struct pkt_file *pfile)
> -{
> -
> -	if (pfile->pkt_len == 0) {
> -
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
>   int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf, u32 alloc_sz)
>   {
>   	pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);

Tested with Edimax N150 and
Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
