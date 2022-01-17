Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F938490305
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiAQHno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:43:44 -0500
Received: from first.geanix.com ([116.203.34.67]:37716 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233264AbiAQHnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:43:43 -0500
Received: from skn-laptop.hadsten (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 1ABB1E1D2B;
        Mon, 17 Jan 2022 07:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1642405421; bh=BkxqqyOywP8z7KZIMPcWrvw63V4L9m98zNSVef5yzcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WwYATuhJElseYGS0r8SZvEhu03GwuQy7g36X87wL53dKMVjnSgq5kOER6nPk6yYOM
         I6SIxCF7yaRBRikAfFD9bMJB53u00p4X+kfnGXuQKzqJvPYC7RqWywTKD3S89utipG
         aZXnAdV+cWj89kMn3efiiQ9hB25tXtAlJyv0iyolcOHFOa+gUAfC7B1zXvU09uPIWz
         0nmVjWBrFOQpUVWzg2NXpGFZMqDvk48yT8e6kKVEro2U/B8wk6naB2y+VlSdqDSnTx
         v1/auBzJJms0zVGdgvuPIwZIUOE9bAyuCYvOE/sQ33ywjMj8pe4dk1BRtiR0uB3Hnc
         UY85hJdHdVBxQ==
Date:   Mon, 17 Jan 2022 08:43:39 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: protect access to rawnand devices while in
 suspend
Message-ID: <20220117074339.ctuaxnetz47j45z4@skn-laptop.hadsten>
References: <20211220130015.3630975-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211220130015.3630975-1-sean@geanix.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 02:00:15PM +0100, Sean Nyekjaer wrote:
> Prevent rawnend access while in a suspended state.
> 
> Commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") allows the
> rawnand layer to return errors rather than waiting in a blocking wait.
> 
> Tested on a iMX6ULL.
> 
> Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---

Hi Boris and Miquel,

I know the kernel test robot is complaining a bit about uninitialized
values.
But is this OK? If I fix the unitialized values?

/Sean
