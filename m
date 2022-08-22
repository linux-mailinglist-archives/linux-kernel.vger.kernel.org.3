Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56C59B738
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 03:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiHVBTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 21:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiHVBTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:19:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315751F2C2;
        Sun, 21 Aug 2022 18:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7511B80E6C;
        Mon, 22 Aug 2022 01:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01961C433D6;
        Mon, 22 Aug 2022 01:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661131145;
        bh=F/UGwewF4mPFRBR0jrY5Fq+g9EQZvayg2l6RScAg6O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRZxjJiMckUnw3/kV9yPN60Yk4hY4e+aodQD+FdYcmdltX6ddI+eIoh5h2WxW6t/a
         j331wG//s+eYyveu5K6x66Zj0J4NXV0Xd8MPiFmxeAevc/+xLJoewZ09SkdQKxsEoF
         iO/RziUcvUxsQLKU9x6+tuPuuvD1OwfjecPntmAD0KhK082rtlfFu148U0upnTTSwN
         7e74tOyqkysf5G+Ajp7EJD+sxaVcYeP+RG5Ypva9nVHJg0pMdqea2ksbjrbbr9yKCR
         zo8yDSqVlN9rJeKVXUs2P1vjnM29CroapnkZLvncyqiL38ZZwEOF16AaV76In2pG2K
         5KVlO5fYaQG3g==
Date:   Mon, 22 Aug 2022 09:18:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610: align SPI node name with dtschema
Message-ID: <20220822011859.GG149610@dragon>
References: <20220810111053.281003-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810111053.281003-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 02:10:53PM +0300, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
