Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A845805A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbiGYUaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiGYUaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:30:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8775596
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:30:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u17so4293299lji.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=btEaiFtsICTFV/AyaHnx+0yvOMPc7jvU7OaVLP6uyWM=;
        b=iznzw/oKStcOI0bAGS9Xra6SuSxmspEu4Az+bEP/SGfdhmWF//Rd85HVVNgR7U2jHQ
         ZDsLiKOgnm9Y7/NDvVjAPw49N4pTs28dJeHdktjTHVkDswNLoFr7RJTtuaXbUNSsF/Hm
         e7ry4jVjw+WRVdLhJCXM6RDnX8o6Z7mYid/WibhtZ9cAQKsWSxuWMBRmXE38e+DhOgdz
         sU6CH4p9QhGYQMkyEb/NezOzUHFTsCW4EgZBU0kz0RpWgMd34uZf+JJUbyT0/U2OxUhr
         y+PWqD7j8MNOXKa9WRAa4iKiaOHss86oF1i2OJennBVqtSIhV/uv0Ut6sGpYY3CQZHNw
         2I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=btEaiFtsICTFV/AyaHnx+0yvOMPc7jvU7OaVLP6uyWM=;
        b=tvR8byDZY9UJ7pFesbUPxiTWeyH441Rh8cTs6DjLuFItEZHeaymovOSUtWlKs9TP/d
         cwrqSCRx1tC+V9uoRwgmiAEukgZ2XilVBbHrT4PaVQePjtpeYMEFnQH97Ii1DfIfZtgh
         EIXmQs6N4EBVDFZCbRFvxMm9keuXiGlXFVCB4nWZ/Cs4hlIiIzyat4ZAZetTaNEd43YD
         fWE1exnfDSPeicyO1l/yjB0l7droLSQvLcG7qnShS0QvOOp64WkvCV5OVkC820UQcy0C
         GOwbtXFQSZSkF92RlUdFNoGaxFtxmfcPyW49JHkgh6UP6e4zBOlr43mgFSZJZKT61gyw
         3WdA==
X-Gm-Message-State: AJIora/tounJN+umxZjatYFdgF0b6J2roABqTl2ks76UiSBbs7JcA3Oi
        ylwRo6VJEPY6HA5eFEDNrp4qe/OcpDVgf9hQ
X-Google-Smtp-Source: AGRyM1tbxmNm8XwCIoU51WsIR8IMAhXgQB5jLfTJC+jrrekZqwm3We1fEXUIA+9bwxjz5INhlXwbpA==
X-Received: by 2002:a05:651c:1542:b0:249:a87f:8a34 with SMTP id y2-20020a05651c154200b00249a87f8a34mr4793010ljp.442.1658781012777;
        Mon, 25 Jul 2022 13:30:12 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id bj24-20020a2eaa98000000b0025df34d252dsm1980011ljb.123.2022.07.25.13.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:30:12 -0700 (PDT)
Message-ID: <da6060ba-637e-3733-a489-a1cd7a385150@linaro.org>
Date:   Mon, 25 Jul 2022 22:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 4/5] ARM: configs: multi_v7_defconfig: Enable HPE GXP
 SPI driver
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
References: <20220725201322.41810-1-nick.hawkins@hpe.com>
 <20220725201322.41810-5-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725201322.41810-5-nick.hawkins@hpe.com>
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

On 25/07/2022 22:13, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Enable the SPI driver on the HPE GXP BMC.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
