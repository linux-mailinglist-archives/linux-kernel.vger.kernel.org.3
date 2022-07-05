Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B78566EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiGENFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiGENEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0606A2CCA0;
        Tue,  5 Jul 2022 05:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A81DD61B40;
        Tue,  5 Jul 2022 12:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF86C341C7;
        Tue,  5 Jul 2022 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657024329;
        bh=SMm/0YOnQP35YDIQ/u0U2zKJ+5i9f0uSLeTFxVlQteI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RmnWnsx8ZpkgLn4Rfop5bknlfZXaMY45jRxyqZjbKg22c5HETCdJJ21xvkGs0u4lD
         Mwq8PGhBG9CpAEm83Tlc6m61H/FDV5TKtvDWH6g6QDx/fLhnCD3o/Lw8OOQCz7jA9W
         DJQmsic0tkqXPuVK/DJQZPPKIPN8kzwyAn9Ru5bUY4yOf60AT8T2VFGFJYTq2hcV3g
         5v30ElCznLgpU6RT3KSdJ3gLA7DKI9rlxElE5NI5+MAtht0Fql9iKlDbj+csj7g7E8
         l8i1xrN1EelFIzYEo2kVyyhPcSCAkfBZ2VHv72clnArZqlZAT2dsb5oMEXv7rhWGL5
         H1w1N1xsJ37+Q==
Received: by pali.im (Postfix)
        id 47B17CBF; Tue,  5 Jul 2022 14:32:06 +0200 (CEST)
Date:   Tue, 5 Jul 2022 14:32:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: Add support for Turris 1.x LEDs
Message-ID: <20220705123206.6umrjbj5g4o5n2mk@pali>
References: <20220705000448.14337-1-pali@kernel.org>
 <20220705000448.14337-2-pali@kernel.org>
 <20220705123705.0a9caead@thinkpad>
 <20220705105609.cpabhrwozyeejwqe@pali>
 <20220705135227.6380d6d5@thinkpad>
 <20220705122238.ul3cctrxkkttge3m@pali>
 <20220705143001.7371a256@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220705143001.7371a256@thinkpad>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 July 2022 14:30:01 Marek Behún wrote:
> On Tue, 5 Jul 2022 14:22:38 +0200
> Pali Rohár <pali@kernel.org> wrote:
> > So what about exporting another sysfs file which controls current level (0-7)?
> 
> OK, that would be satisfactory. Something like
> "selected_brightness_index".

Too long? What about just "brightness_level" and make it R/W?
We already call it level (not index).
