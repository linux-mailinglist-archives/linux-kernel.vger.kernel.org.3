Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E36F516C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359410AbiEBIjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiEBIjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:39:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49818396;
        Mon,  2 May 2022 01:35:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E4C091F43168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651480545;
        bh=YK5wEWWh4YB18B3xRcTLM7iC/xzpNYQAc6MMPQjZcL4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d4iomLv7VXVraLDf9rRyQDMz8zbCBQKO0YEGXzQgzurDCIBs4jZKnKVKSXEfuiNQe
         lEJuO5CaN1vCLqDm9OgjPddNB2b4AgvNB4Neinbx4lzTfYu4aKLzm6mqyCmiO4uiAH
         SrkNHK0Mw78sj0fo+xu30tQy37IV+Y20KJzR09ifZB/lllbbzZrg2Z8m+LLJ19al+c
         Wlwz609I5ckr7OWkhLnuXZ/BAhzM8fry87sg0k3fe3mXyoqDH/Sb0eRMx0VWI3VOhs
         yJBK9avsEaHV3pe1D9xx2Wwk55i6zwKF8EDeZutPYsh78ZpjfPLbzqywdOgv6hiiE0
         lHTRyzRwproGg==
Message-ID: <520ebc55-448f-c23e-ee1d-bbf0d46e6fb7@collabora.com>
Date:   Mon, 2 May 2022 10:35:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: mediatek: Add fallback compatible for
 mt8192's flash
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220429195745.2203461-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220429195745.2203461-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/04/22 21:57, Nícolas F. R. A. Prado ha scritto:
> The dt-binding for Mediatek's SPI NOR flash controller expects a mt8173
> fallback compatible for mt8192, so add it in mt8192.dtsi.
> 
> The driver already sets custom data based on the mt8192 compatible, so
> this fallback compatible won't be used and is added purely to suppress
> the dt-binding warning.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

