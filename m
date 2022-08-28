Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D720B5A3B2C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 05:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiH1Dal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 23:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiH1Dag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 23:30:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6084ADED3;
        Sat, 27 Aug 2022 20:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6E4DB807EB;
        Sun, 28 Aug 2022 03:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE91C433D6;
        Sun, 28 Aug 2022 03:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661657431;
        bh=vakhEANlUdSR/IZHKI+S/KsPEvMB3c/zNHgUQcvVLDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UK87EYu3n3ZT2KqbqoxoLtZSw7CGxzNhlm6tFqTxhwM+MY5DPhtoOx/O7vNQwZovp
         XP5cMmiyeS9ZJlF/f+RJtJkRXJoO1/wVE0Aywu7I75O8/Z4DCSKwWCvFehopJuMGTs
         5f/Xv6F6ZFFqO2biP6pt51aGk6eQdekDB9Uh0DGS54nQ8v/LGS5KijdZxn0jKqbdkG
         QJdD49yPQuIO2akYqDnDWuACOvTjjfPv09y8//Jz6uLQWQDkHXWm180HMLQ28Ncydq
         ZUnaY7OWWZHAkiJZigotaxYCoE8BCFwuMqEp/3l09hJZL+QuSIPuKuy1TjACefyyv3
         Jivwd7mwBy4DQ==
Date:   Sun, 28 Aug 2022 06:30:23 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>,
        Varad Gautam <varad.gautam@suse.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH v9 0/4] Check codeSigning extended key usage extension
Message-ID: <YwrhT0YLb87PtuEk@kernel.org>
References: <20220825142314.8406-1-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825142314.8406-1-jlee@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 10:23:10PM +0800, Lee, Chun-Yi wrote:
> NIAP PP_OS certification requests that OS need to validate the
> CodeSigning extended key usage extension field for integrity
> verifiction of exectable code:
> 
>     https://www.niap-ccevs.org/MMO/PP/-442-/
>         FIA_X509_EXT.1.1
> 
> This patchset adds the logic for parsing the codeSigning EKU extension
> field in X.509. And checking the CodeSigning EKU when verifying
> signature of kernel module or kexec PE binary in PKCS#7.

Might be cutting hairs here but you don't really explain
why we want to support it. It's not a counter argument
to add the feature. It's a counter argument against adding
undocumented features.

BR, Jarkko
