Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8675566371
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiGEGyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiGEGyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1862641;
        Mon,  4 Jul 2022 23:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A7EA6152E;
        Tue,  5 Jul 2022 06:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA9FC341C7;
        Tue,  5 Jul 2022 06:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657004043;
        bh=JISMrbSooutQHHPel6SKTiSLk/ck/ahoUWiu77t4xOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRQers6pzUQIRSG8RxhhL7YMxGADSuj1B2qkc15e6JmpTOS/SvODcjkt/0h+UJosM
         SK1rIpB+X6HSug3AWwxXjdahAKSuPOHxTw3MHpgE6SxErFKIvBwrk/NJUA24dZme1G
         02vGHXkk18v27FdNXVi324bkJwdcTjdlf7Kq+Ok+QwKcqUm3fAaMbhve7i+A5Prqoy
         UZrclcfw/b+ZMsGpkTlKAEpFs+jz0YpELtT39eeuYoySY42hbtEEyJo8YYfpboPa/F
         4l6yqphnBpca4EFo0149HHXJo7DiTpsjdU3VvttvZg0jym0A8luKg48YATdKlQilns
         HlDb7J6m9ZDVw==
Date:   Tue, 5 Jul 2022 12:23:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rahul T R <r-ravikumar@ti.com>
Cc:     linux-phy@lists.infradead.org, kishon@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.yadav@ti.com,
        tomi.valkeinen@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        sjakhade@cadence.com, mparab@cadence.com,
        devicetree@vger.kernel.org, vigneshr@ti.com, lee.jones@linaro.org
Subject: Re: [PATCH v4 0/3] Add support for dphy tx on j721e
Message-ID: <YsPgBteeGNFJSrKv@matsya>
References: <20220623125433.18467-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623125433.18467-1-r-ravikumar@ti.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-22, 18:24, Rahul T R wrote:
> Following series of patches adds support for dphy tx on ti's j721e
> soc. new compatible is added and required cdns dphy ops are implemented.
> the series also adds band ctrl configuration required for dphy tx

Applied, thanks

-- 
~Vinod
