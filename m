Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3E5AFF60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIGIl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIGIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:41:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF11839F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=; b=hfd8sybGfMqbmQOjE0SfaJqlSM
        ZW8dYkd0/wA6tNB6f6D+D6dFo/tZQ/xyHlXU9Wl7O+eKpEKnxzrVwTMX0vxxkwukEfTNq5ABh3HcZ
        FwcJPcC9RwsEC894NG/JLt1qPdTX/JrTk6ETN/hzZOCOvaLVFGQMeQcmJ+5vswQPYoj0G5KxnQfI2
        foT/7Z/dxx0URlv9xjUC1aP7c5/NAHlRwMX4AuL++2cPD5TB++YGh4IUMuPUSQqCAbYunWO75mhq6
        eZ5npMO1MQ8FunZnOPjYGzgRXtgqBUe6Ag/OoLTnjUZ2VBLJzRIHVlzDqM+lOMVubuqESbo5X/guV
        0yTZKncQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVqak-004Nu2-82; Wed, 07 Sep 2022 08:39:26 +0000
Date:   Wed, 7 Sep 2022 01:39:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Gao <chao.gao@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        jxgao@google.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2] swiotlb: avoid potential left shift overflow
Message-ID: <YxhYvjpDyTzlnWnN@infradead.org>
References: <20220819084537.52374-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819084537.52374-1-chao.gao@intel.com>
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

Thanks, applied.
