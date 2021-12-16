Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851D5476E96
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhLPKNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:13:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57094 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbhLPKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:13:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7899E61D2B;
        Thu, 16 Dec 2021 10:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94097C36AE4;
        Thu, 16 Dec 2021 10:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639649589;
        bh=luDNmpkzsE0acrdUWkSefjYdzUd7Wp1biVmINsF1R6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXl0bJfXLQFhDO/3bPGGno0Ui5BSy/UQbkWPoq2hzA3Oj2YaZG0JOZbNgJnwCoQdG
         R7aQrtvYDVFCZoqaeKBI/EvjHXqkZGDQHjeRQK7lwhHY6rZLkMAdhbZrDCqBF8Z1S9
         +z9ZNq+oUjCg82diJaFhH7lBD+Fu4tsUClZleu9l8VMIzc5xTqxR50RhICouYtwQp3
         xy9gR1Kgy3pgZ2zzFr3HZP6lh8s15O5Cxis3dfZmEY5gqgJwUwQElP0Px3ogfihvKn
         OT1FEpV1kLyQzdgBynq1awb4l0aQnyGxdRJM1RjNhlawfyOmrJSjdNmdOYTSJYr83K
         2BZRcI155jZsg==
Date:   Thu, 16 Dec 2021 18:13:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yunus Bas <y.bas@phytec.de>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ARM: dts: imx6qdl: phytec: Add support for
 optional PEB-EVAL-01 board
Message-ID: <20211216101303.GK4216@dragon>
References: <20211216084107.1341968-1-y.bas@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216084107.1341968-1-y.bas@phytec.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 09:41:05AM +0100, Yunus Bas wrote:
> The PHYTEC PEV-EVAL-01 expansion board adds support for additional
> gpio-triggered user-leds and gpio-key support.
> 
> Signed-off-by: Yunus Bas <y.bas@phytec.de>

Applied all, thanks!
