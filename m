Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874A459AE61
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346626AbiHTNEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346698AbiHTNEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:04:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A58BBB
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:03:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ca13so2069202ejb.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mj3vgiQsizW8HcDdV2yPhC8+tmGtdrhf0eIAkG4C9kM=;
        b=eHsT7JjQBOBFnj6S/rmP/+5OqeN3pzoErYUpxYdz9SW85nC8fPDzBpEIwEcEfUgIEn
         ken7VkhQYW8lbpbrxGxV3idxk3t8Rdtd4qJhtGNbP9wjgV7z9YQCM6KSmjkgmMautLtj
         YdfuzvPpRQlFpdeSCdeiFnJea/MI4a/x6B2uLTcPeA/G4ogDL1YC4bV0OS1GshHyPsWE
         xqBgX1Gsd2MWFH/xei427N9Q7/wEFt0fFOad0FEbdEOHB+VWpMBxQD0/4SnS5lTK3hd2
         ke7chTojyl0dB7NjnwusjDvCpWUlor/P2Zv3ug6WKjsHRWUZoEVrNtuC7f1JGCJGQ0Mp
         0wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mj3vgiQsizW8HcDdV2yPhC8+tmGtdrhf0eIAkG4C9kM=;
        b=NQvoxsmPhrAodxOR/wd5tgzpjNJLXrBN0/6ZknVuZW1fgahXS5cD24kKNZH9uTbg6K
         1ofxbhq6sPddWXNQRMb6/eq/uHllBLN+8jczyLuQtJFeYDrDfN6D+EJ0e8PqMnXbkAzI
         Csglfnm68Iy8IVINwrJF73PaHi1mPiDfYje0iEKPLOCMM6D/iedHr5b8xS9li8uAc5d9
         AS6HHn3jYSIkIDBUkXbwZgTqMvl9XKJpQKIGuOmBso/8cqditqUxrFvFx2zzPUGrvUlZ
         200QAb50JUDrOwGXhFTzdItpkeON2f8O8knMZ8cj3PaO8VQpvROJoR+xXHvlqplqu/eX
         CX8Q==
X-Gm-Message-State: ACgBeo2BbNaPSb/mdrmA2HCV+SezBndujUbt496ZujqxhKOwYl6EFrhd
        bJbQ+PsHHFxc6w/UjWBbJGU=
X-Google-Smtp-Source: AA6agR5v5eY7Y/E/SS5QAqboF224jjLrl53RO616vkad8sYCl4aEtNPHhSq5yh7VmEp8B/23KcuAKg==
X-Received: by 2002:a17:907:c05:b0:73d:6e0a:8d22 with SMTP id ga5-20020a1709070c0500b0073d6e0a8d22mr289730ejc.646.1661000589493;
        Sat, 20 Aug 2022 06:03:09 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id f19-20020a17090631d300b0073d05a03347sm2218618ejf.89.2022.08.20.06.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 06:03:09 -0700 (PDT)
Message-ID: <c8ead88c-853e-c7b6-e2cf-1d210e5ada02@gmail.com>
Date:   Sat, 20 Aug 2022 15:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: remove ODM_ConfigRFWithHeaderFile()
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220819182359.24141-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220819182359.24141-1-straube.linux@gmail.com>
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

On 8/19/22 20:23, Michael Straube wrote:
> The function ODM_ConfigRFWithHeaderFile() is just a wrapper around
> ODM_ReadAndConfig_RadioA_1T_8188E(). Remove the wrapper and call
> ODM_ReadAndConfig_RadioA_1T_8188E() directly.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/hal/odm_HWConfig.c     | 5 -----
>   drivers/staging/r8188eu/hal/rtl8188e_rf6052.c  | 2 +-
>   drivers/staging/r8188eu/include/odm_HWConfig.h | 1 -
>   3 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
> index 54cc3d7789cd..035d94b3458e 100644
> --- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
> +++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
> @@ -347,8 +347,3 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
>   	odm_RxPhyStatus92CSeries_Parsing(dm_odm, pPhyInfo, pPhyStatus, pPktinfo, adapt);
>   	odm_Process_RSSIForDM(dm_odm, pPhyInfo, pPktinfo);
>   }
> -
> -enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm)
> -{
> -	return ODM_ReadAndConfig_RadioA_1T_8188E(dm_odm);
> -}
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> index d043b7bc4142..237232432f37 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> @@ -396,7 +396,7 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
>   	udelay(1);/* PlatformStallExecution(1); */
>   
>   	/*----Initialize RF fom connfiguration file----*/
> -	if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv))
> +	if (ODM_ReadAndConfig_RadioA_1T_8188E(&pHalData->odmpriv) == HAL_STATUS_FAILURE)
>   		rtStatus = _FAIL;
>   
>   	/*----Restore RFENV control type----*/;
> diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
> index b37962edb2ed..3f7185780e87 100644
> --- a/drivers/staging/r8188eu/include/odm_HWConfig.h
> +++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
> @@ -66,5 +66,4 @@ void ODM_PhyStatusQuery(struct odm_dm_struct *pDM_Odm,
>   			struct odm_per_pkt_info *pPktinfo,
>   			struct adapter *adapt);
>   
> -enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *pDM_Odm);
>   #endif

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
