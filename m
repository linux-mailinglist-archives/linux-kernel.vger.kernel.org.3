Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F00570A49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiGKTEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKTE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:04:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DAE20BEB;
        Mon, 11 Jul 2022 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RBNxHIfTMPpthTpFhNww5Y/9NLqC54GKvsbl3S45En4=; b=chVl6qlSSO4/c8bSiScrOkkcuH
        gayN/tOIUsmhEZgYgLCKTcqGNF1E/X5jxa+zsJagB27JEUCvsuhZm45eSYsGN/dnGYz21h5maTosb
        Dkpo1mlk991FlgmlUZGQbxPNup+pJlqioW1jkX3K4CboInOmFCQvEqzpG+IyD6wcQ/JuQ4QvxLqOP
        exmRmc96M83f4CS3ojwVJ19b37FAEGkBJCHPxPvcnwrQhShfsEy0tdzdxVSyjICEyYpXgCGek61k9
        HbutIfpd6WNquVyxLG3VR9GEJs0L2EEwbu414oBiI2R0iC3sJS3NffYfhfW9tGp1DfZ9MdHO7a0B1
        teCMmSiQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAyhl-0047Gl-OR; Mon, 11 Jul 2022 19:04:25 +0000
Date:   Mon, 11 Jul 2022 12:04:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     jeyu@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: Update file list for module maintainers
Message-ID: <Ysx0Odu384bTFDy8@bombadil.infradead.org>
References: <20220627190551.517561-1-deller@gmx.de>
 <20220627190551.517561-2-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627190551.517561-2-deller@gmx.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:05:51PM +0200, Helge Deller wrote:
> The scripts/module.lds.S and scripts/modules-check.sh files
> should be maintained by the "MODULE SUPPORT" maintainers.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Thanks! Queued onto modules-next.

  Luis
