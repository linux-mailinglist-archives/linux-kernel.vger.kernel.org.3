Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10D450986D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385507AbiDUG7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385484AbiDUG7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:59:10 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A55CF15FC8;
        Wed, 20 Apr 2022 23:56:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 034B68106;
        Thu, 21 Apr 2022 06:53:14 +0000 (UTC)
Date:   Thu, 21 Apr 2022 09:56:03 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
Message-ID: <YmEAA7kc4jNHSkGm@atomide.com>
References: <20220414192722.2978837-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414192722.2978837-1-dfustini@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Drew Fustini <dfustini@baylibre.com> [220414 19:24]:
> TI AM437x SoCs support isolation of the IOs so that control is taken
> from the peripheral they are connected to and overridden by values
> present in the control register for that pad. This series documents a
> new property 'ti,set-io-isolation' and updates the wkup_m3_ipc driver to
> inform the CM3 firmware when that property is set.

Care to list what hardware and board revisions you're able to test deep
sleep with?

Seems like my am437x-evm is too old for this where the board layout
does not match the schematics for removing a resistor to enable this.

Just wondering if I can still enable tests for this somehow :)

Regards,

Tony
