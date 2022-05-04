Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE35519806
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbiEDHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345359AbiEDHZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:25:38 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70F217049;
        Wed,  4 May 2022 00:22:02 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 8481127B;
        Wed,  4 May 2022 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651648922;
        bh=sx0SctmyG9TOtwIaQSFtf68ixGOt40YgbnYjWyRrhuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X62oo+L0uURQ4J/bspzv5N4OBv2LTgvA7vp+/L4Q792w4u6UA9edJNL4d6wepuPBf
         cehTyrf783Yc9C7Dd8OuCxFepA8OxH/spZpUO/F5v27jFRznhUZeDig9NB0e8cCAL0
         sNxi1LV9gVYX14co9uNTu+HVwP49DesxBlGMZZSU=
Date:   Wed, 4 May 2022 00:22:01 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 0/6] regulator: core: Add support for external outputs
Message-ID: <YnIpmdoQTm1gb4fp@hatter.bewilderbeest.net>
References: <20220504065041.6718-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220504065041.6718-1-zev@bewilderbeest.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 11:50:35PM PDT, Zev Weiss wrote:
>Hello,
>
>This patch series is a new approach at implementing some functionality
>I previously attempted as a separate driver in drivers/misc [0], but I
>think (as suggested by Greg in that thread) ultimately makes more
>sense being built into the regulator subsystem.
>

<snip>

Sorry for the broken threading here (missed a comma in the CC list on 
patch 1 that 'git send-email --dry-run' didn't catch, then forgot to add 
the necessary flags on the second attempt to tack it onto this cover 
letter from the first).

In case it's not obvious, the patches corresponding to this are here: 
https://lore.kernel.org/openbmc/20220504065252.6955-1-zev@bewilderbeest.net/T/


Zev

