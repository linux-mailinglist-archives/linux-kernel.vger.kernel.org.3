Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9496155A210
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiFXTqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXTqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:46:02 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F698239E;
        Fri, 24 Jun 2022 12:45:59 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 51EB4C0002;
        Fri, 24 Jun 2022 19:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656099958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B6gyjsp/NVQ21Eu+gfrxHhHPA4Pr9E0u1UsiQqQsXto=;
        b=e9wP091Mreqnb9j5xGWwwJybQguYWNuV95jwoN8MEU18GFVahBbKXcPlQCoQnJD2m+GvTU
        X+mkSxR7jm4f8FH0Q7AeM124+td5ISk2gchS5XCqO18rCMPaboUWhYQJaHcwIjCKKxS0e9
        CJD6fQAHWsvR9mDfyD3boR16ivPDMFtl6fuaJxwh2s6AbTVfUmG4TffZ1HHmJA56fUzvK0
        T1eIITdJGOt154RVwQLNkE3kN413SOzYhOd/hKSWIZMQEJrxQyVBBKswC+s2S3A4mUgB0U
        8QUX16dp+KK1qRa0E8zRsPz0XZRrH4H/xPj2H44YYEYjS+2qx3lgO6pj/1zkng==
Date:   Fri, 24 Jun 2022 21:45:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, liuke94@huawei.com,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: Directly use ida_alloc()/free()
Message-ID: <165609993470.34899.12304338641218791663.b4-ty@bootlin.com>
References: <20220527073636.2474546-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527073636.2474546-1-liuke94@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 07:36:36 +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> 

Applied, thanks!

[1/1] rtc: Directly use ida_alloc()/free()
      commit: 592ff0c8d0648610511f4e4fb532f100168e6e0d

Best regards,
-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
