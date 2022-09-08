Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9E5B2015
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiIHOEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiIHOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:04:42 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707BB11211E;
        Thu,  8 Sep 2022 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1662645838;
        bh=rjzz30/z7/Pr1KuKonquaOWSGEQlzAerRQsz5EcTcmg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=dVMpQP8L3+/jytMRIW706xGUT/dwvUcNDdKdL/yAw1ScTemRExaVQ43sHwBTeEaPL
         +P0L2DHYNgVOmmfXQoE4g6pjIzdstOwX1Im9aubd+GHEr8BvGGE5blkvOVKHFN++52
         UhF7lL+Hfj4XI4vk5XCshqM8xslZdzxDC4gVje38=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 997D81287AA4;
        Thu,  8 Sep 2022 10:03:58 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lU5B18hUN8ha; Thu,  8 Sep 2022 10:03:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1662645838;
        bh=rjzz30/z7/Pr1KuKonquaOWSGEQlzAerRQsz5EcTcmg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=dVMpQP8L3+/jytMRIW706xGUT/dwvUcNDdKdL/yAw1ScTemRExaVQ43sHwBTeEaPL
         +P0L2DHYNgVOmmfXQoE4g6pjIzdstOwX1Im9aubd+GHEr8BvGGE5blkvOVKHFN++52
         UhF7lL+Hfj4XI4vk5XCshqM8xslZdzxDC4gVje38=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EE73D1287A07;
        Thu,  8 Sep 2022 10:03:57 -0400 (EDT)
Message-ID: <154c64feea4b2942698c6b96370f78a509048605.camel@HansenPartnership.com>
Subject: Re: [PATCH] drivers/ata: fix repeated words in comments
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Conor.Dooley@microchip.com, wangjianli@cdjrlc.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Sep 2022 10:03:56 -0400
In-Reply-To: <a9052683-13a2-1e90-db90-ca9410fafd89@microchip.com>
References: <20220908124937.25962-1-wangjianli@cdjrlc.com>
         <e2f882f7-6871-a754-fbbd-6a5201f45f4a@microchip.com>
         <3a73cf7f02915891c77dc5a3203dc187f6d91194.camel@HansenPartnership.com>
         <a9052683-13a2-1e90-db90-ca9410fafd89@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 13:09 +0000, Conor.Dooley@microchip.com wrote:
[...]
> If there's a tool running against this stuff but maintainers are not
> applying the patches as the "fixes" are not fixes it's only going to
> keep generating the same patches over and over is it not?

That's up to the maintainers, but it's fairly easy to ignore patches
from given sources however often they are repeated.  There's a lot of
wrong patches that keep getting repeated ...

My own take is that the value would be marginal if all the patches were
correct, but they could be applied with minimal effort using patch
automation.  Once you have to verify correctness of each patch, I don't
think the tracking and verification effort is worth the marginal
improvement, but that's a maintainer call.

Regards,

James


