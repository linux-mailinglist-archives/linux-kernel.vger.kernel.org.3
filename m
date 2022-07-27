Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DB2582739
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiG0NAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiG0M76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:59:58 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B373E77D;
        Wed, 27 Jul 2022 05:59:57 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10d6ddda695so22529176fac.0;
        Wed, 27 Jul 2022 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a0DmGg0JIp0Zp/9VQLWAQ9V8gjmWQSxY/8mrp7VzZkM=;
        b=IQHEMwAjhAxVeHBbnNF3nYUeyUyT6A2fnyIgul8BPhU+7xy51w48ROG4kARGrIgTQM
         q/ODaginwZqJ1QJUjgEU4SusrF8AGmcwwngRA5cnHOcZkqJERmN5D2Xr4z+09P9OBHMC
         2RwgLpO82Pux3p5WyHV17XaWl6s5NzYoTai2S4Kd2ZlxR8hcSrLPcfLSD8UQmRVs8HRi
         FQdIvww+oOkb9bG7kkmGEw+WWFrxTu1Arn6q4cOTyXa7gRxhL/0fHBEdSab1jkP+GfpU
         AKBrfT2owP3rwI88UOMZvzLNo0xDehOvmwJg8DYlv3IKQt81vvHifDT3hrfzDKX2Rjey
         sPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a0DmGg0JIp0Zp/9VQLWAQ9V8gjmWQSxY/8mrp7VzZkM=;
        b=mKTyzC2bIO81fN6GdjuKd/kOah54VIPX6RW4cseLUf0CTb8LsmfOu54rS9+ptBogJz
         Mnr72bcdKcDm+HktLp4KoBKDZh5KD92AvplPMVsxoV+y6O7Ym4yiz74RiJ5URyjDHTRB
         CgIaJ86EHdNVDS1bxZp9jRb57hzoGoDREya1sgt9+w2nEC2iyDnXsIfSPU+MMWCDvAFj
         LmupPWVhNTOoW5g1BYjz3P1bVYbWI5LrbTlP9EvdsIputg/VoZHlLV6MeVJWBUC07oiZ
         WQVDY3vH90cFmFB2dJo7BI6k2uT36MKfmD1X2PTg3AZ0Ha7yBXsg1jEVCqrf643QXwyq
         z63Q==
X-Gm-Message-State: AJIora+LHw3FJWTl6I/J/rxBpnlGZaSjhNHHdFnnzd2Yxw9fOVlVqtkY
        jtMeUb52bpVvtUvjdhmfKNA=
X-Google-Smtp-Source: AGRyM1tTYbID95XUFJav5r2BCxzQxtIadm9c4gsLJNmxBqfsbH/NF7jO/w6nsmErwCv9Dw/I0pK9LQ==
X-Received: by 2002:a05:6870:b52c:b0:10e:4488:6cf2 with SMTP id v44-20020a056870b52c00b0010e44886cf2mr2041525oap.58.1658926795817;
        Wed, 27 Jul 2022 05:59:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c10-20020a056830314a00b0061c564a83ebsm7442676ots.19.2022.07.27.05.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 05:59:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 27 Jul 2022 05:59:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Improve documentation
Message-ID: <20220727125952.GA734857@roeck-us.net>
References: <20220727083004.5684-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727083004.5684-1-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 10:30:04AM +0200, Armin Wolf wrote:
> Notify users of this driver that each pwmX
> attribute controls fan number X, meaning that
> probing of pwm channels is unnecessary.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/dell-smm-hwmon.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> --
> 2.30.2
> 
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> index e5d85e40972c..d8f1d6859b96 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -46,6 +46,9 @@ temp[1-10]_input                RO      Temperature reading in milli-degrees
>  temp[1-10]_label                RO      Temperature sensor label.
>  =============================== ======= =======================================
> 
> +Due to the nature of the SMM interface, each pwmX attribute controls
> +fan number X.
> +
>  Disabling automatic BIOS fan control
>  ------------------------------------
