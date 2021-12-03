Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E4D466EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbhLCBFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbhLCBFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:05:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD745C06174A;
        Thu,  2 Dec 2021 17:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BoIKGnMfoc1IIOUC9w9w20aJB0DTazO4q6nZD2D5Ghc=; b=Il2dm8mIqf66EY6d6kB9VZGiP4
        rjysYplfEm5MIZalhXfe8wOli3cUvUclPkyrIBMnLPgjmXp+9CBB9EDL22hGs7CAi6Y3JE6xAk595
        nJ8w1aY/WQrKkVDHD9l3EITK5fO6zJN6MXVgmpdz+i6uT/DFzc8BvtCyUofV7PGlum+CJ+YB5W4OH
        wNKxXfipgzcEXsUMJoq286cQHmUynw2cnuM+0kluZ0+CTQDoFN1ctbmk+ezhdej0qGIMeZhG1z0J6
        SMJwS0vBlDCclLxeFSaCPYqn41Y6i4tiDAcARoLAx7vT9FDT7zd6W18LVHN2wSIONhSKUk5MBn/wR
        8vw+k+PA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mswxQ-00DtnM-NW; Fri, 03 Dec 2021 01:01:48 +0000
Date:   Thu, 2 Dec 2021 17:01:48 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: add in-kernel support for decompressing
Message-ID: <YalsfEC7vix/WsDI@bombadil.infradead.org>
References: <YaMYJv539OEBz5B/@google.com>
 <202112011112.83416FCA2C@keescook>
 <YafYvA5JWMgb6PVy@google.com>
 <202112020012.8B4C205@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112020012.8B4C205@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 12:14:18AM -0800, Kees Cook wrote:
> I still wonder if it might be able to use of the "acomp" API
> instead of calling directly into the specific decompressor.

drivers/base/firmware_loader/main.c also deals with decompression
of files, so I wonder if something can be shared with that code too?

  Luis
