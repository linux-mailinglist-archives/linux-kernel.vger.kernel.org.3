Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A045A9FF6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIAT3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiIAT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:28:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB19E96764
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DVqvYmW8GcL7wXAJ/UsUeOny/43FV7uLCqc3mx9G/g4=; b=fcgpRgFENgCiZXhWtjPlxmfzAx
        8DT9AJql7ya0UIHLRlSd+ep4qitdoi81b+aU3AaUWcpjYG63aravYTPYGfYYg1z3izXoUEH4k6gt4
        FKWa4sVl1S6+qvgCCGvF/2ZbJrNKn0Wnl6RjgzCnwoXsEMVkPBMtk1zq7vwkjWYGPk2VDtWL70feI
        3hoGdn0wqBnw435OAqesICkPK40EcsCiqV36hQqflN+9rVXg/9Gwoqh1PkfTyP8UDJML7rsm0pfS5
        ql5MSbUGjpV5/WwUYSR5TOGpVRMc+p+pDlpTyG0GSRaUPcpnyvPDA0xc//QzGnv4uFBTiStiElGGE
        mL55im9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTprR-006Ike-Mj; Thu, 01 Sep 2022 19:28:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D5D230010B;
        Thu,  1 Sep 2022 21:28:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9ABF2B8D5A28; Thu,  1 Sep 2022 21:28:19 +0200 (CEST)
Date:   Thu, 1 Sep 2022 21:28:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 13/16] objtool: Use macros to define arch specific
 reloc types
Message-ID: <YxEH05wtANcr9g83@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-14-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055223.24767-14-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:22:20AM +0530, Sathvika Vasireddy wrote:
> Make relocation types architecture specific.
> 
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
