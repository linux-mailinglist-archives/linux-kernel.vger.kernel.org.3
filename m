Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628B04E5DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 06:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbiCXFPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiCXFPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:15:31 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB016A05C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 22:13:59 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id BEF7C20130A;
        Thu, 24 Mar 2022 05:13:57 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id ED08F803DE; Thu, 24 Mar 2022 06:10:35 +0100 (CET)
Date:   Thu, 24 Mar 2022 06:10:35 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] random: re-add removed comment about
 get_random_{u32,u64} reseeding
Message-ID: <Yjv9S/NB7hFktukp@owl.dominikbrodowski.net>
References: <Yjt6NJGromYyAb+/@owl.dominikbrodowski.net>
 <20220323201018.171141-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323201018.171141-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Mar 23, 2022 at 02:10:18PM -0600 schrieb Jason A. Donenfeld:
> The comment about get_random_{u32,u64}() not invoking reseeding got
> added in an unrelated commit, that then was recently reverted by
> 0313bc278dac ("Revert "random: block in /dev/urandom""). So this adds
> that little comment snippet back, and improves the wording a bit too.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
