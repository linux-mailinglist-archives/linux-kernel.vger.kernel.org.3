Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC884E3E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiCVMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiCVMaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:30:03 -0400
X-Greylist: delayed 573 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 05:28:33 PDT
Received: from mail.strongswan.org (sitav-80046.hsr.ch [152.96.80.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D656228;
        Tue, 22 Mar 2022 05:28:32 -0700 (PDT)
Received: from think (unknown [185.12.128.224])
        by mail.strongswan.org (Postfix) with ESMTPSA id E100B40AE5;
        Tue, 22 Mar 2022 13:18:57 +0100 (CET)
Message-ID: <6250f5f254f08bf767c052fbe0b5e281cafea2cc.camel@strongswan.org>
Subject: Re: [PATCH 1/2] x86/chacha20: Avoid spurious jumps to other
 functions
From:   Martin Willi <martin@strongswan.org>
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@google.com, herbert@gondor.apana.org.au, Jason@zx2c4.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue, 22 Mar 2022 13:18:57 +0100
In-Reply-To: <20220322115125.737671717@infradead.org>
References: <20220322114809.381992456@infradead.org>
         <20220322115125.737671717@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The chacha_Nblock_xor_avx512vl() functions all have their own,
> identical, .LdoneN label, however in one particular spot {2,4} jump
> to the 8 version instead of their own. [...]
> 
> Make each function consistently use its own done label.

Reviewed-by: Martin Willi <martin@strongswan.org>

