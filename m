Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8158CA84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiHHO0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbiHHO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:26:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F92DEC;
        Mon,  8 Aug 2022 07:26:31 -0700 (PDT)
Received: from notapiano (unknown [146.70.107.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9064B6601C2B;
        Mon,  8 Aug 2022 15:26:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659968790;
        bh=Lmjj/9K8hJ+k57oyBTvp50eiDRhA1CHDdzzZVR6NtzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRPEtsltcdWXIRiiNjCASxDq9fs5Y6Ne/ysFGC4LQbfgq9f7giVHJYbJOdK6tB4x+
         /AvVFGJ9zfg87z7cNnaD51MqHIrWGVK6ZTaUa5JK4PbeGm9aGd1Fsnv7xZi5D4MAKZ
         dH023pAzCEP9IN7TAC5Hr1XFEkuoRHL7Vru0PFaacFc5yBwLPJWIddV73lQVTotwti
         c4/qXZlDBkXwgN+vCzc8cTgtybeF8SEXx2VrczXoaAngd7IQk2HG7QyXBbIzAxDlbd
         f9gPWVA0JafEaBFG627bOKOcw97ehWDWPyZySA1s2QQNFQL0nXQwEVqz0kd3e9zlED
         OfrwLpyXxjGaw==
Date:   Mon, 8 Aug 2022 10:26:24 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, hsinyi@chromium.org
Subject: Re: [PATCH v13 1/1] arm64: dts: Add MediaTek MT8186 dts and
 evaluation board and Makefile
Message-ID: <20220808142624.rdwx7gh5ntlr6oy2@notapiano>
References: <20220802085152.31284-1-allen-kh.cheng@mediatek.com>
 <20220802085152.31284-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802085152.31284-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 04:51:52PM +0800, Allen-KH Cheng wrote:
> Add basic chip support for MediaTek MT8186.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
