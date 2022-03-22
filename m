Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36C44E4133
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiCVO1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbiCVOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:24:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD94D98F4F;
        Tue, 22 Mar 2022 07:19:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 9F78D1F4413E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647958775;
        bh=2ZZiH3Q6QoDzKHSBWyIRldNto/3FwFwrN/F38RcE6Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5WICPDqkPjkv2ZhwlTveB9UxtzmX5E4wncmi9Ziyd6CbKMgZwtyBpgIb7JhyvuhG
         t58Of7F4ECbXqfCKOxpgzIpQK0Ex2YRglMYSlVfuc+MCTK/HyAbw3biC4iE171edH8
         X//Y1FGFuhChsFJtX1ngmIFqxC4+nHAlcjywAUtzNxJhzFZDq047MXnn8unHJtm6xV
         JsrU7RMeNX9VIpRcA/exhmTiQN69hklPbFV0NguvQNKNSb/kqxnnpZIO/gwBCyAMGG
         uCJYyHRegXLoa2WnYqYbiiGasWtZfHldT7oY32nTxvaXzTnmP0DuqqQZpuK/Huhcj4
         B5gTzqBwgGPUA==
Date:   Tue, 22 Mar 2022 10:19:30 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
Subject: Re: [PATCH v4 18/22] arm64: dts: mt8192: Add display nodes
Message-ID: <20220322141930.blpksmixuefhdguv@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-19-allen-kh.cheng@mediatek.com>
 <20220321232657.6z2g3p2aflixzamp@notapiano>
 <28c6f778b312b53ec22aec536dadfb3d7d85c35e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28c6f778b312b53ec22aec536dadfb3d7d85c35e.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 02:15:28PM +0800, allen-kh.cheng wrote:
> On Mon, 2022-03-21 at 19:26 -0400, Nícolas F. R. A. Prado wrote:
> > On Fri, Mar 18, 2022 at 10:45:30PM +0800, Allen-KH Cheng wrote:
> > > +		aal0: aal@1400b000 {
> > > +			compatible = "mediatek,mt8192-disp-aal",
> > > +				     "mediatek,mt8193-disp-aal";
> > 
> > Typo: "mediatek,mt8193-disp-aal" should be "mediatek,mt8173-disp-
> > aal", otherwise 
> > the drm driver doesn't even probe. Typos happen, just please make
> > sure you're
> > testing before sending to the list so these kind of issues can be
> > caught
> > earlier.
> > 
> > Thanks,
> > Nícolas
> > 
> Hi Nícolas,
> 
> Thanks for your kindly reminder.
> 
> There are two compatibles in drivers/gpu/drm/mediatek/mtk_disp_aal.c
> (mediatek,mt8173-disp-aal adn mediatek,mt8183-disp-aal)
> 
> In 8192, We should use mediatek,mt8183-disp-aal because of design.

If that's the case, then the mediatek,aal.yaml binding should be fixed. As it
currently is, the mt8173 compatible is expected as a fallback for mt8192. [1]

> 
> Do I need to add some information for this in mediatek,disp.txt?

Note that the mediatek,disp.txt binding was split into several yaml bindings.
The binding for this node is now mediatek,aal.yaml and can be seen in Chun-Kuang
Hu's tree [1].

Thanks,
Nícolas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/tree/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml?h=mediatek-drm-next
