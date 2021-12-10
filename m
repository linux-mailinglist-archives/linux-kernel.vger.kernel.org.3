Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730AA470CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbhLJWAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344517AbhLJWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:00:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA904C061746;
        Fri, 10 Dec 2021 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=e3xzUnh6wNzIQ9NXm8Wz0BvP/CH5ssrris4KaAbFFzQ=; b=Ecxexbsaq0KNwo77zdVegRmDbC
        jpV7N92m8p/vQqdXCSAfRsUrPVkKbIfsvZu7pRdgrEvCOl9GhSbvQimFuumyyvuUGJ9qGX9aQMwF4
        qAUNFKHEq9feNhhVS8YCKogjQ8P9x7SFwAD+V4XwAIfXB4DLVqYxfW7YeIjcWkXdW3zLRMHDRilpi
        V+tomK72xlogQ86qzb+MvB2i16WFmGXpgInJC1wCaZckW/Vo7eh9wTQtiONgcveZcJEeq/+oMVH72
        9FLueKzFsabcu7IZG2RCpsUgzQhJ1yETl7dV9UAFqlqWAy9mYEXe8dr3jSuDl8vDFD7QCgvG/zsC+
        NT90zY5A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvnsj-003v3f-M9; Fri, 10 Dec 2021 21:56:45 +0000
Date:   Fri, 10 Dec 2021 13:56:45 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Next/Trees: update the modules tree
Message-ID: <YbPNHcF9UrvrR5jb@bombadil.infradead.org>
References: <20211208195931.3369500-1-mcgrof@kernel.org>
 <YbPI6Novz3ikiKEI@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YbPI6Novz3ikiKEI@sirena.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 09:38:48PM +0000, Mark Brown wrote:
> On Wed, Dec 08, 2021 at 11:59:31AM -0800, Luis Chamberlain wrote:
>=20
> > pull request which was merged for v5.16-rc1. I'll queue up fixes
> > on the modules_linus branch.
>=20
> > those in the modules_next branch to match parity with the same style
>=20
> Actually, note that your e-mail says the branches are modules_X while
> the diff says modules-X which looks like it's the correct thing:

modules-linus and modules-next are the correct ones indeed.

Sorry about the confusion.

  Luis

>=20
> > -modules-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/l=
inux.git#modules-linus
> > +modules-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof=
/linux.git#modules-linus
>=20
> > -modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.=
git#modules-next
> > +modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linu=
x.git#modules-next


