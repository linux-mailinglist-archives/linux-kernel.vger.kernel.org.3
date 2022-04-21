Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA70509AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386762AbiDUIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiDUIkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:40:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92840BC1B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:37:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650530230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rji2I2reAO5jVArMzNPDQCXmvUH5KKkxcntxCrD5bxY=;
        b=y9qwEFHvvOljcWHtzGZe0OLEPsHfi+lWBksnqo6l9DJwjQeR17HoWbVki4lDloP5OEDq06
        vGsfXtVBZDZ4ReP/K83zDR0GBiWNHGZuwMOp3qmhKFG8Dze4A5rQf30GQrZSVjaRmKkWkk
        mtaBo26YkJL+JDb2YzKm/ZEr32EVcxJkGad4iZHRMKWfcHZBfeQAOXRJCxSI5zroXCtog3
        do4Qx8tK1CkEXhU6R3N8OYeVcplCzBuiNIpboBiYwXreJfazbH+xMRKL0KHeyKpRgj6hhN
        Bn6tYNuN/LMW1B+DakNZCRKdbIhAXGDsNEsZ7huIw1lD1YRTXRl0IFkNw28F7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650530230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rji2I2reAO5jVArMzNPDQCXmvUH5KKkxcntxCrD5bxY=;
        b=VfI8yNNKGAsMu2uxgCvJ/NAdq6PSi5uXkbk+5PZa/FR26+C6AFMiFClGdIvZq7Lh7mL3h6
        FL3yTJwzdg0CoyBQ==
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        dave.hansen@linux.intel.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 1/2] x86: Check return values from early_memremap calls
In-Reply-To: <1650035401-22855-2-git-send-email-ross.philipson@oracle.com>
References: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
 <1650035401-22855-2-git-send-email-ross.philipson@oracle.com>
Date:   Thu, 21 Apr 2022 10:37:09 +0200
Message-ID: <87a6ceu91m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ross,

On Fri, Apr 15 2022 at 11:10, Ross Philipson wrote:

can you please ensure that all relevant maintainers are CC'ed on such
patches? XEN and Jailhouse people might have opinions, no?

> There are a number of places where early_memremap is called
> but the return pointer is not checked for NULL. The call
> can result in a NULL being returned so the checks must
> be added.

Also please follow:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#function-references-in-changelogs

Thanks,

        tglx
