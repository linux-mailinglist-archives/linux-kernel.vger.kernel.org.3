Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D359C4A58C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiBAItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiBAItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:49:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A7FC061714;
        Tue,  1 Feb 2022 00:49:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67DEE614DC;
        Tue,  1 Feb 2022 08:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF06C340ED;
        Tue,  1 Feb 2022 08:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643705343;
        bh=ajVyrzfKSALQ4/ceI/k/lKRKfDdtj5KLtC27fTafsDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FM9tm/a2y969eT4I/XdeVpMzMoyRa8iLMNN1ulOe5FA9DqOb20JBOlPoeakCH6zJa
         o2niQVSNew+0PwUY8Mmn1XjFXYCHuTNFRutZS+TaciysdOBlX7mFIgyWtGG91xPOvq
         +c+F6DjMvUuneddm4bI2VXZLAh39sI5yIqK8WEHw=
Date:   Tue, 1 Feb 2022 09:49:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <Yfjz/CRUxeVGKaaQ@kroah.com>
References: <20220201030424.1068816-1-david.e.box@linux.intel.com>
 <20220201030424.1068816-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201030424.1068816-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 07:04:22PM -0800, David E. Box wrote:
> +static struct bin_attribute bin_attr_provision_akc;
> +static struct bin_attribute bin_attr_provision_cap;

<snip>

> +static BIN_ATTR_WO(provision_akc, SDSI_SIZE_WRITE_MSG);

You the structure twice, why?

