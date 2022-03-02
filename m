Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF92D4CACB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244321AbiCBR65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiCBR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:58:55 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657364D255;
        Wed,  2 Mar 2022 09:58:11 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id j8-20020a056830014800b005ad00ef6d5dso2385382otp.0;
        Wed, 02 Mar 2022 09:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YqVBhVqe5MYviwVOxLCvP7dI88ZNTXrDmSDZWqdPlQM=;
        b=K5AI8uJfZvHjAN5SUvZTjirGEItnDBilpvwDyqwnP7ROHQ5bTfyVsgUTjY8RYkMwro
         l5/KhYRHRGK7ZKVr7ZX41OxxINlyzkSEPg/G3HiemevuUeSQfqAtljCiH+gCYSjso/kP
         kyVvUCJRUm9Dp2o8FSfs88qWavdqSbUhgeCVonktDqw8PmX5xWarHyE1DkHEzxb3GAt5
         adO79z8533eW6NzeS7XsuXznP0hWqcTewmb5Jwj19ZVAww5xzg6VIU+97q9oAYHmrG1p
         ZlNQOXbfumpUoKsMIZi4wFoaPv9mBJkWPX51XZ/tmLudx+8y90Cyvr14BqracCdgRxn1
         zOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YqVBhVqe5MYviwVOxLCvP7dI88ZNTXrDmSDZWqdPlQM=;
        b=jUgjGXiF0Uia3IjxLiTHbp+rgvKCeTCRRGmqQnsw0GRq89RWl4xglacrjnacqUWEcE
         znqDnpY8U1E9HTNq3oiodCVlHfOIM/xzc64HHZUvAhlxL0XjlzIYdjUOhzkPw3ctDYyY
         ArMklaVyudkwu+7BEqCuRoza56LWVrn/Qn7W8o5l+0E13HQDNJQiXJg+7xJSGi1MxorP
         rI1+s7C3btvAIwcXbhK0SgSCZZ6OHTK5wAps5Mk6zpuQDwcYQ7lDypK1jYVt6D7nb76Z
         YL8WYvN3fW8+dV+IGh9IynYTSzKS004x2LtwcVRWgQxavR3YFyn4V8riZLv8kG+qDf9d
         sJBg==
X-Gm-Message-State: AOAM532+B+GoDEFgks+E7iWE3NcJeEkYIJWw70yPu7O9g2uTzOuFpVys
        0GLeQDNqZFLZH6NygRkN6yQ=
X-Google-Smtp-Source: ABdhPJx1trZa9r7MEYprOsxVsJZc9cwS3IrXTYhcFKbfOXt+fAN5NkPwoItGLYWqwdWOG7OR/7c0cg==
X-Received: by 2002:a05:6830:192:b0:5af:898b:3f88 with SMTP id q18-20020a056830019200b005af898b3f88mr16884037ota.100.1646243890822;
        Wed, 02 Mar 2022 09:58:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000d6bd82a92fsm8209636oab.18.2022.03.02.09.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:58:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Mar 2022 09:58:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Williams <patrick@stwcx.xyz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/2] hwmon: (adm1275) Add sample averaging binding
 support
Message-ID: <20220302175809.GA2522981@roeck-us.net>
References: <20220302123817.27025-1-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302123817.27025-1-potin.lai@quantatw.com>
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

On Wed, Mar 02, 2022 at 08:38:15PM +0800, Potin Lai wrote:
> This patch series allow user config PWR_AVG and VI_AVG in PMON_CONF
> register by adding properties in device tree.
> 

Series applied to hwmon-next.

Thanks,
Guenter
