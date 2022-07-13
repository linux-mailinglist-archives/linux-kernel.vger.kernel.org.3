Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F505730D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiGMIVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiGMIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:20:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851A413D0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:16:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE96A6601A33;
        Wed, 13 Jul 2022 09:16:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657700197;
        bh=R2PxcQlGqCPfLT0tv7PApqY13Oo+XyU+FcKDR3vX5yw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SrFsjNOdbmRGVH79LEvg4jRc+889XWLFYjVaRcA4paF+BEJuUITYvTa1Q73oi6eAj
         DYEoW+L82lnMrP9S2bcLNNcnJsxayrJ8MmDr8zI2mrKD3x7zG+5IdChqSyGBZRGL0j
         KUobuPxuSGfuw0VLkQvvK9uY8Qd0e/B3wemvujNQIOmgCXD9ZybTi2iN0bKqzk37FA
         5yP5dFj7aS1Ku/WCcz46zhMxiyziHBk3LqcrqN2uK2GU0oPDxsdcB62ZrzXs79GUzX
         /Sz9361pBfUpDbUIWANo8vMoMjxHIqObbIbmZiCe3tD7RVbgVo7zqGOEq7PXZ9/xd2
         sChuVxGgssbgw==
Message-ID: <16fe2bd2-bc9b-f2a1-8d82-f8f089d36f37@collabora.com>
Date:   Wed, 13 Jul 2022 10:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Use dev_err_probe on port
 register fail
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Prashant Malani <pmalani@chromium.org>
Cc:     kernel@collabora.com, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220712214554.545035-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220712214554.545035-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/07/22 23:45, Nícolas F. R. A. Prado ha scritto:
> The typec_register_port() can fail with EPROBE_DEFER if the endpoint
> node hasn't probed yet. In order to avoid spamming the log with errors
> in that case, log using dev_err_probe().
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

