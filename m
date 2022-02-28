Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD04C6526
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiB1JAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiB1JAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:00:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9073D1CC;
        Mon, 28 Feb 2022 00:59:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F7861196;
        Mon, 28 Feb 2022 08:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669DBC340E7;
        Mon, 28 Feb 2022 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646038778;
        bh=uPlC4qslwCeJ8Z4r3iRUTyMBWGGVII3DOFy+WNdMmgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOFSkqpKF9SI8926Kj6PtOmLGUeGn01Jmt2hq1jDgAKPOvwzozTxeZ8JCNDrJSkmM
         IAJE7G62/2fjX+qupNjNnSjFn7vrBsUSqd+xH09tC+NststxD/O1yvZdblhqEkM5RC
         OfEcl6ZA3POI/llqGFFrjM2Uz3mTSzeONPcKfsxhiGhDDUPhF8YiqF7j9F2XiRqIrP
         lp8rkWAMw4NfwEXkwMTeM225lQ9IxQWjXc8l4bnG/TF8ovhSap4KtrLP/+9zWyNxAI
         sbM2hKynsJ7xjB3nPNJ2z4f2+aSSPO9P/84Yk3902pWdIODxCMcEOc7WbUAcSu3576
         Grg99bmzLTbig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nObsU-0002tH-D2; Mon, 28 Feb 2022 09:59:35 +0100
Date:   Mon, 28 Feb 2022 09:59:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] USB: serial: pl2303: Add IBM device IDs
Message-ID: <YhyO9gsZZ9mqUzwn@hovoldconsulting.com>
References: <20220224153444.10893-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224153444.10893-1-eajames@linux.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:34:44AM -0600, Eddie James wrote:
> IBM manufactures a PL2303 device for UPS communications. Add the vendor
> and product IDs so that the PL2303 driver binds to the device.

Thanks for the patch, looks good.

> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

The SoB of the submitter should go last here though. You can use
Co-developed-by to give a co-author credit (or add a From line in case
you're in fact not an author). Please review:

	Documentation/process/submitting-patches.rst

and send a v2.

Johan
