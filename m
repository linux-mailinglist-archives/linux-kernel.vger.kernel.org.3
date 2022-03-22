Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4114E44F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiCVRYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiCVRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:24:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF292289;
        Tue, 22 Mar 2022 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DqNqEclD4N3mlsM6SsC6M7YOYDs+yhCj0iuv2SDtItw=; b=Ix7DcVJABa3F9SOEi7SEcU8aCd
        oNNPI0Lr6w4+vjGOCe/J8EbkMJFodcyJ9kE3iNYh9cGRS1JAF0P96xH3RE1Gken/ZB9bcC2rUAhl6
        odZ47uyPZ//taSibqkJxdmpc8tH3kFfwzp2Qh7YEiezEPaM891fdRKhRTVTIFBxPXPWKDkPAFmNf9
        iSrolrRRn6nT9DQJXioflA2qof3PMHEnnlVoEU3O+HZS2Wg6QmlH1jXUcB/0WWc4RpwE9wNof/VyG
        wQ3J2zszPQ5kFBcB5lZ3cyzoAthzy38fIDR/VAwU8fIA1PMX2MKoLO+Offs/Wu3jPYSeY+o4CQuit
        teGWv+3g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWiDp-00BiOb-TU; Tue, 22 Mar 2022 17:23:05 +0000
Date:   Tue, 22 Mar 2022 10:23:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     christophe.leroy@csgroup.eu, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: Re: [PATCH v12 00/14] module: core code clean up
Message-ID: <YjoF+ZoOb//gL2N5@bombadil.infradead.org>
References: <20220322140344.556474-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322140344.556474-1-atomlin@redhat.com>
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

On Tue, Mar 22, 2022 at 02:03:30PM +0000, Aaron Tomlin wrote:
> Hi Luis,
> 
> As per your suggestion [1], this is an attempt to refactor and split
> optional code out of core module support code into separate components.
> This version is based on Linus' commit b47d5a4f6b8d ("Merge tag
> 'audit-pr-20220321' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit").
> 
> No changes in this iteration. Each patch has the same In-Reply-To.

Queued on to modules-testing, thanks!

  Luis
