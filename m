Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846A9524C60
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353547AbiELMHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243140AbiELMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:07:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E733E9A;
        Thu, 12 May 2022 05:07:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KzVry2jy9z4ySc;
        Thu, 12 May 2022 22:07:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652357250;
        bh=VZSW+kLwiLdM89tx8T02OMcLyU8N86ihiltmUjTWwjI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XP41nicttMOhY9hwW7ifQg2VaHXrgfn5gqxy72pbMcNrCIDLFnLRtS6w6og9CNqK6
         nfglk3q4XgkwHUkKXU2YAPNMA6T+LY+efjCMwbPkEjfG7K0jSWdZgbC26jbu/U3Xcl
         5oEbIbP5B31AYRCtrtiLL941I4qH1NkcSEECG4hfVklIAfPOY/c3oDymRLW/N/gs/8
         2nABeRNQSF+J6FzFKg0RD6jU3loze5R0Qj/Exft5+7TIpmm0GH+KfhdI3Lzf+saYbY
         eFMKhvv5GqDVbGt9d2R8lw8p+jKhswUJjJCCd+elCw/toBYU19BWQ19jXOHAty0KmP
         ZMGFbGsOj+R7Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        fnovak@us.ibm.com, linuxppc-dev@ozlabs.org,
        christophe.leroy@csgroup.eu
Subject: Re: request_module DoS
In-Reply-To: <871qwz8aot.fsf@mpe.ellerman.id.au>
References: <YnXiuhdZ49pKL/dK@gondor.apana.org.au>
 <874k1zt0ec.fsf@mpe.ellerman.id.au>
 <Ynk9j6DQmVGAA3Jf@bombadil.infradead.org>
 <Ynvl6wCQRFdYsHar@bombadil.infradead.org>
 <871qwz8aot.fsf@mpe.ellerman.id.au>
Date:   Thu, 12 May 2022 22:07:26 +1000
Message-ID: <87v8ub6jk1.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Luis Chamberlain <mcgrof@kernel.org> writes:
...
>
>> Can someone try this on ppc64le system? At this point I am not convinced
>> this issue is generic.
>
> Does your x86 system have at least 784 CPUs?
>
> I don't know where the original report came from, but the trace shows
> "CPU 784", which would usually indicate a system with at least that many
> CPUs.

Update, apparently the report originally came from IBM, so I'll chase it
up internally.

I think you're right that there's probably no issue in the module code,
sorry to waste your time.

cheers
