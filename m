Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFC25621EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiF3SUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiF3SUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:20:46 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40DE419BE;
        Thu, 30 Jun 2022 11:20:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 88CC04B7;
        Thu, 30 Jun 2022 18:20:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 88CC04B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656613245; bh=zEX0jDaGRsOibTdtNVlBKNOjdBWErNw4UW8i61bvYM8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DzP0hPqKONjHyjuaLmB7ovyEGNeQuVViQe1ciHBH2jmGHFG0VvLvIyZ+5EKPD9DbC
         XXX3Y9ro+pYiIr2b2wi43gkmlZFhORSdYFrn6OUu33pbsA7yc6quedxluojTcTLY/q
         q1A5RRdkw1ju7/1peetdghDEFdyuV9EgH5Qny3zMrsVqz/s91PqCuPEtLI6Qz415Mi
         AYRXlp1BMluvq9uAoB7Fd5LE+oWIfkVAe2fh4lqztw3RgR5IFMRWyjg01B6abvS/DE
         sBnhCvFRb7c7w/0ko1VIbs0GADRAQ2COwNEdEsQiblEmf7ylSpSXczqgiHR3VDx7B2
         Gq/ADIjEZlZBg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: align Italian documentation
In-Reply-To: <87pmiqnjbz.fsf@meer.lwn.net>
References: <20220628111603.603357-1-federico.vaga@vaga.pv.it>
 <87pmiqnjbz.fsf@meer.lwn.net>
Date:   Thu, 30 Jun 2022 12:20:44 -0600
Message-ID: <87letenhc3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Federico Vaga <federico.vaga@vaga.pv.it> writes:
>
>> Translation for the following patches
>>
>> commit df05c0e9496c ("Documentation: Raise the minimum supported version of LLVM to 11.0.0")
>> commit 333b11e541fe ("Documentation: Add minimum pahole version")
>> commit 6d6a8d6a4ed0 ("docs: Update Sphinx requirements")
>> [...]
>
> Applied, thanks.

Actually, I take that back; it creates a massive mess of docs-build
warnings:

  MAINTAINERS:4: WARNING: duplicate label maintainers, other instance in /stuff/k/git/kernel/Documentation/process/maintainers.rst
  MAINTAINERS:107: WARNING: unknown document: ../maintainer/maintainer-entry-profile
  MAINTAINERS:165: WARNING: unknown document: ../networking/device_drivers/ethernet/3com/vortex
  MAINTAINERS:235: WARNING: unknown document: ../networking/6lowpan
  [...]

This all comes down to the duplicate copy of
Documentation/process/maintainers.rst that your patch adds.  Don't do
that, please.

Thanks,

jon
