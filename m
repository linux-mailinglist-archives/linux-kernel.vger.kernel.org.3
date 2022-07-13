Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E0573379
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiGMJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiGMJsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:48:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C796CF32E5;
        Wed, 13 Jul 2022 02:48:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z23-20020a7bc7d7000000b003a2e00222acso1980523wmk.0;
        Wed, 13 Jul 2022 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fuphTEp6gNMdkhjIg8cwnYlOV7ZC8UEsafO4euU0qTU=;
        b=OwPBw5/wFhQh1FmCHxrzl4SdPN+VQzIegQ/2l8pFzpnH3QPnIp/195F3g+1vAlBLeE
         ryTCUkvXaqsptU13qkORenx6Q1KXP8Ww94pxUAKuWe1sXHac7Ao4y3CH/SxwBla8VSkJ
         pvA3IMc8wICq+nc0uS0wtpKC9zQeYFrpUzyGiyWENUWu1ymXL0GTz+Q0lIwapfaibVpO
         b4QaDs3EyLprJ5/EEFR8QDshPYHlGxpn/yUHSacDtEO3haidbIDG0o3HJXosz1YRkY63
         5IUs2GthRrSa9hCIKycx1OvLRxazLQJFi8Unp4HTvOahMqwhTM1+a0OG7/D4Qb7+Jz4J
         Hy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fuphTEp6gNMdkhjIg8cwnYlOV7ZC8UEsafO4euU0qTU=;
        b=LA8ORLWeeNY7tY427OxZCS8X2/e12JbKvxgKlb3Nj/wMkLi3L+BCkwEStucD9Me6qT
         KxVqjuROl/mzIEw1sKxEJ5DvUT5BCRQEPed5PJ8fdotlTTgvSilagS0le1JwQdch24Y3
         iNzyUe0X1eAcXtJnciI+yFW2PUj3Ho7QDynmA7yFLtAbnmTW/rDk/24guXWVv9CKD0Rv
         vUUefuQ+3QE9nb9yHRawDN5AaIEmwCT2YuzLqQZNElFwrfMY5Pp2AKEY2TswzySUZEf3
         Z75DO7f5bkpP7Sdi4pb9QkAGS00uM4vEwGNe79MqYT3gFOKOKFwz4TqKtBibiwTlvRgy
         2dpg==
X-Gm-Message-State: AJIora/ErdalqinL9UD9eHW/p4UAUyrsjDkbh2ZmsaYf6lV1XQ8jqagl
        TIlm9zZgd+0T4OyXEn39d7R5zChzHww=
X-Google-Smtp-Source: AGRyM1vGx38DCq5gzzkM1jipHVI4keT4cuLpJSx0FcW/ba8RgyJ051bVK5Io+nAy7+m8m8TR+8ipEQ==
X-Received: by 2002:a7b:c04d:0:b0:3a2:f89d:5707 with SMTP id u13-20020a7bc04d000000b003a2f89d5707mr2501653wmc.1.1657705686310;
        Wed, 13 Jul 2022 02:48:06 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea36f5.dip0.t-ipconnect.de. [217.234.54.245])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b003976fbfbf00sm1677083wmq.30.2022.07.13.02.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:48:05 -0700 (PDT)
Message-ID: <80a11145-36b9-9173-2bd1-ff4c077db9ff@gmail.com>
Date:   Wed, 13 Jul 2022 11:48:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: repair file entry in MICROSOFT SURFACE
 AGGREGATOR TABLET-MODE SWITCH
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220713040916.1767-1-lukas.bulwahn@gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220713040916.1767-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 06:09, Lukas Bulwahn wrote:
> Commit 9f794056db5b ("platform/surface: Add KIP/POS tablet-mode switch
> driver") adds the section MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH
> with a file entry, but the file that is added with this commit is actually
> named slightly differently.
> 
>    file entry name: drivers/platform/surface/surface_aggregator_tablet_switch.c
>    added file name: drivers/platform/surface/surface_aggregator_tabletsw.c
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this file entry to the actual file name added with the commit above.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for fixing this and sorry for messing this up, I should have noticed.

With the appropriate Fixes tag, as mentioned by Andy:

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9bfd69e2b83d..9ec738419526 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13440,7 +13440,7 @@ MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH
>   M:	Maximilian Luz <luzmaximilian@gmail.com>
>   L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
> -F:	drivers/platform/surface/surface_aggregator_tablet_switch.c
> +F:	drivers/platform/surface/surface_aggregator_tabletsw.c
>   
>   MICROSOFT SURFACE BATTERY AND AC DRIVERS
>   M:	Maximilian Luz <luzmaximilian@gmail.com>
