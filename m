Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5AB5533C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351714AbiFUNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiFUNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:37:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A8255AF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:35:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c21so19000458wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=qqTNqAOeKdNu0PJecSUXPJEvq/QznEHwzYVjdroUPXY=;
        b=1+2MA1gKXKsyI+zQ6hjv+gzIYSGFYfWQpC4wuEyIur/bKKXffQ90R9NQ2TQFbriijc
         /PnZwA/yGte87aVaJ+f9rus8f1xJY/cJ4IqqWrfEHoEjtWU5pH7FPeks7I/a0chx0Svv
         V+uKONK2DGLSVR6O/gd2PQwFmZf97xuv24UNOhxMvnzOP8b7RqXrNjFxJMbr6JpT/qv/
         k9ZoPHPkntMSyBPI3wTcdiFqjEHjQQHfNpVFtn/Xz1r+gjeD0IeaXSCL9vw4wfY0tRGx
         Rhv/wQCaqhajSdgBd14IlPAtS3S/coVtM2VHncbq+pyCeZNPACwDXl/i7NyMgz+pRrpE
         2h4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=qqTNqAOeKdNu0PJecSUXPJEvq/QznEHwzYVjdroUPXY=;
        b=7xjK8MFsLpny/1gm5vDxl+qt4Dk+faXMeNVPAXMmnRfBV4d1t6Ra0bE1orx/JjfwsO
         XFtCr12lcX5V6oMUQtTHEb50LrUiHwO+jTpVUA194MfOS4wfJfvyMScZXXOubFYk7Xkb
         9eZ6n9LLavuBmR0XqVp4RCJH5CJeCJhXWBVXKPN47Nsxh1WhWeOCu7JaKtTygoEPRvda
         zWsdj5jyAEfr14UCWLcnU4UFBqF7iGAsFyLpyCjN1QoQcnFBBaMc4J2O6xGwO6XBnsrQ
         jbHFMKJc33g0gjik7RJi4ZApOBpoh/nL6sBCgJ9Wnb8lDY92Dp5LSgDud40apF/6O3uB
         C7vA==
X-Gm-Message-State: AJIora9CY89IOWJitvLN+ELpMSewfio1VHPCVVhUrzZcraA2vn+cWFiP
        jVxxPCpnBEZKanm6osfbCn3zzg==
X-Google-Smtp-Source: AGRyM1sc4Nuf15EPxf/o4rS6i+04DqBqjCot5RM6I5P+/fHFVBB1ZthkIsqn8RvpWF8Oc1aTu4LGbQ==
X-Received: by 2002:a05:6000:1e01:b0:21b:9a9a:6aee with SMTP id bj1-20020a0560001e0100b0021b9a9a6aeemr2618293wrb.678.1655818556373;
        Tue, 21 Jun 2022 06:35:56 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:9f05:9492:230:f51f? ([2001:861:44c0:66c0:9f05:9492:230:f51f])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d488d000000b0021b86dbad37sm10239199wrq.68.2022.06.21.06.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:35:55 -0700 (PDT)
Message-ID: <432dc551-9e52-137b-3762-1726a9ef087f@baylibre.com>
Date:   Tue, 21 Jun 2022 15:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] phy: dphy: drop unexpected word "the" in the comments
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>, khilman@baylibre.com
Cc:     kishon@ti.com, vkoul@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, victor.liu@nxp.com,
        andrzej.hajda@intel.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220621120015.113682-1-jiangjian@cdjrlc.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220621120015.113682-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 14:00, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: ./drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> line: 139
> * when in RxULPS check state, after the the logic enable the analog,
> changed to
> * when in RxULPS check state, after the logic enable the analog,
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>   drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> index fdbd64c03e12..32d1ff09befb 100644
> --- a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> @@ -136,7 +136,7 @@
>   /* TWAKEUP. */
>   #define MIPI_DSI_WAKEUP_TIM				0x20
>   
> -/* when in RxULPS check state, after the the logic enable the analog,
> +/* when in RxULPS check state, after the logic enable the analog,
>    *	how long we should wait to check the lP state .
>    */
>   #define MIPI_DSI_LPOK_TIM				0x24

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
