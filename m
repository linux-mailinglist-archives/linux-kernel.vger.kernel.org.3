Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB42948EF51
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbiANRnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiANRnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:43:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235E3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 09:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p/a5sC8wCu6QRDPDeSoazAGcfWn/EQU27wXVoKv6HDE=; b=yrRF1LMIPSF4YoxoTtfB4vstpd
        e+UML2knqn2aSgdNakEzx150lxccbItspIZ2QhooXV4TpbqNCi4ukFGA1f1yvO5Skcl7e28SM7yev
        iEfZimQrMDHb/cU39Eu/pFXxpNMvKRJQwbQza6EJkRyilgSUK8zKdD6ybnZAtpamZ7VkmCKe3/EYA
        a0YY3/YLdKROsP92gP3Sbc5qpWnRe6TNxdp6ro6AqEDm7Bd4waXABXSXYMZ9hWwu41utbepcaZC8f
        IO9puCyxnQu9lXSUcv8LdmiPbgKFqo+3DwK56gSbWpBfv1q1iTDj3MG/xtMbddCQ/tiQ+u5tlCzi5
        JmGtObqg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8QbT-009xOM-Qc; Fri, 14 Jan 2022 17:43:07 +0000
Date:   Fri, 14 Jan 2022 09:43:07 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: fix signature check failures when using
 in-kernel decompression
Message-ID: <YeG2Ky8nLGMIyqe3@bombadil.infradead.org>
References: <YeDJKNTYVu/Fe9VS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeDJKNTYVu/Fe9VS@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 04:51:52PM -0800, Dmitry Torokhov wrote:
> The new flag MODULE_INIT_COMPRESSED_FILE unintentionally trips check in
> module_sig_check(). The check was supposed to catch case when version
> info or magic was removed from a signed module, making signature
> invalid, but it was coded too broadly and was catching this new flag as
> well.
> 
> Change the check to only test the 2 particular flags affecting signature
> validity.
> 
> Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Queued on to modules-next.

  Luis
