Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5F4968DC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiAVAlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:41:18 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:40791 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAVAlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:41:17 -0500
Received: by mail-pl1-f174.google.com with SMTP id s9so8319739plg.7;
        Fri, 21 Jan 2022 16:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3yLq0KHZAWYQX+NQC3I5NckmeSHV7kNL1/zKNjJlHAo=;
        b=J8EC4zlZ0CRoz2TUHvPORzXKpRUT19303bCZtPud5gsvUcNqMiDa4v0AV5+bMFhmUO
         7xe16OIFepfzCbo+LXJDJdc5ggxWGV1zlFmZ1pXNEX1dUxJAZMzD5WEw65L0Ly2jJS9O
         1B0l92ouGX5GJ1Z+XgZTm2Nk/WueqlydwGzLF+eHjSyMGdYsiPplxpJ0QgpGxoS3WQy5
         6xCUgfwVtApcPBdNBsV7hIY2wHd8modvQwzilP4jVUWJ/LI1CjqJlwZYuAb0NwVlylBC
         XPnMExJtXKFr11UKgeP8jqWnlmyI0RdvyhScRMJn1SRcInIKt+Vh7liI3Q3eie1IIW1e
         xixA==
X-Gm-Message-State: AOAM531Lapks7xqoU/ojHRSfYexWuAMr0xPJpFha9X2fyz/FKM7o47tw
        vwZ4YGHGPR54IALrKqFgs6Q=
X-Google-Smtp-Source: ABdhPJw4KqEwem/uOWzCkffDrDZszb5lRarnC6IK9kSZmrqpjuXJnWpHZy+Al2+sb+7AsyuhZ8BjTg==
X-Received: by 2002:a17:902:6908:b0:149:b26a:b9b5 with SMTP id j8-20020a170902690800b00149b26ab9b5mr5891332plk.169.1642812076937;
        Fri, 21 Jan 2022 16:41:16 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id pg2sm914482pjb.54.2022.01.21.16.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 16:41:16 -0800 (PST)
Message-ID: <ddb72689-fd3b-5fc7-6558-da55ff6957d8@acm.org>
Date:   Fri, 21 Jan 2022 16:41:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3] scsi: ufs: use an generic error code in
 ufshcd_set_dev_pwr_mode
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
References: <CGME20220121053455epcas2p4f2710091dc5f722a220be91243c60eed@epcas2p4.samsung.com>
 <1642743182-54098-1-git-send-email-kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1642743182-54098-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 21:33, Kiwoong Kim wrote:
> v2 -> v3: change the value of ret only if it's positive
> v1 -> v2: modify the comment of ufshcd_set_dev_pwr_mode
> 
> The return value of ufshcd_set_dev_pwr_mode is given to
> device pm core. However, the function currently returns a result
> in scsi command and the device pm core doesn't understand it.
> It might lead to unexpected behaviors of user land. I found
> the return value led to platform reset in Android.
> 
> This patch is to use an generic code for SSU failures.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
