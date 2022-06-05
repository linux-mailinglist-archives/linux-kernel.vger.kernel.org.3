Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1833C53DD64
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346515AbiFERlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiFERls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:41:48 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E56D255BE;
        Sun,  5 Jun 2022 10:41:47 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w19-20020a9d6393000000b0060aeb359ca8so9279164otk.6;
        Sun, 05 Jun 2022 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7l/0M+AyIL2wnAka/pYwjkcVwlKV7EVM6kl4mjgKPgk=;
        b=lIvhUe2v5nPGbZQxPsw9vndoiGZXXXHYM+zmEsw17VXLnq9A0R/TXZOX6glfKv7rxZ
         CWLw2Z8AkhJpR/Y0+aqkDmEA1F3U6WBw+V/cL1wwy0SYqIkJmuQbNmP7irheuh94FzZG
         PHzua9I8mTsouXby8W98ILGAXog662U5Xu1zG0MhR5lV8trNId6lXYdR9J6/6+OPpDok
         /L6O2Zicxv45bT6bz7RZfndUtyxXIr4NSUHZYsW41fcdL9ZGHKmD1yyjiO1Pl3hBiUa+
         XWGzFhnC9Ea1qx8hR3O79hQZAtMpglmE0GIREavEZhojm1IHaL+xLzKIGeNfiy7a2MHz
         KHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7l/0M+AyIL2wnAka/pYwjkcVwlKV7EVM6kl4mjgKPgk=;
        b=IkM7R6S0YGH1nrTg2TxZMF7uMT7+bObrCelyKdhTB1iblTZDSGcUYoNlSZF5ehAInS
         kOneanSKgF9GdShDx5sCambA1E/dT17qrQaex8aOBzekMXoE8lh/ijQlUS8lpJsLbi8a
         +/BBm8nSCY8Nsnn6BDBFCfUpROcSebvnLI3YvWKd+UUu44qWzyilziTHAv1M9G4hjr9m
         L+BdjP/Y8sNsQTWrFEVWPVE8ZfmGh6vxTroskhxbWqQnB5R4kkGqaoorlUVeO81QQ/sf
         5YI9hkYkD0J4HCXLI4Plf/D8+474Yp37iy+eujjBKB4U7EYgDPkb9k2wRsZFkV+t2UGH
         qfwA==
X-Gm-Message-State: AOAM532kMpknMcknZKAbcFWFvC4DmJXGUHZv8aIiKYf486oETcStU3eU
        yjw1NK1Ob/LSbvR5rBzWjy0=
X-Google-Smtp-Source: ABdhPJxmaRLj+7zzLqVcDkzwFxqgbTe23/4pYuhEqn9iYIhaE0+Vj2dIWoSPRT7IcRvTF+87CWBKQA==
X-Received: by 2002:a05:6830:1bee:b0:60b:25bc:d8e1 with SMTP id k14-20020a0568301bee00b0060b25bcd8e1mr8448582otb.164.1654450906757;
        Sun, 05 Jun 2022 10:41:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p25-20020a056830131900b0060bde07e2d3sm3143701otq.77.2022.06.05.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 10:41:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 5 Jun 2022 10:41:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (lm75) Replace kernel.h with the necessary
 inclusions
Message-ID: <20220605174144.GA3144639@roeck-us.net>
References: <4e07ed43274ad912d4efcfc04f673f25e8f89fdc.1654289489.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e07ed43274ad912d4efcfc04f673f25e8f89fdc.1654289489.git.christophe.jaillet@wanadoo.fr>
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

On Fri, Jun 03, 2022 at 10:51:46PM +0200, Christophe JAILLET wrote:
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/lm75.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/lm75.h b/drivers/hwmon/lm75.h
> index a398171162a8..b803ada5e3c9 100644
> --- a/drivers/hwmon/lm75.h
> +++ b/drivers/hwmon/lm75.h
> @@ -11,7 +11,8 @@
>   * which contains this code, we don't worry about the wasted space.
>   */
>  
> -#include <linux/kernel.h>
> +#include <linux/minmax.h>
> +#include <linux/types.h>
>  
>  /* straight from the datasheet */
>  #define LM75_TEMP_MIN (-55000)
