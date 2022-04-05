Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ACF4F436E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445378AbiDEUIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457455AbiDEQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF775217;
        Tue,  5 Apr 2022 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=TMPbPnFou6Y997rWHcGS0450RsROzpZC2NDKg7Bz0/E=; b=oM7b1v96ZJoPGAEDhmOwbPoLav
        iCeSDBMaybSOWxAT7ohLU+UWfeEvY05rOMw3RNM3JxB4slMWpnvY06O6hoBUVKl2VxYKZiR+9jfg2
        oaK04+/o5LRy8M9ifmfq5HjC86Nr8vNsZB1a+nMGp9c3loCKjSHlDj9HoN+tT+ubDWCancy5h0rvm
        iil5i7GSxAvatFCQU96lZ7QQftnZx0v0bG3BDXZfbrhcTteW69vlucO3Gwh0PwJgDyf0bR+Mb+bSK
        gLRMKXFgAaC4u64Eo8ZqogjKATGl03TfP79k0sYWQxNTbXps14VygL6Fr0PfnOFR/v329Alfuq4Ce
        ZGRkEN4g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nblNS-001lcc-2I; Tue, 05 Apr 2022 15:45:54 +0000
Date:   Tue, 5 Apr 2022 08:45:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the modules tree
Message-ID: <YkxkMiSt1SnCLrGc@bombadil.infradead.org>
References: <20220405081529.28925a1f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220405081529.28925a1f@canb.auug.org.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 08:15:29AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> In commit
>=20
>   450f0134ccf0 ("module: Make internal.h and decompress.c more compliant")
>=20
> Fixes tag
>=20
>   Fixes: f314dfea16a ("modsign: log module name in the event of an error")
>=20
> has these problem(s):
>=20
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").

Fixed, thanks!

  Luis
