Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97084BA60D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbiBQQfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:35:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiBQQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:34:59 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512972B2C69;
        Thu, 17 Feb 2022 08:34:43 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D52C19A2;
        Thu, 17 Feb 2022 16:34:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D52C19A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645115683; bh=cOjwgHIMQdAZZKdFeb4W8f5T5PycAUl3zv4aJ+L8F2Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=g9rdW3esCOEK/Q7wW+RpcfQ2LQsUToEAfwkexq5OexHZJXpwhpc0ai4tFQ90RHZNZ
         3AjyzJIYCtFt3rBWjl/KRAOQKo85QdZV2AINIZAPp52fqX4VG3RPNGAuz5UMNjtxpd
         ia/D5blGw484evGhoRGsrzIhLiYf+e5xY1cCLob/JC1nrBSW2df7NVBMo/piJkJf2N
         BXhZWc/zg3FZ+im8C/zU8fj2iOjGTNTXB2uISVKekDTuxTmPrVK/7nuR81X5lGBlUe
         XhtHnXFYIRrnGpsdLIN24aiJBRedQOJADV1ggJlSvPhsoOV7npbKqG7IqNNtItZ9Ld
         NEoNqwz9zoZJg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 0/5] docs: pdfdocs: Improve LaTeX preamble (TOC, CJK fonts)
In-Reply-To: <cd8b2f4e-6ec4-af27-4f9b-b1dc754ab322@gmail.com>
References: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
 <87zgmr66cn.fsf@meer.lwn.net>
 <d0ce2c79-4e4d-9373-3ab6-e1e355224559@gmail.com>
 <cd8b2f4e-6ec4-af27-4f9b-b1dc754ab322@gmail.com>
Date:   Thu, 17 Feb 2022 09:34:42 -0700
Message-ID: <87fsoh1mfx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> The head of docs-next I see is commit 4fbe7b19a948 ("docs: Fix wording in
> optional zram feature docs").
> I think you have applied my patch set on top of it.
> I'd like you to push up-to-date docs-next so that I can start preparing
> a follow-up patch.

Apologies, I thought I'd done that - done now.

Thanks,

jon
