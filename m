Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4183358328D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiG0S5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiG0S4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:56:44 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94554C62D;
        Wed, 27 Jul 2022 10:58:00 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id ha11so731106pjb.2;
        Wed, 27 Jul 2022 10:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4vE7Bsz6vrHUNePlGNIG+g1zzaWWwe+MjkqFS82oLcU=;
        b=jaOFWWE6QX36qBEc/1dpgUqRXGaox+48OC/dj7b1V9GjH1VjXarB362XWI0FEUWeF4
         9/oyohNFj3F0Z9mTOfo4BSV+bl+yzfQDZfu12TS6tnFRYWBmbGOE+P1tRDf7tNaLIOkr
         iMSvdRbGbkMmycf8ijlFerJKSGR1oPZTtqwjvgFw9dIZokCH+q0A6vjmXQt91ZECdCHQ
         lPASR2KDllApn+1Kx2GLDl4xFh0kbBtDay8u0vnyi5foLK4loO/5smvMSff/gz4YKt7r
         BxOOv6V6mZCnatDtw1ieYyr2+ShVMd5bn/GKG685yjyxxQVgpvgfNC63ltU/AnXyZsr8
         1QHg==
X-Gm-Message-State: AJIora/+ZwT0XYj9OC7Z/0uOyvGQg2UMW2MQxDtt0HAWQYV80t1TlUNK
        X2OzLSeFhhjqLCp+tlS9CRk=
X-Google-Smtp-Source: AGRyM1tFVd8EqwxIE+VDBtTOrcnZ22zKgfGpfCBk21Zv7Woc9eTIJzAuoFWzsa9F1fR+kw0nGXPpKw==
X-Received: by 2002:a17:90b:4d0e:b0:1f1:9109:99df with SMTP id mw14-20020a17090b4d0e00b001f1910999dfmr5884407pjb.234.1658944680200;
        Wed, 27 Jul 2022 10:58:00 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902784100b0016d4f05eb95sm9939079pln.272.2022.07.27.10.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:57:58 -0700 (PDT)
Message-ID: <fa60e605-a881-79aa-b9ed-9c8bdf06778f@acm.org>
Date:   Wed, 27 Jul 2022 10:57:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/5] scsi: ufs: ufs-mediatek: Provide detailed
 description for UIC errors
Content-Language: en-US
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
References: <20220727034454.31892-1-stanley.chu@mediatek.com>
 <20220727034454.31892-3-stanley.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220727034454.31892-3-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 20:44, Stanley Chu wrote:
> diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
> index aa26d415527b..9017ab8f9867 100644
> --- a/drivers/ufs/host/ufs-mediatek.h
> +++ b/drivers/ufs/host/ufs-mediatek.h
> @@ -26,6 +26,44 @@
>   #define REG_UFS_DEBUG_SEL_B2        0x22D8
>   #define REG_UFS_DEBUG_SEL_B3        0x22DC
>   
> +/*
> + * Details of UIC Errors
> + */
> +static const u8 *ufs_uic_err_str[] = {
> +	"PHY Adapter Layer",
> +	"Data Link Layer",
> +	"Network Link Layer",
> +	"Transport Link Layer",
> +	"DME"
> +};

Why type u8 for strings instead of char?

Please define arrays in .c files. Otherwise one copy of the array will 
be included in each source file this header file is included in.

Thanks,

Bart.
