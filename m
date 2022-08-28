Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294265A3EE6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiH1RgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiH1RgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:36:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C03E140AC;
        Sun, 28 Aug 2022 10:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01AB460BA9;
        Sun, 28 Aug 2022 17:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC922C433C1;
        Sun, 28 Aug 2022 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661708166;
        bh=zk0aZVHiItxWxC0upniYjtmDuwhHEaADU5YLRrj+ZxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZeTrYGelgpW8o1guW26ZZlNZjQaFs6rtHOOR6aJNM3xKbHt4g4Z8R9wld8xFLxAJx
         wVIsW37alkXZzNwzXxtnnqVm3KdkFL5uqPJ+T7OmYlN8qeuBok0Nl8pX4QbCuwnxFj
         AoBhJs7DjSPN0UtcDTdcZ4zJe9Ao2G550k/r0o0dPzkntvFlR8KR3pOBbCbLnt2tdV
         1pKuSUQ+/aHfwEvTk8JWf+hfovsx12KQ/PthVLDMzvo9sImIv/vcyAQIUReNk/zj03
         AFSH6xA1No/e/MZXgBIKHjE2tljQqWtt/QmLDmI3hkTMeIpThZl/a7mc5Ycywj24Fk
         rOSWld2vCFv3Q==
Date:   Sun, 28 Aug 2022 18:01:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220828180050.51c3e857@jic23-huawei>
In-Reply-To: <99dfcc39-ab1b-1b24-c6b2-67de5509f5ac@linaro.org>
References: <20220823145649.3118479-2-robh@kernel.org>
        <99dfcc39-ab1b-1b24-c6b2-67de5509f5ac@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 15:04:33 +0300
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 23/08/2022 17:56, Rob Herring wrote:
> > In order to ensure only documented properties are present, node schemas
> > must have unevaluatedProperties or additionalProperties set to false
> > (typically).
> >   
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it before I push out as togreg for linux-next to pick up.

Side note. Some odd entries in your cc list...  alsa-devel?

Thanks,

Jonathan

> 
> 
> Best regards,
> Krzysztof

