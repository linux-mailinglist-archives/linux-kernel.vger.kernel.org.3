Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B244A5930A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbiHOOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiHOOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:24:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C183237D0;
        Mon, 15 Aug 2022 07:24:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5476623A;
        Mon, 15 Aug 2022 07:24:19 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B3D13F66F;
        Mon, 15 Aug 2022 07:24:17 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     robh@kernel.org, liviu.dudau@arm.com,
        krzysztof.kozlowski+dt@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: arm: juno: Remove legacy Coresight 'slave-mode' property
Date:   Mon, 15 Aug 2022 15:24:10 +0100
Message-Id: <166057205600.3028788.8763427332853911221.b4-ty@arm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220721212952.1984382-1-robh@kernel.org>
References: <20220721212952.1984382-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 15:29:52 -0600, Rob Herring wrote:
> The 'slave-mode' property is not valid under 'in-ports' as it was the
> legacy way to find input ports. Warnings are generated from the Coresight
> schema:
> 
> arch/arm64/boot/dts/arm/juno-r1.dtb: funnel@20150000: in-ports:port@0:endpoint: Unevaluated properties are not allowed ('slave-mode' was unexpected)
>         From schema: Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> 
> [...]

Applied to sudeep.holla/linux (for-next/juno), thanks!

[1/1] arm64: dts: arm: juno: Remove legacy Coresight 'slave-mode' property
      https://git.kernel.org/sudeep.holla/c/2a9eb57e20e6

--
Regards,
Sudeep

