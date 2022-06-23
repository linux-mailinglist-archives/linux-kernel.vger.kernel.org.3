Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4419557D11
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiFWNba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiFWNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:31:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACECD4B87A;
        Thu, 23 Jun 2022 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s1xQoHTn/Lr0+vVYsf70oX3lAbFND52LQc/C57Oloyk=; b=0cvtSfpbjDBhuu8RdU4KjsttIJ
        ZvGVQew19PkUqqLON8Aj8FjVg0MmUiMDc/+5Hd6ePm5+pxyaue0kKPrkoPypwc//iXKk0v0oUaloW
        13wnV91pwua/GICiL8k9WRoizdXOizWNADhJVbD5nYgZPg2QZ+yEPQvVPrzECBkYfNF++AGmQvEAj
        2WaBh02nWG55171QU1zcvLhYmXzJp2ov8wsPhZYN/eTkfRV0Tp5N1RPCk2nyy/0RiurNUzKx/aZ3J
        m25c4iK7c2K5zlM/jLFPf6MDrtu0xisgiHpvCzJqe8c8i18A+xIa070zfMUXUtaUzY0iG1Q/2NGzX
        Vw1bxplw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4Mv1-00FNAQ-AK; Thu, 23 Jun 2022 13:30:47 +0000
Date:   Thu, 23 Jun 2022 06:30:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Li Nan <linan122@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v4] block: remove WARN_ON() from bd_link_disk_holder
Message-ID: <YrRrB0Lpnuy5TA/k@infradead.org>
References: <20220623074100.2251301-1-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623074100.2251301-1-linan122@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
