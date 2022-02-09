Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7855C4AEA9C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiBIGuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBIGug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:50:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB2BC05CB89;
        Tue,  8 Feb 2022 22:50:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8E60B81F17;
        Wed,  9 Feb 2022 06:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAC9C340E7;
        Wed,  9 Feb 2022 06:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644389437;
        bh=JSJwDcbl25E7GeKEJiknWA5JGfaS90PWnKx+WSo1apY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMkcO8ZH1YlVYScW2HeQm/OeIdK9FEKYed+6ncWysIIRtpeYQexvhX9+pGMAbs7H1
         fFoW4vv9GwI95ISZknyKrMXbf6hzbGn/agg0NzmNkWeb1xmq0PepOcqEZaL+9P7Fo8
         MCZlDC/Ri0IegMbF8YfKernDlQHRKbt2s4lwp0nJR7qjwXyt9XGZvcUSyzXILM1Sts
         nEY58MRmQpMXnS8PKE71gWRPeV7AkfZFdIEWIdmgWqakQvr6v5EvzKKrvmUtex1nYx
         ovWkXvON6T6HN8MSLRwA0UJa7jGy0rn4+Hi8i2Rsse8dDkWUdR0GejlDgcViXgfITO
         HxtnrVamffXig==
Date:   Wed, 9 Feb 2022 14:50:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: fsl-lpuart: Drop i.MX8QXP
 backwards compatibility
Message-ID: <20220209065029.GA4909@dragon>
References: <20220118135918.2126010-1-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118135918.2126010-1-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 03:59:17PM +0200, Abel Vesa wrote:
> Drop the i.MX8QXP backwards compatibility with i.MX7ULP since they
> differ from clocks handling point of view.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

I tried to pick up the patch, but it failed to apply to my imx/bindings
branch.  Could you rebase?

Shawn

> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index aa83cbf56d59..ff364bd0fbac 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -20,11 +20,10 @@ properties:
>            - fsl,ls1021a-lpuart
>            - fsl,ls1028a-lpuart
>            - fsl,imx7ulp-lpuart
> +          - fsl,imx8qxp-lpuart
>            - fsl,imxrt1050-lpuart
>        - items:
> -          - enum:
> -              - fsl,imx8qxp-lpuart
> -              - fsl,imx8ulp-lpuart
> +          - const: fsl,imx8ulp-lpuart
>            - const: fsl,imx7ulp-lpuart
>        - items:
>            - enum:
> -- 
> 2.31.1
> 
