Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536A958E48A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiHJBdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiHJBc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:32:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6227A6C111
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2374CB81A10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DC2C433C1;
        Wed, 10 Aug 2022 01:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660095173;
        bh=g3JxB45AmRZUU4j5cTJQ79aSQ2EPOMB1eQC1xGAnDnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1X0FdepTmyhPZ0h6LkpLzJhIiza099h6UqBj4c7sI26P6/SsZyQVfk915khMY/gYp
         OOLwuYjwuLs18/+LnbejFkjKOyUpBQA+f2n4NX1HHu/CBPiQk1Vf9CzSsi93fQuRhx
         Vo2KjhNhV1ettS76yvw60yGvPM++3BwQJh0WAPGc=
Date:   Tue, 9 Aug 2022 18:32:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-Id: <20220809183252.d168b5a8be31fff5aeef1b3e@linux-foundation.org>
In-Reply-To: <YvJ/V2bor9Q3P6ov@dhcp22.suse.cz>
References: <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
        <YupFSpXOrcfXJNya@dhcp22.suse.cz>
        <YuqNToCACD8kKBG+@MiWiFi-R3L-srv>
        <YuqOrJKcgfamdXkk@dhcp22.suse.cz>
        <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
        <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
        <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
        <Yuu1EyC95XL98XNI@dhcp22.suse.cz>
        <Yu0OWLbzLxCkSGVJ@MiWiFi-R3L-srv>
        <Yu1VTAxd9/jP/iEk@dhcp22.suse.cz>
        <YvJ/V2bor9Q3P6ov@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 17:37:59 +0200 Michal Hocko <mhocko@suse.com> wrote:

> we have a system complainging about order-10 allocation for the DMA pool.
> 

I'll add a cc:stable to this - if future users like the patch, so will
current ones!
