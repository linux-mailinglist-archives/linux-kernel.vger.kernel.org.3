Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC5533210
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbiEXT5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbiEXT5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:57:36 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9840E175BC
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:57:35 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 24OJqGUX030520;
        Tue, 24 May 2022 14:52:16 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 24OJqGgw030519;
        Tue, 24 May 2022 14:52:16 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 24 May 2022 14:52:16 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220524195216.GL25951@gate.crashing.org>
References: <20220524093939.30927-1-pali@kernel.org> <20220524175955.GI25951@gate.crashing.org> <20220524181255.bmszzxmbwzv7zed7@pali> <20220524185247.GK25951@gate.crashing.org> <20220524191610.hnodzz2j7mlgthey@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524191610.hnodzz2j7mlgthey@pali>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 09:16:10PM +0200, Pali Rohár wrote:
> On Tuesday 24 May 2022 13:52:47 Segher Boessenkool wrote:
> > Aha.  Right, because this config forces -mspe it requires one of these
> > CPUs.
> > 
> > You can use a powerpc-linux compiler instead, and everything will just
> > work.  These CPUs are still supported, in all of GCC 9 .. GCC 12 :-)
> 
> Ok. I can use different "generic" powerpc compiler (It should work fine
> as you said, as it has also -mcpu=8540 option). But I think that
> compilation of kernel should be supported also by that gcc 8.5.0 e500
> compiler.

That linuxspe compiler you mean.  Sure, why not, the more the merrier,
as long as it doesn't get in the way of other stuff, I won't protest.

But please don't confuse people: you are talking about a
powerpc-linuxspe compiler, not e500, which is supported just fine by
current GCC trunk still, and does not have such limitations :-)


Segher
