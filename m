Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1715200B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiEIPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbiEIPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:09:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58822685DC;
        Mon,  9 May 2022 08:05:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 9355F1F441A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652108725;
        bh=jwx7aoAOlo/IJzWJjPvpl/xGpjbHcHsD07r0sZmj1yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/4nJIvMOj5TT2NzwztqbxeysgjE5CI478h4wmebsMpDRzoIVTxsDchO+oiTYWCiI
         Bzg4sk/GWak+7NvQQ42YzSfavD5nj0lANWuukpPi+bepSoaSP78RTUbh/uZB1XC4kN
         aLQld3NcAGSH55Sc67tAAZBAmAJybBE6JktNuTKhLRJgJNHeqW9q7jKCbGT+tTZ9Wg
         CdoTa1kCmp49YK82c/w4GWdbvHVh3ctGY54Yx421gzvUqlEKfPi0Zl83OtvsqsQak1
         RaPU151VNrRhR2Aoe+NfL8U/7vR+VMqVvc/jqe8JsKUyzuojOiE0Ma5Pw2MTWcOCOY
         nuW65r2mHlW3A==
Date:   Mon, 9 May 2022 11:05:17 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg
 exclusive to mt819x
Message-ID: <20220509150517.ij5lev2mlcem2epx@notapiano>
References: <20220506213226.257859-1-nfraprado@collabora.com>
 <20220506213226.257859-2-nfraprado@collabora.com>
 <CA+Px+wXQjys8xvTSSJkLXoGp4yQnANbKWBtfuxiYi0UX6DH0jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Px+wXQjys8xvTSSJkLXoGp4yQnANbKWBtfuxiYi0UX6DH0jw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 10:27:18AM +0800, Tzung-Bi Shih wrote:
> On Sat, May 7, 2022 at 5:32 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - mediatek,mt8192-scp
> > +            - mediatek,mt8195-scp
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 3
> > +          maxItems: 3
> > +        reg-names:
> > +          items:
> > +            - const: sram
> > +            - const: cfg
> > +            - const: l1tcm
> 
> "l1tcm" should be optional.  Does it make more sense by using "minItems: 2"?

Hi Tzung-Bi,

thank you for the information. I did notice from the driver code that l1tcm was
treated as optional for mt8192, but since I wasn't sure if that was intended, I
kept it as required for the mt8192/mt8195 binding, since making it optional
later wouldn't break the ABI, but the opposite would.

But yes, since it is indeed optional for those platforms, I will lower minItems
to 2 for them in the next version.

Thanks,
Nícolas
