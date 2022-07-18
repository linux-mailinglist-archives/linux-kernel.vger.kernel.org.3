Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9D65787F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiGRQ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbiGRQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:58:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8975E2BB31;
        Mon, 18 Jul 2022 09:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FF43B8167A;
        Mon, 18 Jul 2022 16:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89CBC341C0;
        Mon, 18 Jul 2022 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658163487;
        bh=Pv6CF0fctVJjOuZW4hNgdDsz8hkNLBlWN2b+uvUotbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L7oe73yAKMB9aQzWZKy9GH8tX+2xEIjljKKE4/fFtpQ52MaAYvZNIuiGsTvG4XnOe
         PlU8nmcYhKjcVUQjfjppL5Jg5qd61J3S++WZrsv26TP6sn6xYRbL0g5CwBCw0o+ixI
         Fj4tjiBkjzyPMqPO8HUPBCXgsJOwuoK4mvdyKwMHReeUquSSXCj6bzAsAcCc9TswcS
         6k5/T/v5MiY2Mya96xBanEwIcRz5d4zDI1lxCeyI0PD0xD9dUEGgTU5bDji+zgBFiW
         8XW1XdKhcp+VKGHg1DI5xPqsryHhCnqpDnWI6ZoPheofLGWhR2capYKZcI5WsCaqDg
         xAPnUbtVVLxvw==
Date:   Mon, 18 Jul 2022 18:08:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/3] iio: adc: Add rtq6056 support
Message-ID: <20220718180802.43b66961@jic23-huawei>
In-Reply-To: <1658123163-10039-3-git-send-email-u0084500@gmail.com>
References: <1658123163-10039-1-git-send-email-u0084500@gmail.com>
        <1658123163-10039-3-git-send-email-u0084500@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 13:46:02 +0800
cy_huang <u0084500@gmail.com> wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Richtek rtq6056 supporting.
> 
> It can be used for the system to monitor load current and power with 16-bit
> resolution.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

other than the ABI question around integration_time vs sampling_frequency
in review of patch 3, this looks good to me.

Thanks,

Jonathan
