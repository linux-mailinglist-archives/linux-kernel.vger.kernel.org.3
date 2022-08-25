Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F75A1662
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242600AbiHYQJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbiHYQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:09:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5CFB5A41
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:09:41 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:09:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661443779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rYkG/lvIB1Tcs4iv5gRUCIjYfTBF7E0YRIHmgTEWkSU=;
        b=wpEYXANkdq0xh8Qz1gaqS60OX9huUgs3yDr7i5051aWtopquggn7771q2r4YHsGiDNtCb8
        1Ddm+gabyN403bOBJJbesTOh45+Eu8LtGxUhichYGlKj6BZ4RvjTY6Bux1xp2lN7hnGgkT
        nKhTza0CP2yuofK0ENTqmNkSJ6QwSOBoCxZbU/HFnHzqN4093Al1VAfs4RZZntt3g92hfh
        NIrVJIAlZ7xQ5KMy37JdUAgtWo/VuOr7ENMcCJ1yBUR/D8ZUFutdZSisRu/6ZQ9MfLSI8Q
        fhv0iiv4zn9kOf77+x9BH5qkiKYQluNOcWkMjWz4zPTG43WFZ30OLBPwCpNdBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661443779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rYkG/lvIB1Tcs4iv5gRUCIjYfTBF7E0YRIHmgTEWkSU=;
        b=VnHneFr0PdAunF12j4c5fuEwYFHry6P71WCRcr1SDz6mdIsn3/CFdqciYakdqgd+J79Uv0
        WwrN89kKrVrYrhBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] checkpatch: Print an error if rwlock.h is included
 directly.
Message-ID: <YweewqulHskAZQOP@linutronix.de>
References: <20220816075118.173455-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220816075118.173455-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-16 09:51:18 [+0200], To linux-kernel@vger.kernel.org wrote:
> rwlock.h shouldn't be included directly in source code. PREEMPT_RT uses
> a different implementation and this rwlock.h include breaks it.
> 
> Add an error message if linux/rwlock.h is included.

This can be ignored, I found a more efficient way of doing this.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
