Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB1E468EF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhLFCHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:07:00 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39912 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232591AbhLFCG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=SzIdXRV5A6pVnIH0yj8mStVOz9/z6kuCS+fJHW04vJc=; b=YamMwNsDRRwLbwhXenHpRUYQWf
        X1uRBtnCs2myofd44GWOlDtqnl7NNNhaaGrqme33h++s9SevU5STfYfBvokGfvZ9vTtVSWD33OI2V
        un2OsGqZzKVNoK2NZKXmRHBHwrvK25Pbnx+3RfghKoplt6cvGGKTbs1aPuIa2ygyEEZ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mu3LX-00Fd2E-91; Mon, 06 Dec 2021 03:03:15 +0100
Date:   Mon, 6 Dec 2021 03:03:15 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, kabel@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm/arm64: dts: Enable CP0 GPIOs for CN9130-CRB
Message-ID: <Ya1vY55e9vAkifS+@lunn.ch>
References: <20211205225618.1565909-1-chris.packham@alliedtelesis.co.nz>
 <20211205225618.1565909-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205225618.1565909-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:56:17AM +1300, Chris Packham wrote:
> Enable the CP0 GPIO devices for the CN9130-CRB. This is needed for a
> number of the peripheral devices to function.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
