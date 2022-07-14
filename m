Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B03C574B52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiGNK6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiGNK6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:58:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFF63DF;
        Thu, 14 Jul 2022 03:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5D905CE25B7;
        Thu, 14 Jul 2022 10:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C65C34114;
        Thu, 14 Jul 2022 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657796311;
        bh=blzTjVSdteYEEgziH1egT1Z2bdKseoVJHmbkMNfVChc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Znv3Xz9kEA/E3bEnKB3yklOJOeuKWJyI5kWfbITCR6uRU1ZrOXgaT7h2B6AIIa9Xs
         Ff6sG5k6ejG2owjqR53K8e4rd/M5u0OgAo2B3a7Gyzjs7raRBUzRvj1xRvGXtdIV6B
         sphSfKyZqmWZBktb9a4hFx5Wk5+YAZlXm9YTcxSitALd5gmm+T/weYwM9SsdATtmhf
         50/HpTrzgOOmI+UDyub2aixaf7hFL/rekDZyj0xTb97QAHmtNcZmv8PdbK33pVcyTf
         O75dXTaZOwF0q7MN4Vbao9+vIaCUVL5RNXVhMQhGD6BdG1KmoklbfIx8mc4hrnJqX8
         FbtL400aYAjEg==
Message-ID: <65a1d324-9645-56a3-fd81-7ff87897fe49@kernel.org>
Date:   Thu, 14 Jul 2022 12:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] rtla: Fix Makefile when called from -C tools/
Content-Language: en-US
To:     sedat.dilek@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org>
 <CA+icZUVbQNM+MkMCQik83FoiWF_a1v7Mb-4hZX6SZgNcp2x5SA@mail.gmail.com>
 <CA+icZUW-Mu-Cak481yrE9f6PvGcfaDN7ZPLhrtX6L7zOPU73Zg@mail.gmail.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CA+icZUW-Mu-Cak481yrE9f6PvGcfaDN7ZPLhrtX6L7zOPU73Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 11:53, Sedat Dilek wrote:
>>
> Addendum:
> 
> Subject?
> 
> [PATCH V2] rtla: Fix Makefile when called from -C tools/
> 
> ...called from -C tools/ clean?
> 
it is not needed.

-- Daniel
