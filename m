Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC2559FCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiHXOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiHXOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:14:27 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7E198369;
        Wed, 24 Aug 2022 07:14:26 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id n14so9690827qvq.10;
        Wed, 24 Aug 2022 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=AQnlGxv5ktbflmEXsnY8iSY/o77OIXfWnk/QgzP3E3w=;
        b=AMHtnJiA9mJwv+33UHB/6/iCQZ2eFALzM1hXRkcEKKsZaVNHRpnk/ChBJtPX4m3VYk
         OV/20fdS65ZnWzea15+QcKhS64ACkxEQwt3HRnDvVj8nqeEi7j5RR5HcvbaFVW6XGBSf
         QhivDQJYnnDotQH6P35PKhfQ0Oj3tt7dw8IjVhJPF1x738qL6xzqIWTdpmoji4fGVvkl
         GBz6bANkGkbsbUGp2th+J/PbDmI/BF5CqnscGYvtc5IO/WYoDk2Yf15a9leUx/F8qsdj
         YUo0YZrqDgQSMSeQcfMvKQpuO0jfmsFZ9xKRyfz/B+j/Z9/TokG6dzDmvlyyRIZYp/iG
         d2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=AQnlGxv5ktbflmEXsnY8iSY/o77OIXfWnk/QgzP3E3w=;
        b=KfGWaU/94otit0eltExJ/x48RFSQ0SFpoNtZQwzTXj/0j5DAxx2QCXSVMd/HOFeREi
         aDizDzbR2VGKieaRBRsBeXFES6Cc6a/vWyJDql8twOa3PGp4VDT7fWtCrZXM6gW3NJQJ
         l3WJU9KOP99ZneqvxB7xMdb2FvdiE7bdL3qSPohjmBCl3D7V6qWfDokGcINA/pGmPnUZ
         YQSL4dAiMe/WxpSU2biiakieLlj2sKSRURsO5iN4qpJup3yyYujK64zz2Duoa0zXTKmt
         uHWFrnH9y9diSVmJqNAit9CeNa8t3H7QYHrOt25e2DJZ86P4Yswj7JZ+/kOihpoWd6x5
         d3Kg==
X-Gm-Message-State: ACgBeo2/zKgFLj2WGdfN9pd4XYtmOZGPCO9ID77ZL5+iEWiQmOotc4zq
        FhiYL/y/FWHfAZqZ/eKI2Yc=
X-Google-Smtp-Source: AA6agR49F8BFcBbZ6/L/Gkw9oGUZ0AQDuHioHaQId3viv1k/3kOHWyhKz7t/Kg6X8KBjqHyMpknkhg==
X-Received: by 2002:a05:6214:23c7:b0:492:2ada:11d7 with SMTP id hr7-20020a05621423c700b004922ada11d7mr24055317qvb.116.1661350465652;
        Wed, 24 Aug 2022 07:14:25 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id f12-20020a05622a104c00b003438a8e842fsm13677283qte.44.2022.08.24.07.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 07:14:25 -0700 (PDT)
Message-ID: <9caed19e-ec83-92d3-cc86-586cc01f2fee@gmail.com>
Date:   Wed, 24 Aug 2022 07:14:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH linux-next] scsi: lpfc: Remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com, martin.petersen@oracle.com
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220824075017.221244-1-ye.xingchen@zte.com.cn>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220824075017.221244-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/24/2022 12:50 AM, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value from lpfc_sli4_issue_wqe() directly instead of storing it
>   in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/scsi/lpfc/lpfc_sli.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
> index 608016725db9..1298cea81396 100644
> --- a/drivers/scsi/lpfc/lpfc_sli.c
> +++ b/drivers/scsi/lpfc/lpfc_sli.c
> @@ -10322,12 +10322,10 @@ static int
>   __lpfc_sli_issue_fcp_io_s4(struct lpfc_hba *phba, uint32_t ring_number,
>   			   struct lpfc_iocbq *piocb, uint32_t flag)
>   {
> -	int rc;
>   	struct lpfc_io_buf *lpfc_cmd = piocb->io_buf;
>   
>   	lpfc_prep_embed_io(phba, lpfc_cmd);
> -	rc = lpfc_sli4_issue_wqe(phba, lpfc_cmd->hdwq, piocb);
> -	return rc;
> +	return lpfc_sli4_issue_wqe(phba, lpfc_cmd->hdwq, piocb);
>   }
>   
>   void

Thanks

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

