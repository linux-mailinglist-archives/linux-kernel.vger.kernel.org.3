Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EB64FF436
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiDMJ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiDMJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:56:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E084EDDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C20CBB82176
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5E9C385A3;
        Wed, 13 Apr 2022 09:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649843624;
        bh=6r3fkXMzd8g99ogF3ht/l19Cw3uTqx/4BgPVQdUQkk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iafrXM5mzK/c592vRQLkWV3sKdyBpujiiNfjdHBT10mt/cEaDhRzj9MDoAyCO4C0I
         pQjQb6AcaZkPqW/KmaQ70t322bvLg6Th4GjOHC9UxfJdRBs3EharNlcvTKHXZFmKsL
         B+4cTdmdl+Vd8w6UCl+YzMNP2HyyDBXYAA2d0KQXmJq+DK+lyF7sJn6NO+aSHfBRi6
         NJGVGqtBR4MdY4i39vO2p7z/R9njWlcteYPsYgWZ4eEyM1PbjNtLDczJTpcUAeGghm
         XSeYEo6DmBJCq4EZAQzYU8ifup5Zy7ucUHsYF52+sBoAaoqukX+MNxby6j1WgTeB5y
         sUWUPTXZt6vYA==
Date:   Wed, 13 Apr 2022 15:23:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     kishon@ti.com, heiko@sntech.de, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] phy/rockchip: Use of_device_get_match_data()
Message-ID: <YladpACp1FiLkmXh@matsya>
References: <20220303014406.2059140-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303014406.2059140-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-03-22, 01:44, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.

Applied, thanks

-- 
~Vinod
