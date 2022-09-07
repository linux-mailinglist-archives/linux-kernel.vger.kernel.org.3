Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A865B0A30
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIGQdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGQdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2CA7E013;
        Wed,  7 Sep 2022 09:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA5D5619A9;
        Wed,  7 Sep 2022 16:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE94DC433C1;
        Wed,  7 Sep 2022 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662568414;
        bh=AAB6Huu3ZlaINnAmbB+e3dt23bU2El2/Mz0SFEyyIxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+8BMs2CzlgjCDzTBmoW489NaCSwLjhVnegzttOeTHnOktXYFDM192XHs4sF2AGc+
         diLyroyG1iD5TvGOdh1CVJnaF7pDtqrqAC6Lw/+jCy9yl39d/Ypjz01evcAK0J6WG2
         dP9UGtbUJ7QoysWRtwjCNSKpPgCC2WeTPmGiTcy8ESQvnjZJs3vbCtZDST7wsGMIqJ
         R4ym//XbwQtYnUk33tBGBH36tim4qSR0J0U56uSYrdA/oYBn/sAPxQrU1igKEgvC6s
         jk2/p93qDyihdy+HC7/HqtbslxyYbODZ/4XJ9EYCs8+yn7ClgGPzDbPd8KcGRZHzFn
         5Ew8iLMWRbjqQ==
Received: by pali.im (Postfix)
        id 4B1FA7F0; Wed,  7 Sep 2022 18:33:31 +0200 (CEST)
Date:   Wed, 7 Sep 2022 18:33:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Message-ID: <20220907163331.zoumcdmmarnbkmm5@pali>
References: <20220820102925.29476-1-pali@kernel.org>
 <20220831081715.14673-1-pali@kernel.org>
 <9a71a2f3-97f6-f3ac-8852-1d3da1a50370@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a71a2f3-97f6-f3ac-8852-1d3da1a50370@linaro.org>
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

On Wednesday 07 September 2022 14:38:42 Krzysztof Kozlowski wrote:
> On 31/08/2022 10:17, Pali Rohár wrote:
> > This new optional priority property allows to specify custom priority level
> > of reset device. Prior this change priority level was hardcoded to 192 and
> > not possible to specify or change. Specifying other value is needed for
> > some boards. Default level when not specified stays at 192 as before.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> Thanks for the changes. Explanation looks good.
> 
> I sent a patch adding the common schema with priority. If it gets
> ack/review from Rob and Sebastian, please kindly rebase on top of it and
> use same way as I did for gpio-restart.yaml
> 
> Best regards,
> Krzysztof

Ok, so just by adding "allOf: - $ref: restart-handler.yaml#" right?
