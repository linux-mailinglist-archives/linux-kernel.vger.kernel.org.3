Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DAF563C2E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiGAWHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiGAWHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:07:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC575C9F2;
        Fri,  1 Jul 2022 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7ys1H/itbGlSJmn0R1YyKpZrJjKGuppwOKh7bqYI3v8=; b=UyE3pZVdG4JJ37tooODvaz5w/N
        CUohGoZFz6VDw9CirfU9M4DK+Nam6XSogFYNqZCtPExhWAcxsevOLKnvbuoiK5/a3MAqJFHq6y33v
        cmU6aPtR0Jl3G8DvI5DC0huyiiA1bERou533bjV1zJo7GKGYEsOFObxSKAn1ryWoq0vGzf4uJGBuP
        l/FIxJUR1jfMI9C64uYO990Xd4q12ZG6xs/8dH1As50gq1pKwkGRz3+MX4xV+taFTyEpAlm6Tp52V
        PTDPjeh9s/w4bUvCUO3QPu7rT4sXiKYxSLWUH0tvkrnpwU+2cpyhUAjw4Bf6J00Ec2zX7Piokkwg0
        /TProHlg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7OnC-0079Jk-1x; Fri, 01 Jul 2022 22:07:14 +0000
Date:   Fri, 1 Jul 2022 15:07:14 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Increase readability of
 module_kallsyms_lookup_name()
Message-ID: <Yr9wEiJpu6EfPdaq@bombadil.infradead.org>
References: <f15dcfd75e064f80eeb75c9baf9e881196039db7.1655100096.git.christophe.leroy@csgroup.eu>
 <133321ea63ceb4cdd83346e068d1d16b676678f8.1655100096.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133321ea63ceb4cdd83346e068d1d16b676678f8.1655100096.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 08:02:02AM +0200, Christophe Leroy wrote:
> module_kallsyms_lookup_name() has several exit conditions but
> can't return immediately due to preempt_disable().
> 
> Refactor module_kallsyms_lookup_name() to allow returning from
> anywhere, and reduce depth.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks for this cleanup, holy crap that was gross before, queued up!

  Luis
