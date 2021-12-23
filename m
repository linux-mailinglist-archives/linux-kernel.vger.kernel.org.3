Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E89747E18D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243211AbhLWKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbhLWKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:37:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE93C061401;
        Thu, 23 Dec 2021 02:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9CTXoMz+nAirRgLcZXJGcmLtCkLkirPVQ2I7ACSu0t4=; b=NBkgL0qZPWtsIce+oEUpbhHkYz
        L+y40PGH97mD2t0zGz4QBL5W6T8YNI5q6KgXC+Bj0zE1B05PJZTHHTWwLv0yT6uRHsNFXG13TnHPu
        glytwUMa/u9nQd2PTZ8OEAiAd9IoLKS6lNbSr1hzjyEHL/dtoIc6JDDC/HAmtKVlfapFujfXbm4yt
        1X5ESVZvpp8HgWZZnDd7H1zs8g0NfPMGVozlUvXg93Le0hrOSbGTiayQ1xdR2joX8gv5Lfbo1RO7n
        75vVQCYnaql2D+nymcsdRXDk7pRVZdK2jajE97x+tAEmTyxuHhGP4fc8Wgq+nJaEBfI6J3fTqC7CW
        D33xqP0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0LSq-00CVsC-HQ; Thu, 23 Dec 2021 10:36:48 +0000
Date:   Thu, 23 Dec 2021 02:36:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vimal Agrawal <avimalin@gmail.com>
Cc:     mcgrof@kernel.org, vimal.Agrawal@sophos.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        JBeulich@suse.com, jeffm@suse.com, sam@ravnborg.org,
        linux-kbuild@vger.kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/module.c: heuristic enhancement when
 INSTALL_MOD_STRIP= "--strip-unneeded" is used
Message-ID: <YcRRQCMZFepB/hzX@infradead.org>
References: <YcJZWiQ407ZxMM+y@bombadil.infradead.org>
 <20211222132332.7817-1-vimal.agrawal@sophos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211222132332.7817-1-vimal.agrawal@sophos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 06:53:32PM +0530, Vimal Agrawal wrote:
> If kernel modules are stripped off symbols (e.g. built by using strip
> --strip-unneeded option) then stack traces in dmesg do not show symbol

We never build modules with that ёption, so this is completely pointless.

NAK.
