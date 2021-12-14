Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2E47493F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhLNRZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:25:05 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54716 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236440AbhLNRZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ob20XausBzq6AKHnvx100ZEb5sXAdDEYot8/2FbY9Rw=; b=r39iXamGDhEio4TFFj9payUDeV
        BPuiPKTaP7jiGJG8QE/A9D0ErTR4Ez/tnonYYStAkHmvv4MkrmtIVYyP4jvvdDzz4LS02TTO0cIgi
        /prHtLwHpDOusOlRyBr9IlMAGGrCW6NwjrmCrTb97LJStI3Lj0ysxCi5wrwM1Jrr8pXY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mxBXs-00GXJS-RD; Tue, 14 Dec 2021 18:24:56 +0100
Date:   Tue, 14 Dec 2021 18:24:56 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 1/1] ARM: orion/gpio: Get rid of unused first
 parameter in orion_gpio_init()
Message-ID: <YbjTaGy+wFhgVuFz@lunn.ch>
References: <20211214140656.53694-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214140656.53694-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 04:06:56PM +0200, Andy Shevchenko wrote:
> The OF node pointer is always NULL, get rid of unused parameter in
> orion_gpio_init(). As a side effect it will allow to switch GPIO
> library to the fwnode API, as well as in case of resurrecting it here
> it should be fwnode_handle anyways.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
