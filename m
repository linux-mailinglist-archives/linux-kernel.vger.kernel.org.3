Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE752245E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbiEJSwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245507AbiEJSwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:52:02 -0400
X-Greylist: delayed 570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 May 2022 11:52:00 PDT
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DBD3983A;
        Tue, 10 May 2022 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1652207619; bh=eEMgZINYQ44NSW+OonRUpyj7F/sW+A2Jm9uwvNs8jr4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TpcJSDuUmNMt953JxafvbVtrBCNZSU4KFNH9R8LcqVbMEE+jS9t3DgO4EfiTJqEuC
         SWookCL89KKFGsLJgBkvA8SkmjY45ISwAbh+e05CR5NXVurAFn3Td1rNJZ13LqAXmH
         ennypFhlKI5SbA0jLm73qNQFdA5nwIQ9HnCjy1H/19WKXLucwLIXtsliXXHt3iaj89
         CLm7sk43uszo2mxV1b7yYbK/P1m+a49N2es95no7t+lXhz5Ri66w7YuIBFFGMAoKPv
         LcC9K62uyZnFUWZNAO9+A/unxjlImu1OZ4MmL5BY9WAebqdwj8DNsOTue3iqZfrw6M
         VOOGrb60PUIsQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 444E73B24F0;
        Tue, 10 May 2022 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1652207619; bh=eEMgZINYQ44NSW+OonRUpyj7F/sW+A2Jm9uwvNs8jr4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TpcJSDuUmNMt953JxafvbVtrBCNZSU4KFNH9R8LcqVbMEE+jS9t3DgO4EfiTJqEuC
         SWookCL89KKFGsLJgBkvA8SkmjY45ISwAbh+e05CR5NXVurAFn3Td1rNJZ13LqAXmH
         ennypFhlKI5SbA0jLm73qNQFdA5nwIQ9HnCjy1H/19WKXLucwLIXtsliXXHt3iaj89
         CLm7sk43uszo2mxV1b7yYbK/P1m+a49N2es95no7t+lXhz5Ri66w7YuIBFFGMAoKPv
         LcC9K62uyZnFUWZNAO9+A/unxjlImu1OZ4MmL5BY9WAebqdwj8DNsOTue3iqZfrw6M
         VOOGrb60PUIsQ==
Received: from [192.168.1.102] (mobile-access-5672eb-224.dhcp.inet.fi [86.114.235.224])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id A13493B2450;
        Tue, 10 May 2022 18:33:38 +0000 (UTC)
Message-ID: <dfb390de-28eb-c56e-0283-c3202fab3891@mleia.com>
Date:   Tue, 10 May 2022 21:33:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [patch 06/10] clocksource/drivers/lpc32xx: Convert to SPDX
 identifier
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220510171003.952873904@linutronix.de>
 <20220510171254.717233312@linutronix.de>
From:   Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20220510171254.717233312@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20220510_183339_301208_64D1F334 
X-CRM114-Status: UNSURE (   8.32  )
X-CRM114-Notice: Please train this message. 
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 20:24, Thomas Gleixner wrote:
> The license information clearly states GPL version 2 only. The extra text
> which excludes warranties is an excerpt of the corresponding GPLv2 clause
> 11.
> 
> So the SPDX identifier covers it completely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
