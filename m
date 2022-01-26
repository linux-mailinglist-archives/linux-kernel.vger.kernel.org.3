Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F649C967
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiAZMQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:16:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45958 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiAZMQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:16:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9F6EB81CB4;
        Wed, 26 Jan 2022 12:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D3C340E3;
        Wed, 26 Jan 2022 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643199384;
        bh=HCJF5AT6oZiIHzqC/sgDY2NWB0+NIjbeeOvKVGlv0Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJhDFw9MHJQrtSmEcTWUp/fAGDuu4ADIDB5duLZvFq8tlZmsKjqsh4+5BknpC93R+
         AmZuZdhBfiWtzo3p0TqnZe44ibS0BgfcOIKVMV+SDTNJxiDuLQp00n/AjY/IjN8zEb
         Lq7lAHrXP0BPytn1FAsfyvhguQr/Q49FZksyO334=
Date:   Wed, 26 Jan 2022 13:16:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v8 4/4] staging: mt7621-dts: align resets with binding
 documentation
Message-ID: <YfE7ld1YIhX3rv6j@kroah.com>
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
 <20220110114930.1406665-5-sergio.paracuellos@gmail.com>
 <d62d838872d26201b04a1014a925738d29ff3e48.camel@pengutronix.de>
 <CAMhs-H__SxEZ4OtdN_PFf4g+joWBRgRR0q7hHkZX3d=qZtpxUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H__SxEZ4OtdN_PFf4g+joWBRgRR0q7hHkZX3d=qZtpxUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:46:43PM +0100, Sergio Paracuellos wrote:
> Hi Greg,
> 
> On Mon, Jan 10, 2022 at 12:54 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> >
> > On Mon, 2022-01-10 at 12:49 +0100, Sergio Paracuellos wrote:
> > > Binding documentation for compatible 'mediatek,mt7621-sysc' has been updated
> > > to be used as a reset provider. Align reset related bits and system controller
> > > node with binding documentation along the dtsi file.
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> >
> > regards
> > Philipp
> 
> Can I get your Acked-by on this patch to apply this series through the clk tree?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
