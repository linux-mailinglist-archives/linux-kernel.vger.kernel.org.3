Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48814BA01A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbiBQM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:28:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbiBQM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:27:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF115D399;
        Thu, 17 Feb 2022 04:27:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B744619A6;
        Thu, 17 Feb 2022 12:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04467C340E8;
        Thu, 17 Feb 2022 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645100863;
        bh=2dU0Q4jhcnpTCl5wKjBVMqHcTJ3NgI/2klyS76pBROU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpULGs3yXKTjnMXohAsDpL/ITHXauX2AeMA//7ZYrS1XDlloeieEjUZvJaBJ1aEfn
         surFl138HiX4+o80sfj4paVXxRm0MVJWfWEOxsTOlc9GLp0mYmU1Lm1CzFZc9uOsJE
         1HZV2rmWbEvDU8khQ61lTO2xcm8eYd0o5c2I5LpE=
Date:   Thu, 17 Feb 2022 13:27:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tty: n_gsm: fix encoding of control signal octet bit
 DV
Message-ID: <Yg4/PJxW9ZC+KHzV@kroah.com>
References: <AM4PR1001MB1378023FB7411DD0E6A18CD3E0369@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR1001MB1378023FB7411DD0E6A18CD3E0369@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 10:45:14AM +0000, Starke, Daniel wrote:
> > All of these are patch 1/1, which is odd :(
> > 
> > Please renumber them properly and resend.
> 
> All these patches are based on the current version of tty-next and are
> completely independent from each other. The only common part is the file
> they apply to. Therefore, this is not a patch series. Would you still
> suggest to apply a different numbering?

Yes, please send them as a patch series, numbered correctly, as a whole
series of patches, all listed as 1/1 does not do good things for our
tools.

thanks,

greg k-h
