Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E265730ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbiGMIXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiGMIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:22:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43171EA179;
        Wed, 13 Jul 2022 01:20:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B3C46601A33;
        Wed, 13 Jul 2022 09:20:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657700422;
        bh=BRLu8cOK8l/4Ws4rWHe6gFK1hufYAm7DWjojesB8ytU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dhsuyUZcR58ywsv0TAFff7fIptPwtYPMaqeCaUdH18QoPb/VcB1D8Qs7x0ckX/hno
         23co0fc3ELNH9WITEXvLX7lVtsMzUrASk5b4as2gxEOaE0fcCQH7t7h+wCF1CXSRNP
         um0CGo5B/PIvJiavmsu1qQM+/2hWduWdSLQqdp3LoMgBwPUCKNivU+73mVnz0/uzod
         7iWcnOSzljSnKQiK199/ejFLO45VHwjEsc/RRfAjwP5pOo1LEiK+Ch/4cxpcvF0soQ
         MckdbMGBCMBMlZ3lesELnWkcCm27E+Vc/0tBuovkTY2qWqgJeheHbk5bKicgCKxzxr
         zTvPvzKCNSjEQ==
Message-ID: <be0b3f03-b95b-9718-3933-8c79bbfcb3af@collabora.com>
Date:   Wed, 13 Jul 2022 10:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] soc: mediatek: mutex: add mt8186 mutex mod
 settings for mdp3
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Xiandong Wang <xiandong.wang@mediatek.com>
References: <20220711123247.15807-1-allen-kh.cheng@mediatek.com>
 <20220711123247.15807-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220711123247.15807-3-allen-kh.cheng@mediatek.com>
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

Il 11/07/22 14:32, Allen-KH Cheng ha scritto:
> This patch adds mt8186 mutex mod settings for mdp3.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

