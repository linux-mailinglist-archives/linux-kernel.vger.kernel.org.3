Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80956568369
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiGFJZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiGFJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:25:46 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF9C17E0C;
        Wed,  6 Jul 2022 02:25:45 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 354E94CC; Wed,  6 Jul 2022 11:25:43 +0200 (CEST)
Date:   Wed, 6 Jul 2022 11:25:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the iommu tree
Message-ID: <YsVVFkpB/HB27+gP@8bytes.org>
References: <20220627084115.559a257f@canb.auug.org.au>
 <84e26670-5e0f-61b8-8912-42bd048faf16@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e26670-5e0f-61b8-8912-42bd048faf16@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasant,

On Mon, Jul 04, 2022 at 04:55:28PM +0530, Vasant Hegde wrote:
> Sorry. I didn't realize mailing list is changing "From:" header. Will you be
> fixing it in your tree -OR- do you want me to resend patches with updated
> "From:" line in patches?

It is best if you could re-send this with correct From lines and I will
apply it then from my mbox. Please Cc iommu@lists.linux.dev.

Regards,

	Joerg
