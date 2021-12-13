Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23156472DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhLMNwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhLMNwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:52:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E2FC061574;
        Mon, 13 Dec 2021 05:52:07 -0800 (PST)
Date:   Mon, 13 Dec 2021 14:52:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639403525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvPVVL5hpvPQZW/oXDRC/DMj/vt92LQqc7il/C/om5E=;
        b=mqkZ6Jc5xXcDmuAdO97Toq7JmG47BpUZ6Iu1ABJnksS+UP43kYq7P45js4BOC5PEH0OUKh
        lgZx2t+2bY/3ib3jXNVBMA/VBu9zoRcEfvsDU3SbfnajT8FGEyOCg9pcRCgupIfXOHnyKP
        jxDzqy9bnzCgiQurvW89FiB2FnyaNBWZvXEHAtntJJ9lfhn3it1jp4KsNG2lUdPOsqRiJd
        e+HDudPo8J6OOcZrZzWXoqdO6Z7ivh/ZVzisSpKNEpJQb46SFQVHZPy3r+21R+hoLAbCWe
        VYApTPGIf3oPk3HJ+LdJmG/wm6RTUksOQKpAiAgKhLMp92984vrurr0CH7g4Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639403525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvPVVL5hpvPQZW/oXDRC/DMj/vt92LQqc7il/C/om5E=;
        b=+zOpglHj8vaFsGfz/mTDMmpei6rOwTP3PUFcwWDgvt5w9P88HsIJIRZtJjoIF62rD5DFmc
        WmB+4CARhU74rgCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, axboe@kernel.dk,
        tglx@linutronix.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] blk-mq: make synchronous hw_queue runs RT friendly
Message-ID: <YbdQA0WDooPXGzQb@linutronix.de>
References: <20211213054425.28121-1-dave@stgolabs.net>
 <YbdFeHVnQbT0E5kR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbdFeHVnQbT0E5kR@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-13 05:07:04 [-0800], Christoph Hellwig wrote:
> But more importantly:  why isn't migrate_disable/enable doing the right
> thing for !PREEMPT_RT to avoid this mess?

Thank you for asking the question.

Sebastian
