Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506CA5597BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiFXKVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiFXKVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:21:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC57F7C502
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:21:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A740721982;
        Fri, 24 Jun 2022 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656066092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2o//5RsBBP4Q3Y91eiwaePN5wmGbpiIFxxYpkXu0ZYE=;
        b=O4tm8iaMwSHu7ldBuiOY3Elnh25wFyZ7CO1Np57zyckcwbNLwUjGFIfBe47zwAUB8KGjed
        BM+UX85MO9dLfcnS0r7gBEhxEAeTWifOrYCZ8VnHSdYxk6shATkvn4CrKt5yCo1YGaz56t
        1wOQkxQ+fHRsZ2e7NveJ5q67TCOjW0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656066092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2o//5RsBBP4Q3Y91eiwaePN5wmGbpiIFxxYpkXu0ZYE=;
        b=g3osGxy0Z3so5e0NMyBNVREKmUrFXe4Bc1ptB8YZmasy9nWMFNoJWl9XKORLjHxtPrXOIP
        7n3ksU1XW+E8SwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EBD413ACA;
        Fri, 24 Jun 2022 10:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K3NaGSyQtWKSJAAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 24 Jun 2022 10:21:32 +0000
Date:   Fri, 24 Jun 2022 12:21:31 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: Add new IOMMU development mailing list
Message-ID: <YrWQK32lXdyzVheR@suse.de>
References: <20220622082601.31678-1-joro@8bytes.org>
 <YrVZ7g3AKzoI0uMG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrVZ7g3AKzoI0uMG@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:30:06PM -0700, Christoph Hellwig wrote:
> iommu@lists.linux-foundation.org is also listed for various other
> MAINTAINERS entries.  Can you please send a list to update all of them
> to Linus ASAP, including for 5.19 and -stable?

Right, will do, thanks for the heads-up.

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
 
(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev

