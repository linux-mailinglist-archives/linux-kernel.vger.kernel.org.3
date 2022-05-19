Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D18E52CF38
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiESJUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiESJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:20:41 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C707A76DD;
        Thu, 19 May 2022 02:20:39 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D1AB8200012;
        Thu, 19 May 2022 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652952037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3fF8TXfzuMO2aAQ4ZMYHR9TcyWJ8s6t3LJpHkibRzbo=;
        b=pMPJsTuEHgPN5iQT99K6z1ZdCIcfwX5MsMSGQwX8O/h0GX+eDDaHKEmZi+ks8VDWONVn5g
        0Sn1/OrnngudgVnU6ktbTyx7JJD2ZopvUy4J7qVOBZvwrQSkWOsWvHIbFVW8Avjde1p0wm
        n/2BxOKno8f9sP0vmxsR6ToTWqseLIO0t91qQyYATVAJynCsvaLmuS0XFGyzW5INDEMDXF
        mPwr44bIdZdFDsk4LJgR0ciB1a4eAy4LdpqaPuDxrxRxLtXcC5/LfclVLfDmdmKUbW+l7I
        DVk7IvUQ5ZkfKAbZPVj8J9UxyHs6aumOqeLKnxUp6L/PLCXj2q6S1Fm57TtwRw==
Date:   Thu, 19 May 2022 11:20:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, miquel.raynal@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] rtc: rzn1: fix platform_no_drv_owner.cocci warning
Message-ID: <165295200014.525355.7168522727059763563.b4-ty@bootlin.com>
References: <20220518232445.79156-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518232445.79156-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 07:24:45 +0800, Yang Li wrote:
> Remove .owner field if calls are used which set it automatically.
> ./drivers/rtc/rtc-rzn1.c:411:3-8: No need to set .owner here. The core
> will do it.
> 
> 

Applied, thanks!

[1/1] rtc: rzn1: fix platform_no_drv_owner.cocci warning
      commit: e60e8a73235ce5d42a2891c6989e8df1c8888c4a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
