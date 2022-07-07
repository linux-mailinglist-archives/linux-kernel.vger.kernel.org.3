Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4156AB16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiGGSy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiGGSy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:54:26 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E94F2AC45;
        Thu,  7 Jul 2022 11:54:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 98E98784;
        Thu,  7 Jul 2022 18:54:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 98E98784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657220065; bh=/fMlRf3BBiH/y93ZsQHiL7t7Abbfscbt0cKNfAWYzk4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=l6amQO03x3OqUce5kRG/390r2EX/q8YrX1e6aGN/L1PbQbt593fTX3QUrnRl2F0ED
         I+H0WL9n1gvoIUxlFOSd6o491UzVtidx4R0mIKHiSxpMXB46BcWEAYjYlYbQAkAOKx
         Yvp8EWr0DBOIonr95HiTvzNpkRK75NeG13L2M3J5Jd6vWZfN+TNUbBOW6QJcy2CcPs
         /X+Zks2+z7cAuyV+uZeFosNGNHa1JU0Hagtib82Dkf0VMuCaJxwpQ28ZCLtgRONgdZ
         cSAoaQdKHlDu8N9FNmYeCILWTr2ruYi8941LNmxZcShChPVd9zdjj313LDuVTCtIMm
         mcthwisLlmP5w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 02/12] docs: tegra194-hte.rst: don't include gpiolib.c
 twice
In-Reply-To: <YsYBMtHLygtss+9u@orome>
References: <cover.1656759988.git.mchehab@kernel.org>
 <de81b472f552bd651f140f0aa779a29652fffa62.1656759989.git.mchehab@kernel.org>
 <7e536472-60cd-c81f-254e-bab9fda7ed37@nvidia.com> <YsYBMtHLygtss+9u@orome>
Date:   Thu, 07 Jul 2022 12:54:24 -0600
Message-ID: <87edywbvof.fsf@meer.lwn.net>
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

Thierry Reding <thierry.reding@gmail.com> writes:

> here's another one that applies on top of that earlier patch. Can you
> apply this to your tree?

Done.

Thanks,

jon
