Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3015D476878
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhLPDIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:08:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46600 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhLPDIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:08:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE1E661BEA;
        Thu, 16 Dec 2021 03:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A4CC36AE0;
        Thu, 16 Dec 2021 03:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639624120;
        bh=TXBIFGc25Qw13VvCSpXb5l6XQy5Lk9QgDInhZ1JSPxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0btZ2F/JmvVDA6I1p+rmUiHpmddV+nwOeVu7UTej/X1evMDLHwurBwFoRA7JgURf
         VFSIUFPc9hONPzQUfTZQOaa+yd52wn4byeB7eXz4Ms/9xKSD2h4C7THnUj/BJRjTnU
         I/CB/K+nL32H11kDV8v8dMD78F+Axv491BBs1t6t8vfOww8MDFjsd0Ornlgegdeb8G
         0DjMEZ2Pg8JIMq4MjZtPZBf+zmukKWjufRvw+oqTSefmFbxQEHd51PYwQBL/SYV695
         Oi26xJv4Up+VTzp5f+p7FK4tI1NyNp5jKU82hAI4RaST9vKWIbpdq2bJUKxYazChMu
         q/ziOVEihrjHg==
Date:   Thu, 16 Dec 2021 11:08:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     s.hauer@pengutronix.de, dmitry.torokhov@gmail.com,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        Jason.Gerecke@wacom.com, linux-imx@nxp.com, Ping.Cheng@wacom.com,
        devicetree@vger.kernel.org, martin.chen@wacom.com,
        tatsunosuke.tobita@wacom.com
Subject: Re: [PATCH v16 3/3] ARM: dts: imx7d: remarkable2: add wacom
 digitizer device
Message-ID: <20211216030833.GQ4216@dragon>
References: <20211208124045.61815-1-alistair@alistair23.me>
 <20211208124045.61815-4-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208124045.61815-4-alistair@alistair23.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:40:45PM +1000, Alistair Francis wrote:
> Add Wacom I2C support for the reMarkable 2 eInk tablet using the
> generic I2C HID framework.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

I updated the subject prefix like below.

 ARM: dts: imx7d-remarkable2:

Applied, thanks!
