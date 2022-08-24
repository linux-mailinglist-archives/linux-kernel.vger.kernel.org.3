Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8C59FCFC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbiHXOOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiHXOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:14:46 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06725E3E;
        Wed, 24 Aug 2022 07:14:44 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f14so12755069qkm.0;
        Wed, 24 Aug 2022 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=TrqZDLsdYAynvTBTtJeOsZRgN9teX3NoYhIaynPD3O0=;
        b=YA2cr2sUfrrR9nZvKWTh6NCF0O5FAOKudo2fOVPVsiDOQ4xFW8LHjSPR0IZ73tSuTv
         NKuv06y7KdJ1K7u0G1HaI6+e0no1y6qBe552QQJ1mgJAhYCwtg5FZWljl6QcZYiR+OiR
         XkHNGJwsT0p/DWxyRWTp/iHpmzdvrEFcoTMwPslLz7NVZToXNdKmykZ8tzPAi+hRc+C3
         SZNhrhFJregqhoqcsDOWcn9lmDm84gcQk9OPky8lQ89EzLCh5Yf9eLStvgp/syruGmqC
         pgd6TPNqYE6cWe+Emch7d5BLOvpvi0REGsNsmbU7rzLgX2RfFXf4b75dBd6zHpx2ZYIQ
         WAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TrqZDLsdYAynvTBTtJeOsZRgN9teX3NoYhIaynPD3O0=;
        b=xGdE1WapAUWXujXHBU6tJOXFJZEIXBitG+8w3B2TvEyeGC6xr6EgGtTZLxzfVsqJPy
         pgg9U7PGsmyChlvVF7shnqb2sfBam4nUZzUP5nbVfKcL6nxSMKkRppDFmJs7SKOSvhgr
         uS1EYBLwxBcz1kTr6lKlIcWwfQKbbIFZrWKNklqxnCViaxf9/rn5OADARIHjpoN6Ubx0
         gNs1V6wjJPab/HfUDeMXKc7mLZ8FysxjCAbrShwfujTQxTGHO7Jm8KiDjxiz0ipZE8/j
         qr/IeHIf6IDE8qpwSRTvv9tw59QWYlaUhNLpiu1C1TjxtEHB+sd6tVV4XgkiHPQYMIxb
         gcmQ==
X-Gm-Message-State: ACgBeo3kUHd5xwOU3Bnugew/ipbfyCJrV6BwIVxslwzp06cM6pMx/7a1
        A9LYY01xXWv9UYHVreexHFo=
X-Google-Smtp-Source: AA6agR5LoOlLPTqceeqPLn7Qug4WWCw17PUBJFJgN5NvonbLTaEMWM0boiMk5V5z252R7p6E5u8gkg==
X-Received: by 2002:a37:9344:0:b0:6b9:b91a:1634 with SMTP id v65-20020a379344000000b006b9b91a1634mr20252116qkd.75.1661350482491;
        Wed, 24 Aug 2022 07:14:42 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a454400b006bbe7ded98csm12200718qkp.112.2022.08.24.07.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 07:14:42 -0700 (PDT)
Message-ID: <be283e0b-211b-71eb-746e-7a221f01fbb0@gmail.com>
Date:   Wed, 24 Aug 2022 07:14:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH linux-next] scsi: lpfc: Remove unneeded result variable
Content-Language: en-US
To:     cgel.zte@gmail.com, martin.petersen@oracle.com
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220824075123.221316-1-ye.xingchen@zte.com.cn>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220824075123.221316-1-ye.xingchen@zte.com.cn>
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

On 8/24/2022 12:51 AM, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value from lpfc_issue_reg_vfi() directly instead of storing it
>   in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/scsi/lpfc/lpfc_bsg.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
> index 9be3bb01a8ec..ac0c7ccf2eae 100644
> --- a/drivers/scsi/lpfc/lpfc_bsg.c
> +++ b/drivers/scsi/lpfc/lpfc_bsg.c
> @@ -1977,8 +1977,6 @@ lpfc_sli4_bsg_set_loopback_mode(struct lpfc_hba *phba, int mode,
>   static int
>   lpfc_sli4_diag_fcport_reg_setup(struct lpfc_hba *phba)
>   {
> -	int rc;
> -
>   	if (phba->pport->fc_flag & FC_VFI_REGISTERED) {
>   		lpfc_printf_log(phba, KERN_WARNING, LOG_LIBDFC,
>   				"3136 Port still had vfi registered: "
> @@ -1988,8 +1986,7 @@ lpfc_sli4_diag_fcport_reg_setup(struct lpfc_hba *phba)
>   				phba->vpi_ids[phba->pport->vpi]);
>   		return -EINVAL;
>   	}
> -	rc = lpfc_issue_reg_vfi(phba->pport);
> -	return rc;
> +	return lpfc_issue_reg_vfi(phba->pport);
>   }
>   
>   /**

Thanks

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

