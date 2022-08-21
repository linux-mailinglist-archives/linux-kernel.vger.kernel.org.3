Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7A59B40E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiHUNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHUNoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 09:44:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E197EF5A3;
        Sun, 21 Aug 2022 06:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9C360EA8;
        Sun, 21 Aug 2022 13:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECCFC433C1;
        Sun, 21 Aug 2022 13:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661089458;
        bh=xQ8ibJ4yx45AT0e3tS3vC0vt5Aci2LGXxlHw2tjJsJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMedxHrHBbv5BwrkR4vFBen/vQuZzj/M6qJGDQPXQnAv1CSSl9nwz/qi1VXFPBR6k
         CkWx1nZUBGmU2ViiYnhYg4gKWtZw7kggTijTURypfLcaG20y+hoPpypUYIlsiWCtfU
         /XFaDQl7qmXBhCAdNzxCsAvwutotqs91L6BYymyf2+RJrT1HUArjYGLirYgip9sNmG
         0XtgXYqPYbo/CtcZdrXpwyz6S42KgjtUFc202q+BY7nZYbO6tSStlmlAwWSOHcibdf
         LA6igncB/Rz0n7d1gvqH2IdXc6GiZp4EiC438GY5okEg5aLw6rFML7eBbwnoCA4KKy
         59AiQLlMv5U/A==
Date:   Sun, 21 Aug 2022 21:44:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ls1021a: Use generic node name for DMA
Message-ID: <20220821134413.GD149610@dragon>
References: <20220807183646.5641-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807183646.5641-1-singh.kuldeep87k@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 12:06:45AM +0530, Kuldeep Singh wrote:
> DT spec expects generic DMA controller node name as "dma-controller" to
> enable validations.
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

Applied, thanks!
