Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE45248311D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiACMnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiACMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:43:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0894C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 04:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 09BA6CE0FA0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 12:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F2CC36AEB;
        Mon,  3 Jan 2022 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641213794;
        bh=QakZzB02W9Wb76jnX2bCNZJHaO6xVBbCw8P+v2OsArY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REk/3vAvaM0yJVfgOGiMDeD+zUOSC9cIHXLHXheYajSAh70kucjrZIeFo+m/OI60R
         iw0jQE119vx5yL6xmxrPRS2TlrlvxOZRAuX+ZCuGzB7CgaE+NCJ0fwKqPaluk/HdKS
         jaBjyu5RkOgyImkUx1FQJH8GYTGUl4EflQRhLybI=
Date:   Mon, 3 Jan 2022 13:43:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] mux: Add support for reading mux state from consumer
 DT node
Message-ID: <YdLvX8TWBavEq8PH@kroah.com>
References: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
 <b9bb0b36-cf58-b436-6b72-c4211022981c@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9bb0b36-cf58-b436-6b72-c4211022981c@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 11:38:29PM +0100, Peter Rosin wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> In some cases, we might need to provide the state of the mux to be set for
> the operation of a given peripheral. Therefore, pass this information using
> mux-states property.

Where is the user of this new function?

thanks,

greg k-h
