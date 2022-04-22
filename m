Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DDB50BB18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449168AbiDVPF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449105AbiDVPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:05:28 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05235D659;
        Fri, 22 Apr 2022 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BbPYA2g9BCFH+kmq6TApdRKCU3T7CZdIzG2vcwbdRVI=; b=2krPnKsoWwNjGdLX2CJsoLh1hT
        DGI/HTmpPKbZ6UhTJqaSWTVEJCigHJBvEKLLPMHSGF/l1jLoy+CN2ueTS8MT7AxYSNss14xZjrOal
        Wi5HKu9YEZ8Av6KSXUJ2w2DDdwv2jarMN8mZ4VtIK0d8bKtCwnnoGd1t+J6wZcEPn690=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nhunP-00GziB-Je; Fri, 22 Apr 2022 17:02:07 +0200
Date:   Fri, 22 Apr 2022 17:02:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 3/9] dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
Message-ID: <YmLDb7SYtCX6Cjc7@lunn.ch>
References: <20220422145147.2210587-1-sean.anderson@seco.com>
 <20220422145147.2210587-4-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422145147.2210587-4-sean.anderson@seco.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:51:41AM -0400, Sean Anderson wrote:
> The TA_PROG_SFP supply must be enabled to program the fuses, and
> disabled to read the fuses (such as at power-on-reset). On many boards,
> this supply is controlled by a jumper. The user must manually insert or
> remove it at the appropriate time in the programming process. However,
> on other boards this supply is controlled by an FPGA or a GPIO. In
> these cases, the driver can automatically enable and disable it as
> necessary.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
