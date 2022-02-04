Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164A74AA3F6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377857AbiBDXHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:07:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34928 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiBDXHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:07:33 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644016051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XnhUMmuoy3H9frjewzOP3Ywq/q0qdsbrKJfw5nT/m5k=;
        b=SOrHnXVoPsmninpWXs7KWSnkzSfHvmZT2/Qwp8SQ3LJmhoagnYkNopDitPTiZBx8bJwzVi
        +L1A/Vp7e7jWLVYl5g9q/jBz6Q+WZHHiHLf7Divdgh2F5TyEIzwu0A+DPO/VJ+cyuht2BR
        OgyOeL+yHiTAUkOEk2ICFehbrKjMRT+ZALsXd7KOUDEts30nnEbRJNYWqz9MAOeqgmFG6z
        1WvGc99mVt2WBauUhR3n1hiejdO3dj6xITEQuIcSrEfH1dS1etlSJ3uwStNURXbAvqblWg
        vqFPJYVcB4KzDlpksC7k43DS4KHUUKTz7sUFNR5et46bJWzOsQXnPQx4fX5lbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644016051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XnhUMmuoy3H9frjewzOP3Ywq/q0qdsbrKJfw5nT/m5k=;
        b=Z8NUF1bglArTaYD5uZz98QaGYAItoaStikcyQYz06YFqKMk5g9zors8SaVtMR3Z66WKb5q
        oYmW4denlK0mMXBg==
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v3 01/11] iommu/sva: Rename CONFIG_IOMMU_SVA_LIB to
 CONFIG_IOMMU_SVA
In-Reply-To: <20220128202905.2274672-2-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-2-fenghua.yu@intel.com>
Date:   Sat, 05 Feb 2022 00:07:31 +0100
Message-ID: <877daacjt8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28 2022 at 12:28, Fenghua Yu wrote:

> This CONFIG option originally only referred to the Shared
> Virtual Address (SVA) library. But it is now also used for
> non-library portions of code.
>
> Drop the "_LIB" suffix so that there is just one configuration
> options for all code relating to SVA.
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
