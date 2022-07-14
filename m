Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA775749EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiGNKAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiGNKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:00:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63261A396;
        Thu, 14 Jul 2022 03:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 826E361FB5;
        Thu, 14 Jul 2022 10:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54E1C34114;
        Thu, 14 Jul 2022 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657792830;
        bh=HoH9YJdc2U+sb80GLj9TQU8IV2cMXr3qp2pjDocp0xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVqvxHdjm5/kh1jkEfizpjQRdnJujKLLlp5S3PCueFNHbC8MaYDAA5hqlLM0n+Kyv
         bXtxrqAtMzmWPx7ucIcuMGB9XGHeyyfRYL/Q1C7XJ2JirDWXaCtWz0eUGtL62SGJYf
         O0JZ3e7PMxZZrp9XQn3FT+SbWSjVmWsOsOL7EJXUsizrQpXmfAR6gdfGFleyFZi531
         uEwHRMbafssOa0u5dfeAEm02KI/Z/t32ajV4gQMk48CmWdRDMHZHCjJM+8twTIgrw8
         MrL5UTZ1wITIT57aWE7v1gOf8nFn0K9BXGo1tHh9BhXuhyRbf2bpUOSq1f2t9nju9N
         fnaJhm3Uv0YVg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBve7-0008NT-GR; Thu, 14 Jul 2022 12:00:35 +0200
Date:   Thu, 14 Jul 2022 12:00:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/30] dt-bindings: phy: qcom,qmp: drop redundant
 descriptions
Message-ID: <Ys/pQw3e0HPhLZUg@hovoldconsulting.com>
References: <20220707134725.3512-1-johan+linaro@kernel.org>
 <20220707134725.3512-4-johan+linaro@kernel.org>
 <26916d41-f398-8527-96f4-9a28f4f4e789@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26916d41-f398-8527-96f4-9a28f4f4e789@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:07:21AM +0200, Krzysztof Kozlowski wrote:
> On 07/07/2022 15:46, Johan Hovold wrote:
> > Drop the redundant supply and clock descriptions which did not add much
> > information beyond what can be inferred from the corresponding resource
> > names.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> 
> (...)
> 
> >              - const: ref
> >              - const: refgen
> >          resets:
> > -          items:
> > -            - description: reset of phy block.
> > +          maxItems: 1
> >          reset-names:
> >            items:
> >              - const: phy
> > @@ -376,11 +334,7 @@ allOf:
> >      then:
> >        properties:
> >          clocks:
> > -          items:
> > -            - description: Phy aux clock.
> > -            - description: 19.2 MHz ref clk source.
> > -            - description: 19.2 MHz ref clk.
> 
> Here and in other places - I think you loose information, because the
> frequency is not mentioned in clock name.

Right, but it is also arguable redundant information for the binding
(similar for the vdda-pll voltage).

I can add a comment after the name if you prefer that?

Johan
