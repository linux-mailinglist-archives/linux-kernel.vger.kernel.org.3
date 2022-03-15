Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1D54DA67F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352674AbiCOX6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbiCOX6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:58:10 -0400
X-Greylist: delayed 1419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 16:56:57 PDT
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.49.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D38DEA7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:56:57 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 0100EE1A8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:33:18 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id UGdJn7ENFRnrrUGdJndKgz; Tue, 15 Mar 2022 18:31:17 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HEFY99UDZaIUfCtZ9L2p6iCk1UNtORB38v8eSsiexn8=; b=Cx6QonKW/5HmkNIbG3vLPCw84t
        48QEUx3V7Sjmfd34Jr8iorwai7194VBnbzG8pwnbzaj1ceaiEyO+G3YwQdX/SeiuJs3Cz9Z0nnGu+
        4e/2hHtqJkPlqScJwxpTzb7tP2EzKHjgv9me0esD0rb1H+2uhIfngKh/t5z2HA4zkdXPuVA/Qs7dr
        lU+6BZzlN0eSdmfPvG0q8phAJ2s/U8/f749Nz57ergPM6r9IVXolwXLhioZFluKDiON8+T/w35d/Y
        g7FtWEgAJLClfGw6+6GJPeFd/MLMM+LJDdvSX09PPgN0dSYw5rJ+5uXSnX8KkyA2dj8x8mXx7W590
        GqO2voCw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57494 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nUGdJ-002Y1Q-ER; Tue, 15 Mar 2022 23:31:17 +0000
Date:   Tue, 15 Mar 2022 16:31:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     cgel.zte@gmail.com
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] hwmon: (scpi-hwmon): Use of_device_get_match_data()
Message-ID: <20220315233116.GA4152815@roeck-us.net>
References: <20220315023412.2118415-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315023412.2118415-1-chi.minghao@zte.com.cn>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nUGdJ-002Y1Q-ER
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57494
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 36
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 02:34:12AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Applied to hwmon-next.

Thanks,
Guenter
