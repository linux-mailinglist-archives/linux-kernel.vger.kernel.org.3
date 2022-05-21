Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD71652FCF1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242630AbiEUNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiEUNmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:42:53 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F447DE12;
        Sat, 21 May 2022 06:42:51 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id b16-20020a4ad890000000b0040e5576e0fcso1235192oov.5;
        Sat, 21 May 2022 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pYRA5QH4iouakvCE0ILtQQLB2x20GDUa4V027uzU95M=;
        b=B/epKmmFajtCBFumscdQdc2Uur7Kf/1E4+SRENRP+879X8tVj279yLnAECXPUkGJru
         D2Xi47zbLpFjoFuabVeZgZkAsh+owFgoQvvCf4l251xTxfaTTTHlU+VV6B30GSkUvu1O
         hEd+NHh78hJnVghUxdVEpDe5JVg0O4+Wz2V6tsaH99MjiOzby9Kwp8IDnBptmOtSo8oq
         vmeHD1rmKuKdjurOKDzy23xWggJYELzJLelX53xIil4+msiKWO1v/SdPoj1gbnY/FFLO
         Q5/HZRDe9e3r0ChbUNpX8E3EjSI2hPo3jutSTDwjjZgoW1O1euX2GxYaB/7ZjXwDDbHN
         lI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pYRA5QH4iouakvCE0ILtQQLB2x20GDUa4V027uzU95M=;
        b=bFfku8IM6s3vXanYTRSlYou6FKo1Q7rJ789Yfl8WstTB90DnWTliNn/AML5vDRJB6Q
         6SN5Rnd+o8sE6wCRvtcpNR9yvKi01gcyYBKkCqNSM6G8OHE+InBnp+yLxUU9YnQn3Jsm
         KzKkhVQ8NxBGq7gYkzVqSSPDB+THZrawSmnOLIqnA3JR45wCDtOQ+74YXF1ULOBiHy1N
         xSIyYZcYHtEZ9Q0ZkT5JMFYv8q6Yhg8UcpfjBzWRKA86Q2bgWzbYT5N0zjfwLQF6tECD
         D28QBOQ2WGQYqSiyyn/So2r4ksVOfPRqD4PfpOrEDNldB9MJIBtDZ8fPzx/HocGOUqzB
         eOcQ==
X-Gm-Message-State: AOAM530eKMjfOPGnPa/TlGPlkAvyyEgk/Owdlv3b0+btE3ep51njIgyg
        jaLbgRleIdmrrvqnl8lWdNOKM8yrenaKxw==
X-Google-Smtp-Source: ABdhPJwoPyC3vwB7/OG1tBYMM1RDnmASoNxrsSEMitpcIxDa9EvTMeePgm+AHtldnhfAANclgiwoEg==
X-Received: by 2002:a4a:d48c:0:b0:35e:aa26:b720 with SMTP id o12-20020a4ad48c000000b0035eaa26b720mr6084976oos.12.1653140570477;
        Sat, 21 May 2022 06:42:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m129-20020aca3f87000000b00325cda1ff99sm2249218oia.24.2022.05.21.06.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:42:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 21 May 2022 06:42:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Michael Walle <michael@walle.cc>, kernel-janitors@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: fix typo in comment
Message-ID: <20220521134248.GA105784@roeck-us.net>
References: <20220521111145.81697-37-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-37-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 01:10:47PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/sl28cpld-hwmon.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/sl28cpld-hwmon.c b/drivers/hwmon/sl28cpld-hwmon.c
> index e2fc60bf40bd..9ce4899a81a5 100644
> --- a/drivers/hwmon/sl28cpld-hwmon.c
> +++ b/drivers/hwmon/sl28cpld-hwmon.c
> @@ -54,7 +54,7 @@ static int sl28cpld_hwmon_read(struct device *dev,
>  
>  		/*
>  		 * The counter period is 1000ms and the sysfs specification
> -		 * says we should asssume 2 pulses per revolution.
> +		 * says we should assume 2 pulses per revolution.
>  		 */
>  		value *= 60 / 2;
>  
