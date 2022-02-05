Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF474AA807
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357997AbiBEKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:15:47 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:56798 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiBEKPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:15:47 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 6C204201364;
        Sat,  5 Feb 2022 10:15:44 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 0031480719; Sat,  5 Feb 2022 11:13:48 +0100 (CET)
Date:   Sat, 5 Feb 2022 11:13:48 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: rsrc_nonstatic: make static read-only array
 order const
Message-ID: <Yf5N3J6rpFs8qvPv@owl.dominikbrodowski.net>
References: <20220123233403.8482-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123233403.8482-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Jan 23, 2022 at 11:34:03PM +0000 schrieb Colin Ian King:
> The static array is order read-only so it make sense to make
> it const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

If it's read-only, it doesn't need to be static, right? Could you
update the patch and replace the static with const, please?

Thanks,
	Dominik
