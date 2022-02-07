Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7038D4AB656
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiBGHzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbiBGHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:54:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10F8C043187
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bfCko0XswDvyzrb0mScH4JQ23JKYjCONFevhpF7t2sU=; b=aErNdsMKpYnzA/uXYosYH9LYbr
        Crd9CPk5jupCo9B0JJDmqKXVT61JtDVANEmEb3rRWodYGWmdQkrtcXR8HlpOmFOp9QAV2OoAFs4Lt
        RHhUaTiFk65mdYf/9JMNZy7hLn7POnICFqy+LnpGqIny7U2znLMaZh5eVZE+g6cO5Oa8WEK0OLPDG
        96ooA/QcX+4/TbxLktF5aHovA85VaWyK+6JtVlrnjrgygPcoGHWc3oA2fZ8D1eMFk+oSal5QW2PI4
        oCmHfBnJxCqIEXCR4o4EPauKW2n5Qch8M67glzwEHNLOWnu+2BXBNv8u8YLxE6XZJ1/R1jB5Xls7q
        a5n6YEKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGyrQ-009GBG-0s; Mon, 07 Feb 2022 07:54:56 +0000
Date:   Sun, 6 Feb 2022 23:54:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 38/75] mm: Add folio_is_zone_device() and
 folio_is_device_private()
Message-ID: <YgDQUL3454ZCeUBV@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-39-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-39-willy@infradead.org>
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

On Fri, Feb 04, 2022 at 07:58:15PM +0000, Matthew Wilcox (Oracle) wrote:
> These two wrappers are the equivalent of is_zone_device_page()
> and is_device_private_page().

The looks sane, but I just send out a series this morning that moves
is_device_private_page to memremap.h and removes the inclusion of
memremap.h in mm.h, so there will be a bit of a conflict.
