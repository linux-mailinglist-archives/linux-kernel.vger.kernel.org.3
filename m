Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD8C4E52C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiCWNJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244140AbiCWNJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:09:07 -0400
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.47.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2AB7CDD3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:07:37 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id D8C75126BE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:07:36 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id X0i8nRxXNdx86X0i8nBpwW; Wed, 23 Mar 2022 08:07:36 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8+pfNUUQtuD5FnL4aaPjvVlw9+HwXVLMFMf5MupVubU=; b=VokFt6dzrRSC2AKV1MZngq3OL/
        n0xPdGmYBC9TCUnGZKpxWyoaICvTSnxpd8buWdxP/faPIuDNvNCdqy5c1wqviKXmzykPG8dLPEOvD
        /+7ixOiPElxQRHPi0Kf5c6quCAYftYFlviKu/kMt9SoZ6nFGbgTVDghVOzq8ntCggjShFaoAdMfNw
        vo/lNgjZJ7JwLRCAuUGsUk8S8P0zhaq3GSOHTVupoU4jlIkVF1Uw/Wj4nCbiZUNYN27X1QwNUX3+s
        l68n1Uiq5yev8T+xGiG7L91NOvlq8ZtIeDxG5E4xlr63YKrBr2ppTjm2ZYsN3Gqlfs/8RAtvsgfa+
        X0lQztCg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54410)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nX0i8-0019B4-3l; Wed, 23 Mar 2022 13:07:36 +0000
Message-ID: <d6c61a10-e671-3543-5653-ceb3d9ed60cf@roeck-us.net>
Date:   Wed, 23 Mar 2022 06:07:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] watchdog: imx2_wdg: Allow ping on suspend
Content-Language: en-US
To:     Alistair Francis <alistair@alistair23.me>, shawnguo@kernel.org,
        linux-watchdog@vger.kernel.org, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, festevam@gmail.com, robh+dt@kernel.org
References: <20220323115752.360409-1-alistair@alistair23.me>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220323115752.360409-1-alistair@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nX0i8-0019B4-3l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54410
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 7
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 04:57, Alistair Francis wrote:
> The i.MX watchdog cannot be disabled by software once it has been
> enabled. This means that it can't be stopped before suspend.
> 
> For systems that enter low power mode this is fine, as the watchdog will
> be automatically stopped by hardware in low power mode. Not all i.MX
> platforms support low power mode in the mainline kernel. For example the
> i.MX7D does not enter low power mode and so will be rebooted 2 minutes
> after entering sleep states.
> 
> This patch introduces a device tree property "fsl,ping-during-suspend"
> that can be used to enable ping on suspend support for these systems.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

What is the difference to earlier versions ?

Guenter
