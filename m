Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5259C0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiHVNvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiHVNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4471E2ED4E;
        Mon, 22 Aug 2022 06:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2C2D611AA;
        Mon, 22 Aug 2022 13:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18269C433D6;
        Mon, 22 Aug 2022 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661176254;
        bh=/cAXDlxfdqXtNq2EiSdHceUvcnPaNa0w0mmKBDRxaTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVEGPBuXI1lIaWb0vZ7AbB8Bh4pFVa8uYcmwTmCuZYzZ8XlOhFz2AscRUCUHgjY01
         WxwWLAALdKtnt9/PV9aDGvcwj2fr0LOoORwyZFZv8Ds0hpCyDisbvuEIlw8NH3L3id
         Wu4UhnjHyB+oDNU2hlqRCA0bgLgaknVTNRL0VTRFNSc4m2p4UgCosm5NhgmZMBVPVq
         JR6U4v8fvwlTjZKNeXaH5G/6m/lAJqz4lhY1cRI5OEDU7gJQNNchC5cCcTzlUNE1gP
         4fFuxExY5MwhTgZUWfBVJcMLXONUyn2OsmqdAP5mtTQ1KU2vWZX9qUyY3G6qrwKXdU
         ChE3GCV7L2oYw==
Received: by pali.im (Postfix)
        id CB05697B; Mon, 22 Aug 2022 15:50:50 +0200 (CEST)
Date:   Mon, 22 Aug 2022 15:50:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Message-ID: <20220822135050.o4a4bw3dqkmhtjgb@pali>
References: <20220820102925.29476-1-pali@kernel.org>
 <20220822124728.GA3641041-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220822124728.GA3641041-robh@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 August 2022 07:47:28 Rob Herring wrote:
> On Sat, Aug 20, 2022 at 12:29:23PM +0200, Pali Rohár wrote:
> > This new optional priority property allows to specify custom priority level
> > of reset device. Default level was always 192.
> 
> Why do we need/want this? What problem does it solve?

See patch 3/3.

> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  .../devicetree/bindings/power/reset/syscon-reboot.yaml        | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> > index da2509724812..d905133aab27 100644
> > --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> > @@ -42,6 +42,10 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      description: The reset value written to the reboot register (32 bit access).
> >  
> > +  priority:
> 
> A bit too generic for the name.
> 
> > +    $ref: /schemas/types.yaml#/definitions/sint32
> > +    description: Priority level of this syscon reset device. Default 192.
> 
> default: 192
> 
> 
> Though I'm not really sure about the whole concept of this in DT. Where 
> does 192 come from?

Implicitly from the current implementation and how it is used.

> Presumably if we have more than 1 reset device, then 
> 'priority' is needed in multiple places. So you need a common schema 
> defining the property (as property types should be defined exactly 
> once) which this schema can reference.
> 
> Rob

Sorry, I do not understand.
