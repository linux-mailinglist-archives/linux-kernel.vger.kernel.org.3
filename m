Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87D1554AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355237AbiFVNO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbiFVNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9A16556;
        Wed, 22 Jun 2022 06:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA24061A2B;
        Wed, 22 Jun 2022 13:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A042C34114;
        Wed, 22 Jun 2022 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655903663;
        bh=Gj3VM0yeJBj/nRrG6vM2dxW6NSTwd6le7/WSYwfM5+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWA8UbGuCwSOlrs7g7crjz73TBnUWQpzpk2we5f4pjS08i7LVpB1ml3jMgE57zUkO
         rgJa74OXkSHK0yzmUjM3b59zNm6AawKyti+BlJsepv1GEbz33KXp5cmDp+zKoz544r
         SHiSW+OtwfheIjZ3EcXgu3mGvb+LSITJUSYvrO3/LQrvdfzsMKlzGtQvJ+XY0Y2Dnz
         W6qtZtdT/5hymr552yMjLUYAm+zS9DxBOg/UnpA2eE1h7zU8u69MlopfauLds2GXjq
         UqylrPcikT7h9mPqzrVhUSGxyBz3nsHLmgZ7jIIRy9Q+30vyjcCRhUBThlgSobSwWm
         8SYgTdc38x0/g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o40BW-0006Hv-Sz; Wed, 22 Jun 2022 15:14:18 +0200
Date:   Wed, 22 Jun 2022 15:14:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad
 X13s devicetree
Message-ID: <YrMVqifgV4kZaP7F@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-7-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622041224.627803-7-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:12:24PM -0700, Bjorn Andersson wrote:
> From: Johan Hovold <johan+linaro@kernel.org>
> 
> Add an initial Lenovo Thinkpad X13s devicetree.

I'd like to amend the commit message somewhat before this is merged.

> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changs since v1:
> - New patch

I've also done a few minor clean ups (including the include file
cleanup) so I'll reply here a v2.

Johan
