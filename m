Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CDD57378E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiGMNhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGMNhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:37:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C9BAF;
        Wed, 13 Jul 2022 06:37:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so3672631pjf.2;
        Wed, 13 Jul 2022 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9VPeTM+RMxSJafERix3xHnha+cDSW/2ONKNAdzCPHC4=;
        b=n33sN1bwpUY+Gktgn67zK6cBJoSZuH1H9e3cexnKl0ZkgVzro+wS7jB75auXt6AYaZ
         2k2Pj+08wHqjR4hw/cbWtDPB8tYx+hFLNpv5wRV4XHoSsY/2xIKiKN02LTIqv6o3XmfC
         /ma0yy9LlOxBj8RO0rsbRBEQF0xoTip/UsQnYkCf+5yptc+62Eu32KMPAg0/GqlXndyo
         VWdowAPjappLAe/S7bpdxCKvBNplwVc917kKXSFodJ/SSI0rFf9Wm7d3bvIYIE9mBAoC
         gO5kaB1wj8+LBtLz9I9J16tMlQNw/MV0tLCYfhnskS+6AZl5+DHfwFBtD5HtOwq9prRv
         s2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9VPeTM+RMxSJafERix3xHnha+cDSW/2ONKNAdzCPHC4=;
        b=I4RY/EEUe+DESlzXc0dvoAyS0Xcd7Y6pczR1zYof7nnFyK+uIHLerB6jD9Jl31Am+N
         K06Ux7Pwq2Mo3qlLJBH09y15M0Eesa/w3D+fsuPAN+ocUZ4a2g4fk4NqoFc3nIK4CScw
         M03D6vMwKT28fQlGFGtjQPXdpuJMRFBIFakhV12p+BpzWWfeNqxAx5452luiJLS8KW5v
         OBLB+D4srURwFrayrvkgS+u3VJC4dhIfRYxibgBwL3QaQOQQAmVjW8hY4keyw81HJErM
         V0qwJDKBoBSThZdN8z1bHchurb1wY95v4Z2PPJzllj8t85GHniUUZ0hTcVvoAk733dtX
         uOYg==
X-Gm-Message-State: AJIora8hf85Snyz9N5hztyYcUZQnmpBVoe8mLSgHGI086puNzohfuoSN
        6fOHo7O0PpFrEKYoqXpoDVo=
X-Google-Smtp-Source: AGRyM1vA10ewwFsWCbXH3EKKgCXDKVAbkS3vZaFRHSOdLBfGedIfAkY8GOFMXXPqyMJjoefhp+8HCA==
X-Received: by 2002:a17:902:e54e:b0:16c:56e:7a1e with SMTP id n14-20020a170902e54e00b0016c056e7a1emr3210051plf.30.1657719471237;
        Wed, 13 Jul 2022 06:37:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902d19100b00161e50e2245sm8739709plb.178.2022.07.13.06.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:37:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jul 2022 06:37:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add missing sensors for X570-I
 GAMING
Message-ID: <20220713133749.GA3732583@roeck-us.net>
References: <20220710085539.1682869-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710085539.1682869-1-eugene.shalygin@gmail.com>
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

On Sun, Jul 10, 2022 at 10:55:38AM +0200, Eugene Shalygin wrote:
> VRM and chipset temperature for ROG STRIX X570-I GAMING were missing
> according to a user contribution to the LHM project [1].
> 
> [1] https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/pull/767
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus-ec-sensors.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 625c2baa35ec..0749cd023a32 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -366,9 +366,10 @@ static const struct ec_board_info board_info[] = {
>  	},
>  	{
>  		.board_names = {"ROG STRIX X570-I GAMING"},
> -		.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
> -			SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
> -			SENSOR_IN_CPU_CORE,
> +		.sensors = SENSOR_TEMP_CHIPSET | SENSOR_TEMP_VRM |
> +			SENSOR_TEMP_T_SENSOR |
> +			SENSOR_FAN_VRM_HS | SENSOR_FAN_CHIPSET |
> +			SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
>  		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>  		.family = family_amd_500_series,
>  	},
