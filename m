Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3505595DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiHPN7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiHPN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:59:51 -0400
X-Greylist: delayed 1316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Aug 2022 06:59:47 PDT
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E6D59253;
        Tue, 16 Aug 2022 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e/P0dZRVpx52m88paCNMNBZULrSwc01U661inww9QsU=; b=dAkQZjGmyeiMijnr1kaFmUYc7Z
        rhU2n+/3qXOA73chZadip7JBKrTxHD9lCube0YK7xTL9Vrr81Jcjr4Wn51G70wXNolnXPJrGOL9xQ
        VQDY6cZ9QmAkkT21DHZ+j4PmKAjg7vnHiz2So2XNLnP4gNMe1zJNR9WImdISvG486PnAH/RSxL9FS
        XUHjGIAxh81nOvFRVuyn5MucSSJJ3+BB92XxstegQcLbLWdXQx2PWC4SF7G1XBf1YtJUgSUNYbYFH
        miQICmEem4emk6wcFgxLMWVVaghGvmker2M7/FDpBtIGfq1LwUhcQfPfY8kwoVFuvQxZil2XDF4jy
        J+97E1Zg==;
Received: from [2600:1700:4830:1658::fb2] (port=38832)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <david@lechnology.com>)
        id 1oNwlO-0000Xz-03;
        Tue, 16 Aug 2022 09:37:47 -0400
Message-ID: <5d816181-65f1-0102-0faa-8940509ef0d3@lechnology.com>
Date:   Tue, 16 Aug 2022 08:37:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] counter: Move symbols into COUNTER namespace
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
References: <20220815220321.74161-1-william.gray@linaro.org>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20220815220321.74161-1-william.gray@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 5:03 PM, William Breathitt Gray wrote:
> Counter subsystem symbols are only relevant to counter drivers. A
> COUNTER namespace is created to control the availability of these
> symbols to modules that import this namespace explicitly.
> ---


Acked-by: David Lechner <david@lechnology.com>
