Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D975101BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352163AbiDZPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352338AbiDZPXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:23:04 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C10C1759EE;
        Tue, 26 Apr 2022 08:17:00 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id j25-20020a4a7519000000b0035e6db06150so1114565ooc.6;
        Tue, 26 Apr 2022 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JMv0lACNSYZoaK4Imij/2QqoYoRHCxnEs4tYjd0AuZY=;
        b=nF81iYuyzj2BsCHaIPslpKnx4nDb5cAJ+C2ZnzS7poY9waQZjFtmRKhfZwY2tByMwa
         C2CW5JzL3SfXKFhbz5xJKR3DO8ato84l8Z0aMtLcsCe6DOXr1iLv0gJAeGQ2fBd6drbB
         6mJ+R+JQzHA0w2EFP3M26J8Y0yh4ZFZl6vCXYDeBgZvVOg13WddhnxscdKusx5c2U5oL
         b/sZdIslprpaRMUF//yyip7DXQUMJjCaxMO6SApZ3JKdT9y+H2QBUPUYqh3X7SBuCGU3
         xDCvXv8iiJclRUzBSi/0zHp3o0qZZQ4mSqTZlY1r0pSw1DX61zZJQ/0Xh8/ft4i/ZJ2D
         BmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JMv0lACNSYZoaK4Imij/2QqoYoRHCxnEs4tYjd0AuZY=;
        b=DoFodKVgWG2KPcvj+7ZclXiCulZ2FpByf3x+MkqAjZkTbU/wNQYji1Cl6AxsI3YVnf
         PstPerdRJj+vVegF4K3LEMl3zGGPI8eEINoeDazlsvXuYdaFjZSndUNSnj9J6jrM/B+L
         Kbyt8a6eu4tuezfFwH8mQCZ6WBu65LVqh2YfkYH8uArQ4DJ6nGnEOH9c0fmmRElM5Nm9
         88GZkW804/lo+kVwZkTwNeFFFJeH9/oU2QM63r70GGVlqUGtpS9a7ICmqYksSdkdjfIF
         ZYS5IsXvcKccoJWjOlTF2fG49MgHqoVP8uYjX556IyLjlI1E/lv45LiMIofM5Ik+el0c
         il2g==
X-Gm-Message-State: AOAM533fLYJv3W0euIJqLu5Iqh8plGjUTRdezSox9S+i/13xbnCdxKvh
        PuC7x/QZLb7i5lkKJ0MZjSk=
X-Google-Smtp-Source: ABdhPJyHAw9fGB73HaOb1RQA+A+aDbE1QKOQv61rWFhkDPkMLHpMbaUo7MAJPP6SW7kOpAsYEspI3Q==
X-Received: by 2002:a05:6820:151b:b0:33a:6aa4:2d6e with SMTP id ay27-20020a056820151b00b0033a6aa42d6emr8474432oob.54.1650986219219;
        Tue, 26 Apr 2022 08:16:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j19-20020a056830271300b006057ca85f79sm4998706otu.62.2022.04.26.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 08:16:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 08:16:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
Message-ID: <20220426151656.GA3119637@roeck-us.net>
References: <20220426092340.495704-1-eugene.shalygin@gmail.com>
 <20220426092340.495704-2-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426092340.495704-2-eugene.shalygin@gmail.com>
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

On Tue, Apr 26, 2022 at 11:23:37AM +0200, Eugene Shalygin wrote:
> We need to keep some more information about the current board than just
> the sensors set, and with more boards to add the dmi id array grows
> quickly. Our probe code is always the same so let's switch to a custom
> test code and a custom board info array. That allows us to omit board
> vendor string (ASUS uses two strings that differ in case) in the board
> info and use case-insensitive comparison, and also do not duplicate
> sensor definitions for such board variants as " (WI-FI)" when sensors
> are identical to the base variant.
> 
> Also saves a quarter of the module size by replacing big dmi_system_id
> structs with smaller ones.
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> ---
...
>  
> -MODULE_DEVICE_TABLE(dmi, asus_ec_dmi_table);
> +MODULE_DEVICE_TABLE(acpi, acpi_ec_ids);
>  module_platform_driver_probe(asus_ec_sensors_platform_driver, asus_ec_probe);

Since this is now tied to MODULE_DEVICE_TABLE(acpi, ...), I think the
probe function should be referenced in asus_ec_sensors_platform_driver,
and it should be module_platform_driver() instead of
module_platform_driver_probe().

Guenter
