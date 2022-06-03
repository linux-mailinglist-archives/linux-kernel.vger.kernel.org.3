Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647AD53CC61
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245574AbiFCPhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245568AbiFCPhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:37:14 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4249FD0;
        Fri,  3 Jun 2022 08:37:07 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id f2-20020a4a8f42000000b0035e74942d42so1516180ool.13;
        Fri, 03 Jun 2022 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=B6b/Q5SgAcOc3K4fWusz0O9jH0GJ9lnT4P8XfLl7DVo=;
        b=CmYvWPA1umVbfEqJmeM1hEra2L8wkmiU2JN99b82Hwl80ndUOej6sSdOjpLd970Z1m
         PjLdbnoLdVP84Fg++Sq1QcjhHdESCQubMOUOIFC56lHWJ2rwyna6Qu1TxFFYtYEpeiUV
         TWGJozjhST4C6EfYxs1nQyQs+prI+35yPvGpckO9TZS8E/md3lkP++0itRB3cJbGQ6fp
         3EbLfHVdp8RGh8I1ft7xoxN2j0iVliOdG72UpEKZh/XUh59L9azju3eAxzEKXZA+5DzC
         zmBXW8++LJZcxpiW69dKJrjTK4oQKsVlN+1MM030CSt81DRhqYuF6bDiQw/Cnpa6aY5l
         T6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=B6b/Q5SgAcOc3K4fWusz0O9jH0GJ9lnT4P8XfLl7DVo=;
        b=T4dskxC1xGS4EWGAmeySDbtKRd+ZzSMAzGu31e0HQH53AR6xuKgy1ZPB7PwC3EPMY7
         pMIrzDmsHR+tvwj60H8IlovI+472d7TBhdOiP/fojAL6xhFyFRa8P85S+D2Vbu7oMvIP
         FAvqA2F9swmcMuPRegMlbkyZM37N+IRxxlxKkd2F33sCmoVwaXgncDooBcdlUXfkMlHT
         Xvd8DntaIumx/rUaHA//hTt0CebUvbqre3s5UQoSqQpLE8sNh3L6qxJuhi+Q6t1vJ6AP
         wkmwfr+QOzxinJAkWdkn0AqWpO1erDW77HaaAlg1QhTtpFRGevaTU7I1BpSUiO++f63z
         nSxw==
X-Gm-Message-State: AOAM533giBMmphzKlUd5W33o6jVLmTvYhOpCcP5l6hLS89PssmU/f4FQ
        2866VbibfLLEXTclY9+S5m8hNMfswWo=
X-Google-Smtp-Source: ABdhPJww/rfrREW6GYx3CReOeYpODPV1bQdaLt65Zuq05y/Z7erEiat4CW6jvaD1CwbXkvnyIi25WQ==
X-Received: by 2002:a4a:ded3:0:b0:41b:4187:67a7 with SMTP id w19-20020a4aded3000000b0041b418767a7mr3004131oou.60.1654270626664;
        Fri, 03 Jun 2022 08:37:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bh35-20020a056808182300b00325cda1ff95sm4545788oib.20.2022.06.03.08.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 08:37:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ccaf859b-55bb-ab06-dbe3-9c8350ec5ac6@roeck-us.net>
Date:   Fri, 3 Jun 2022 08:37:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     D Scott Phillips <scott@os.amperecomputing.com>,
        linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com,
        Darren Hart <darren@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
References: <20220603152116.2269912-1-scott@os.amperecomputing.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (xgene) restrict power measurements to admin by
 default
In-Reply-To: <20220603152116.2269912-1-scott@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/22 08:21, D Scott Phillips wrote:
> Access to power information can be used to infer the instructions being run
> and possibly even data being processed on a cpu[1]. Restrict access to
> power information to administrator users by default. (Cf. a similar
> powercap change[2].)
> 
> [1]: Lipp, Moritz, et al. "PLATYPUS: software-based power side-channel
>       attacks on x86." 2021 IEEE Symposium on Security and Privacy (SP).
>       IEEE, 2021.
> [2]: commit 949dd0104c49 ("powercap: restrict energy meter to root access")
> 
> Fixes: ed42cfa881e1 ("hwmon: Add xgene hwmon driver")
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/hwmon/xgene-hwmon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
> index 5cde837bfd09..6ad1daf2d354 100644
> --- a/drivers/hwmon/xgene-hwmon.c
> +++ b/drivers/hwmon/xgene-hwmon.c
> @@ -397,9 +397,9 @@ static DEVICE_ATTR_RO(temp1_label);
>   static DEVICE_ATTR_RO(temp1_input);
>   static DEVICE_ATTR_RO(temp1_critical_alarm);
>   static DEVICE_ATTR_RO(power1_label);
> -static DEVICE_ATTR_RO(power1_input);
> +static DEVICE_ATTR_ADMIN_RO(power1_input);
>   static DEVICE_ATTR_RO(power2_label);
> -static DEVICE_ATTR_RO(power2_input);
> +static DEVICE_ATTR_ADMIN_RO(power2_input);
>   
>   static struct attribute *xgene_hwmon_attrs[] = {
>   	&dev_attr_temp1_label.attr,


NACK. The hwmon ABI expects world read access. Either find a workaround
by making the measurements less accurate, or drop the driver. Also see
commit 9049572fb145 ("hwmon: Remove amd_energy driver"), "Attribute access"
in Documentation/hwmon/sysfs-interface.rst, and [1].

Guenter


---
[1] https://patchwork.kernel.org/project/linux-hwmon/patch/20210409174852.4585-2-linux@roeck-us.net/
