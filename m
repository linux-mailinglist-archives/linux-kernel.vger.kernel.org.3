Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4352B4FDD0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiDLKuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357177AbiDLKpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:45:52 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A511815A01;
        Tue, 12 Apr 2022 02:44:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4BCFC8061;
        Tue, 12 Apr 2022 09:42:05 +0000 (UTC)
Date:   Tue, 12 Apr 2022 12:44:36 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [PATCH] ARM: dts: Fix mmc order for omap3-gta04
Message-ID: <YlVKBHTUIMMaDZKg@atomide.com>
References: <dc9173ee3d391d9e92b7ab8ed4f84b29f0a21c83.1646744420.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc9173ee3d391d9e92b7ab8ed4f84b29f0a21c83.1646744420.git.hns@goldelico.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [220308 14:59]:
> commit a1ebdb374199 ("ARM: dts: Fix swapped mmc order for omap3")
> 
> introduces general mmc aliases. Let's tailor them to the need
> of the GTA04 board which does not make use of mmc2 and mmc3 interfaces.
> 
> Fixes: commit a1ebdb374199 ("ARM: dts: Fix swapped mmc order for omap3")
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applying into fixes thanks.

Tony
