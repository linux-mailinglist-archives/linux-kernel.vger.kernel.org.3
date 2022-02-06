Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CCA4AADF5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 06:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiBFFdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 00:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBFFdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 00:33:14 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE1C06173B;
        Sat,  5 Feb 2022 21:33:13 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so9941988oov.3;
        Sat, 05 Feb 2022 21:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MDwo1QignIVmB9o/CHw5md1FjaCAoJt0+t4hgZ76n4k=;
        b=Ro9lbYd46vZhD5iB3lGlnpfI0K/fSBCxaQH60HL4hY1Sd+vwjJYmnXRwe6Ab/a3N27
         btjwGxB1cKNKVgkhqT+LeUmenrboGbi8sXG1Jv59eugwo+C4lQ7rgjF655N9kVyDE3T7
         kOaRRTcepyvsaWo7D9nA3spXl8VILyaQ9FJSMtpgKASrRGpbAPVpXiXBT38MzD5EKY09
         QmFaDSr1wmlxTnUDB6N7ap1SOxaP7Z+ZU/e0FQGhN+QaQ9pbK3xmUM5sr9o5slbvVN/Y
         u22/+U8WIrZZEM7uYdKWSGz9wx0p/0iDbGJPhwoAGyhOPd/+vsEhlM/uhxAdiWa8cgBt
         twUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MDwo1QignIVmB9o/CHw5md1FjaCAoJt0+t4hgZ76n4k=;
        b=xVckakbkA7IOJvJv9Kxb2ENlZpmsBFLmvD2+we7na1wCLMDfgq7LI6AiJlnXZRJcXJ
         hpJABcmWZHQapNWA1PWQxdrdo++da5aZgAz0/PhRgDGFQphIl9/bzKN08Z2qR25ZlP0W
         d46P95fEMTnvx/ZGtx08nkfO8cDpsbOPINoVqXhLi4XFb7IRQuUG07py4T/R8rYfdJNi
         zOlRM2WKiUrbsAdbQUk6uhxm8ekhsTj30d8L3sBBSqNoP8/jDwykMSB9hSbt9YyM+iYw
         1KZGrlfWYtRp3KgUS96xV9RwIsoEThJSe9VHWPeKmd5ygUILcZrK2N++QM2fhS14Ftyt
         CKEA==
X-Gm-Message-State: AOAM530W7/CABU7/tn9mPbocoB3+wbmDG0JlKeWHwnFoS6DzZrSmRJEu
        NeOhl1IN9iuxeQI7jQlf/DM=
X-Google-Smtp-Source: ABdhPJxepkoupKH3w33rjx0UGoytxYV1Ko641roE4vZtXBtqhX65mttCOM97I/Zy5Bik6d89dGs03g==
X-Received: by 2002:a05:6870:6296:: with SMTP id s22mr2630790oan.231.1644125592001;
        Sat, 05 Feb 2022 21:33:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 124sm2759971oif.7.2022.02.05.21.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 21:33:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 5 Feb 2022 21:33:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Add Steam Deck driver
Message-ID: <20220206053309.GA3140643@roeck-us.net>
References: <20220206022023.376142-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206022023.376142-1-andrew.smirnov@gmail.com>
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

On Sat, Feb 05, 2022 at 06:20:23PM -0800, Andrey Smirnov wrote:
> Add a driver exposing various bits and pieces of functionality
> provided by Steam Deck specific VLV0100 device presented by EC
> firmware. This includes but not limited to:
> 
>     - CPU/device's fan control
>     - Read-only access to DDIC registers
>     - Battery tempreature measurements
>     - Various display related control knobs
>     - USB Type-C connector event notification
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-kernel@vger.kernel.org (open list)
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
...
> +
> +static umode_t
> +steamdeck_is_visible(struct kobject *kobj, struct attribute *attr, int index)
> +{
> +	return attr->mode;
> +}

This is unnecessary. Using attr->mode is the default operation if there
is no is_visible function.

Guenter
