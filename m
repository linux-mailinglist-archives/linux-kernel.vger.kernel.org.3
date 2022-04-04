Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D094F0D75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 03:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376881AbiDDBs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 21:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344091AbiDDBsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 21:48:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CF186CB;
        Sun,  3 Apr 2022 18:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=iYteJcvBgc/YlU1X4Yo/ta7CrqAZSWx1rViU/Vx9fDU=; b=vx4Ug+BqP19TzwZ6WfSkT8gFXX
        ZZ+Vb5A1VhkcyygtiMTWQr/SA18H/maiUVGiLbCBCYDQH8qGX3pidHsevpHfw80dDQSJMKpRb6bUU
        0xM663j/8QSpV9pdjpbzJcIaCWPoeUqOXyBhqNaqsrB5In46PJi8rt8ByBdqqQqtShTpo7QKnQQag
        Cwr6YX8LACN+fTCqhYXkosoyKb1T825KDXcWf2Yf2T4asJ6Bso9VFj/TVoJZepAT3ggCvxM1H72RS
        y1AA3DwtPJD6qQuqwQcnDhes6kPzqBFo44/JxmkRmxvCwjjoJw05dsCRmJSfXN/xy5LaWS7d3GNJr
        N5T+h+oA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbBnr-00Ck2y-Uz; Mon, 04 Apr 2022 01:46:47 +0000
Date:   Sun, 3 Apr 2022 18:46:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wei Xiao <xiaowei66@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sysctl tree
Message-ID: <YkpOBykNOI6YjMon@bombadil.infradead.org>
References: <20220330115617.4d694d11@canb.auug.org.au>
 <20220404102617.572de1d8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220404102617.572de1d8@canb.auug.org.au>
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

On Mon, Apr 04, 2022 at 10:26:17AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> On Wed, 30 Mar 2022 11:56:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Hi all,
> >=20
> > After merging the sysctl tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >=20
> > kernel/sysctl.c:1776:36: error: 'C_A_D' undeclared here (not in a funct=
ion)
> >  1776 |                 .data           =3D &C_A_D,
> >       |                                    ^~~~~
> >=20
> > Caused by commit
> >=20
> >   84053cc7ef2f ("ftrace: move sysctl_ftrace_enabled to ftrace.c")
> >=20
> > I can't imagine how that happened (though I do note that the whole bran=
ch
> > has been rebased and not tested :-( ).
> >=20
> > I have used the sysctl tree from next-20220329 for today.
>=20
> I am still getting this failure.

I have fixed these issues in a new push to sysctl-next just now.
This all goes tested through 0-day with no issues found there.
Sorry for the delay in fixing this.

  Luis
