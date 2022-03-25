Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0478A4E7817
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbiCYPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376984AbiCYPiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:38:13 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D502642EEB;
        Fri, 25 Mar 2022 08:34:57 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id x2so8402190plm.7;
        Fri, 25 Mar 2022 08:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bbdgCmNtwzY2RLS376ybn/+3eTx3HqJcLP+kZSbonms=;
        b=II646205Fe+H3Uj8+9+hWRuf7OkHp8NB6cGfzmJJqCmPoVZ1dA7ashLKAn+t2uT6qi
         AGvNAmVfA/4tLXYU2AglDOyxUgwcEFmizD12oucdJfhJdiFtKwk50qsPTHQGCQ0ZDUPj
         Iw9LCvM+BdnHeycV7y3ZRkdkH/qBvc3fba4DKZk+scOsrr2txuSaiHOCGD4xhBMdBIYU
         rn+6sjH7dVjFlJp32GTumNR3JWDx7sgRdmz1R5b4701nVNjfEyQYEYZwib2UC47auEWC
         r1sWCHBgiW2eQwsI0bcAhQgCppD/5IbjIYx/tBDnSg2Oq11mkE18BtJjqAH5o0VIC225
         0YhA==
X-Gm-Message-State: AOAM531bCEUEh9lVsrVR8vAKYr7iKhmqtC8xhXZhGRmg24QMNNvqCqAW
        RNtaIYGimXfallenJFqS17v0eP52pz0=
X-Google-Smtp-Source: ABdhPJylDRG/b4rWwQqiSjQYi+msf7VHn9E4kX9F42tOQD4859a6He0M7PZWCvqJkgeYBJhkGx0RPQ==
X-Received: by 2002:a17:902:db0f:b0:154:665e:af75 with SMTP id m15-20020a170902db0f00b00154665eaf75mr12089337plx.147.1648222497062;
        Fri, 25 Mar 2022 08:34:57 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k18-20020a056a00135200b004fb18fc6c78sm2880862pfu.31.2022.03.25.08.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:34:56 -0700 (PDT)
Message-ID: <e3654323-1880-d7b9-fba6-59b387b6fa77@acm.org>
Date:   Fri, 25 Mar 2022 08:34:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] scsi: ufs: unipro: add to define HS-Gear5 mode
Content-Language: en-US
To:     SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
References: <sc.suh@samsung.com;>
 <CGME20220325082858epcas2p41c0918b1cacce09eaa5f7ffe84d9f994@epcas2p4.samsung.com>
 <20220324201410.59187-1-hy50.seo@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220324201410.59187-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 13:14, SEO HOYOUNG wrote:
> diff --git a/drivers/scsi/ufs/unipro.h b/drivers/scsi/ufs/unipro.h
> index 8e9e486a4f7b..0d2131e1f027 100644
> --- a/drivers/scsi/ufs/unipro.h
> +++ b/drivers/scsi/ufs/unipro.h
> @@ -231,6 +231,7 @@ enum ufs_hs_gear_tag {
>   	UFS_HS_G2,		/* HS Gear 2 */
>   	UFS_HS_G3,		/* HS Gear 3 */
>   	UFS_HS_G4,		/* HS Gear 4 */
> +	UFS_HS_G5,		/* HS Gear 5 */
>   };

Where is the code that uses this new constant?

Thanks,

Bart.
