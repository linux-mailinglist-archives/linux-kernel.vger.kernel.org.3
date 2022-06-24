Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB55455A079
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiFXRkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiFXRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:40:27 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC62B11440;
        Fri, 24 Jun 2022 10:40:25 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9C081240005;
        Fri, 24 Jun 2022 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656092424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i+I0fAg7dAYLMjZXVCRufkyrCMRSm4aTbpDZNNw4VYY=;
        b=K7FCNMXUQucpCpZjepBBIywZZdzJ78N7wWoHsTXLIihwMJ2L07JwbFquU7gfJEMXV8Krqg
        2B12YhbbnggCBS1iCEAgRFT9Nc6haQySllbZnvGDHggkTnzBxbz3CiEjIwarHRMIFRYmY3
        g+b9wUL4Uqol6uPWgjoBqPxrsid/msiXslgN0ByIl6csR07FCUmuuTs3vLC6Mal3PuGzzE
        jXxWHq6nR0ZHHJ0/yxRe27Iny3YjLV7Vq89wiK5ugFPXMx9Fp3p2VVbVN5IIGFvfj6m8SD
        OVUaOZbFOMPTe0G9w8J1TyzfVmT3y1w5fC9IV478muUoMMqIytgaoP45HOjGSQ==
Date:   Fri, 24 Jun 2022 19:40:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, long17.cool@163.com, steve@sk2.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsa@kernel.org
Subject: Re: [PATCH] rtc: use simple i2c probe
Message-ID: <165609236793.30693.563618039150236880.b4-ty@bootlin.com>
References: <20220610162346.4134094-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610162346.4134094-1-steve@sk2.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 18:23:43 +0200, Stephen Kitt wrote:
> All these drivers have an i2c probe function which doesn't use the
> "struct i2c_device_id *id" parameter, so they can trivially be
> converted to the "probe_new" style of probe with a single argument.
> 
> This change was done using the following Coccinelle script, and fixed
> up for whitespace changes:
> 
> [...]

Applied, thanks!

[1/1] rtc: use simple i2c probe
      commit: 4e4a13cc302ec6ea9b04422a02ebfd422e9eb9a8

Best regards,
-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
