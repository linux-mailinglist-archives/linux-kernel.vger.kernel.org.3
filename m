Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CE4533972
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiEYJII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242890AbiEYJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:05:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19884A5001;
        Wed, 25 May 2022 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f149isEkjIfAHkC+kbuLgy37kQgwJtPXTfas0jr63Rc=; b=BWj14xMlVhzlgV8vM7pFcL7HEB
        j2YKII9yKoy9BoT+mo3FTOVL20gSISBCGw21FQ0sk9ZTnvsmre0CQOX1Ps/UAI7lyPRWqCVtrGlup
        bBc/gAafKdFc4egnMR42NpLeQA8T44Ko1/rwzB1eO40eCR/Ka7HaqF3pdGeH54TFx9ZGp+mOsLmai
        X3Sx+wWUtJfD6uM2Ba0d46C0pKz71i8szm4KqsUSIJ8W7/oY2YCNou2gBH+vnyZwgHo9sLgSMGuP/
        2vqpy9gN/RNy4+tGPCoLoeozqyMMRWPUwEjWZCFRWi1rIqS95/cF0rsyP9UKey2k0vz37XoTHidTH
        s2ALPSMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntmvt-00AWFk-ED; Wed, 25 May 2022 09:03:57 +0000
Date:   Wed, 25 May 2022 02:03:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
Subject: Re: [PATCH 2/3] ata: ahci: Rename module parameter for lpm policy
Message-ID: <Yo3w/dsaly+gcQNR@infradead.org>
References: <20220524170508.563-1-mario.limonciello@amd.com>
 <20220524170508.563-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524170508.563-3-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 12:05:07PM -0500, Mario Limonciello wrote:
> The LPM policy is applied to more chipsets than just mobile designs.
> Update the module parameter to drop the word "mobile" to make this
> clearer to users.
> 
> Also, document this renamed parameter in the admin-guide for users
> as it was missing previously.

Even if the name is confusing I don't think we should rename it as
that breaks existing setups.  I think just updating the documentation
is good enough, but if you feel strongly we can just add the new name
while keeping the old one as an alias.
