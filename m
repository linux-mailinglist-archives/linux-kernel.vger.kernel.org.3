Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FA24C77D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbiB1SdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240989AbiB1Scx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:32:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9165E90266;
        Mon, 28 Feb 2022 10:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=dICcsoDk333ljL1gV1LjYHKVxlY+plpbc6kX/fhnUjM=; b=Nc1YKC9fa7/kqB+n77vaXmUx/9
        OpsXO/XunyzmVNd281ek80dpWWyFY4bJqgTvLg89Gm4v8t2RB/pAXobeLX7AT7Xx+waA3/gexbNGd
        aqX8LjXI4BMNyrLx/ZPscZWf3vrclE1Bp0zX/0/Qip/758D7twN0OAjPBJgqEWOu3c8MWQoHPheie
        KlGQSUJHNwh3uBoGYFXQhXVEYiORieZwX9O9n3G66/tU8RmHEnNrVh10T6N1E5jBQ4MHW+nYdy4YW
        42iVNg9Y/ypuZjF2/XNxfqJ2k6hH67W1+lxSp+wcnadO4AAaamBSTLbpPBk5e3jUGT6j0rUstky9A
        BFvYRC8A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOkZG-00DgdD-SC; Mon, 28 Feb 2022 18:16:18 +0000
Date:   Mon, 28 Feb 2022 10:16:18 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     broonie@kernel.org, Jessica Yu <jeyu@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the modules tree
Message-ID: <Yh0RcnzT2DhnDSo6@bombadil.infradead.org>
References: <20220221160721.1627006-1-broonie@kernel.org>
 <YhWAjCTPp3hhxEOG@bombadil.infradead.org>
 <20220228161307.0467e4e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220228161307.0467e4e1@canb.auug.org.au>
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

On Mon, Feb 28, 2022 at 04:13:07PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> On Tue, 22 Feb 2022 16:32:12 -0800 Luis Chamberlain <mcgrof@kernel.org> w=
rote:
> >
> > Thanks for the report Mark. Aaron, did you fix this issue on your latest
> > series?
> >=20
> > On Mon, Feb 21, 2022 at 04:07:21PM +0000, broonie@kernel.org wrote:
> > > Hi all,
> > >=20
> > > After merging the modules tree, today's linux-next build (KCONFIG_NAM=
E)
>=20
> This was a powerpc ppc64_defconfig build.
>=20
> I am still getting this build failure.

A v9 from Aaron is still in the works so I've dropped all the patches on
linux-next and reset the it to Linus' tree for now.

  Luis
