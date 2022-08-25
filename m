Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421CF5A13ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242457AbiHYOi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242372AbiHYOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:37:48 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B593B69D6;
        Thu, 25 Aug 2022 07:37:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C17F5C00A6;
        Thu, 25 Aug 2022 10:37:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 Aug 2022 10:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1661438259; x=
        1661524659; bh=uQZAkfIx3BtXGm6NsJ9y2axRk4c1HylK1+1Iy6cM5qM=; b=c
        bRaru4GC2gO7/NsJgLNSC7kPw5lEOXfQhCBenCG+ykPTz9ye7y+CqCzJeq8AEqE0
        GYLg0SLqCPcq17RFjk5QaFP0VPCTsADN7gpBatGAmwILkg4QDrZbnHTKc25eDmMY
        jsUnjB1v2uKCWO3ppIr30qA0OKt7rqs0bCPSJ6QJQ2ujYz4o8Sun54+WoFh8xEsi
        EBiQGvVjObDvfYaRGOWOnALcoOqMCkz1BIZ8z6sxITr46WG/nBNyw1DI166mCG3a
        ucYdoLpAsHrAEhrLD8o7f7O6j+q10F1VjAffT7hrkG8lGgDsubFhOa8PlTL4jgG5
        N3JuEtdTy3g4lZj4i1tGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661438259; x=
        1661524659; bh=uQZAkfIx3BtXGm6NsJ9y2axRk4c1HylK1+1Iy6cM5qM=; b=d
        zCzKqjhUGuHGxMq8DZxIHFgJIN0+PZFEen85/okLW7fnVb9RtTB/XzO/S8XTSVH5
        SDaV4pK3xNTdFVObfPjh/OMsOg+7za5EaZNcnc2GFgktGGR/R8xSc+5miOkLp7c+
        7MjQn/M4WkhWUCWJdFM2SM2HyGikqt7vGiQaGKKh9800dlQeuZ7ej2rzFKITfVQS
        VVM4ek89oEIDz6wlFhiR9Zd7QDH9abVd/Xnf6KKwnZWzYjIuwdjX4LXta+KWrosS
        cujV9P1xiV8P+MVXcCo3n1+wCqt/ZaPv46gV4iBAH5s4duWayYiduDY2+ZYxxiCn
        QrBY1Zcz9Hi6ZV7kx3nuw==
X-ME-Sender: <xms:MokHY9ytPkTelAYkCj0iAzVWDqlrgLIGuw0E_hxgdx2iyzD0l8oFrA>
    <xme:MokHY9TKqbXS0yMdtPT3tS84Lb1DwPQqoF7k8cZgsWUnLSCMRLnfCZEZLjKiKiE7s
    8jhHZ6JJdcCWH3ikA>
X-ME-Received: <xmr:MokHY3UsVrDjl35b9s1YJpNcsdIjn0VHXocn46bjZw51AuAt7y4dqAmZy99kkEWAH4NeC2d2MFdZPNToC6_Vnkt01oSEy9cndwzwnxlAME8Yn75E2j_0Q4yelQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejfedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeitedvhfejhfdvjefggeeutdegteejfffgvedtjedukefgueek
    tddtvdegfedtgfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:MokHY_h3YTcDjZq0MRYPBf26oIlQvEjMzMId5yc-Ay03yFu7MNu2qQ>
    <xmx:MokHY_CoLAv5UX4krtnT5UK1jnBH7SrUcBfwqNTlOYvd21H11pHC9Q>
    <xmx:MokHY4Iq8j-Jkd-3UOB6BRLmn4qtxtYRxkv46gHUHCLyDlnJso79wA>
    <xmx:M4kHY_wMZpDE9efVbs_vbH2-tFpL-K1rK9zFl-k-J0r4XT05Xy_C4w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 10:37:38 -0400 (EDT)
Subject: Re: [PATCH 4/8] dt-bindings: sun6i-a31-mipi-dphy: Add the A100 DPHY
 variant
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-5-samuel@sholland.org> <YwdRvBSGDNIUOMnH@aptenodytes>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <95464d37-6da5-1f63-8f21-93ede5666312@sholland.org>
Date:   Thu, 25 Aug 2022 09:37:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YwdRvBSGDNIUOMnH@aptenodytes>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 5:41 AM, Paul Kocialkowski wrote:
> Hi Samuel,
> 
> On Fri 12 Aug 22, 02:55, Samuel Holland wrote:
>> A100 features an updated DPHY, which moves PLL control inside the DPHY
>> register space. (Previously PLL-MIPI was controlled from the CCU. This
>> does not affect the "clocks" property because the link between PLL-MIPI
>> and the DPHY was never represented in the devicetree.) It also requires
>> a modified analog power-on sequence. Finally, the new DPHY adds support
>> for operating as an LVDS PHY. D1 uses this same variant.
> 
> Do you have some pointers about that? I'd be surprised that this PHY is now
> used for "traditional" LVDS display output, which is usually done with a simpler
> LVDS phy attached to the display controller.

Yes, this is documented in the A133 User Manual. As for the BSP code, see:

https://github.com/Tina-Linux/tina-d1x-linux-5.4/blob/master/drivers/video/fbdev/sunxi/disp2/disp/de/lowlevel_v2x/de_dsi.c#L773
https://github.com/Tina-Linux/tina-d1x-linux-5.4/blob/master/drivers/video/fbdev/sunxi/disp2/disp/de/lowlevel_v2x/de_lcd_sun50iw10.c#L390
https://github.com/Tina-Linux/tina-d1x-linux-5.4/blob/master/drivers/video/fbdev/sunxi/disp2/disp/de/disp_lcd.c#L786

Regards,
Samuel

> However I've seen that some new Allwinner SoCs come with sub-LVDS camera input,
> which typically requires a more complex PHY due to the high number of lanes.
> 
> Anyway for now this is:
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Cheers,
> 
> Paul
> 
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml           | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
>> index cf49bd99b3e2..b88c4b52af7d 100644
>> --- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
>> @@ -17,9 +17,13 @@ properties:
>>    compatible:
>>      oneOf:
>>        - const: allwinner,sun6i-a31-mipi-dphy
>> +      - const: allwinner,sun50i-a100-mipi-dphy
>>        - items:
>>            - const: allwinner,sun50i-a64-mipi-dphy
>>            - const: allwinner,sun6i-a31-mipi-dphy
>> +      - items:
>> +          - const: allwinner,sun20i-d1-mipi-dphy
>> +          - const: allwinner,sun50i-a100-mipi-dphy
>>  
>>    reg:
>>      maxItems: 1
>> -- 
>> 2.35.1
>>
> 

