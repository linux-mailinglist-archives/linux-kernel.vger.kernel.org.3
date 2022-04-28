Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4482F513541
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347296AbiD1Nh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347280AbiD1Nhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:37:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38763ADD73;
        Thu, 28 Apr 2022 06:34:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 25E171F4043E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651152877;
        bh=GU8omeXrJMfiZadEv1lU4ULMJLZKc5nKhQvVWYR6Kng=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zci5EGF3w5QPmXuuq1SwposSe9d6KMSH+Ii9J0t8fDkjJ+2m3YGMhkSwg7zkTynOT
         w/Aa2fGUruj+UOOaLFTBHP7XSnhvs+VZnu/ZSce56t3dJYtlEuH4YzuTnuuAU4uiV/
         4v7+SZ41eHXIbheZq9MCva6QLsLleUNuaKmNUPBk5ridkPajUXpjB/SavbfR2aDPYu
         eUMpp4ABATl2qO7Ussp78Jy9en/I6kxjO3Fviszdp2mRb7jpY+rx7G+NrfxApud6Rx
         NrVK166N4mB+o0OPyfdt4yfop/8p1Dyp+ln8isOFls/tXHIqkKSK/Xgpp7mRlgY0gQ
         s4QpN720ZSaKQ==
Message-ID: <8007e692-7a67-2930-709a-494d4e7df1de@collabora.com>
Date:   Thu, 28 Apr 2022 15:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add compatible for MediaTek
 MT8186
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, hsinyi@chromium.org
References: <20220428061717.11197-1-allen-kh.cheng@mediatek.com>
 <20220428061717.11197-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220428061717.11197-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/04/22 08:17, Allen-KH Cheng ha scritto:
> This commit adds dt-binding documentation for the MediaTek MT8186
> reference board.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

