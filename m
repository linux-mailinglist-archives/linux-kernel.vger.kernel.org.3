Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1626352027C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiEIQfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbiEIQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:35:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C62E098;
        Mon,  9 May 2022 09:31:41 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADA9F1EC01D4;
        Mon,  9 May 2022 18:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652113895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YVZDhhuwFnG0wO9zG2gz1m1ChZD7/QsEFk2nXCEHMmY=;
        b=rGl4Ip+PNvLTALQHSdUG89pzYor5BP8t3NYCl5ruhddTTsfk9a0w3Vx+hjAt8rPD77xcel
        u35x0hFwVkG2cz5/8d/HDeuA70a/n7vqEwwnvRNo6drlfmU0ISJPcTrvrXG1EJw6hv8WgM
        xY5BKcbCNji7BIHkNvD1AwirRUrRVUU=
Date:   Mon, 9 May 2022 18:31:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v7 06/12] platform/x86/intel/ifs: Check IFS Image sanity
Message-ID: <YnlB6iAp4fjM0Cw9@zn.tnic>
References: <20220506014035.1173578-1-tony.luck@intel.com>
 <20220506225410.1652287-1-tony.luck@intel.com>
 <20220506225410.1652287-7-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220506225410.1652287-7-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 03:54:04PM -0700, Tony Luck wrote:
> From: Jithu Joseph <jithu.joseph@intel.com>
> 
> IFS image is designed specifically for a given family, model and
> stepping of the processor. Like Intel microcode header, the IFS image
> has the Processor Signature, Checksum and Processor Flags that must be
> matched with the information returned by the CPUID.

Is the checksum the only protection against people loading arbitrary IFS
images or are those things signed or encrypted, just like the microcode?

I'd hope they pass the same checks as microcode, when they get loaded,
considering the similarity of how they're handled...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
