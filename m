Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9394752565F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358372AbiELUbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiELUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:31:29 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB81C6D3BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2vK6FnWBP1817oYqphdnfUUwzMIFm5rEKTDKuU0voEA=; b=l2izM9Zq3/HgabV9OeYkH4BXjS
        PqNXfjf/Ripzli/6VJQGUdRUoQoPZvi/XmzOuRNKO6jR8gMIjhIY74P1tu36jWx3WYMEIGnwnGhrD
        a9CytOf8gV+TvDXcvat4hlQ+Z9oNc8KepPMqivIdu59n3fWObbFXCxlazU4ZBNFBUeYI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1npFT3-002VDd-Bn; Thu, 12 May 2022 22:31:25 +0200
Date:   Thu, 12 May 2022 22:31:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Modi, Geet" <geet.modi@ti.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sharma, Vikram" <vikram.sharma@ti.com>,
        "Lin, Hillman" <h-lin@ti.com>
Subject: Re: [PATCH net-next 2/2] net: phy: dp83td510: Add support for the
 DP83TD510 Ethernet PHY
Message-ID: <Yn1unW4qbWGoW7kV@lunn.ch>
References: <4721A09C-E025-461B-9A0B-B6799AD528C1@ti.com>
 <84CCD666-B7E8-48F6-B3FA-3510C3FA913B@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84CCD666-B7E8-48F6-B3FA-3510C3FA913B@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:19:05PM +0000, Modi, Geet wrote:
> Hi Andrew,
> 
>  
> 
> Hope you are doing well. This patch was submitted back when Dan was part of TI.
> It came to our notice recently that it is still pending approval.
> 
>  
> 
> Reaching out to check the information you need to approve this driver
> submission ?

Please post it again.

       Andrew
