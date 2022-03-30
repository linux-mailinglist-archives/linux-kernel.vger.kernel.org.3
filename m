Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92724ECCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350471AbiC3TCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350357AbiC3TCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:02:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7423C7B553;
        Wed, 30 Mar 2022 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=06sSSn0J0ZsK+M9YNtNFlQARP4cIQe5+a3DhFgQSasw=; b=Bnut82cpPv0/xL0g2Ul3Sr7OKi
        Dj0nkJAYAxyQ5nEOZyHqoZNQ7hIP+zZv5ZqyfTkfwaD9saGSZ+0V+fWaqvUde9QIhhwF66mOtVZ2I
        6FplQj6GNHK64PDKbyUp1G7TX/NMJuvapMhlybY1nTzZxyeLWpdjquQ4dGlzpr8/fQbIUZkMICQl2
        JqK31LuBDXAapub+G9xu6prOOfT4Ty/SbqaLFUI8fvOeHCnV1Lpl8/gCSAQqJjPvF9Na7KbSwADCQ
        o8eBXyqLp3ceKXKnyOPAOE4LJEKrOq3NPosL+B1Oe/S8kAsHEOpmvJBRHSiDv9q/08JNG8AjCMWNp
        tdAPsAqQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZdYL-00HE6L-6h; Wed, 30 Mar 2022 19:00:21 +0000
Date:   Wed, 30 Mar 2022 12:00:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wei Xiao <xiaowei66@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sysctl tree
Message-ID: <YkSoxQhTVitU6mh9@bombadil.infradead.org>
References: <20220330115617.4d694d11@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220330115617.4d694d11@canb.auug.org.au>
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

On Wed, Mar 30, 2022 at 11:56:17AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the sysctl tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> kernel/sysctl.c:1776:36: error: 'C_A_D' undeclared here (not in a functio=
n)
>  1776 |                 .data           =3D &C_A_D,
>       |                                    ^~~~~
>=20
> Caused by commit
>=20
>   84053cc7ef2f ("ftrace: move sysctl_ftrace_enabled to ftrace.c")
>=20
> I can't imagine how that happened (though I do note that the whole branch
> has been rebased and not tested :-( ).

Sorry about that, indeed I rebased it and only test compiled the
conflicts.

> I have used the sysctl tree from next-20220329 for today.

I'll push to 0-day testing before pushing a new iteration.
Trying to prepare to push to Linus.

  Luis

