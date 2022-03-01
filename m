Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8404C7F79
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiCAAoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiCAAoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:44:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D31AD8C;
        Mon, 28 Feb 2022 16:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=VRtotTgRjt8wUewVfxAnnsW/LkqttFUYABF7jPzSKmM=; b=UaEbdPQ//Q6peho6+qf+TIsEPC
        lOypGHi4VgTUdDgo7t4MZDqp4xjdTX8F8B9CNJ5wukDUTmL3X8UvDu159XkZE83rIFnP828FdzM3w
        rZgvHFV2mmZmtLvWNWxENS4RIXBU926w1p95B9ilgn/mgYp1WU1s9Db4fWXZ/JrdRw6up/ruNc9IU
        UJV6EqXhM8SUcEM3Dy5DOOIzPMfPnQ53zGKapqcIf+OnychSawAT0lvkOxttBxyN1dGRfzEnTufXx
        R60vjjf5dmZMRmC3wckSqLUcgHppTqrVZXS7fdKidrZoZSWEzUtOFYfcB9f+qsXu2iR2Vh7rvwPOB
        mJAqhAbw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOqbp-00EWOO-1a; Tue, 01 Mar 2022 00:43:21 +0000
Date:   Mon, 28 Feb 2022 16:43:21 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the modules tree
Message-ID: <Yh1sKVz4g+X0xge0@bombadil.infradead.org>
References: <20220301113333.21d6f0c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220301113333.21d6f0c6@canb.auug.org.au>
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

On Tue, Mar 01, 2022 at 11:33:33AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> In commit
>=20
>   f131a1296ecf ("module: Make internal.h and decompress.c more compliant")
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

This is not that critical but I've decided to reset my tree again back
to Linus' tree as I jumped the gun in mergig this to modulex-next as it
has not been run time tested yet. So I've dumped this on modules-testing, a=
nd
once we get more testing results I'll push this to modules-next.

I can fix the commit log to have 12 digits on the SHA1 manually,
provided no other compile or run time issues are found.

  Luis
