Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AB578E36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiGRXSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGRXS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:18:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721CE33414;
        Mon, 18 Jul 2022 16:18:26 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C584C6601A63;
        Tue, 19 Jul 2022 00:18:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658186304;
        bh=UM4gBJ2BtVtD84duWT1ks5rNF+2B9D8ohiEI/ecjHAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyBw7ORsfV6wYz+uF3dMl9dfMnwLCnH4+eMBjvEW1L1CBoE5fShAwFfD/InMUNTfT
         YSfkN8EZrUjOvN5xfhvbjXk6fyMwsZUL6BBcekKJkiH+JlgLIv+xCo+GNb06tVHkhY
         ootcuQKxB9duhelQ9L2p1THTz2UGG3pTo29/Y+Q0uFzKCqjSUhbIFzOiWcCgx6YtMB
         h3r0zkUHU5QsTvJx1j7MAxYrb5HGpxnq3PMYbx4aD6FVl8FhFtngT64jGG9yETf70P
         FBxyOwlLKm6mcwdeTZBJK5yFR2OZqY6De96DVly4u52l7wxDr/CiLYgQRotxdxFj5F
         P8OOq6tUfBJ1g==
Date:   Mon, 18 Jul 2022 19:18:20 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v3 3/5] arm64: dts: mediatek: Add mmsys #reset-cells
 property for mt8192
Message-ID: <20220718231820.j6dxkd5hmfsi6vrq@notapiano>
References: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
 <20220712114046.15574-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220712114046.15574-4-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 07:40:44PM +0800, Allen-KH Cheng wrote:
> To support reset of mmsys, we include mt8192-resets.h and add
> property of #reset-cells in mmsys.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
