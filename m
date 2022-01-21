Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA79A4960EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350645AbiAUObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:31:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33594 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348810AbiAUObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:31:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D07466179B;
        Fri, 21 Jan 2022 14:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE93C340E1;
        Fri, 21 Jan 2022 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642775475;
        bh=9UX5OxtUvEMfbi9ErdAxUjq/gpyFFn0Z8Jngw+epl0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSv297ad+o2QzmoyWh21/Y9xupD8jpy4rneolPDSg/REJjB4mkoO5c9L1C2axFNhp
         cfSp1BH+8l14oHNf0a8anxfLmYi7l2wCvoWsb0p4D55qAnbFDhsZ2vWxW8D4WfmE4+
         5hFQYMJrRbOZs0iixaFQRde77FlBnRFSFHn0tjoE=
Date:   Fri, 21 Jan 2022 15:31:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_sourcesink: Fix isoc transfer for
 USB_SPEED_SUPER_PLUS
Message-ID: <YerDsJKn0vAHEIAC@kroah.com>
References: <1642764684-26060-1-git-send-email-quic_pkondeti@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642764684-26060-1-git-send-email-quic_pkondeti@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 05:01:24PM +0530, Pavankumar Kondeti wrote:
> Currently when gadget enumerates in super speed plus, the isoc
> endpoint request buffer size is not calculated correctly. Fix
> this by checking the gadget speed against USB_SPEED_SUPER_PLUS
> and update the request buffer size.
> 
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

What commit id does this fix?

thanks,

greg k-h
