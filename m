Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17846502D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355267AbiDOPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239644AbiDOPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:47:01 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F334122
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:44:32 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id p10-20020a056820044a00b00320d7d4af22so1426538oou.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j5NRrlqKENHyQZylLDNmhFaG1FDwZsqTXLGE7hmnAc8=;
        b=nIfghUNNlsWFgGmG0oagSqP/rbsjGz/ayL9SQmTjbAiE2C1DHSX2ULMahq+z7vZLb6
         YXc0sI/ArX5P1V8v9UodN+l7wZcJB6/IP5c3TtMy134/Xak+A9QMJrpfjhjGfo/VrSW6
         FNOMApcWJ6mW3EgIrAhypitfUYrEcq8imVcAGqI99jdCAofwj3w3COo+GgEaUeweNySA
         WCLMr3aQRHbhTisAnZmG6/uGgl8YEKVaLsdYYURqoFTxX48hxoXYUV5yobQro/gUHnjV
         S3xoKFi7e4pv883P81fE1F7pASmY7sdsmIXzhbmpoXvSL1PmtQ9bkLvZvVE7dTV8H65S
         MKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j5NRrlqKENHyQZylLDNmhFaG1FDwZsqTXLGE7hmnAc8=;
        b=46CNDoIddWhV0fIL05M6mOY+zUiWVWWebrbK64ErQHY/9JSkBUhriRFesA00V7P3ur
         ZcPJzqj1w7GddG4lsEXT6cvkw1+ggNIh4HO2idQXrJSGILJ6MjT5KLc12dyF0x6Y2kJo
         ABbZQ8JT+AjzKmR2zMv4I6qFW415D+dqbq/K7N3XT3+yHSddLYNxqaYwpb7TwSu8EkUr
         7FT+V6mvBOrBVTPcS6goA3RS0dsmfHNM7ICpQkm9HSYGNDjCWUH1s3Ib6bDF1Ia8asGu
         zleOK8xjiX70OdkWKL3zOkHP4XlNKCJmnXtAXF7UABelUJSfjvoVGBfRJs1xbyv0yA7H
         N0qw==
X-Gm-Message-State: AOAM531/GLyyvR6BVx2771t5uSxiAlDcekLtSZF+69LFJ1f2saiMBdoX
        HijeqYrCq3NlKAEknnQvE/xhIbRp4tVqKw==
X-Google-Smtp-Source: ABdhPJxlabBeRt5snh3dbVOSDxuMbJAGcychFWL5yqte5rUEYQhYAI9blLmXaExxNobKuQl7Eb9MQw==
X-Received: by 2002:a4a:d254:0:b0:324:b1bf:da28 with SMTP id e20-20020a4ad254000000b00324b1bfda28mr2428616oos.49.1650037471728;
        Fri, 15 Apr 2022 08:44:31 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id c19-20020a9d7853000000b005cdbc0f02ccsm1176938otm.68.2022.04.15.08.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 08:44:31 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <f4f8d381-9ee1-c504-c41c-97a9332066c9@lwfinger.net>
Date:   Fri, 15 Apr 2022 10:44:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/8] staging: r8188eu: clean up comments in struct
 rt_firmware_hdr
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220415121023.11564-1-straube.linux@gmail.com>
 <20220415121023.11564-4-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220415121023.11564-4-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 07:10, Michael Straube wrote:
> The comments in struct rt_firmware_hdr are not needed.
> Remove them.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v3:
> - no changes
> 
> v2:
> - no changes
> 
>   drivers/staging/r8188eu/core/rtw_fw.c | 37 ++++++++-------------------
>   1 file changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
> index 7cd08268f3b9..323e0c634c4e 100644
> --- a/drivers/staging/r8188eu/core/rtw_fw.c
> +++ b/drivers/staging/r8188eu/core/rtw_fw.c
> @@ -14,37 +14,22 @@
>   	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||	\
>   	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
>   
> -/*  This structure must be careful with byte-ordering */
> -
>   struct rt_firmware_hdr {
> -	/*  8-byte alinment required */
> -	/*  LONG WORD 0 ---- */
> -	__le16		Signature;	/* 92C0: test chip; 92C,
> -					 * 88C0: test chip; 88C1: MP A-cut;
> -					 * 92C1: MP A-cut */
> -	u8		Category;	/*  AP/NIC and USB/PCI */
> -	u8		Function;	/*  Reserved for different FW function
> -					 *  indcation, for further use when
> -					 *  driver needs to download different
> -					 *  FW for different conditions */
> -	__le16		Version;	/*  FW Version */
> -	u8		Subversion;	/*  FW Subversion, default 0x00 */
> +	__le16		Signature;
> +	u8		Category;
> +	u8		Function;
> +	__le16		Version;
> +	u8		Subversion;
>   	u8		Rsvd1;
> -
> -	/*  LONG WORD 1 ---- */
> -	u8		Month;	/*  Release time Month field */
> -	u8		Date;	/*  Release time Date field */
> -	u8		Hour;	/*  Release time Hour field */
> -	u8		Minute;	/*  Release time Minute field */
> -	__le16		RamCodeSize;	/*  The size of RAM code */
> +	u8		Month;
> +	u8		Date;
> +	u8		Hour;
> +	u8		Minute;
> +	__le16		RamCodeSize;
>   	u8		Foundry;
>   	u8		Rsvd2;
> -
> -	/*  LONG WORD 2 ---- */
> -	__le32		SvnIdx;	/*  The SVN entry index */
> +	__le32		SvnIdx;
>   	__le32		Rsvd3;
> -
> -	/*  LONG WORD 3 ---- */
>   	__le32		Rsvd4;
>   	__le32		Rsvd5;
>   };

The comments "LONG WORD" are useless, but the comments describing the fields are 
still useful. I do not like this patch.

Will your next step be stripping ALL comments from the driver? The source would 
be a lot smaller that way! :)

Larry

