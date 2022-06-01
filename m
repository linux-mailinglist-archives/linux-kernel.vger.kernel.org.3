Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6264453AFBE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiFAUv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiFAUuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:50:52 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29C2985A8;
        Wed,  1 Jun 2022 13:49:12 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CBF68240006;
        Wed,  1 Jun 2022 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654116534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=itBnDuOydygpxjCTl5U2crygqhbKNBZcw4zJX+3JOeM=;
        b=TsBwKSbimpLK5rCjTlX94Fw0+B3J8r1te1bYddmkru5waQjZuzQkvfU3aQy2s+Ko/tLB2W
        zzqBkehSz8OFphOsaQKIGdZUk+n35R9AiF0oU70VKsVPO+YJAF9hrmCVAaKqf0k7nNDdhN
        iAOBI7vUcojEU0+wRg6TDr+UCd8G6krYLF4Q+tZ7SWdKbIKPXe5QThybzznRakuphWmnUA
        t9Z1kdcK990L8irO6INMsnbtsnUAhRIQRH6OOyap/E42KyTZkmvIlnnHL+3o1QVVd7sahi
        lTiZflofjKc0KiT3GmhNLnzkldt28HlbWbXBEt0ouK4V47kiqURU7KEGycvFQw==
Date:   Wed, 1 Jun 2022 22:48:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify entries for some i3c drivers after
 dt conversion
Message-ID: <165411647849.792060.10768725309583825997.b4-ty@bootlin.com>
References: <20220601074212.19984-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601074212.19984-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 09:42:12 +0200, Lukas Bulwahn wrote:
> Commit 4bd69ecfa672 ("dt-bindings: i3c: Convert cdns,i3c-master to DT
> schema") and commit 6742ca620bd9 ("dt-bindings: i3c: Convert
> snps,dw-i3c-master to DT schema") convert some i3c dt-bindings to yaml,
> but miss to adjust its reference in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> broken references.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: rectify entries for some i3c drivers after dt conversion
      commit: 66ed42caf286a7aaeb6f1db4b2995dd9416226c2

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
