Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB674FF43B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiDMJ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbiDMJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:56:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D4D5674D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54937B82179
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ABBC385A4;
        Wed, 13 Apr 2022 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649843638;
        bh=Wb7p5+hjmHsBsLBQbro2bfTLXKiDwDGJXsLe1SdZawc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=puHkI3/HkSkrN6yHbSN3Cwbp/ra8pyXcR+01BYDczlqPHrVTYCJGpVMyeKm9CC+zC
         0oey2Ew6vKXWXRUFY4uDh7kdhqXObpYTIUGqO7MTnJ8cFtznIxdrq93kALwZfHWZ80
         KYGnWV3KSWGd8CHJN5WlV6w2kAN56HLZPM8Nrg0hZ5bFqyE+XsNnp01B7WRzVMcKQE
         h5QreN7579WgkMAtaLWwr0BWXVt2Ge2m8k8MpSwtfns3fswQcV4fK39wKbY9UsKnG2
         IVJsCUnLxaLVv+nrUxFdeIyFx71U9Eu0jkHXqkB1OL892qCh4GVyKtki5fqxashd5a
         FBHFrRvI2qr5g==
Date:   Wed, 13 Apr 2022 15:23:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     kishon@ti.com, heiko@sntech.de, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] phy/rockchip: Use of_device_get_match_data()
Message-ID: <YladsfTMN4/SDo50@matsya>
References: <20220304011755.2061529-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304011755.2061529-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-03-22, 01:17, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.

Applied, thanks

-- 
~Vinod
