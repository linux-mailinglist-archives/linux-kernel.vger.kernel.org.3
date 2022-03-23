Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E834E5975
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbiCWT6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiCWT6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:58:49 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B3C8BF55
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:57:19 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 1385D2000B1;
        Wed, 23 Mar 2022 19:57:18 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 77D52803DB; Wed, 23 Mar 2022 20:51:16 +0100 (CET)
Date:   Wed, 23 Mar 2022 20:51:16 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: re-add removed comment about
 get_random_{u32,u64} reseeding
Message-ID: <Yjt6NJGromYyAb+/@owl.dominikbrodowski.net>
References: <20220323042336.148775-1-Jason@zx2c4.com>
 <Yjt0AX8st/gE00CM@owl.dominikbrodowski.net>
 <CAHmME9r7+tU6sU80opW-cyw4srsnOpLTsUKUv2Qdfs-DtPYekw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r7+tU6sU80opW-cyw4srsnOpLTsUKUv2Qdfs-DtPYekw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am Wed, Mar 23, 2022 at 01:45:22PM -0600 schrieb Jason A. Donenfeld:
> Hi Dominik,
> 
> Good point; might as well take this opportunity to firm up that
> wording. How about:
> 
> "... and do not invoke reseeding until the buffer is emptied."

Yes, that sounds better. Though "integer family of functions" still sounds a
bit ambiguous.

Thanks,
	Dominik
