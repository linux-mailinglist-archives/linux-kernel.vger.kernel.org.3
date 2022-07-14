Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61ED57494E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiGNJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiGNJoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:44:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D381260F;
        Thu, 14 Jul 2022 02:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6287B61F68;
        Thu, 14 Jul 2022 09:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C93C34115;
        Thu, 14 Jul 2022 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657791853;
        bh=AaG5DijCBCbZIPwIggTULO+h15a919z2ZS94dMzJroY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbIP8/t/lBeB+OdaUEhX2HsSDs06lOpzNUScj7RaB7i/msLrjMmTTqB2d2NF+3Qzm
         4JuGWMqkXa4D6vUvwE/zFCsVuowFSGC5wkfuvJl/S2QHtdJT/21/FzZ1bJVTkSU/ox
         90iF1pBXes8zbxXd8kwlU7M8DJptdOYmvvF1DfpZB1kVaFHcaGdmgRhhS4ONArmNxE
         p7tDJ0+fir60cv6cVKu7aGLiZeE0nJtMLrlGXBhkALr+CzxWNIUgXZW6DFK6iaBPmF
         4k0/Pmgkv+GnGQ79B+Ok3pobjvVAif/I32B/sLFixvL/f5LqPdKWF9X98X+tOpNxVC
         GorCtotJOL/sA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBvOM-00057B-1x; Thu, 14 Jul 2022 11:44:18 +0200
Date:   Thu, 14 Jul 2022 11:44:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/30] phy: qcom,qmp: fix dt-bindings and deprecate
 lane suffix
Message-ID: <Ys/lct4Dc0o426xy@hovoldconsulting.com>
References: <20220707134725.3512-1-johan+linaro@kernel.org>
 <Ys/QBPJmkWO6O3Fw@hovoldconsulting.com>
 <5187985c-7f86-320b-aee9-a1107c8ce0a7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5187985c-7f86-320b-aee9-a1107c8ce0a7@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:31:22AM +0200, Krzysztof Kozlowski wrote:
> On 14/07/2022 10:12, Johan Hovold wrote:

> > Any further comments to this series?
> > 
> > Vinod, I noticed there was a conflict when rebasing on linux-next due to
> > commit 85d43a69db2d ("dt-bindings: phy: qcom,qmp: add IPQ8074 PCIe Gen3
> > PHY binding").
> > 
> 
> I got few comments. Apologies for a slow review, I am a bit overloaded.

Heh, no worries. Review within a week is awesome.

Thanks for taking another look.

Johan
