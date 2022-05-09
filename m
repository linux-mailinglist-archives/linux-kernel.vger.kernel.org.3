Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9551F465
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiEIGU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiEIGS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:18:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF24EABAE;
        Sun,  8 May 2022 23:14:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C26668AFE; Mon,  9 May 2022 08:14:30 +0200 (CEST)
Date:   Mon, 9 May 2022 08:14:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Minh Yuan <yuanmingbuaa@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH 1/3] floppy: use a statically allocated error counter
Message-ID: <20220509061430.GA17155@lst.de>
References: <20220508093709.24548-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508093709.24548-1-w@1wt.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole series looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
