Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D7755A175
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiFXTNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiFXTMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:12:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293181A37;
        Fri, 24 Jun 2022 12:12:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1B79431A;
        Fri, 24 Jun 2022 19:12:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1B79431A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656097961; bh=MpPrOxX6z/lQ6cdX+XEUdc9zOOieEi7IAhJTqR36Er4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FHCP6XVH2CLk2hggk3UZwUCOuT71hv8eacYgUjO5JMOa0LDWDSmCjc5uMlQZ8xYeS
         AoO6HkaWfYBThjZoHn7ugQDALfJB5hwKwqLiUgDu8HtkcDRF91ftnN8s9ic1J85rd9
         RD3t1D6GhikFnZoPwQsr4SfecixGapQx9ggqCnqb8KqUJLNBLqRCqdkqcNJgtx8DsE
         rapcIocgEMZG+RkKCyFg7HXFnP1dYutYIzHxB849wM6FczQw75V8ANBKEf6chmFo+k
         DMppTfLWQiGWfgbqvsF7lsw2IO0xDQohlfiDl8/0HGyalonyX+W6ujgs63EK3zDqxv
         LDVwlpA4kRp8w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tom Schwindl <schwindl@posteo.de>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: driver-api: gpio: Fix some typos
In-Reply-To: <YrTdAv3YPlCiDr2u@posteo.de>
References: <YrTdAv3YPlCiDr2u@posteo.de>
Date:   Fri, 24 Jun 2022 13:12:40 -0600
Message-ID: <87sfnt5107.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Schwindl <schwindl@posteo.de> writes:

> Correct some simple spelling mistakes in consumer.rst, driver.rst
> and using-gpio.rst.
>
> Signed-off-by: Tom Schwindl <schwindl@posteo.de>
> ---
>  Documentation/driver-api/gpio/consumer.rst   | 2 +-
>  Documentation/driver-api/gpio/driver.rst     | 6 +++---
>  Documentation/driver-api/gpio/using-gpio.rst | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

jon
