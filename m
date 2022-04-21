Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D7509999
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386028AbiDUHlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385996AbiDUHlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:41:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884581E3EB;
        Thu, 21 Apr 2022 00:37:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2459A61A7B;
        Thu, 21 Apr 2022 07:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C824CC385A5;
        Thu, 21 Apr 2022 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650526662;
        bh=b4j2Og9/SHRS5yriha4XC4sLIfkB0bYffFlnNixYDWw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZZ6HUp3wvTEaNG7Mw8epF95SxeJikxuAkdqStSkmLHepPkDsSFRLbQKroGifJWfnR
         VvNuaw5N4TpA9s0fPLMAQ29qEyJpItOibp8aYlZsrzzIuhSEm3zhDOzlHklGox2Yli
         a20fwHjqp1Kmdw9w6Jl9r2QBIObBhpU35K7Gvf5aH06Or223GhOwSzKKgRW2Aq8emx
         rNgM59shHOV6fuIAutcp/OsKZjOY5akFJIZ5kxO0UaIGiJC2aFTWYvA2FDg9NVtpYD
         VL/kLawYoGx+BbFG9RXh0ApvS9d1dJzU8gJThsF63WngBGBoH/iSkKMNisG1Wa+VTm
         KlSeWvl2NbQ1A==
Message-ID: <af9a8506-7c8e-d76c-c14f-1bf1c913a18c@kernel.org>
Date:   Thu, 21 Apr 2022 09:37:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] arm: dts: Add device tree for bosch acc board
Content-Language: en-US
To:     Philip Oberfichtner <pro@denx.de>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Winker Matthias <Matthias.Winker@de.bosch.com>
References: <20220412101905.514310-1-pro@denx.de>
 <20220412101905.514310-3-pro@denx.de>
 <f2b1359d-a003-ae38-e8af-ab6aa1d0fe72@kernel.org>
 <cd7546a341d475eca99a446b6c8a5141056b3bc8.camel@denx.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <cd7546a341d475eca99a446b6c8a5141056b3bc8.camel@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 09:06, Philip Oberfichtner wrote:
> 
> The "operating-points" and "fsl,soc-operating-points" properties are
> defined in imx6q.dtsi. We are just overwriting them here.     

OK, thanks for explanation.

(...)

>> Please run `make dtbs_check` (see Docs for this) and fix the
>> warnings.
>> Please fix automated check warnings before using reviewers time.
> 
> I built with W=1 and used checkpatch.pl. But I'm having trouble using
> make dtbs_check. Seems like I get all warnings for all possible dts. Is
> there a way to get warnings for a single dt only?

I think no, it is not possible at the moment. I understand it's a pain
and already someone proposed to have a ability to check only subset of
DTS files.

Workaround is to build imx defconfig, run dtbs_check, touch your files
and run dtbs_check again looking for results.

Best regards,
Krzysztof
