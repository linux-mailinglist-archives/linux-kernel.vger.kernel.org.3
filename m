Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9841947F916
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 22:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhLZVx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 16:53:59 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:60615 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbhLZVx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 16:53:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JMZLp6sXsz4xgt;
        Mon, 27 Dec 2021 08:53:54 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     cgel.zte@gmail.com, fbarrat@linux.ibm.com
Cc:     Zeal Robot <zealci@zte.com.cn>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ajd@linux.ibm.com,
        Minghao Chi <chi.minghao@zte.com.cn>, arnd@arndb.de,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211215060438.441918-1-chi.minghao@zte.com.cn>
References: <20211215060438.441918-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH misc-next] drivers/misc: remove redundant rc variable
Message-Id: <164055553192.3187272.15008325315150052113.b4-ty@ellerman.id.au>
Date:   Mon, 27 Dec 2021 08:52:11 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 06:04:38 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from ocxl_context_attach() directly instead
> of taking this in another redundant variable.
> 
> 

Applied to powerpc/next.

[1/1] drivers/misc: remove redundant rc variable
      https://git.kernel.org/powerpc/c/30e120e6a9d247cec7effd55fd6783d5c619ed4c

cheers
