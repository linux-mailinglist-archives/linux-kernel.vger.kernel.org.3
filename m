Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0CB56C597
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGIBED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGIBD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:03:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DAB48CBA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 18:03:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so185882pjf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 18:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vFiV4uPA86GqxETpS+6jvd5xGaz91uSwNSUUhka1jIQ=;
        b=RASgpHD5VOrY8b8hszTY7YZ3Yf3LLW7W9qNzgV2RTqEfLVFCuP1BAgekcqFgJV8pxB
         o5n/GKYNYm48Mgi7tzd4/bx1RpKJddZjFW1ywrvVL7+WFOiIGBqGe8her/XEfIgT52rf
         rwW7xJGxWREVqmkLIC8AyFgUwgR9BQc8tpW+I3PsbDhc8cJbJ5oe4MtEcXVKY+kWsFAe
         dl6Rkm1OR6NtXOlpVMbuLCOINSiRc0iRe4H0bWe+70ZOWwbJR92/iYBu3zRzBdacYaKN
         kdWh3NSPD51bqhRTGIDbu9Ak1McO/L6i8t6CGOmqjfUyOnJBjBuQVAKMx6Udn42EsjjZ
         VfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vFiV4uPA86GqxETpS+6jvd5xGaz91uSwNSUUhka1jIQ=;
        b=gYmFECDx+WD0FMUBirj9RaevofbCatT4D6u+W0n5K7VQV3KYkKjWqI0FcJTSbexZnr
         zAsdeGHo1O4sWnNb4Q9Df2ysj12w0Wfq55yJ8O/q/4eOJ1d06xg0KKrDlRHnDravugRA
         fvM9AK5pzkLk0OM4vK2Mqk4dr9p1N368cqwJ3U3agCftkWU8y71wPKxQKp/vb+rE1yPJ
         T2UycIFyrXd274aOFkcsEr35cqgiFfuYvSQvwzbxLR0Re7k2OB4YH33RvFI3xef+ujb+
         91X2PTxseqYPI2frv6Oqosvvj5mclE033NTH/suCLRpYEjSo86y9Qn9l6f+x8YfAW5+H
         i7fQ==
X-Gm-Message-State: AJIora+2snzfKxqqbXaNHVIgYukPMrFTDzSv+Jj4mfonYUphcUmy22xT
        X+C0OsvH6HEI/B7GOWUNawmpGhaQlKY=
X-Google-Smtp-Source: AGRyM1sN/6lJQh9iyX3wZUPhZ0tDTw81TbfkqAA0K7BO9edHyKEqlQbJkTp/yF/BJqS0dVAbmw0qpA==
X-Received: by 2002:a17:903:1110:b0:16b:6968:1d08 with SMTP id n16-20020a170903111000b0016b69681d08mr6313635plh.3.1657328636263;
        Fri, 08 Jul 2022 18:03:56 -0700 (PDT)
Received: from [172.30.1.47] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id be4-20020a656e44000000b0040caab35e5bsm67492pgb.89.2022.07.08.18.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 18:03:55 -0700 (PDT)
Message-ID: <0cef31e4-7e07-087a-1d4b-241cdce76970@gmail.com>
Date:   Sat, 9 Jul 2022 10:03:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] extcon: Add EXTCON_DISP_CVBS and EXTCON_DISP_EDP
Content-Language: en-US
To:     Michael Wu <michael@allwinnertech.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
References: <20220708095714.127736-1-michael@allwinnertech.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220708095714.127736-1-michael@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8
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

On 22. 7. 8. 18:57, Michael Wu wrote:
> Add EXTCON_DISP_CVBS for Composite Video Broadcast Signal.
> Add EXTCON_DISP_EDP for Embedded Display Port
> 
> [1] https://en.wikipedia.org/wiki/Composite_video
> [2] https://en.wikipedia.org/wiki/DisplayPort#eDP
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/extcon/extcon.c | 10 ++++++++++
>  include/linux/extcon.h  |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index d3a32b8064994..774607a616f7b 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -167,6 +167,16 @@ static const struct __extcon_info {
>  		.id = EXTCON_DISP_HMD,
>  		.name = "HMD",
>  	},
> +	[EXTCON_DISP_CVBS] = {
> +		.type = EXTCON_TYPE_DISP,
> +		.id = EXTCON_DISP_CVBS,
> +		.name = "CVBS",
> +	},
> +	[EXTCON_DISP_EDP] = {
> +		.type = EXTCON_TYPE_DISP,
> +		.id = EXTCON_DISP_EDP,
> +		.name = "EDP",
> +	},
>  
>  	/* Miscellaneous external connector */
>  	[EXTCON_DOCK] = {
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index 685401d94d398..3c45c3846fe94 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -76,6 +76,8 @@
>  #define EXTCON_DISP_VGA		43	/* Video Graphics Array */
>  #define EXTCON_DISP_DP		44	/* Display Port */
>  #define EXTCON_DISP_HMD		45	/* Head-Mounted Display */
> +#define EXTCON_DISP_CVBS	46	/* Composite Video Broadcast Signal */
> +#define EXTCON_DISP_EDP		47	/* Embedded Display Port */
>  
>  /* Miscellaneous external connector */
>  #define EXTCON_DOCK		60

Applied it. Thanks.

Do you have a plan to send extcon driver with newly added connector type?

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
