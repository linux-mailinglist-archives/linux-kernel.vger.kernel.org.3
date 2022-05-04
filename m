Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9346D519956
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiEDIOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346083AbiEDIOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:14:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCBD1DB;
        Wed,  4 May 2022 01:11:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F2F821F43F34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651651859;
        bh=/jiZgVApvYyURKtaMltQCHC5vAnx+PmRgNJz/ENPruU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JcO/T9fmxesXuqmiI6lT/hvrrsBu0JKyDlpiOKBYugj0SO9wGtNrDasM/4dKi6Jk7
         Gc+/pyCdaj3tY0M8kxGsLHWm5xR/bBhRtFZ/2rxsPohMQPSebWR+/8CnHrZC3YWi9x
         jCTsltQcpeQEtvp3YpBTTX9DxQqEUbCToNIGPDHpjHpUteaaq3ogmjElAFiE3vLmHZ
         DmHIwqDJAeRvnW7vAi6Beao400bkL/S9C/5UDqfWxI/2Af1tj0jeLGvnDKkki5+nf6
         n/GVMOzOGQ+Dd6fVf0VuoQjOcpAzVTJAfr+lKoIvpBxSRj1K/yo7r0kNh00jFBi+3m
         5Qyev2BJjEo6w==
Message-ID: <8e0435e0-d871-c278-3362-d349cbd1f7c8@collabora.com>
Date:   Wed, 4 May 2022 10:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: mt8192: Follow binding order for SCP
 registers
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220503212531.2657870-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220503212531.2657870-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 23:25, Nícolas F. R. A. Prado ha scritto:
> The dt-binding for SCP documents the reg-names order as sram, cfg,
> l1tcm. Update the SCP node on the mt8192 devicetree to follow that
> order, which gets rid of a dtbs_check warning. This doesn't change any
> behavior since the SCP driver accesses the memory regions through the
> names anyway.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Nic, you need a Fixes: tag on this commit, please add it and send a v2!

Cheers!

