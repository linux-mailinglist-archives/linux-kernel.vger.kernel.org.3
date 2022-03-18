Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020924DD2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiCRCU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiCRCU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:20:58 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.47.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7DD14DFDE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:19:41 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id AE650400C57FB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 21:19:40 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id V2DMnn24Cb6UBV2DMn9HBC; Thu, 17 Mar 2022 21:19:40 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ky8uCgQ2LtJWwLmOZHo0sE79+IbP8XRgDEQpzCPpe94=; b=5dNi3xZZmlGgxC20SVMtph40/e
        7/T0xGM7XYLWNFlmMUAJzpgmX+6bf3ol9Atw2pDZqt299WHClftENgae/pjpDLQOKnHuS/n1jwjVF
        F/8No8HVw5i11YnWgnrvg0uVc56OkGN1Bbb9yk0X0KGR+fXW1GADL/stnhKTss1R7s2lp8s2y84jK
        jEWbvGGSppvo4V16dofsNbt+WjFePDmvrc7xPnk68sRPLMwMWg4qVMyZqEPnphPrwhVfCT9rtKY79
        f8VwRJHmniDitziL5l6nnJcfwIhJNviMOmPJ3MJMJYTkIWeql+XkaaLO7+VzsBPeLy1a5DP3XP2eM
        fLiaRr1g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57532 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nV2DL-003oi1-Sw; Fri, 18 Mar 2022 02:19:40 +0000
Date:   Thu, 17 Mar 2022 19:19:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.15 00/25] 5.15.30-rc1 review
Message-ID: <20220318021938.GC2113234@roeck-us.net>
References: <20220317124526.308079100@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317124526.308079100@linuxfoundation.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nV2DL-003oi1-Sw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57532
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 38
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:45:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.30 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 19 Mar 2022 12:45:16 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 488 pass: 488 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
