Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C434BC8EF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbiBSOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:44:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiBSOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:43:57 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836F3F30D;
        Sat, 19 Feb 2022 06:43:37 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a19so20747307qvm.4;
        Sat, 19 Feb 2022 06:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rqiMv2dfBlWYecvEovZ5f/zHHvSjkItcD/1oZautZdU=;
        b=NK408NNIuCtNVAfJSS5eI46y6QyMfuvvpXjju4rkIEcC2fAlJJOKY9VxZ3xXj68yX3
         mdT2V9ng5ErPp/SAsk+CYp7CqK/ltqDKinOpLUhkPgLb2HDvMXnKKbDQWfijDiSxNmOZ
         2sdThZS7C78Iyi8wNt8VE/WhGLdSg/W8LHjAwyGtzT8SrxnmwPp43+2ls6elcGYrpnlw
         DpM5gnhXipk52r0DyenHqTfoy3VeDIvk8KyAhtQ+lQ5qHP0Bsany/mN18eHE4YaWlXYt
         vNJYo2aXIP1qKukcmK0ilCycp7BrmEI19i/45b5R4VVh4OK0w/Pb5BpPLWsbLoerz99l
         Z8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=rqiMv2dfBlWYecvEovZ5f/zHHvSjkItcD/1oZautZdU=;
        b=iZtu4IIRCTWN+fuHGH9y2wlydqVVFphpHQ7IetmmznFBKXWEi66z6Aoj6Ik0TfehB7
         D6/YLj/thbfRB871EX+jURz7dPDyy/UnpRuTS5k7AjXdLH7nVHcKI/Ol/n3PEwvgp6yA
         OzHEpzESkH5Ws78MeiA5teWyTlstoIMaZYYUiNeIUhxqji4F0AR8dgn3Tx6kJ6fV8bbR
         JFQjIi5jRsxbQ8cFKUAlEiXi4ftMhyIEYIJ9f03Nn7yT5jagg4aRq1K4mkK3nt6EeOBF
         gUsF2XIC/s9aCuwv8C5BUv9rvxe7jhJNA4RV+Sluj1f1DMphIuWY/89TwdSd25p5UsrX
         5eOw==
X-Gm-Message-State: AOAM530LcX17nqiGF6RraIkzVyYr632s8jEGosdS/56L8RS7DUr/Byoo
        VCJhg2KlXXBV42x8JlyJYtE=
X-Google-Smtp-Source: ABdhPJx4nPrQ0XqrE7710vUfFYUApYELhFK7b7su7IzOiJ+y7MtQifjcyX6qz71SoFioohDwo02uIQ==
X-Received: by 2002:ac8:5f83:0:b0:2d5:e0d8:a836 with SMTP id j3-20020ac85f83000000b002d5e0d8a836mr10913407qta.46.1645281815915;
        Sat, 19 Feb 2022 06:43:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j19sm21105762qkp.120.2022.02.19.06.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:43:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 06:43:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] hwmon: (dell-smm) Reword and mark parameter "force"
 as unsafe
Message-ID: <20220219144334.GA1032424@roeck-us.net>
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-8-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215191113.16640-8-W_Armin@gmx.de>
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

On Tue, Feb 15, 2022 at 08:11:13PM +0100, Armin Wolf wrote:
> When enabling said module parameter, the driver ignores
> all feature blacklists on relevant models, which has the
> potential for strange side effects. Also there seems to
> be a slight chance for unsupported devices to behave
> badly when probed for features.
> In such cases, the kernel should be tainted to inform
> people that these issues might have been caused by
> the dell_smm_hwmon driver with "force" enabled.
> Also reword the parameter description to remind users
> that enabling "force" also enables blacklisted features.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Reviewed-by: Pali Rohár <pali@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 04a41d59da60..67d63932b48a 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -87,8 +87,8 @@ MODULE_LICENSE("GPL");
>  MODULE_ALIAS("i8k");
> 
>  static bool force;
> -module_param(force, bool, 0);
> -MODULE_PARM_DESC(force, "Force loading without checking for supported models");
> +module_param_unsafe(force, bool, 0);
> +MODULE_PARM_DESC(force, "Force loading without checking for supported models and features");
> 
>  static bool ignore_dmi;
>  module_param(ignore_dmi, bool, 0);
