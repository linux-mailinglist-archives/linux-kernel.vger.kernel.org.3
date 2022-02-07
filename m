Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE83E4ABEF5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443316AbiBGNJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442752AbiBGMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:21:38 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CDBC03FEEB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tShKP7DzrciWLnOrgAH7zSTls+TIYFTi1DqPtEI8pwU=; b=UcBN14L6XJOXVMYkGW2kLXQbYx
        Ho5602YSmxAWsrllkJMfFXkq7rp3suSrM8Lo9l0kgYqbD5rz42xjnV1eYFyapVKTg7eDm1ckbm9kb
        BJHR4JglQEB+y3hVFtpZGiTf+HXuHqwF9esRGmr1nVQwdXw2lmeimGVGzyHQIJPif6/hWPgglS+iu
        zpgtlqaH6qziFnbo5TpmK6bGrj1n0A8pxioKCAvg+llIwW/04lvgM/sF11hFk6VhXwJYU0qE4fzx1
        WBym9TgfWVdeS3ccvTjjT40+RqI1TwLrI2TNUf4fDDGDNPNfp950vwQ9FA6X8RDHok5ssF1DjE6hq
        NK2SvOGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nH2s5-007lYE-Bq; Mon, 07 Feb 2022 12:11:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DAA6986235; Mon,  7 Feb 2022 13:11:51 +0100 (CET)
Date:   Mon, 7 Feb 2022 13:11:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        ardb@kernel.org, arnd@arndb.de, will@kernel.org
Subject: Re: [PATCH v3] atomics: fix atomic64_{read_acquire,set_release}
 fallbacks
Message-ID: <20220207121151.GE23216@worktop.programming.kicks-ass.net>
References: <20220207101943.439825-1-mark.rutland@arm.com>
 <20220207113820.hl6kpewb7blzllf5@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220207113820.hl6kpewb7blzllf5@tardis>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:38:20PM +0800, Boqun Feng wrote:
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will@kernel.org>
>=20
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thanks guys, updated!
