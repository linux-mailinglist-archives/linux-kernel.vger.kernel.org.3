Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9A4BF7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiBVMJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiBVMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:09:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976A6B458E;
        Tue, 22 Feb 2022 04:08:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36C41B81995;
        Tue, 22 Feb 2022 12:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81A5C340E8;
        Tue, 22 Feb 2022 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645531724;
        bh=KiLmQYE1zsLB1JOKSusDj6Fs0OXTjXKjzDkTWV/k4VU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFgH7y5CtEh6X+QBnViRTZDkvbO8JBeYJAMpPqibM5600tpDi8s2G/L5GFjsBz8/s
         ewx05CTiVkMObB3HwVjA1VEut/EI5hbJ/QTVIR0t6LsULlN/DQ7RXTzBAOXcawU4CR
         kyPHeEd+EFO+Z0rAHztBLUDBzLPEFtNywhByLSGRbRADGhK+YrEiQJ/iSLZn++jTxv
         aXKU5ZqEncHOrhRDuOfAi/ZRvtTkXl+Hst3OXCIf3Bk3GSg5zWXMSE/isgK9uWo7Rc
         D2XI5RPM6B6NA7jwnFyM0uQyZVibeHxILscrdALPK8ATE61Uju7BXdbBKkm39it+7w
         2awLFm4VHQeOg==
Date:   Tue, 22 Feb 2022 12:08:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: linux-next: manual merge of the slab tree with the origin tree
Message-ID: <YhTSSN3Hlh19MHSX@sirena.org.uk>
References: <20220222010824.3406817-1-broonie@kernel.org>
 <c19d1ff8-ab19-a118-17e6-bbf74059954b@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="61pwXX3kz7G/bNpI"
Content-Disposition: inline
In-Reply-To: <c19d1ff8-ab19-a118-17e6-bbf74059954b@suse.cz>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--61pwXX3kz7G/bNpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 22, 2022 at 02:35:39AM +0100, Vlastimil Babka wrote:

> Weird, these commits are old and unreachable, this is from before the merge
> window. The slab tree for-next is here, Stephen has been incorporating it for
> some time:

> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=for-next

> Same thing with your other mail wrt mm/zsmalloc.c

Yes, there was a problem picking up new versions of trees which I've
already sorted.  Things should be fine today (modulo any conflicts).

--61pwXX3kz7G/bNpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIU0kcACgkQJNaLcl1U
h9Cgggf/QcP20fZKzfwwMVgsHXaaXTv3D4vSkuh9wn2Nq7RHV4mpu9RmWipcBlKk
4dZlWkxMtADIAGpww5CFG+fmgXv1ZlhrfA5MRRuQiYgIWmMnPQf3xskjfiI+5JP+
3OyeB+XE3OqU1qFOnKnobIx8Ka+AQaE9q/AWVxxYeBYDtO4NXJxBZzIrEMQP3ksF
A9HuiNhlgblQeGQP5n/s8kj62WQQ1JEmaasEzT7BcPhuW7kCvk39hxwUaNFl4nJ0
FRncYs9kaHwmjFZNMxyGrjDoTwnlysFaFgWr3O9KztVl97sBWdfBbjXFgEwj2Fgn
bMPJfF+pTqEX6NnHTgWZBQmqffAGNg==
=KeY5
-----END PGP SIGNATURE-----

--61pwXX3kz7G/bNpI--
