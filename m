Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626D5509556
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383935AbiDUD0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbiDUD0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:26:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72852BE0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=518s/bV4TCH6do4faMKwUTbJ1R5G6bDFA0nS4eF5vTY=; b=iRYqt+h9E0JwHybuuadReFIah7
        JbrdMQSYq7eZX3GosxWDisUHT1nXAZM4qUIpylUT+iVAn1sydqAt+AAV6IrQc0FoOLXoli48sTMav
        fpZfW75tCJDDzv7thpQbLsjquYqdKDXOBmMRDxkHm9DSNRx9e2qYz4ZSNkfE/gSMoL8xMx8eebM13
        iZ0mlqSD5Pm09AVXsecgJTSAYoKOny63jt8HrxWkpKP+LHqWVIrMq9w5l2tVs9HCUAH+opX9uuTFf
        QzpA6b5FT/UbxkOE1qOBGZ+qJTQ2JLF0o5OHIBhDr+jZlG5ZdaJ78T84mY8wML7JZ7awBsw8xAOxv
        vut4T7Xg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhNPc-004hzz-Sh; Thu, 21 Apr 2022 03:23:20 +0000
Date:   Thu, 21 Apr 2022 04:23:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_table_check: Drop all redundant EXPORT_SYMBOL()
Message-ID: <YmDOKJCZteqrKr61@casper.infradead.org>
References: <20220420060221.1107736-1-anshuman.khandual@arm.com>
 <CA+CK2bARgsgBAgawfAD8-xzDN6+_sg4zrPQnoTFy4b=ZMx_u1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bARgsgBAgawfAD8-xzDN6+_sg4zrPQnoTFy4b=ZMx_u1g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:54:08PM -0400, Pasha Tatashin wrote:
> The rest of EXPORTs were added to be symmetric, and allow other
> drivers to use set_*p**()/clear_p** calls.

EXPORT_SYMBOLs actually have a real cost.  We don't add them "for
symmetry".
