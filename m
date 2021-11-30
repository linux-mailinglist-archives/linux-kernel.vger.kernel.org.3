Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A11463F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbhK3UeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343728AbhK3Udt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:33:49 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD35C061746;
        Tue, 30 Nov 2021 12:30:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gt5so16202104pjb.1;
        Tue, 30 Nov 2021 12:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LB/UpLmF0G/QWkAI+gjzYfJzqDpyo7KEC6icunFW9lA=;
        b=i8Y8vuu77WN+vi5Wbd7ObhXHj32sZeYDbQAxyhTroXEOluDXBJrQ2D0D4DZ70At9Xh
         sc3/t/4U+PuMRtF3pAyDrJxBtlTO6V8nwXsW7iUqRp2bWwrVqGy8s8h85pq5T4YHLuaC
         hiW6jNb1HzqZNHHylC+01fil+rOQ5tNfTYidVdoLWO2QXEO4LhIWWQvT21yAq0ANKU23
         fH1yqDP+QHbqVD+xT3bkTN+EyFge/0h2sZGE+LPfz0wOXZw3lpOtRmmPfAhAW21n5C0C
         FqCvJ6zKbslTfnB+qvhaIGIovYNu+VjunvKmR9Z/2NTTnrheAfVUQtXNZLJexC3/UqkO
         v4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LB/UpLmF0G/QWkAI+gjzYfJzqDpyo7KEC6icunFW9lA=;
        b=gVWdnSiruIXObAdreZLW/ukMp7OLbhhE8uTcGvETH7BGPfFk7Iv+Qp/Oor7GZ/Mnes
         5G7bLueCRw9C0+TjD6nNYL6x6uMq44LVtFMaYew5kNs9M3t6syIt6JeU+NGII5DmFzf4
         DMXjwFqqXEAxuHnX1wtpOszr96Fa98fh4NZ6HP55eABxgaCCKgZ8exwsJyIW2sxagPK4
         VOYykihgig9Mw/ECkXLbFZo79hoGSLstQnKN2SmGggG08wkrAAw7wZQtIxF9CtbQaBlD
         UP4Cpf01f6SL3k2iX2n9eEVm9fSp1JmgObewqPpP8Omc68H7vyzIlz8XWXBJOUWqxsjy
         eMZQ==
X-Gm-Message-State: AOAM53186bk10QFOfnGJW/+v8FO6I++8Z3lYlgPUbk2hBaXbPbBZ6LIC
        OjHfnoRSB0dwiQ4tsRWeClAHCxwxZp8=
X-Google-Smtp-Source: ABdhPJz2vZ4/AlsMzOcZBLPlW25yLLJtwfedjUH3UjsfFxLl8XyrL3gEdAYs1P7R2ytZ7pzI8Ziw6Q==
X-Received: by 2002:a17:902:f545:b0:145:4402:c334 with SMTP id h5-20020a170902f54500b001454402c334mr1520236plf.65.1638304228935;
        Tue, 30 Nov 2021 12:30:28 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gv23sm3292945pjb.17.2021.11.30.12.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 12:30:28 -0800 (PST)
Subject: Re: [PATCH 2/2] scsi: qla4xxx: Format SYSFS_FLAG_FW_SEL_BOOT as byte
To:     linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "supporter:QLOGIC QL41xxx ISCSI DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:QLOGIC QL41xxx ISCSI DRIVER" <linux-scsi@vger.kernel.org>
References: <20211130202934.5023-1-f.fainelli@gmail.com>
 <20211130202934.5023-3-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <30497371-1f5a-a22a-1a60-8f6105ea8ddd@gmail.com>
Date:   Tue, 30 Nov 2021 12:30:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211130202934.5023-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 12:29 PM, Florian Fainelli wrote:
> qedi formats SYSFS_FLAG_FW_SEL_BOOT as a byte, and the qla4xxx driver
> does exactly the same thing, align them for consistency.
> 
> Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index 8987acc24dac..39b2f833eb26 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -5734,7 +5734,7 @@ static ssize_t qla4xxx_show_boot_eth_info(void *data, int type, char *buf)
>  
>  	switch (type) {
>  	case ISCSI_BOOT_ETH_FLAGS:
> -		rc = sprintf(str, "%d\n", SYSFS_FLAG_FW_SEL_BOOT);
> +		rc = sprintf(str, "%hhd\n", (char)SYSFS_FLAG_FW_SEL_BOOT);
>  		break;
>  	case ISCSI_BOOT_ETH_INDEX:
>  		rc = sprintf(str, "0\n");
> @@ -5843,7 +5843,7 @@ qla4xxx_show_boot_tgt_info(struct ql4_boot_session_info *boot_sess, int type,
>  			     (char *)&boot_conn->chap.intr_secret);
>  		break;
>  	case ISCSI_BOOT_TGT_FLAGS:
> -		rc = sprintf(str, "%d\n", SYSFS_FLAG_FW_SEL_BOOT);
> +		rc = sprintf(str, "%hdd\n", (char)SYSFS_FLAG_FW_SEL_BOOT);

Sorry, I botched up that one, let me resend.
-- 
Florian
