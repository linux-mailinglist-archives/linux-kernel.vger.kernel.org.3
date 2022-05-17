Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3074529948
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiEQGGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiEQGG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:06:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159A7643
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3e+6V4b10eNtcSRBt1KIAzPNtk5l+0fY1/wz2FkGjdQ=; b=Wzht2lcb7FV40IHQIzmP0ZgE7g
        +1bOSbJTMNjV/qYc0SZs6IyS8aPoZkjF7S4D33fgjCT55faZeLxLQXwsdl5cvfgcdPHFGmos5yZ61
        V2XYxTgKsHEdla8kc3+jGEhY/q7b0DIE4/1aDPA4GDRavX+STjVC/ejZVRMw9oqXkILqZgbCq5THl
        LiQhw5cu3GX4k1NStUmWfiYdfilUjzNr1scoPl+h0T2cZCCF54ul8HEXc0t201G/TauAhgvPLhrT1
        CNZCqaEWDdnuvM8q7XrD66oSofqxCPerlInJ673T7zw5K2Zz1TZADxDevdbrgkz/aI02SSO5loGiu
        +rBAhxig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqqLh-00Blq5-8T; Tue, 17 May 2022 06:06:25 +0000
Date:   Mon, 16 May 2022 23:06:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     hch@infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] freevxfs: Modify parameter description in
 kernel-doc comment
Message-ID: <YoM7YZVU4GYtUdpo@infradead.org>
References: <20220512075238.29925-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512075238.29925-1-yang.lee@linux.alibaba.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I don't have a freevfs tree, so please send it to Al or Andrew, thanks!
