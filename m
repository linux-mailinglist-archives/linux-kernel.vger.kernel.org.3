Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1754EE86
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379450AbiFQAjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFQAjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:39:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186005FF1B;
        Thu, 16 Jun 2022 17:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA056B82678;
        Fri, 17 Jun 2022 00:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72810C34114;
        Fri, 17 Jun 2022 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655426346;
        bh=3zyM3B1L4dkBQNLZ6hSQTnSprTyRszI6LtRPOa9krqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oy0WYy722Fq152agcEDyh5Hfz6KKLFZc7aMQhj3MDGRsPCXDGojgaGauzS/e2tEx7
         6NpMGX/cNwOSl4zltlWs3HAxFvRPyjNjxYLnirSmoLhhk9dBfdOfL0rBrjS+zyQud5
         A0fLASr2NuvxgKUbUP4dhH/ErEkS+z4Pg3sh/8BdvpfvkLhD2u6+oMbtIp4uTDCcQJ
         EmUhRW9fsu/ZBgggWxGhdpRpODjeix6c5axV1T4I14hoK82JaoRtRgvgaQKrSWMXcr
         lAj0+m//euLM/u57w2McBosNULHy77EBdZXtGLU+GBRp3LTK0eMJ0bAzTX7TPfJJLC
         K2CqHVIf0Il/Q==
Date:   Thu, 16 Jun 2022 17:39:05 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add include/dt-bindings/phy to GENERIC PHY
 FRAMEWORK
Message-ID: <YqvNKXe78KXg2UBs@matsya>
References: <20220613122621.18397-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613122621.18397-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-06-22, 14:26, Lukas Bulwahn wrote:
> Maintainers of the directory Documentation/devicetree/bindings/phy
> are also the maintainers of the corresponding directory
> include/dt-bindings/phy.
> 
> Add the file entry for include/dt-bindings/phy to the appropriate
> section in MAINTAINERS.

Applied, thanks

-- 
~Vinod
