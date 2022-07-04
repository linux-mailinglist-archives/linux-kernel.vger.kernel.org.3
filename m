Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1299C565299
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiGDKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiGDKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:41:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F23F5BF;
        Mon,  4 Jul 2022 03:41:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2A8846601986;
        Mon,  4 Jul 2022 11:41:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656931283;
        bh=f3c4kkDwwiCmWpxmDdEeUx88rl6RKNgV+YiQ40P1JBc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ECy7sRKPE1OcYGmjNj9m8CrmuPM8ZkxfyhlN4vC7dPuYOLPZBgKRMB0tiwb4csKVq
         PtxvEYyEafgi3mwrlrnPM2TKxbLXrMGFSO4TEWQvy6F4JX/LIMUhWgpcICd2/F2FXC
         vZDZYOKq1qEFOl8U6R8bEhpUUbsXPwSLZl0TrwJ9yDWg4JE7rXuMWvIPReZwfR6VN2
         u7cfYhde8nlEtgTs/r47EDj0YJA6hE4qkRAn9Q674ySpapS4+fU7z9B5Dgg3m1hPsc
         geIGo1CxbB58FmNsgyrwmUeF+SyUGAcGelhJCuJWOcdWysDFhI5S9InSVj0xme/x1h
         e0WapU90ajgVg==
Message-ID: <b416abd3-32b1-5465-dc9a-44c7e753e8b0@collabora.com>
Date:   Mon, 4 Jul 2022 12:41:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 15/16] arm64: dts: mt8195: Add gce node
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-16-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220704100028.19932-16-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/07/22 12:00, Tinghan Shen ha scritto:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> Add gce node and gce alias to mt8195 device tree.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

