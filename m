Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D084685EE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 16:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344799AbhLDPbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 10:31:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38364 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhLDPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 10:31:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 167A1B80D00;
        Sat,  4 Dec 2021 15:27:55 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id E28E2C341C0;
        Sat,  4 Dec 2021 15:27:50 +0000 (UTC)
Date:   Sat, 4 Dec 2021 15:32:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Nikita Travkin <nikita@trvn.ru>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: ltr501: Add
 proximity-near-level
Message-ID: <20211204153259.1b69e03b@jic23-huawei>
In-Reply-To: <Yaf2aV6GCOaswsDH@robh.at.kernel.org>
References: <20211125125646.54831-1-nikita@trvn.ru>
        <Yaf2aV6GCOaswsDH@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 16:25:45 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, 25 Nov 2021 17:56:45 +0500, Nikita Travkin wrote:
> > This value inidcates the proximity level that should be considered
> > "close".
> > 
> > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> > ---
> >  .../devicetree/bindings/iio/light/liteon,ltr501.yaml       | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Series applied to the togreg branch of iio.git.
I'll push it out as testing first to let 0-day see if it can find any
problems before I go breaking next ;)

Jonathan
