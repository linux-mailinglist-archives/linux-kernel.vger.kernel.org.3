Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7690F5ABF7E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiICPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 11:21:27 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1996E0F5;
        Sat,  3 Sep 2022 08:21:25 -0700 (PDT)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1FF3C1BF207;
        Sat,  3 Sep 2022 15:21:19 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1oUUxS-002V0V-Mt; Sat, 03 Sep 2022 17:21:18 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 07/12] riscv: dts: allwinner: Add Allwinner D1 Nezha
 devicetree
References: <20220815050815.22340-1-samuel@sholland.org>
        <20220815050815.22340-8-samuel@sholland.org>
Date:   Sat, 03 Sep 2022 17:21:18 +0200
In-Reply-To: <20220815050815.22340-8-samuel@sholland.org> (Samuel Holland's
        message of "Mon, 15 Aug 2022 00:08:10 -0500")
Message-ID: <87sfl8zdox.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Samuel" == Samuel Holland <samuel@sholland.org> writes:

 > "D1 Nezha" is Allwinner's first-party development board for the D1 SoC.
 > It was shipped with 512M, 1G, or 2G of DDR3. It supports onboard audio,
 > HDMI, gigabit Ethernet, WiFi and Bluetooth, USB 2.0 host and OTG ports,
 > plus low-speed I/O from the SoC and a GPIO expander chip.

 > Most other D1 boards copied the Nezha's power tree, with the 1.8V rail
 > powered by the SoCs internal LDOA, analog domains powered by ALDO, and
 > the rest of the board powered by always-on fixed regulators. Some (but
 > not all) boards also copied the PWM CPU regulator. To avoid duplication,
 > factor out the out the regulator references that are common across all

NIT: s/out the out the/out the/

-- 
Bye, Peter Korsgaard
