Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20956B225
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiGHFLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGHFLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:11:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93DE7968B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D72D6245A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA58C341C0;
        Fri,  8 Jul 2022 05:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657257108;
        bh=CRNCeDRx2gTmZvbFUCZcwCoIpZ7yIENeQY6jwpR3WuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ln7jHpyUwj9hesGwTO02VHdcJPiJb3gWi36P9S1B4LQx2t6V1bMVpTGAnxqAiAQHM
         oLKdYDjtEXntg156Dz0NdQDeGdp5bVMitwb4Y4ufulsEjnPynj9sni/imewivnyGY+
         yrkKlsDgKrOkbKk586RsKEvVUuQyoctCZTIk06oBNb5ptV3PBH7B+1vjmwBxjYp/lm
         ODQ9zu4HGVhDBHHYeIjo0cm5baCnAEomaz6bGENkAcnhSCJ8xnSBwbAafjwXpmoY5S
         hYlHM1vKXu2jDgdV8bFrbR4yZErDXrVFM9TtQxfLFqJJO7BS7gDDa5I8CT9zx1C+Mt
         xSGEUknkbUu5w==
Date:   Fri, 8 Jul 2022 10:41:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: cadence: Sierra: Remove unused `regmap` field
 from state struct
Message-ID: <Yse8kM499AmrIQ4d@matsya>
References: <20220707071722.44201-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707071722.44201-1-lars@metafoo.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-07-22, 09:17, Lars-Peter Clausen wrote:
> The driver state struct for the sierra PHY driver has a field named
> `regmap` that is never referenced. Remove it since it is unused.
> 
> Not that there are separate fields of type `struct regmap` for the
> individual sections of the device's register map. These other regmaps are
> used and not affected by the patch.

Applied both, thanks

-- 
~Vinod
