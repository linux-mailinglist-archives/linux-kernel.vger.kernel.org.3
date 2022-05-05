Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED651BA1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347566AbiEEIWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244938AbiEEIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:20:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A71A49C8E;
        Thu,  5 May 2022 01:17:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7C2B51F40639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651738622;
        bh=DltpyffxGCnMttOdjwga03qATyZuSIFzMUFN/jjVMRY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nThj+bzMWjxKwTmt2qlJ/+Owd47RE6aBL+lcRlbqO+6Q8laog1VGiax1adHrqQ2UG
         ohHy7GxJ8lXqaDdtBfTaqIqdsx6gB0RdnwitY+sB9EFsJU5X0Zyk0tOwGcUzWJB7fN
         XFVA7pWnLXDFWtciW5JvD0XcOl5V0j/8NMr1W2rHcd9GXUEZQ+Fyu4wcnYygDSfLJU
         LD9XrPpU9hR8B6C163mWihj7O0ccB7v4shL4Ind7r0/KHeMVe8r78+wImo4V0RZDWO
         ykRhYsU/zneisYpPwb0aW3aEbDMh0A53YS2tYscUvh0135amNgGhlI0qmQSaPfJqf+
         BzmEvbz+JNBqA==
Message-ID: <0b77cc7d-0595-504c-ab35-2850840dbdaf@collabora.com>
Date:   Thu, 5 May 2022 10:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] arm64: dts: mt8192: Follow binding order for SCP
 registers
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220504214516.2957504-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220504214516.2957504-1-nfraprado@collabora.com>
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

Il 04/05/22 23:45, Nícolas F. R. A. Prado ha scritto:
> The dt-binding for SCP documents the reg-names order as sram, cfg,
> l1tcm. Update the SCP node on the mt8192 devicetree to follow that
> order, which gets rid of a dtbs_check warning. This doesn't change any
> behavior since the SCP driver accesses the memory regions through the
> names anyway.
> 
> Fixes: c63556ec6bfe ("arm64: dts: mt8192: Add SCP node")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Now, that's perfect! Thanks!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

