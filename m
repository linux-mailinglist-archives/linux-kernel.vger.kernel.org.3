Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2D5ACBB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiIEG7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiIEG7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:59:42 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC1ABCAC;
        Sun,  4 Sep 2022 23:59:34 -0700 (PDT)
Received: (Authenticated sender: thomas.petazzoni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B0F09100008;
        Mon,  5 Sep 2022 06:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662361173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yy/0JQ9UNn1sE4XgrcjFzqB9YfrKrZm4GD6QD3XRCYY=;
        b=QXzcMo73Zmy9eX7o2N3VM9sHsGCecvT0xRsFmNrlEdakFdB/SlXTmGOivt0F5SjHl8iGTF
        uxwgVUIehlIlJ9Ag38HmRCVCSDSTsOxbtlFfDhyfF2R01JTn0/LDW+rfpoL+zu5zNJTudZ
        g1uJrKc05TLcLQlUHWZukBc2tdRHv6pmx0iujQ/W6KrhTiYLodiEPhMJj+56DfF+VPw7Qe
        3VPlfOzXLFPafPEa/vklY7dfhjEGmlLuYDkTjLbSz2goJp+VWuW7GfJTcjDTX0iW8Psz1c
        mT3tDy0Dfs9mrauS1eoUCRlPwiwxJ95h0PMGgMUPZV74fp2mNX/8DI0qH0V1cA==
Date:   Mon, 5 Sep 2022 08:59:29 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2] dt-binding: gpio: publish binding IDs under dual
 license
Message-ID: <20220905085929.38c737fc@windsurf>
In-Reply-To: <20220901163636.3930634-1-etienne.carriere@linaro.org>
References: <20220901163636.3930634-1-etienne.carriere@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Sep 2022 18:36:36 +0200
Etienne Carriere <etienne.carriere@linaro.org> wrote:

> Changes gpio.h DT binding header file to be published under GPLv2 or
> BSD-3-Clause license terms. This change allows these GPIO generic

You're actually changing to BSD-2-Clause. Your v1 changed to
BSD-3-Clause, but following feedback, you change the SPDX code to
BSD-2-Clause but forgot to update the commit log.

Best regards,

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
