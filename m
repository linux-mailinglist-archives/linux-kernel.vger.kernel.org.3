Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6037A566080
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiGEBJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiGEBJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:09:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AF3AE67;
        Mon,  4 Jul 2022 18:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 531E8B81174;
        Tue,  5 Jul 2022 01:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC90C3411E;
        Tue,  5 Jul 2022 01:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656983341;
        bh=0bXhSKEDoZtsL74HNM3wpJRuF7dDoG5MGtWktQvyyiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Alce4gdQkhsdIA8+iCEyrko8U1tfeHQ8vqN9rKQOIT40R7yf2ogVFakC6KGydeB4F
         6LQ9Z3UKM+Rfmv3XxbVXXEuGJ0uXj0/yY7jBNV37EbHX88vCZlYSRLlUlnJsqYcNpG
         M1beZdV8K/6tdUKESXScM4GC6T5d6f7JoOkwRcRfd+UNFBK49DKzJpnqKcA8opH4dk
         n6jAZ7N3XUVIjOlFZ4aI/3vijWhKliJPlWUnS29f9zOEeh6iEqb80qsCtZ87HzCBma
         0HNukRi2x9+Sk37u9zP+QvRBwZeaNz2dF4nsv1JoyTO0lpabHKn9JztHoNjfFoLreN
         SP1V7tIWt6Jmw==
Date:   Tue, 5 Jul 2022 09:08:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 0/4] nvmem: sfp: binding updates
Message-ID: <20220705010854.GR819983@dragon>
References: <20220630223207.1687329-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630223207.1687329-1-sean.anderson@seco.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 06:32:03PM -0400, Sean Anderson wrote:
> This adds bindings for SFP devices which had support added in commit
> 33a1c6618677 ("nvmem: sfp: Add support for TA 2.1 devices").
> 
> Shawn, I saw that you applied patch 1/4 (formerly patch 5/9) [1].
> However, I wasn't able to find it in your repo [2], so I've left it in.
> Feel free to disregard it if you've already applied it somewhere.

Sorry, I did not push my branch in time.  It's on imx/fixes branch now.

> 
> [1] https://lore.kernel.org/linux-arm-kernel/20220629133217.GM819983@dragon/
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> 
> Changes in v4:
> - Split off 32-bit changes into their own patch
> - Use arm64 prefix instead of ARM
> 
> Sean Anderson (4):
>   arm64: dts: ls1028a: Update SFP binding to include clock
>   arm64: dts: layerscape: Add SFP binding for TA 2.1 devices
>   ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
>   arm64: dts: Add SFP binding for TA 3.0 devices

Applied all with s/binding/node on subject.

Shawn
