Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD94AC8DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiBGSuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiBGSra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:47:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CFDC0401DA;
        Mon,  7 Feb 2022 10:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=QN6yfdo8RIWM0BFuvlpHBuhEA39RjktPtMeJoHOPZ3k=; b=FhiBYuqQqKT3nv9OEbw64uUrre
        dkZnveEyOXp6nG2wEHaxtG8QUm2SiisUAuMu3Z6EjbybxnyNV/gJYFQ/q5RjcaIiMsVTc0nSBm5ZW
        z0gr5pT0cFtRc1bDQxNO7e+aKjIU80WgSlcXdNGIpGmTFZJf0Cny5Z+0NoqGKkmaNA6YZDQuHq5ui
        XIpkEh2CIRhp0jcpduFORv1lBxpEnJB8dYfRSqg2QPO+ZyV/Yni5ke903nRPZRADlKI2fE/dPUEmP
        sCHBND9foCAEYyzQGNRnWJFegsszhRKXLPb+wXfVwOXFmx7AQyvIjDzatos2kzr0JbNuNzctfqHXt
        Re+MJDWQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nH92s-001mkC-AN; Mon, 07 Feb 2022 18:47:26 +0000
Message-ID: <7753c65a-ce16-eb4f-395b-bc5e54c647c6@infradead.org>
Date:   Mon, 7 Feb 2022 10:47:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] dell-smm-hwmon: rewrite CONFIG_I8K description
Content-Language: en-US
To:     =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
References: <20220207182940.242838-1-mat.jonczyk@o2.pl>
 <20220207182940.242838-2-mat.jonczyk@o2.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220207182940.242838-2-mat.jonczyk@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 2/7/22 10:29, Mateusz Jończyk wrote:
> It is not the laptops, but the /proc/i8k interface that is legacy. The
> old description was confusing, fix this.
> 
> I'm not a native English speaker, so I'd like that someone proofread
> this description.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> ---
>  drivers/hwmon/Kconfig | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index dd244aa747ad..8f9f41a9ef70 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -506,18 +506,17 @@ config SENSORS_DELL_SMM
>  	  userspace interface for i8kutils package.
>  
>  config I8K
> -	bool "Dell i8k legacy laptop support"
> +	bool "Legacy /proc/i8k interface of Dell laptop SMM BIOS hwmon driver"
>  	depends on SENSORS_DELL_SMM
>  	help
> -	  This option enables legacy /proc/i8k userspace interface in hwmon
> -	  dell-smm-hwmon driver. Character file /proc/i8k reports bios version,
> -	  temperature and allows controlling fan speeds of Dell laptops via
> -	  System Management Mode. For old Dell laptops (like Dell Inspiron 8000)
> -	  it reports also power and hotkey status. For fan speed control is
> -	  needed userspace package i8kutils.
> +	  This option enables the legacy /proc/i8k userspace interface of the
> +	  dell-smm-hwmon driver. The character file /proc/i8k exposes the BIOS
> +	  version, temperatures and allows control of fan speeds of some Dell
> +	  laptops. Sometimes, it reports also power and hotkey status.

	  Comma not needed ^^^; "it also reports ..." would be more common.

>  
> -	  Say Y if you intend to run this kernel on old Dell laptops or want to
> -	  use userspace package i8kutils.
> +	  This interface is required to run programs from the i8kutils package.
> +
> +	  Say Y if you intend to run userspace programs that use this interface.
>  	  Say N otherwise.
>  
>  config SENSORS_DA9052_ADC

thanks.

-- 
~Randy
