Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE343512464
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiD0VSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiD0VSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:18:00 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881E44D9E3;
        Wed, 27 Apr 2022 14:14:48 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id z2so3383162oic.6;
        Wed, 27 Apr 2022 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=561YrT69nk0DWKNHd3eP9JJUDLgbOiO8rQpf04ht9Wg=;
        b=JJwp5TRlxexJwAz0C+j3WowYh4glfTn16Pr/+8luldcUWvTc0hW5dPurNQkd34v59Q
         CvNVqjtFINCmc9YHgI6NhSEClIZqPSMxUqccL5kiNFxc73nYRyZ2FbkOQkcK8pg7YzdO
         Arau/41aEs4ccIxz3jsE4laoK24EKff+VFcTDmq3HL+cdLrn7mBfS9zKB6y7ySVK9hNW
         ZBIi7SgUFmMMlOrcI7fcR4ogWuurTKKen+AjiwD1CtzKUR2xtL8GtY8jkVZ2YT3ShzIn
         kdV9aFBTs5VUdunmGMMBWv4LHjEloXSo3KecSqmAf6WUhenwMSHdUA4sD5TFqviXlkQT
         liHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=561YrT69nk0DWKNHd3eP9JJUDLgbOiO8rQpf04ht9Wg=;
        b=4Xq6HgvyIgyvr95yYDGrqAm7hIIPBorpg02E4iPic+hJ2fdWD31TbQAMutBZQjE5/X
         kJvIWPJd/1cnSPj835GTpSfwRFOPJ0msCJx+Mg30wXn4l2fdRhryg/1lGMNWkqG6j+Eb
         VbSxyN9xaBupqNP7Ig+oOEaOLocEKONWKAb/YS07s8jCK3/vklqNJJXXbTkvaEDe878t
         REuCKjj5UhQsIqKlHfFrimzQDQh9wXwCbd3YU/nzF8SwfODTST770bjXZ75c4tBAJ8cr
         WF0k9QPxNmcTGtO4O5VRMd0GrZJvCIbk5rpKo21vr49ryFPjG5k3Oa/Q5FnlR4eYuEDv
         pCXw==
X-Gm-Message-State: AOAM532dBX/Sdmnz79Na8u7ZtDK9yOe4pCZNd4ZleljohAQiS0CIhqZA
        ou4lzDRiKNXtyE9alnq/xu4=
X-Google-Smtp-Source: ABdhPJycktFkkpNFRLymu2HEinZsWKpanCsXFrtS7XBY2e4q8HiAymex8cKpfMNj3rJgvA0fI4zH9g==
X-Received: by 2002:a05:6808:15a7:b0:322:be0d:556a with SMTP id t39-20020a05680815a700b00322be0d556amr14053788oiw.85.1651094087917;
        Wed, 27 Apr 2022 14:14:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e7-20020a056808148700b003252f1da45bsm3953124oiw.38.2022.04.27.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:14:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 27 Apr 2022 14:14:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add doc entry for PRIME X470-PRO
Message-ID: <20220427211445.GA3217307@roeck-us.net>
References: <20220427180237.1475954-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427180237.1475954-1-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:02:36PM +0200, Eugene Shalygin wrote:
> Add PRIME X470-PRO to the list of supported boards.
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/asus_ec_sensors.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index 36ca531d32dd..1700fe619597 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -4,6 +4,7 @@ Kernel driver asus_ec_sensors
>  =================================
>  
>  Supported boards:
> + * PRIME X470-PRO,
>   * PRIME X570-PRO,
>   * Pro WS X570-ACE,
>   * ProArt X570-CREATOR WIFI
