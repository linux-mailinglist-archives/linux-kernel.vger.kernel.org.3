Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B64F7AA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbiDGJBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiDGJA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:00:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA408E1B7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4873B8241E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC51BC385B8;
        Thu,  7 Apr 2022 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649321929;
        bh=6RgwU1E1n8auPmzQMx4Tm1lNyPHTBaGj7MCSSIyGXoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kYIxcJWLe5MezQQjwgGDD7V6F74RwZafKSbuk5Ofsv7wOtEiSGbGcVifZ+mMWEyWk
         wkhRoGUjGSuowStsCvZD7GNlat0/mG9mLoxGt5KTixz8+Wp4hWi9Ii+jE6ExSssQqq
         tBknaQQhzX24OHYqpdmP/yGyHPjpZ4mKSQHi7c6mehNqBkgh+CCzDgDZeXMZLvcrEh
         WdEzaso5kthwdVaE9fVOBBu4DXTW/cuPQ08jXkRQTks0eH/3XkYV4f5mS2cdYP/FCf
         ZMjxyjk2vIO9Y+cPOdCBI1DqJOazAwiEdUxC14Iolv4WtAADdapRRIDxrLXwkO7QCT
         67POFlLvqpIGg==
Date:   Thu, 7 Apr 2022 09:58:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mark.rutland@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        mingo@redhat.com, tglx@linutronix.de, catalin.marinas@arm.com,
        will@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, qirui.001@bytedance.com
Subject: Re: [External] Re: [PATCH v3 3/3] arm64/ftrace: Make function graph
 use ftrace directly
Message-ID: <Yk6nw1kWC28c9W2k@sirena.org.uk>
References: <20220224093251.49971-1-zhouchengming@bytedance.com>
 <20220224093251.49971-3-zhouchengming@bytedance.com>
 <c8b7508b-ce2a-c7dc-92c4-ca5f17992844@bytedance.com>
 <20220322094100.73dc3ad0@gandalf.local.home>
 <7807fc23-c6c9-b6a9-62ef-e34e8beefdea@bytedance.com>
 <20220322104956.42203163@gandalf.local.home>
 <69edba11-6d15-b80a-5840-86834101f76d@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PmSmEBB1VdIVnuiZ"
Content-Disposition: inline
In-Reply-To: <69edba11-6d15-b80a-5840-86834101f76d@bytedance.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PmSmEBB1VdIVnuiZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2022 at 10:26:53AM +0800, Chengming Zhou wrote:
> On 2022/3/22 22:49, Steven Rostedt wrote:

> > I don't have an issue with this patch, but it needs to go through the arm64
> > tree.

> Hi Mark, would you mind picking this up for arm64 tree?

[Different Mark here...]
It's Catalin and Will who pick things up for the arm64 tree, AFAICT this
was sent before -rc1 so you'll probably need to resend it to make sure
it gets picked up.

--PmSmEBB1VdIVnuiZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJOp78ACgkQJNaLcl1U
h9COGggAhj7Gmo9VOWMHQcdA5lCDEGQK0Nf+UZOLbT9LRpqXELVdopCpHPcxLpNb
IzyFVH42TtwOM4fJz5C0A295uHFxIYGaf1jcGkpAMv5mVVfQOd2Hma0dW7wCeYp2
Z8crT7nFHOxtGxsf6/uFCN9d+ehO7OVEQf6Oy361fqq/wXMyC9lbJKUrPZa+DZOQ
XnVYqh+LclErQZgODKrwMx2qHQ61IFnP30gO9sc9alXKQ34hYhW059Jp7c72SL5N
Hkzdz5OLzBM0cVXLSsYH/JWe1slcBbtEv+KTV7vt17D+US/YsD2zuJqv1D9YdlzJ
LgnaqN8IHz+6lWNBJ8k3kimCKz3aQQ==
=70q+
-----END PGP SIGNATURE-----

--PmSmEBB1VdIVnuiZ--
