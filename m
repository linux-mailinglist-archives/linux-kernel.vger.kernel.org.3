Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1B511980
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiD0Nkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiD0Nk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:40:26 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BE54D626;
        Wed, 27 Apr 2022 06:37:14 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v65so1949567oig.10;
        Wed, 27 Apr 2022 06:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yhF0G6yyXaul33YQtZP9cS7G8SlHQ9Le2XaQbFcTYvo=;
        b=SUsmhZGs20++DaCxL7upzoXkA2Dm33XtRqXivIfkZODlAT7QE/Jk/BvTcWT5lLt3/k
         3TTrDFXoFkdEXyJeApS3tp7MxGMnTq0fL1DWsA+oNzXuQ1jQsD4IHzLGxh9NXRe1pxmN
         p9NjQJ6LMjrVwVYPxHC6dKs+bb92+jw9o07tNRh97ma9VtjU5yky3hEpOC5+wGlFNPTT
         g+rI/d+gPXCE+omJagi+o499emwmzpA2273FxrTp91JnXnXIc+dvAhRwurudHiZY3eeY
         dZ+L6FeAUT0b0B/MfTQ4IIRbTcuCYyxtiDlTlnlNgDcN4HjEIE6en8Ij7V0wEBTKJSM2
         GYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yhF0G6yyXaul33YQtZP9cS7G8SlHQ9Le2XaQbFcTYvo=;
        b=vnMlEQ67y2/ECSIU0V9omFi2M/zBsW6I4j/hvEWiyouab71WkU2q4wmqzKQTF65PkO
         ugT0yw6o8/7aUGJMZ32xj4ebgCGgFhATXhJ+w93Jxw1kx6zzhs7oxbjnG2bLcLj3zZAr
         07JRuKVXpAjGTGa6fOOJjbo7U/gZM2xKGjY4l1bf+e3AdyOCuiPRJA6GrU+xVV3wUGBR
         COk8fBUB+4FFcI2tSgFQ6i6CLcuICmEp+wErqfyqf3mrKOK7xpbvrPGrlTK0mTsbFHWc
         urVHTcTRo8oPPNI7xC4LthHcnuj3RtC20fHLZRaVYacldWa9aqilU9AIqLx3e3hoW4+c
         13dg==
X-Gm-Message-State: AOAM530rH9k+TZycf6iXafgEFIh6z8WJse0yOJ7OZG1sFRfFicFILhhi
        Ccc7ITe65z7OsXmCCZnzjAa0Ws8BwIg=
X-Google-Smtp-Source: ABdhPJz2pYe9wnusQC+BCwMLIw1YI1xV8X7qaYNnP2DtrkYyQC4A+AQu40ZHbQRlz8+Z77qeysc4Gw==
X-Received: by 2002:a05:6808:2209:b0:322:bbb4:4572 with SMTP id bd9-20020a056808220900b00322bbb44572mr17131157oib.182.1651066633500;
        Wed, 27 Apr 2022 06:37:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q13-20020a4ab3cd000000b0032830efe365sm6661469ooo.43.2022.04.27.06.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 06:37:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bc46d60e-7c89-ad05-780c-9e9fd19f788e@roeck-us.net>
Date:   Wed, 27 Apr 2022 06:37:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/7] hwmon: (nct6775) Convert to regmap, add i2c
 support
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20220427010154.29749-1-zev@bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220427010154.29749-1-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zev,

On 4/26/22 18:01, Zev Weiss wrote:
> Hello,
> 
> This is v4 of my effort to add i2c support to the nct6775 hwmon
> driver.
> 

Thanks a lot for your effort.

I applied patches 2..6 to hwmon-next. The first and the last
patch of the series will have to wait for DT maintainer approval.

Thanks,
Guenter
