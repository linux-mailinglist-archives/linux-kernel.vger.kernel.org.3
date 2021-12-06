Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDA8468F75
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhLFDEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:04:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45978 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhLFDEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:04:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 746F7B80E5C;
        Mon,  6 Dec 2021 03:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D134C00446;
        Mon,  6 Dec 2021 03:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638759641;
        bh=9cNh3RaFJCMKVcO5Axb4MRechF03pDBvYKBusB/8Ne4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnY1Iv1Ig7bbKpMO8If+A+18dXLv8SSNpWLXWgfvzb1S/5RZY1TowaCgsFmFNEfJL
         P37weL1L4jo9vwk/Ft1FVzbWZgkbmPPoKCoPVWZ2MqV34Sl6pj+ob4Ljsur8qGWai9
         XLnIIMVleJuOo8BSZaphwy0oG3O4JW4qV3NX60o/64p9QjxzsCM/TWQ3+WR5IUK35d
         92tYOHVghRt9XeqKN6vXsZrjn+MO5vPCjj9qcFdq4+6lfaY6rmNbN0c3dyxQeHCEOw
         1ZxNLo7Qpojff/NuEL08nEYwXt10g8xPkiPumW1zZeeQA5plDJVqO/zDr0TcB8M14r
         z9+o3wyQjo5CA==
Date:   Mon, 6 Dec 2021 11:00:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ping Cheng <Ping.Cheng@wacom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Alistair Francis <alistair23@gmail.com>,
        tatsunosuke.tobita@wacom.com,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jason Gerecke <Jason.Gerecke@wacom.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>, martin.chen@wacom.com,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v15 3/3] ARM: dts: imx7d: remarkable2: add wacom
 digitizer device
Message-ID: <20211206030033.GZ4216@dragon>
References: <20211202115622.40153-1-alistair@alistair23.me>
 <20211202115622.40153-4-alistair@alistair23.me>
 <CAO-hwJJ7jJJkExu+GxwiGn=6t+aUow9ktmCedMRCfNF0bLAXfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJJ7jJJkExu+GxwiGn=6t+aUow9ktmCedMRCfNF0bLAXfQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:57:11PM +0100, Benjamin Tissoires wrote:
> On Thu, Dec 2, 2021 at 12:56 PM Alistair Francis <alistair@alistair23.me> wrote:
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  arch/arm/boot/dts/imx7d-remarkable2.dts | 59 +++++++++++++++++++++++++
> 
> I think I am always asking the same question, but is it fine for me to
> take this patch through the hid tree?
> I seem to remember that this was a little bit free for all but I'd
> like to get the confirmation first.

I will take care of dts patch.

Shawn
