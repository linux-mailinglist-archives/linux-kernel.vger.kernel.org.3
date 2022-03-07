Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECF44CFF0C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242489AbiCGMqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242483AbiCGMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:46:03 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E44249E;
        Mon,  7 Mar 2022 04:45:08 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C308A2223A;
        Mon,  7 Mar 2022 13:45:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646657107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6sN0on+TklJLiMkk+8nKplqKWkNGHVbTBnp3A9FH6r0=;
        b=V9GNDxz53Qy/kbVDQrLya7ZyUsj8qit4bW/2dpZNhwhl8ThqfQvk5HeErfeqB5zwl9H9L7
        Zn3QGEnOIA2H9B8aVBU3hTcebp75B6aNj6t/9dZLT2wzvPjA/TtD0ub//nKM85mwglNL0z
        mxvmUcNoSRbye3XnKid8Tx7ITD6lWdU=
From:   Michael Walle <michael@walle.cc>
To:     horatiu.vultur@microchip.com
Cc:     andriy.shevchenko@linux.intel.com, colin.foster@in-advantage.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 1/2] pinctrl: ocelot: Fix the pincfg resource.
Date:   Mon,  7 Mar 2022 13:45:01 +0100
Message-Id: <20220307124501.3487932-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304144432.3397621-2-horatiu.vultur@microchip.com>
References: <20220304144432.3397621-2-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The pincfg resources are in the second memory resource. But the driver
> still tries to access the first memory resource to get the pincfg. This
> is wrong therefore fix to access the second memory resource.
> 
> Reviewed-by: Colin Foster <colin.foster@in-advantage.com>
> Fixes: ad96111e658a95 ("pinctrl: ocelot: combine get resource and ioremap into single call")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

There is already this patch pending, which does exactly
the same:
https://lore.kernel.org/linux-gpio/20220216082020.981797-1-michael@walle.cc/

FWIW, there is also this one:
https://lore.kernel.org/linux-gpio/20220216122727.1005041-1-michael@walle.cc/

-michael
