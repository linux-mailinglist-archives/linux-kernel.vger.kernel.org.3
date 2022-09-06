Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680CF5AEFAD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiIFP5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbiIFPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:55:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D0BC08;
        Tue,  6 Sep 2022 08:14:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D3B861578;
        Tue,  6 Sep 2022 15:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0FFC433C1;
        Tue,  6 Sep 2022 15:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662477270;
        bh=RLlUXBr0FaAsDnl8Ie0mfXsc/byo4dhX3a94fKTzjPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCNfY/kCJGVj78h+KkI3jQAx4S+APJm00Q+lMeI0F58fBjRvI40vxAWAe6iiqWxDP
         SFlilTUYQc2EETQnbmjCv9amwz7FMtP8HfvtUvkceH3dcz34HvJuvmtLpWELulY82Z
         UebZVOjZzkKRg8fIwh0drQilzw9pqJOr5IJk9RQnDsbdHG8Svsd8rrdUpPKxLmxrkB
         qROkPDN26kNlxNM+ezbPfnPYenyauu6AnODn3+nblNoBxM/PZdDVvchaICNATO5SEz
         Z69pj/JlDHobGst4xSwABGJYKRtuF9yUiUIuJ2+DPeV97nVGEo5FqvJiIYY+X1gxm/
         JC1mtnCuzPf8Q==
Date:   Tue, 6 Sep 2022 16:13:54 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mithil Bavishi <bavishimithil@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, contact@paulk.fr
Subject: Re: [PATCH 02/10] dt-bindings: power: reset: Move twl4030-power from
 mfd to power/reset
Message-ID: <Yxdjsn8dDfsj58ZP@google.com>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
 <20220820071659.1215-3-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220820071659.1215-3-bavishimithil@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022, Mithil Bavishi wrote:

> Move the documentation for twl4030-power from mfd to power/reset
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  .../devicetree/bindings/{mfd => power/reset}/twl4030-power.txt    | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{mfd => power/reset}/twl4030-power.txt (100%)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/power/reset/twl4030-power.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/mfd/twl4030-power.txt
> rename to Documentation/devicetree/bindings/power/reset/twl4030-power.txt

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
