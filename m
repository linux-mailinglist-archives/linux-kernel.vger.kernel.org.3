Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4457A515702
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiD2Vmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiD2Vme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:42:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B92ABF6F;
        Fri, 29 Apr 2022 14:39:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id EF97B1F44998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651268354;
        bh=WK4FKxae6LiE0ifOj5eYluz18VJJvRL3D1Oio2jffCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7tQBYWieqJk/kul1aCTNMBZGLJonywzSUcjW69kxCCY+dOCDNEbVaEDvQWMvZ3x2
         qiDmZJwvKW2XuNOi23eg2IG/UgSXjEoU4H5AFxaqsa6qyQ6vO2lf+QAV6kfcoUsJOt
         S+suDoPEZyHlAZlwt1MRmDJvnnOuL/WpIkzjWukKrGPBM9iMCwJRtTExYhCCEXSCd1
         DNL8BfDCCwqKciTaPJE9oCr1iVpKBjuZ0WJnl8Gvs7Puqsp54Jsq0nyLme66MnEzbw
         QjB6+wUxMBJp4Pf2fO+VNxsvMGzMocMH0pvKKr4/6SCrtyhSm++W5FV5atqfc4/K7W
         vA8Y0VpysqLVA==
Date:   Fri, 29 Apr 2022 17:39:07 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, hsinyi@chromium.org
Subject: Re: [PATCH v8 2/2] arm64: dts: Add MediaTek SoC MT8186 dts and
 evaluation board and Makefile
Message-ID: <20220429213907.d2lwnukugoa7owxn@notapiano>
References: <20220428061717.11197-1-allen-kh.cheng@mediatek.com>
 <20220428061717.11197-3-allen-kh.cheng@mediatek.com>
 <20220428172736.qlkinujpxjxumsnx@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428172736.qlkinujpxjxumsnx@notapiano>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 01:27:41PM -0400, Nícolas F. R. A. Prado wrote:
> Hi Allen,
> 
> On Thu, Apr 28, 2022 at 02:17:17PM +0800, Allen-KH Cheng wrote:
> > +		scp: scp@10500000 {
> > +			compatible = "mediatek,mt8186-scp";
> > +			reg = <0 0x10500000 0 0x40000>,
> > +			      <0 0x105c0000 0 0x19080>;
> > +			reg-names = "sram", "cfg";
> 
> The mtk,scp dt-binding should be updated as it currently doesn't allow l1tcm to
> be missing. According to comments in the driver cfg is optional as well, so a
> patch to the binding making both optional would be great.

Hi Allen,

actually I've just sent a patch for this myself [1], as it was also required for
mt8192-asurada. Sorry for the noise.

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220429211111.2214119-2-nfraprado@collabora.com/

> 
> Thanks,
> Nícolas
