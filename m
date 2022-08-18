Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73930598FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344417AbiHRV7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiHRV7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:59:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1398E25E81;
        Thu, 18 Aug 2022 14:59:46 -0700 (PDT)
Received: from notapiano (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F5776601B46;
        Thu, 18 Aug 2022 22:59:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660859984;
        bh=Ywr+TRyo5kID6vdf/Ha5uTtV3PhPkoYBPghVaG7zL0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BacyDNYOHPFdC53DYZfM88pvN/PGaHbIqwvTh3QEO5GAUjuLicPbqx6QX0Ii6l85M
         4DpQHF36npu9SyYbqJ9t4c4WOE3nYiy0FEgmSQZ11QeADi/Eax46U9uloiuIs/oHxb
         ozgIlBMoHadbXBV3m5FhpMua6z+xlCT7il6RfqygnkNlkn8iG60Gx7X/kAT7JRhefF
         9v5bh8XuvBUbB8yuVGBrjpIYcN/TTPxEIERh7DsQpUL7aAzrkTJWsfs4dfbsc4p2Y7
         RZlsiPQesHSpcs7C5hlXboWxO13XUeYSncO6X/PCO7KkZjTUCS4IIxXERRehbBEKqo
         Hg9shXZpTpt7w==
Date:   Thu, 18 Aug 2022 17:59:38 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v25 00/10] Add MediaTek SoC(vdosys1) support for mt8195
Message-ID: <20220818215938.w6sgdp5tpvf5eert@notapiano>
References: <20220711075245.10492-1-nancy.lin@mediatek.com>
 <0afc69a72a4c55b17f8b626d43a08ad56ada64c5.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0afc69a72a4c55b17f8b626d43a08ad56ada64c5.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 06:04:08PM +0800, Nancy.Lin wrote:
[..]
> Hello Matthias,
> 
> This series is about mmsys configuration of external display path.
> 
> It is in version *25*, and it is reviewed by many reviewers, like CK
> and Angelo.
> The reset.h is also reviewed by Krzysztof.
> 
> This series is also well tested by Rex-BC and Angelo.

There is actually a silly but breaking bug in this version [1] affecting a lot
of platforms, including mt8192.

I'll provide a Tested-by tag for mt8192 in the next version, just in case. (If
you can, please CC me, Nancy).

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220818214715.spbyic34szubx3gi@notapiano/
