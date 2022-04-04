Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F290B4F1306
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357341AbiDDKVy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Apr 2022 06:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357310AbiDDKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:21:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0703723BF5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:19:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJoG-0002KL-QS; Mon, 04 Apr 2022 12:19:44 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJoG-0010X0-NU; Mon, 04 Apr 2022 12:19:43 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJoE-0006nU-Hx; Mon, 04 Apr 2022 12:19:42 +0200
Message-ID: <1787d3136a36e58e25a5906ac3807f14ed4f5e17.camel@pengutronix.de>
Subject: Re: [PATCH v2] dt-bindings: reset: Add parent "resets" property as
 optional
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Apr 2022 12:19:42 +0200
In-Reply-To: <1648617078-8312-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1648617078-8312-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2022-03-30 at 14:11 +0900, Kunihiko Hayashi wrote:
> LD11 mio reset controller has a reset lines from system controller.
> Add parent "resets" property to fix the following warning.
> 
>   uniphier-ld11-global.dt.yaml: reset: 'resets' does not match any of
> the regexes: 'pinctrl-[0-9]+'
>       From schema:
> Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
> 
> Changes since v1:
> - Use maxItems for a single reset
> 
>  .../devicetree/bindings/reset/socionext,uniphier-reset.yaml    | 3
> +++
>  1 file changed, 3 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/reset/socionext,uniphier-
> reset.yaml
> b/Documentation/devicetree/bindings/reset/socionext,uniphier-
> reset.yaml
> index 377a7d242323..6566804ec567 100644
> --- a/Documentation/devicetree/bindings/reset/socionext,uniphier-
> reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-
> reset.yaml
> @@ -55,6 +55,9 @@ properties:
>    "#reset-cells":
>      const: 1
>  
> +  resets:
> +    maxItems: 1
> +
>  additionalProperties: false
>  
>  required:

Thank you, applied to reset/fixes.

regards
Philipp
