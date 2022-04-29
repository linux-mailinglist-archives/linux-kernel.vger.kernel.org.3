Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540555142C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354839AbiD2HCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351983AbiD2HCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:02:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AB3BC878
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:59:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a21so8002549edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7dcel1unR3OSaS5OenjvPcDKkJcdS5R3C1O6/98GUmQ=;
        b=LQdCDFQTSiKnyVzKBAY6Jqj6ysLz3DCV5cfns3Da1oyHmMbh62opBpARto/wtWTQeg
         OIx5tbIyIlvCz+C61RMpk4q8UXOhtIkDK6GgaT2acdp4jHyO6p7Jmw+Fr1/S6Qi3cDcU
         Ib0t6rlpkPnIgxitjOZdndHjysqgsZLvP9JSPyGiOjBfK+ocsE5WhRSAh35V5b4RJWrl
         fhNxuUiDeKWBn1QAFBjXws/h965X8+5mOFpLCtwooQ51BW5d0YzNAFKas7vRC5daoEtE
         UocMhnb0WoD1NEmaRBkMmNo+q/jfwKsoE7l2dMDVUlwHqe6xAg6aXFcgGtLGsMXWbxcT
         ORxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7dcel1unR3OSaS5OenjvPcDKkJcdS5R3C1O6/98GUmQ=;
        b=0IjT1nC+wYAUKy85vXs3xSZXQ3xmPy963EVGdsVpEctNu+zEHqpveAgLc6M0We0FtB
         jun28lodv/QBBKeCZN93GPMfbyA+x/c+5cFiI7NJC5NDRt9FcB7Vkbd4rKuABOofylYr
         GuO30bcSKqpLtBe4E+EArotRs9BCgnSVwW7VNWNVA89ZyCD7FygCIIHrAnn3SdqorJZx
         IjwcXdj00lgYJPvG0ivG9f6xyckYXhrgWliJPGg99ZLW207PXGK08OgQMIelAFhSRW2v
         qPXy9kQYvyIZhvdnh5fnmOUZnab5mIY3IxK8Gwckt5hSh6UeExCIVTubc8DbEEa468Oj
         ZpjQ==
X-Gm-Message-State: AOAM533QTfKmkt4MYmT7XcY1PJTWZDkYZhlRWqxMZiQ9bcFJpTRbdhcI
        vvgPrLRCxvENyalOQ2qnmsM0Xg==
X-Google-Smtp-Source: ABdhPJx2Ly9+KUtPEJqkBVpf88bhpxc8PjYl3CDeeuNKFo8S5Pz7pwUAz4F/kP8kgjNbBS1PhEA+aQ==
X-Received: by 2002:a05:6402:d05:b0:425:b7ab:776e with SMTP id eb5-20020a0564020d0500b00425b7ab776emr39083670edb.142.1651215571955;
        Thu, 28 Apr 2022 23:59:31 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jz1-20020a17090775e100b006f3ef214e27sm360328ejc.141.2022.04.28.23.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 23:59:31 -0700 (PDT)
Message-ID: <36ebec7d-e09a-241f-c7f2-457af7f19ae3@linaro.org>
Date:   Fri, 29 Apr 2022 08:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/2] memory: omap-gpmc: Allow building as a module
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220426082611.24427-1-rogerq@kernel.org>
 <20220426082611.24427-3-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426082611.24427-3-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 10:26, Roger Quadros wrote:
> Allow OMAP_GPMC to be built as a module.
> 
> When building this driver as a module, the symbol
> 'of_default_bus_match_table' will not be found
> as it is not being exported.
> 
> The of_match_node() call is redundant anyways as
> of_platform_default_populate() already takes care of
> matching with 'of_default_bus_match_table'. So get
> rid of that call. This will also resolve the
> module build failure.
> 
> Move compatible match table to the end where it is
> usually expected.

Don't
use
some
unusual
wrapping
style.

Read
instead:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586


Best regards,
Krzysztof
