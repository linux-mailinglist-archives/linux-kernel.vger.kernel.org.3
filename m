Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA164D4182
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiCJHHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiCJHHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:07:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948F413018E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5qEpiz+56DY3JLvDm+QE6C8IbUHNH7tFbDi+Ah+kp+M=; b=oIQOr3FKP/c9vz0zr5FlogRYZ2
        m8WAPbUgVdC+03zX/VZtPU0jxCY4VN3bDcyiKSgBJq2+AuC0i8fmsqtzKL2mYFsI6RwNcwALe+8sw
        RaPuy8qMKLFWTsc0hIJIkay2zOj38I9zc1YrOlrFRtu+kXIChSkcUXSddlXtG1URmVJ8SyCfMCTTE
        xksSr02hYVmueF88FIUN9sAh9j67d1W8DRqIouodHa/NZCJ4O80advpQnaSp+DfakDZRbBikYRoQk
        9uSbdMIf8RkmMX7q+QA999otngkTnf4laL/whj9LHzqrbMpgiqQxLad6a/vinG2aD+0Y6CI+tiw2B
        sR0opzPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSCsQ-00BhEG-A0; Thu, 10 Mar 2022 07:06:22 +0000
Date:   Wed, 9 Mar 2022 23:06:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael T. Kloos" <michael@michaelkloos.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Work to remove kernel dependence on the
 M-extension
Message-ID: <YimjbmdACoQOk+hj@infradead.org>
References: <20220309052842.247031-1-michael@michaelkloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309052842.247031-1-michael@michaelkloos.com>
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

Why?
