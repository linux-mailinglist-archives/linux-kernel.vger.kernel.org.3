Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348E44E6396
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350286AbiCXMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350305AbiCXMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:46:15 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8B93A5C1;
        Thu, 24 Mar 2022 05:44:37 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id bx5so4617842pjb.3;
        Thu, 24 Mar 2022 05:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HZwsIhjtgSAmnia0/qaT3RxixpuiveiXDCzTc8KKHGA=;
        b=rUjQxZuaozbndvZ/yS5THFwiW+bZ5QuG4Lqq5dvYjTeIduF31GN/HtKtoOSvObcGAo
         dxEDvdqjRyvhT1gZZWnc79Cj9RfBY0uI6KyokvKyiG3iN0auNRSlBsU7+SKiwnoiIunr
         6Z+Ke0kANGP9QVeoDOs4FGtloXeTEzsSPX0DiHdRUz4rs7H4HLbUwGf3Ne0H2qMCePGY
         0TVItaZALuzobzeh+LLYhJUxofsJN9eJ//Ym9SjF1Y6lhU5+COo3KrZ7itFmZFiUCo2T
         sDgeuRYQmEToy3hS7qa6YZPfr9JXizPhQgSyT0bYUReW80Joq7hC+zDMlrOdZ7aQyHDx
         Q/+w==
X-Gm-Message-State: AOAM531mhgGtLCssF6BmxMR0PqtWKk4vPE8ZqSgmOJgYPLmd2R0Kl1rR
        TZYgyP+/AkSPNyH+cHgEmEA=
X-Google-Smtp-Source: ABdhPJz9ePb2UO+o7Kg3QBx7giEUT6UhTsxA28zonwRRr36ruXOgSgWc/cpXYsIcs0AGEZGbkpjykQ==
X-Received: by 2002:a17:903:3091:b0:153:9dcf:de71 with SMTP id u17-20020a170903309100b001539dcfde71mr5671611plc.7.1648125876217;
        Thu, 24 Mar 2022 05:44:36 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm2669252pgc.50.2022.03.24.05.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 05:44:35 -0700 (PDT)
Message-ID: <0034b2f8-0eba-f700-6fff-03cf5b8c8332@acm.org>
Date:   Thu, 24 Mar 2022 05:44:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] scsi: ufs: core: Remove unused field in struct ufs_hba
Content-Language: en-US
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220324070146epcms2p577d43ce3e7cbd36aa964f3842e49b2ba@epcms2p5>
 <413601558.101648105683746.JavaMail.epsvc@epcpadp4>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <413601558.101648105683746.JavaMail.epsvc@epcpadp4>
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

On 3/24/22 00:01, Keoseong Park wrote:
> Remove unused field "rpm_lvl_attr" and "spm_lvl_attr" in struct ufs_hba.
> Commit cbb6813ee771 ("scsi: ufs: sysfs: attribute group for existing
> sysfs entries.") removed all code using that field.
> 
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
> ---
>   drivers/scsi/ufs/ufshcd.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 88c20f3608c2..94f545be183a 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -820,8 +820,6 @@ struct ufs_hba {
>   	enum ufs_pm_level rpm_lvl;
>   	/* Desired UFS power management level during system PM */
>   	enum ufs_pm_level spm_lvl;
> -	struct device_attribute rpm_lvl_attr;
> -	struct device_attribute spm_lvl_attr;
>   	int pm_op_in_progress;
>   
>   	/* Auto-Hibernate Idle Timer register value */

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
