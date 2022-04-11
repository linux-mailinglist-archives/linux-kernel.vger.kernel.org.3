Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856624FC2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348759AbiDKRNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241751AbiDKRNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764CE24940
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:11:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA13A616D6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93574C385A4;
        Mon, 11 Apr 2022 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649697082;
        bh=BGuusMW9bZqM7HMRmScsvZjSdzwjV66gHPQDF4gT+DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiL1v+69Vj7tbmHgC+V8jgyLjIMNxK6BzfU/Q3q0vnJlqzsmOUIauCmOisBavqfsc
         b5dejDy6IdmrkkWGLOHalSqRYxMN0o01UryQhL5dsSscAjc5Iz9NXoNNX4t/FQjLiq
         /alTY47ZIvZxgTQhw6otZbQbl0Od4gtOmmj1luvnzrlYAGXO5Rg8Kkcl0GEJ8Mo7kI
         1alwN/MSk0FSo4RWxhh+AJ2DwSzGLRJKFpJ9kzXQZ2m/MbJx8P7yprlnvvyerKzPoD
         WvwWFlnECADcjQifGw/NlUFwedgeJMRwA+QhJ53JmywqzZ4/II1Mzrw25MgOkSGaVL
         Ae6cpWn3n1zHg==
Date:   Mon, 11 Apr 2022 22:41:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     kishon@ti.com, lv.ruyi@zte.com.cn, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] phy: ti: Fix missing of_node_put in
 ti_pipe3_get_sysctrl()
Message-ID: <YlRhNZI8Fy5I2E6i@matsya>
References: <20220408095617.2495234-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408095617.2495234-1-lv.ruyi@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-04-22, 09:56, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> of_parse_phandle() returns node pointer with refcount incremented, use
> of_node_put() on it to decrease refcount when done.

Applied, thanks

-- 
~Vinod
