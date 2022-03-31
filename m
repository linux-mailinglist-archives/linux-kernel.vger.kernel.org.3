Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57B34ED2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiCaEhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCaEhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:37:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7185AA4D;
        Wed, 30 Mar 2022 21:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mjPo0ALhekam+cKurpmgNPz65ahpCtgaw9wWKXxz9nI=; b=44GVYRfH+UprBVY3J4nWjDcdFC
        2amAFX2YH/w/AFeCYskg5KZG1YfzoTllYEMMjzreui5CIFI7Y2FmlR/k+41QJKyP+50HCuRiRZ8Av
        SErvLxnR5H3X3WsITfCyKWyPtYku8rgUyoxxasW2YL4SHWd8IbvLQlZpkUzsXr5w2fRHsU6Gkc22Y
        bweeehvAFhiKn52Yajy2VoAMsUjnqFSOq9lR3WZ8kuI8Lo8xm9FcXlyalYz7cRdL7gyBILRlv39tS
        5nlNzqFfkd1XiTOpZh5N2omP03ldvhIQv3iAD9y30woTnij9jrFGbGLdoeqbNXdjh995ogWznzFpB
        Ok5LVh0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZmWg-000dOB-Le; Thu, 31 Mar 2022 04:35:14 +0000
Date:   Wed, 30 Mar 2022 21:35:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michael Marod <michael@michaelmarod.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: NVME performance regression in Linux 5.x due to lack of block
 level IO queueing
Message-ID: <YkUvgu6VxNORv8M6@infradead.org>
References: <51E3A396-F68B-496D-AE36-B0457A3B0968@michaelmarod.com>
 <847D3821-1D92-468C-88C3-34284BA7922E@michaelmarod.com>
 <C06B8EF0-BF3B-4F14-994F-F80B5102D538@michaelmarod.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C06B8EF0-BF3B-4F14-994F-F80B5102D538@michaelmarod.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.4 is very old.  Do you still have a problem with the latest kernel
(5.17) ?
