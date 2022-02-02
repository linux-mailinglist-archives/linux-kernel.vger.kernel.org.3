Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FAD4A7374
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345051AbiBBOm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345020AbiBBOm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:42:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A55C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wNMshXbuCTqUOnI7M//lG/XFvyRaK5X/8Im7LfAckek=; b=dw9rRMjAGvniQ1uzO0LA+9V9Gw
        OdvrvAgtPPVJYreAIQWxS5xzKT6KHx9afxYsQB8FxoZTz5b7t6V7Ng1WmKZSd2NT4xTri4hK2HTb0
        LvqZ43AZKUS7+CGcPuNYc2IHP8sv9V1MUkjcgpe0aaKLcZsXBseTf/14EIs2eS7/43PsO9gCmsdv2
        fFcTyKrpmQKs0Z3hZQ5D2iopZNll9BqYrIBVjLjQomVZnkY/xBFB+bsPmEOlgr7dhxe1r2LT4Ox4A
        ras/HfPmT4VeHbUPZttS1RJHnYAsCtSas0a246va9B9+FK9Wjq+dxYZk8nKDKKG5scGD75TQcRgLI
        8EopZFrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFGpy-00Fm85-47; Wed, 02 Feb 2022 14:42:22 +0000
Date:   Wed, 2 Feb 2022 06:42:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm: introduce a DM_ENFORCE_OPEN_COUNT flag.
Message-ID: <YfqYTuhGqOl4SneK@infradead.org>
References: <20220125002025.GA21887@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
 <20220126192234.572058-1-bgeffon@google.com>
 <CADyq12yugY0g2EMYvyrPVn98x3Tp4PR+eVddmmjZpKSYyrrzag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12yugY0g2EMYvyrPVn98x3Tp4PR+eVddmmjZpKSYyrrzag@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Withmy block hat on: nak to this.  No block driver has any business at
all rejecting "too many openers".  In fact any opener but the first of
a partition is already not counted as an opener, and I plan to complete
hide the open count from the device driver.
