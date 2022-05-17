Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2652ADF4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiEQWS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEQWSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:18:55 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBCD3BF9D;
        Tue, 17 May 2022 15:18:53 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6BE4F100003;
        Tue, 17 May 2022 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652825932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RU+TnHn7PAKyWRHQ76VYEGCSfBI3trWV5aXmLI2KXTM=;
        b=CLfhz2xtHdAMN0iwmoVMyf2weSgH0fO1bsOW6e36MpD8Lnn813hefcT20TVNP+d1MgDUxt
        /bwGmO6CR+g+jfQ0mETE7eaESekBQtGchSuDaK/MDGZRcuK3YYn51vVAgVL1rjrcUuhB81
        fi3T7ScY0EbJrXlz9L/APczegKSRb7Vf4OSiDmmxrEYTcZ70+eXvctAR9E0XnuE52Wr+ge
        F048m2cJfMguW3R7NmuBU12zKDOSuE+d0gcJ0IETlD8Pf1f5HHg6zdtyTkIAv0XuVVNC0J
        Qo4TVTqPoedjQtd1Y5Cy4+WHSzWS9aCQFYaNrrEAkIlZGz5R6laOwLuBHiai/A==
Date:   Wed, 18 May 2022 00:18:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] rtc: simplify the return expression of
 rx8025_set_offset()
Message-ID: <165282590997.294391.3805393279220987607.b4-ty@bootlin.com>
References: <20220505022314.59822-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505022314.59822-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 02:23:14 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> 

Applied, thanks!

[1/1] rtc: simplify the return expression of rx8025_set_offset()
      commit: bce7a01ada6456d00c69cd816357ded268ad780c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
