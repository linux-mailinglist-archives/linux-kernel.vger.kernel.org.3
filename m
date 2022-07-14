Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7929C574924
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiGNJgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbiGNJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:36:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970E03718E;
        Thu, 14 Jul 2022 02:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19AF5B823DA;
        Thu, 14 Jul 2022 09:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73595C34115;
        Thu, 14 Jul 2022 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657791368;
        bh=6MIUuvwdVpJ4tK1rbwNOev3l1SYrBB/w4GMGLdGU6sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLubpj75G9oFRJH1WLpBEJaKWFTpChk/WQIOVn6p+VOolGCbg405INhs9InkfmAgX
         0YJVvED8VC2/6Rcm6tpLhKnPPEvyA8GAEBWJ/9fSnKl8o5FoCjXuehwB7jNhmOFvVb
         a9kcfiXani+hCEfiAE8Zm67PQ5rlvVhOLK7twbiUz+WWWoP5fn6def4yK0LyZqBsIu
         9MqyOAfLhOBeS59D23Brrpb081+fPRu406W+0f1Wc1lHhjZDLmpM4uTyj9cgTTfzMC
         XPc5EoYNgBVFIloNs8yEIaQ8w/jS1YbG8J5dl2RsGAO4PAD8lvR0bSYDUVauvL8ymx
         Lx+Gq63UMGfqg==
Received: by pali.im (Postfix)
        id 6763F1295; Thu, 14 Jul 2022 11:36:05 +0200 (CEST)
Date:   Thu, 14 Jul 2022 11:36:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
Message-ID: <20220714093605.wdyrcxehg2ij5lvx@pali>
References: <20220713125644.3117-1-pali@kernel.org>
 <a9e1ccb7-6caa-2f7c-b879-b3ff4945794c@linaro.org>
 <20220713200336.addvyfjhakrx72am@pali>
 <7a4fba17-9c71-a4e6-643a-62aa0dfd4774@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a4fba17-9c71-a4e6-643a-62aa0dfd4774@linaro.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 July 2022 08:56:12 Krzysztof Kozlowski wrote:
> On 13/07/2022 22:03, Pali Rohár wrote:
> > On Wednesday 13 July 2022 21:42:43 Krzysztof Kozlowski wrote:
> >> On 13/07/2022 14:56, Pali Rohár wrote:
> >>> All Armada 3720 boards have Armada 3720 processor which is of Armada 3700
> >>> family and do not have Armada 3710 processor. So none of them should have
> >>> compatible string for Armada 3710 processor.
> >>>
> >>> Fix compatible string for all these boards by removing wrong processor
> >>> string "marvell,armada3710" and adding family string "marvell,armada3700"
> >>> as the last one. (Note that this is same way how are defined Armada 3710
> >>> DTS files).
> >>
> >> Please do not introduce some changes just in DTS, but start from the
> >> bindings. Someone wrote the bindings like that and expected to be that
> >> way, so first change the bindings with proper rationale. Then change the
> >> DTS files.
> >>
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > Ok, I tried to update bindings and fix example in it, see patch:
> > https://lore.kernel.org/linux-devicetree/20220713200123.22612-1-pali@kernel.org/
> 
> The reason you used here should be expressed in that commit as well

Which I exactly did (Armada 3700 = famity, Armada 3720 = SoC, Armada
3720 DB is name of the board with Armada 3720 SoC, so correctly indicate
SoC in example). So what else?

> because you change the ABI and affect other users (projects, systems).
> 
> Best regards,
> Krzysztof
