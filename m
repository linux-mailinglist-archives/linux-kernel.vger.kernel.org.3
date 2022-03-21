Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D574E26C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347511AbiCUMnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347575AbiCUMnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:43:08 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA06158D85;
        Mon, 21 Mar 2022 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/OoQA2C4opCgk8x2lj3pHFSDfpkhAccLtFf/6lMUfYQ=; b=kUtJQWixDH80LVAnhbDfBTrcEk
        5nNGeNE8pXGoM/OHMTNTfAmHJVpqzwZ8JGgagpp6FHe9/rB6PPqmKNRXSOUdasQmrR1KKKvEviEhz
        istE8jROHTI30VltkyGXfmWKe7YFdQEPZBQl4idSxQ9WsPTD8prprEUwM5Rum/01wxp4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nWHLv-00Bwcj-4v; Mon, 21 Mar 2022 13:41:39 +0100
Date:   Mon, 21 Mar 2022 13:41:39 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali@kernel.org, marek.behun@nic.cz
Subject: Re: [PATCH 1/2] arm64: dts: uDPU: update partition table
Message-ID: <Yjhyg5cNe5KZ6SOp@lunn.ch>
References: <20220321121728.414839-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321121728.414839-1-robert.marko@sartura.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 01:17:27PM +0100, Robert Marko wrote:
> Partition currently called "uboot" does not only contain U-boot, but
> rather it contains TF-A, U-boot and U-boot environment.
> 
> So, to avoid accidentally deleting the U-boot environment which is
> located at 0x180000 split the partition.
> 
> "uboot" is not the correct name as you can't boot these boards with U-boot
> only, TF-A must be present as well, so rename the "uboot" partition to
> "firmware".

Are there any ABI issues here? If these names are being used
somewhere, you are potentially breaking the boot. At minimum, i would
like to see something in the commit message which indicates you have
considered this and why you don't expect it to be a problem.

	   Andrew
